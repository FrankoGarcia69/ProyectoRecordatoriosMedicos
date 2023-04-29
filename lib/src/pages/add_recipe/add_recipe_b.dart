import 'package:rxdart/rxdart.dart';
import '../../../models/errors.dart';
import '../../../models/recipetype.dart';

class AddRecipeB {
  //tipo de receta
  BehaviorSubject<RecipeType>? _selectRecipeType$;
  ValueStream<RecipeType> get selectRecipeType => _selectRecipeType$!.stream;

  //intervalo de tiempo
  BehaviorSubject<int>? _selectedIntervals$;
  BehaviorSubject<int>? get selectedIntervals => _selectedIntervals$;

  //tiempo
  BehaviorSubject<String>? _selectedTimeDay$;
  BehaviorSubject<String>? get selectedTimeDay$ => _selectedTimeDay$;

  //posibles errores
  BehaviorSubject<AddError>? _errorState$;
  BehaviorSubject<AddError>? get errorState$ => _errorState$;

  AddRecipeB() {
    _selectRecipeType$ = BehaviorSubject<RecipeType>.seeded(RecipeType.none);

    _selectedTimeDay$ = BehaviorSubject<String>.seeded('none');

    _selectedIntervals$ = BehaviorSubject<int>.seeded(0);

    _errorState$ = BehaviorSubject<AddError>.seeded(AddError.none);
  }

  void dispose() {
    _selectRecipeType$!.close();
    _selectedIntervals$!.close();
    _selectedTimeDay$!.close();
  }

  void submitError(AddError error) {
    _errorState$!.add(error);
  }

  void updateInterval(int interval) {
    _selectedIntervals$!.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeDay$!.add(time);
  }

  void updateSelectedRecipe(RecipeType type) {
    RecipeType _tempType = _selectRecipeType$!.value;
    if (type == _tempType) {
      _selectRecipeType$!.add(RecipeType.none);
    } else {
      _selectRecipeType$!.add(type);
    }
  }
}
