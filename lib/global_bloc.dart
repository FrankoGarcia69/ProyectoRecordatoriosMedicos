import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/recipe.dart';

class GlobalB {
  BehaviorSubject<List<Recipe>>? _recipeList$;
  BehaviorSubject<List<Recipe>>? get recipeList$ => _recipeList$;

  GlobalB() {
    _recipeList$ = BehaviorSubject<List<Recipe>>.seeded([]);
    createRecipeList();
  }

  Future removeRecipe(Recipe tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> recipeJsonList = [];

    var blocList = _recipeList$!.value;
    blocList
        .removeWhere((recipe) => recipe.recipename == tobeRemoved.recipename);

        for(int i = 0; i<(24 / tobeRemoved.interval!).floor(); i++){
          flutterLocalNotificationsPlugin.cancel(int.parse(tobeRemoved.notificationid![i]));
        }

        if(blocList.isNotEmpty){
          for(var blockRecipe in blocList){
            String recipeJson = jsonEncode(blockRecipe.toJson());
            recipeJsonList.add(recipeJson);
          }
        }

        sharedUser.setStringList('Recipe', recipeJsonList);
        _recipeList$!.add(blocList);
  }

  Future updateRecipeList(Recipe newRecipe) async {
    var blocList = _recipeList$!.value;
    blocList.add(newRecipe);
    _recipeList$!.add(blocList);

    Map<String, dynamic> tempMap = newRecipe.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newRecipeJson = jsonEncode(tempMap);

    List<String> recipeJsonList = [];

    if (sharedUser.getStringList('recipes') == null) {
      recipeJsonList.add(newRecipeJson);
    } else {
      recipeJsonList = sharedUser.getStringList('recipes')!;
      recipeJsonList.add(newRecipeJson);
    }

    sharedUser.setStringList('recipes', recipeJsonList);
  }

  Future createRecipeList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('recipes');
    List<Recipe> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonRecipe in jsonList) {
        dynamic userMap = jsonDecode(jsonRecipe);
        Recipe tempRecipe = Recipe.fromJson(userMap);
        prefList.add(tempRecipe);
      }
      //actualizacion de estado
      _recipeList$!.add(prefList);
    }
  }

  void dispose() {
    _recipeList$!.close();
  }
}
