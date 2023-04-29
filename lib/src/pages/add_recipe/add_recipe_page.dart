import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/errors.dart';
import 'package:flutter_application_1/src/pages/add_recipe/add_recipe_b.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../common/converttime.dart';
import '../../../constantscolors.dart';
import '../../../global_bloc.dart';

import '../../../models/recipe.dart';
import '../../../models/recipetype.dart';
import '../success_screen/success_screen.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  late TextEditingController nameController;
  late TextEditingController doseController;
  late AddRecipeB _addRecipeB;
  late GlobalKey<ScaffoldState> _Scaffoldkey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    doseController.dispose();
    _addRecipeB.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    doseController = TextEditingController();
    _addRecipeB = AddRecipeB();
    _Scaffoldkey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalB globalB = Provider.of<GlobalB>(context);
    return Scaffold(
      key: _Scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Añadir Nueva Receta'),
      ),
      body: Provider<AddRecipeB>.value(
        value: _addRecipeB,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PanelTitle(
                  title: 'Nombre de Medicina',
                  isRequired: true,
                ),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 15,
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: cOtherColor,
                      ),
                ),
                const PanelTitle(
                  title: 'Dosis en mg',
                  isRequired: false,
                ),
                TextFormField(
                  controller: doseController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: cOtherColor,
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const PanelTitle(
                  title: 'Tipo de Medicina',
                  isRequired: false,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: StreamBuilder<RecipeType>(
                    stream: _addRecipeB.selectRecipeType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RecipeTypeColumn(
                              name: 'Capsulas',
                              iconValue: 'assets/icons/pill.svg',
                              isSelected: snapshot.data == RecipeType.Capsulas
                                  ? true
                                  : false,
                              recipeType: RecipeType.Capsulas),
                          RecipeTypeColumn(
                              name: 'Jeringa',
                              iconValue: 'assets/icons/syringe.svg',
                              isSelected: snapshot.data == RecipeType.Jeringa
                                  ? true
                                  : false,
                              recipeType: RecipeType.Jeringa),
                          RecipeTypeColumn(
                              name: 'Tabletas',
                              iconValue: 'assets/icons/pill2.svg',
                              isSelected: snapshot.data == RecipeType.Tabletas
                                  ? true
                                  : false,
                              recipeType: RecipeType.Tabletas),
                          RecipeTypeColumn(
                              name: 'Bote',
                              iconValue: 'assets/icons/bottle.svg',
                              isSelected: snapshot.data == RecipeType.Bote
                                  ? true
                                  : false,
                              recipeType: RecipeType.Bote),
                        ],
                      );
                    },
                  ),
                ),
                const PanelTitle(
                  title: 'Intervalo de Dosis',
                  isRequired: true,
                ),
                const IntervalSelect(),
                const PanelTitle(
                  title: 'Tiempo de inicio',
                  isRequired: true,
                ),
                const SelectTime(),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: SizedBox(
                    width: 80.w,
                    height: 8.h,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: cPrimaryColor,
                        shape: const StadiumBorder(),
                      ),
                      child: Center(
                        child: Text('Añadir',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: cScaffoldColor,
                                    )),
                      ),
                      onPressed: () {
                        String? recipeName;
                        int? dose;

                        if (nameController.text == "") {
                          _addRecipeB.submitError(AddError.nameNull);
                          return;
                        }

                        if (nameController.text != "") {
                          recipeName = nameController.text;
                        }

                        if (doseController.text == "") {
                          dose = 0;
                        }

                        if (doseController.text != "") {
                          dose = int.parse(doseController.text);
                        }

                        for (var recipe in globalB.recipeList$!.value) {
                          if (recipeName == recipe.recipename) {
                            _addRecipeB.submitError(AddError.nameDuplicate);
                            return;
                          }
                        }

                        if (_addRecipeB.selectedIntervals!.value == 0) {
                          _addRecipeB.submitError(AddError.interval);
                          return;
                        }

                        if (_addRecipeB.selectedTimeDay$!.value == 'None') {
                          _addRecipeB.submitError(AddError.startime);
                          return;
                        }

                        String recipeType = _addRecipeB.selectRecipeType.value
                            .toString()
                            .substring(11);

                        int interval = _addRecipeB.selectedIntervals!.value;
                        String startTime = _addRecipeB.selectedTimeDay$!.value;

                        List<int> intids =
                            makeids(24 / _addRecipeB.selectedIntervals!.value);

                        List<String> notificationids =
                            intids.map((i) => i.toString()).toList();

                        Recipe addRecipe = Recipe(
                            notificationid: notificationids,
                            recipename: recipeName,
                            dose: dose,
                            recipetype: recipeType,
                            interval: interval,
                            starttime: startTime);

                        globalB.updateRecipeList(addRecipe);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SuccessScreen())));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _addRecipeB.errorState$!.listen((AddError error) {
      switch (error) {
        case AddError.nameNull:
          displayError("Porfavor ingrese el nombre del medicamento");
          break;

        case AddError.nameDuplicate:
          displayError("El nombre del medicamento ya existe");
          break;

        case AddError.dose:
          displayError("Porfavor ingrese la dosis requerida");
          break;
        case AddError.interval:
          displayError("Porfavor ingrese el intervalo");
          break;

        case AddError.startime:
          displayError("Porfavor ingrese el tiempo de inicio");
          break;

        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: cOtherColor,
      content: Text(error),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  List<int> makeids(double n) {
    var rng = Random();

    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }

    return ids;
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
      });
      //provider updatetime
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: cPrimaryColor, shape: StadiumBorder()),
            onPressed: () {
              _selectTime();
            },
            child: Center(
              child: Text(
                  _clicked == false
                      ? 'Seleccionar Tiempo'
                      : '${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: cScaffoldColor,
                      )),
            )),
      ),
    );
  }
}

class IntervalSelect extends StatefulWidget {
  const IntervalSelect({super.key});

  @override
  State<IntervalSelect> createState() => _IntervalSelectState();
}

class _IntervalSelectState extends State<IntervalSelect> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final AddRecipeB addRecipeB = Provider.of<AddRecipeB>(context);
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recordar cada ',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          DropdownButton(
            iconEnabledColor: cOtherColor,
            dropdownColor: cScaffoldColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text('Seleccione un Intervalo',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: cSecondaryColor))
                : null,
            elevation: 3,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map((int e) {
              return DropdownMenuItem<int>(
                value: e,
                child: Text(
                  e.toString(),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: cSecondaryColor,
                      ),
                ),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _selected = newVal!;
                addRecipeB.updateInterval(newVal);
              });
            },
          ),
          Text(
            _selected == 1 ? 'hora.' : 'horas.',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}

class RecipeTypeColumn extends StatelessWidget {
  const RecipeTypeColumn(
      {super.key,
      required this.name,
      required this.iconValue,
      required this.isSelected,
      required this.recipeType});
  final RecipeType recipeType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final AddRecipeB addRecipeB = Provider.of<AddRecipeB>(context);
    return GestureDetector(
      onTap: () {
        addRecipeB.updateSelectedRecipe(recipeType);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 20.w,
            // height: 10.h,
            decoration: BoxDecoration(
              color: isSelected ? cOtherColor : Colors.white,
              borderRadius: BorderRadius.circular(3.h),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(1.h),
                child: SvgPicture.asset(iconValue,
                    height: 7.h,
                    color: isSelected ? Colors.white : cOtherColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              height: 10.w,
              width: 10.h,
              decoration: BoxDecoration(
                color: isSelected ? cOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Center(
                    child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: isSelected ? Colors.white : cOtherColor),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TextSpan(
          text: isRequired ? ' *' : '',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: cPrimaryColor,
              ),
        )
      ])),
    );
  }
}
