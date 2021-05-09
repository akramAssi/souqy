import 'package:souqy/res/car.dart';

class FormValidator {
  static bool isEmpty(String value) => value.isEmpty;
  static bool isBrand(String value) => brands.contains(value);
  static bool isBrandValid(String value) => !(isEmpty(value) && isBrand(value));
}
