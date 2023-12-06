import 'package:flutter/cupertino.dart';

import 'VariationsColorsModel.dart';
import 'VariationsUnitsModel.dart';

class VariationModel {
  TextEditingController? varSize;
  VariationsUnitModel? fkUnit;
  VariationsColorModel? fkColor;
  TextEditingController? varVariationPrice;
  String unitError = "";
  String colorError = "";
  TextEditingController? discountPrice;
  bool isDataValid = true;
  VariationModel(
      {this.varSize,
      this.fkUnit,
      this.fkColor,
      this.varVariationPrice,
      this.discountPrice});
}
