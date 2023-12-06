// import 'dart:convert';
// import 'dart:core';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:wena_partners/vendor/config/local_storage.dart';
// import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
// import 'package:wena_partners/vendor/product/models/CategoriesModel.dart';
// import 'package:wena_partners/vendor/product/models/ChooseImageProductModel.dart';
// import 'package:wena_partners/vendor/product/models/VariationsColorsModel.dart';
// import 'package:wena_partners/vendor/product/models/VariationsUnitsModel.dart';
// import 'package:wena_partners/vendor/product/models/variation_model.dart';
// import 'package:wena_partners/vendor/product/repository/add_product_repository.dart';
// import 'package:wena_partners/vendor/product/repository/category_repository.dart';
// import 'package:wena_partners/vendor/product/repository/color_repository.dart';
// import 'package:wena_partners/vendor/product/repository/product_keyword_repository.dart';
// import 'package:wena_partners/vendor/product/repository/unit_repository.dart';
// import 'package:wena_partners/vendor/product/screen/choose_screen.dart';
// import 'package:wena_partners/vendor/styles/colors.dart';
// import 'package:wena_partners/vendor/styles/sizes.dart';
// import 'package:wena_partners/vendor/styles/theme.dart';
// import 'package:wena_partners/vendor/utils/status.dart';
// import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
// import 'package:wena_partners/vendor/widget/common_input_widget.dart';
// import 'package:wena_partners/vendor/widget/custome_buttons.dart';
// import 'package:wena_partners/vendor/widget/loading_dialog.dart';
//
// class AddProductScreen extends StatefulWidget {
//   @override
//   _AddProductState createState() => _AddProductState();
// }
//
// class _AddProductState extends State<AddProductScreen> {
//   final TextEditingController _controllerTitle = TextEditingController();
//   final TextEditingController _controllerAutoSearch = TextEditingController();
//   final TextEditingController _controllerOldPrice = TextEditingController();
//   final TextEditingController _controllerNewPrice = TextEditingController();
//   final TextEditingController _controllerShortDesc = TextEditingController();
//   final TextEditingController _controllerLongDesc = TextEditingController();
//   final TextEditingController _controllerTime = TextEditingController();
//   final TextEditingController _controllerVidoeLink = TextEditingController();
//   List<String> images = [""];
//   List<ChooseImageProductModel> selectedImages = [ChooseImageProductModel()];
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<CategoryModel> categoryies = [];
//   List<VariationsColorModel> colors = [];
//   List<VariationsUnitModel> units = [];
//   String _userId = "";
//   bool autoSelected = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserId();
//     getCategories();
//     getColors();
//     getUnits();
//     _controllerAutoSearch.addListener(() {
//       if (!autoSelected) {
//         _controllerTitle.text = _controllerAutoSearch.text;
//         if (_controllerAutoSearch.text.length > 2) {
//           getHint(_controllerAutoSearch.text);
//         }
//       }
//       autoSelected = false;
//       setState(() {});
//     });
//   }
//
//   getUserId() async {
//     _userId = await LocalStorage.getUserId();
//   }
//
//   final CatoryRepository _catoryRepository = CatoryRepository();
//   getCategories() {
//     _catoryRepository.getCategories(stateChange: () {
//       if (mounted) {
//         if (_catoryRepository.productResp.status == Status.LOADING) {
//           showLoadingDialog();
//         } else if (_catoryRepository.productResp.status == Status.COMPLETED) {
//           hideLoadingDialog();
//         }
//         setState(() {});
//       }
//     }).then((value) {
//       if (value["body"]['code'] == 200) {
//         categoryies = value["body"]['data']
//             .map<CategoryModel>((json) => CategoryModel.fromJson(json))
//             .toList();
//       }
//     });
//   }
//
//   final UnitsRepository _unitsRepository = UnitsRepository();
//   getUnits() {
//     _unitsRepository.getProductUnits(
//         data: {},
//         stateChange: () {
//           if (mounted) {
//             setState(() {});
//           }
//         }).then((value) {
//       if (value["body"]['code'] == 200) {
//         units = value["body"]['data']
//             .map<VariationsUnitModel>(
//                 (json) => VariationsUnitModel.fromJson(json))
//             .toList();
//       }
//     });
//   }
//
//   final ColorsRepository _colorsRepository = ColorsRepository();
//   getColors() {
//     _colorsRepository.getProductColors(
//         data: {},
//         stateChange: () {
//           if (mounted) {
//             setState(() {});
//           }
//         }).then((value) {
//       if (value["body"]['code'] == 200) {
//         colors = value["body"]['data']
//             .map<VariationsColorModel>(
//                 (json) => VariationsColorModel.fromJson(json))
//             .toList();
//       }
//     });
//   }
//
//   final ProductKeywordRepository _hintRepository = ProductKeywordRepository();
//   getHint(String keyword) {
//     _hintRepository.getProductKeyword(
//         data: {"keyword": keyword},
//         stateChange: () {
//           if (mounted) {
//             setState(() {});
//           }
//         }).then((value) {
//       if (value["body"]['status'] == 200) {
//         if (value["body"]['data'].length > 0) {
//           hints = value["body"]['data'].map<String>((json) {
//             return json["var_title"].toString();
//           }).toList();
//         }
//         if (mounted) {
//           setState(() {});
//         }
//       }
//     });
//   }
//
//   CategoryModel selectedCategory = CategoryModel();
//
//   bool _forVariation = false;
//   List<VariationModel> variationModel = [
//     VariationModel(
//         varSize: TextEditingController(text: ""),
//         discountPrice: TextEditingController(text: ""),
//         fkUnit: VariationsUnitModel(),
//         fkColor: VariationsColorModel(),
//         varVariationPrice: TextEditingController(text: ""))
//   ];
//   String selectTimeUnit = "Minutes";
//
//   String categoryError = "";
//   String _errProductImages = "";
//   String _erroTimeUnit = "";
//   String productTitle = "";
//   List<String> hints = [];
//   GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
//
//   bool validateVariation() {
//     bool valid = true;
//     for (var element in variationModel) {
//       if (!element.isDataValid) {
//         valid = false;
//       }
//     }
//     return valid;
//   }
//
//   bool discountAmountError = false;
//   bool sellamountError = false;
//   @override
//   Widget build(BuildContext context) {
//     return BackgroundWithBackMaterialWidget(
//         Expanded(
//             child: Column(children: [
//           Expanded(
//               child: SingleChildScrollView(
//                   child: Container(
//                       alignment: FractionalOffset.centerLeft,
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             Autocomplete<String>(
//                               optionsBuilder:
//                                   (TextEditingValue textEditingValue) {
//                                 if (textEditingValue.text.length > 2) {
//                                   productTitle = textEditingValue.text;
//                                   getHint(textEditingValue.text);
//                                 }
//                                 if (textEditingValue.text == '') {
//                                   return const Iterable<String>.empty();
//                                 }
//                                 return hints.where((String option) {
//                                   return option.contains(
//                                       textEditingValue.text.toLowerCase());
//                                 });
//                               },
//                               fieldViewBuilder: (BuildContext context,
//                                   TextEditingController
//                                       fieldTextEditingController,
//                                   FocusNode fieldFocusNode,
//                                   VoidCallback onFieldSubmitted) {
//                                 return TextField(
//                                   decoration: InputDecoration(
//                                     counterText: "",
//                                     hintText: "Title",
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           width: 2, color: Color(colorDADADA)),
//                                       borderRadius:
//                                           BorderRadius.circular(dimen10),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           width: 2, color: Color(colorDADADA)),
//                                       borderRadius:
//                                           BorderRadius.circular(dimen10),
//                                     ),
//                                     hintStyle: textSegoeUiColorContentSize16,
//                                     fillColor: const Color(colorF7F8F9),
//                                     contentPadding: EdgeInsets.only(
//                                         left: dimen20,
//                                         top: dimen10,
//                                         bottom: dimen10,
//                                         right: dimen20), // Added this
//                                   ),
//                                   controller: fieldTextEditingController,
//                                   focusNode: fieldFocusNode,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 );
//                               },
//                               onSelected: (String selection) {
//                                 debugPrint('You just selected $selection');
//                                 productTitle = selection;
//                               },
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                 top: dimen20,
//                               ),
//                               padding: EdgeInsets.only(
//                                 left: dimen10,
//                                 right: dimen10,
//                               ),
//                               decoration: BoxDecoration(
//                                   color: const Color(colorF7F8F9),
//                                   border: Border.all(
//                                       width: 2.0,
//                                       color: Color(categoryError == ""
//                                           ? colorDADADA
//                                           : colorRed)),
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(dimen10))),
//                               child: SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width - dimen50,
//                                 child: Stack(
//                                   alignment: FractionalOffset.center,
//                                   children: [
//                                     Container(
//                                         padding: EdgeInsets.only(
//                                             top: dimen12, bottom: dimen12),
//                                         alignment: FractionalOffset.bottomLeft,
//                                         child: Text(
//                                             selectedCategory.intGlcode != null
//                                                 ? selectedCategory.varTitle!
//                                                 : "Select Categories",
//                                             style: selectedCategory.intGlcode !=
//                                                     null
//                                                 ? textSegoeUiColorBlackSize16
//                                                 : textSegoeUiColorContentSize16)),
//                                     Container(
//                                         alignment: FractionalOffset.centerRight,
//                                         child: DropdownButton<CategoryModel>(
//                                           isExpanded: true,
//                                           underline: Container(),
//                                           icon: Image.asset(
//                                             "assets/icons/arrow_down.png",
//                                             width: dimen15,
//                                             height: dimen15,
//                                           ),
//                                           items: categoryies
//                                               .map((CategoryModel value) {
//                                             return DropdownMenuItem<
//                                                 CategoryModel>(
//                                               value: value,
//                                               child: Text(value.varTitle!),
//                                             );
//                                           }).toList(),
//                                           onChanged: (_) {
//                                             selectedCategory = _!;
//                                             setState(() {});
//                                           },
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             if (categoryError != "")
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: dimen10, left: dimen20),
//                                 child: Text(
//                                   categoryError,
//                                   textAlign: TextAlign.start,
//                                   style: textSegoeUiColorRedSize16,
//                                 ),
//                               ),
//                             Container(
//                                 margin: EdgeInsets.only(top: dimen20),
//                                 height: dimen100,
//                                 child: ListView.builder(
//                                   itemCount: selectedImages.length,
//                                   scrollDirection: Axis.horizontal,
//                                   itemBuilder: ((context, index) => index == 0
//                                       ? GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ChooseImagesScreen("", "",
//                                                         (images) {
//                                                   selectedImages.clear();
//                                                   selectedImages.add(
//                                                       ChooseImageProductModel());
//                                                   selectedImages.addAll(images);
//
//                                                   if (mounted) {
//                                                     setState(() {});
//                                                   }
//                                                 }),
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             alignment: FractionalOffset.center,
//                                             width: dimen100,
//                                             decoration: BoxDecoration(
//                                               color: const Color(colorF7F7F7),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(dimen10)),
//                                               border: Border.all(
//                                                 width: _errProductImages == ""
//                                                     ? 1
//                                                     : 2,
//                                                 color: Color(
//                                                     _errProductImages == ""
//                                                         ? colorDADADA
//                                                         : colorRed),
//                                               ),
//                                             ),
//                                             child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Expanded(
//                                                       child: Container(
//                                                     alignment:
//                                                         FractionalOffset.center,
//                                                     child: Image.asset(
//                                                       "assets/icons/add.png",
//                                                       width: dimen24,
//                                                       height: dimen24,
//                                                     ),
//                                                   )),
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         bottom: dimen10),
//                                                     child: Text(
//                                                       "Add",
//                                                       style:
//                                                           textSegoeUiColorContentSize16,
//                                                     ),
//                                                   )
//                                                 ]),
//                                           ))
//                                       : Container(
//                                           margin:
//                                               EdgeInsets.only(left: dimen10),
//                                           child: Stack(
//                                             alignment:
//                                                 FractionalOffset.bottomCenter,
//                                             children: [
//                                               Container(
//                                                 padding: const EdgeInsets.all(2),
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.all(
//                                                             Radius.circular(
//                                                                 dimen20)),
//                                                     border: Border.all(
//                                                         width: 2,
//                                                         color: const Color(
//                                                             colorDADADA))),
//                                                 child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             dimen20),
//                                                     child: CachedNetworkImage(
//                                                       imageUrl:
//                                                           selectedImages[index]
//                                                               .varImageUrl!,
//                                                       placeholder:
//                                                           (context, url) =>
//                                                               Image.asset(
//                                                         'assets/images/placeholder.png',
//                                                       ),
//                                                       errorWidget: (context,
//                                                               url, error) =>
//                                                           Image.asset(
//                                                         'assets/images/placeholder.png',
//                                                       ),
//                                                     )),
//                                               ),
//                                               Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: dimen10),
//                                                   child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                       GestureDetector(
//                                                           onTap: () {
//                                                             showDialog<void>(
//                                                                 context:
//                                                                     context,
//                                                                 useSafeArea:
//                                                                     true,
//                                                                 barrierDismissible:
//                                                                     true, // user must tap button!
//                                                                 builder:
//                                                                     (BuildContext
//                                                                         dcontext) {
//                                                                   return AlertDialog(
//                                                                       insetPadding:
//                                                                           EdgeInsets
//                                                                               .zero,
//                                                                       contentPadding:
//                                                                           EdgeInsets
//                                                                               .zero,
//                                                                       content:
//                                                                           Wrap(
//                                                                         children: [
//                                                                           Column(
//                                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                                               children: <Widget>[
//                                                                                 GestureDetector(
//                                                                                   onTap: () {
//                                                                                     Navigator.of(dcontext).pop();
//                                                                                   },
//                                                                                   child: Container(
//                                                                                     alignment: FractionalOffset.topRight,
//                                                                                     margin: const EdgeInsets.only(top: 24, right: 24),
//                                                                                     child: const Icon(
//                                                                                       Icons.close,
//                                                                                       size: 26,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                     child: CachedNetworkImage(
//                                                                                   imageUrl: selectedImages[index].varImageUrl!,
//                                                                                   placeholder: (context, url) => Image.asset(
//                                                                                     'assets/images/placeholder.png',
//                                                                                   ),
//                                                                                   errorWidget: (context, url, error) => Image.asset(
//                                                                                     'assets/images/placeholder.png',
//                                                                                   ),
//                                                                                 )),
//                                                                               ])
//                                                                         ],
//                                                                       ));
//                                                                 });
//                                                           },
//                                                           child: Container(
//                                                             padding:
//                                                                 const EdgeInsets.all(
//                                                                     2),
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             dimen100))),
//                                                             child: Image.asset(
//                                                               "assets/icons/icon_expand.png",
//                                                               width: dimen30,
//                                                               height: dimen30,
//                                                             ),
//                                                           )),
//                                                       SizedBox(
//                                                         width: dimen10,
//                                                       ),
//                                                       GestureDetector(
//                                                           onTap: () {
//                                                             selectedImages
//                                                                 .removeAt(
//                                                                     index);
//                                                             setState(() {});
//                                                           },
//                                                           child: Container(
//                                                             padding:
//                                                                 const EdgeInsets.all(
//                                                                     2),
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             dimen100))),
//                                                             child: Image.asset(
//                                                               "assets/icons/icon_delete.png",
//                                                               width: dimen30,
//                                                               height: dimen30,
//                                                             ),
//                                                           )),
//                                                     ],
//                                                   ))
//                                             ],
//                                           ))),
//                                 )),
//                             if (_errProductImages != "")
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: dimen10, left: dimen20),
//                                 child: Text(
//                                   _errProductImages,
//                                   textAlign: TextAlign.start,
//                                   style: textSegoeUiColorRedSize16,
//                                 ),
//                               ),
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Checkbox(
//                                     value: _forVariation,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         _forVariation = newValue!;
//                                       });
//                                     },
//                                   ),
//                                   Container(
//                                     child: Text(
//                                       "Variation applicable",
//                                       style: textSegoeUiColorContentSize16,
//                                     ),
//                                   )
//                                 ]),
//                             if (!_forVariation)
//                               Container(
//                                 margin: EdgeInsets.only(top: dimen20),
//                                 child: Row(children: [
//                                   Expanded(
//                                       child: CommonInputWidget(
//                                     _controllerOldPrice,
//                                     hint: "Enter Sell Price",
//                                     isValidator: !_forVariation ? true : false,
//                                     validatorString: "Old price is required.",
//                                     inputType: TextInputType.number,
//                                   )),
//                                   SizedBox(
//                                     width: dimen10,
//                                   ),
//                                   Expanded(
//                                       child: Column(children: [
//                                     CommonInputWidget(
//                                       _controllerNewPrice,
//                                       hint: "Enter Discount Price",
//                                       haveForceError: discountAmountError,
//                                       forceError:
//                                           "Discount price should be less than sell price",
//                                       isValidator:
//                                           !_forVariation ? true : false,
//                                       validatorString: "Old price is required.",
//                                       inputType: TextInputType.number,
//                                       textChangeListner: (value) {
//                                         String s = value;
//                                         if (_controllerOldPrice.text != "" &&
//                                             value != "") {
//                                           if (double.parse(
//                                                   _controllerOldPrice.text) <=
//                                               double.parse(value)) {
//                                             setState(() {
//                                               discountAmountError = true;
//                                             });
//                                           } else {
//                                             setState(() {
//                                               discountAmountError = false;
//                                             });
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   ])),
//                                 ]),
//                               ),
//                             SizedBox(
//                               height: dimen30,
//                             ),
//                             if (_forVariation)
//                               Row(
//                                 children: [
//                                   Expanded(
//                                       child: Text(
//                                     "Variations",
//                                     style: textSegoeUiColorBlackSize16,
//                                   )),
//                                   GestureDetector(
//                                       onTap: () {
//                                         variationModel.add(VariationModel(
//                                             varSize:
//                                                 TextEditingController(text: ""),
//                                             fkUnit: VariationsUnitModel(),
//                                             fkColor: VariationsColorModel(),
//                                             discountPrice:
//                                                 TextEditingController(text: ""),
//                                             varVariationPrice:
//                                                 TextEditingController(
//                                                     text: "")));
//                                         if (mounted) {
//                                           setState(() {});
//                                         }
//                                       },
//                                       child: Image.asset(
//                                         "assets/icons/add.png",
//                                         width: dimen20,
//                                         height: dimen20,
//                                         color: Colors.black,
//                                       ))
//                                 ],
//                               ),
//                             if (_forVariation)
//                               ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: variationModel.length,
//                                   itemBuilder: ((context, index) => Container(
//                                         margin: EdgeInsets.only(top: dimen20),
//                                         padding: EdgeInsets.all(dimen15),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               width: 2,
//                                               color: const Color(colorDADADA)),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(dimen20)),
//                                           color: const Color(colorF4F4F4),
//                                         ),
//                                         child: Column(children: [
//                                           if (index != 0)
//                                             Container(
//                                                 alignment: FractionalOffset
//                                                     .centerRight,
//                                                 child: GestureDetector(
//                                                     onTap: () {
//                                                       variationModel
//                                                           .removeAt(index);
//                                                       setState(() {});
//                                                     },
//                                                     child: const Icon(Icons.remove))),
//                                           Row(children: [
//                                             Expanded(
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                   Text(
//                                                     "Size",
//                                                     style:
//                                                         textSegoeUiColorBlackSize16,
//                                                   ),
//                                                   SizedBox(
//                                                     height: dimen10,
//                                                   ),
//                                                   SizedBox(
//                                                       height: dimen50,
//                                                       child: CommonInputWidget(
//                                                         variationModel[index]
//                                                             .varSize!,
//                                                         hint: "Size",
//                                                         inputType: TextInputType
//                                                             .number,
//                                                         textChangeListner:
//                                                             (value) {
//                                                           variationModel[index]
//                                                               .unitError = "";
//                                                           variationModel[index]
//                                                                   .isDataValid =
//                                                               true;
//                                                           if (value != "") {
//                                                             for (int k = 0;
//                                                                 k <
//                                                                     variationModel
//                                                                         .length;
//                                                                 k++) {
//                                                               if (k != index) {
//                                                                 if (variationModel[
//                                                                             k]
//                                                                         .varSize !=
//                                                                     null) {
//                                                                   if (variationModel[k]
//                                                                               .varSize!
//                                                                               .text ==
//                                                                           value &&
//                                                                       variationModel[index]
//                                                                               .fkUnit ==
//                                                                           variationModel[k]
//                                                                               .fkUnit) {
//                                                                     variationModel[
//                                                                             index]
//                                                                         .isDataValid = false;
//                                                                     variationModel[index]
//                                                                             .unitError =
//                                                                         "Size already filled";
//                                                                   }
//                                                                 }
//                                                               }
//                                                             }
//                                                             if (mounted) {
//                                                               setState(() {});
//                                                             }
//                                                           }
//                                                         },
//                                                       )),
//                                                   if (variationModel[index]
//                                                           .unitError !=
//                                                       "")
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: dimen10,
//                                                           left: dimen20),
//                                                       child: Text(
//                                                         variationModel[index]
//                                                             .unitError,
//                                                         style:
//                                                             textSegoeUiColorRedSize16,
//                                                       ),
//                                                     ),
//                                                 ])),
//                                             SizedBox(
//                                               width: dimen10,
//                                             ),
//                                             Expanded(
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                   Text(
//                                                     "Unit",
//                                                     style:
//                                                         textSegoeUiColorBlackSize16,
//                                                   ),
//                                                   SizedBox(
//                                                     height: dimen10,
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                       left: dimen10,
//                                                       right: dimen10,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                         color: const Color(
//                                                             colorF7F8F9),
//                                                         border: Border.all(
//                                                             width: 2.0,
//                                                             color: const Color(
//                                                                 colorDADADA)),
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     dimen10))),
//                                                     child: SizedBox(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width -
//                                                               dimen50,
//                                                       child: Stack(
//                                                         alignment:
//                                                             FractionalOffset
//                                                                 .center,
//                                                         children: [
//                                                           Container(
//                                                               padding: EdgeInsets
//                                                                   .only(
//                                                                       top:
//                                                                           dimen12,
//                                                                       bottom:
//                                                                           dimen12),
//                                                               alignment:
//                                                                   FractionalOffset
//                                                                       .bottomLeft,
//                                                               child: Text(
//                                                                   variationModel[index]
//                                                                               .fkUnit!
//                                                                               .intGlcode !=
//                                                                           null
//                                                                       ? variationModel[
//                                                                               index]
//                                                                           .fkUnit!
//                                                                           .varTitle!
//                                                                       : "Unit",
//                                                                   style: variationModel[index]
//                                                                               .fkUnit!
//                                                                               .intGlcode !=
//                                                                           null
//                                                                       ? textSegoeUiColorBlackSize16
//                                                                       : textSegoeUiColorContentSize16)),
//                                                           Container(
//                                                               alignment:
//                                                                   FractionalOffset
//                                                                       .centerRight,
//                                                               child: DropdownButton<
//                                                                   VariationsUnitModel>(
//                                                                 isExpanded:
//                                                                     true,
//                                                                 underline:
//                                                                     Container(),
//                                                                 icon:
//                                                                     Image.asset(
//                                                                   "assets/icons/arrow_down.png",
//                                                                   width:
//                                                                       dimen15,
//                                                                   height:
//                                                                       dimen15,
//                                                                 ),
//                                                                 items: units.map(
//                                                                     (VariationsUnitModel
//                                                                         value) {
//                                                                   return DropdownMenuItem<
//                                                                       VariationsUnitModel>(
//                                                                     value:
//                                                                         value,
//                                                                     child: Text(
//                                                                         value
//                                                                             .varTitle!),
//                                                                   );
//                                                                 }).toList(),
//                                                                 onChanged: (_) {
//                                                                   variationModel[
//                                                                           index]
//                                                                       .fkUnit = _!;
//                                                                   variationModel[
//                                                                           index]
//                                                                       .unitError = "";
//                                                                   variationModel[
//                                                                           index]
//                                                                       .isDataValid = true;
//                                                                   for (int k =
//                                                                           0;
//                                                                       k <
//                                                                           variationModel
//                                                                               .length;
//                                                                       k++) {
//                                                                     if (k !=
//                                                                         index) {
//                                                                       if (variationModel[k]
//                                                                               .varSize !=
//                                                                           null) {
//                                                                         if (variationModel[k].varSize!.text == variationModel[index].varSize!.text &&
//                                                                             variationModel[index].fkUnit ==
//                                                                                 variationModel[k].fkUnit) {
//                                                                           variationModel[index].isDataValid =
//                                                                               false;
//                                                                           variationModel[index].unitError =
//                                                                               "Size already filled";
//                                                                         }
//                                                                       }
//                                                                     }
//                                                                   }
//                                                                   if (mounted) {
//                                                                     setState(
//                                                                         () {});
//                                                                   }
//                                                                   setState(
//                                                                       () {});
//                                                                 },
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   if (variationModel[index]
//                                                           .unitError !=
//                                                       "")
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: dimen10,
//                                                           left: dimen20),
//                                                       child: Text(
//                                                         variationModel[index]
//                                                             .unitError,
//                                                         style: const TextStyle(
//                                                             color: Colors
//                                                                 .transparent),
//                                                       ),
//                                                     ),
//                                                 ]))
//                                           ]),
//                                           SizedBox(
//                                             height: dimen20,
//                                           ),
//                                           Row(children: [
//                                             Expanded(
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                   Text(
//                                                     "Color",
//                                                     style:
//                                                         textSegoeUiColorBlackSize16,
//                                                   ),
//                                                   SizedBox(
//                                                     height: dimen10,
//                                                   ),
//                                                   Container(
//                                                     height: dimen50,
//                                                     padding: EdgeInsets.only(
//                                                       left: dimen10,
//                                                       right: dimen10,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                         color: const Color(
//                                                             colorF7F8F9),
//                                                         border: Border.all(
//                                                             width: 2.0,
//                                                             color: const Color(
//                                                                 colorDADADA)),
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     dimen10))),
//                                                     child: SizedBox(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width -
//                                                               dimen40,
//                                                       child: Stack(
//                                                         alignment:
//                                                             FractionalOffset
//                                                                 .center,
//                                                         children: [
//                                                           Container(
//                                                               padding: EdgeInsets
//                                                                   .only(
//                                                                       top:
//                                                                           dimen12,
//                                                                       bottom:
//                                                                           dimen12),
//                                                               alignment:
//                                                                   FractionalOffset
//                                                                       .bottomLeft,
//                                                               child: Text(
//                                                                   variationModel[index]
//                                                                               .fkColor!
//                                                                               .intGlcode !=
//                                                                           null
//                                                                       ? variationModel[
//                                                                               index]
//                                                                           .fkColor!
//                                                                           .varTitle!
//                                                                       : "Color",
//                                                                   style: variationModel[index]
//                                                                               .fkColor!
//                                                                               .intGlcode !=
//                                                                           null
//                                                                       ? textSegoeUiColorBlackSize16
//                                                                       : textSegoeUiColorContentSize16)),
//                                                           Container(
//                                                               alignment:
//                                                                   FractionalOffset
//                                                                       .centerRight,
//                                                               child: DropdownButton<
//                                                                   VariationsColorModel>(
//                                                                 isExpanded:
//                                                                     true,
//                                                                 underline:
//                                                                     Container(),
//                                                                 icon:
//                                                                     Image.asset(
//                                                                   "assets/icons/arrow_down.png",
//                                                                   width:
//                                                                       dimen15,
//                                                                   height:
//                                                                       dimen15,
//                                                                 ),
//                                                                 items: colors.map(
//                                                                     (VariationsColorModel
//                                                                         value) {
//                                                                   return DropdownMenuItem<
//                                                                       VariationsColorModel>(
//                                                                     value:
//                                                                         value,
//                                                                     child: Text(
//                                                                         value
//                                                                             .varTitle!),
//                                                                   );
//                                                                 }).toList(),
//                                                                 onChanged: (_) {
//                                                                   variationModel[
//                                                                           index]
//                                                                       .colorError = "";
//                                                                   bool isExist =
//                                                                       false;
//                                                                   variationModel[
//                                                                           index]
//                                                                       .isDataValid = true;
//                                                                   for (var element in variationModel) {
//                                                                     if (element
//                                                                             .fkColor!
//                                                                             .intGlcode ==
//                                                                         _!.intGlcode) {
//                                                                       variationModel[index]
//                                                                               .isDataValid =
//                                                                           false;
//                                                                       variationModel[index]
//                                                                               .colorError =
//                                                                           "${_.varTitle} color already filled.";
//                                                                     } else {
//                                                                       isExist =
//                                                                           true;
//                                                                     }
//                                                                   }
//                                                                   variationModel[
//                                                                           index]
//                                                                       .fkColor = _;
//                                                                   setState(
//                                                                       () {});
//                                                                 },
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   if (variationModel[index]
//                                                           .colorError !=
//                                                       "")
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: dimen10,
//                                                           left: dimen20),
//                                                       child: Text(
//                                                         variationModel[index]
//                                                             .colorError,
//                                                         style:
//                                                             textSegoeUiColorRedSize16,
//                                                       ),
//                                                     ),
//                                                 ])),
//                                             SizedBox(
//                                               width: dimen10,
//                                             ),
//                                             Expanded(
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                   Text(
//                                                     "Price",
//                                                     style:
//                                                         textSegoeUiColorBlackSize16,
//                                                   ),
//                                                   SizedBox(
//                                                     height: dimen10,
//                                                   ),
//                                                   SizedBox(
//                                                       child: CommonInputWidget(
//                                                     variationModel[index]
//                                                         .varVariationPrice!,
//                                                     hint: "Price",
//                                                     inputType:
//                                                         TextInputType.number,
//                                                   )),
//                                                   if (variationModel[index]
//                                                           .colorError !=
//                                                       "")
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: dimen10,
//                                                           left: dimen20),
//                                                       child: Text(
//                                                         variationModel[index]
//                                                             .colorError,
//                                                         style: const TextStyle(
//                                                             color: Colors
//                                                                 .transparent),
//                                                       ),
//                                                     ),
//                                                 ])),
//                                           ]),
//                                         ]),
//                                       ))),
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             CommonInputWidget(
//                               _controllerShortDesc,
//                               hint: "Short Description",
//                               isValidator: true,
//                               validatorString: "Short description is requird.",
//                               inputType: TextInputType.text,
//                             ),
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             CommonInputWidget(
//                               _controllerLongDesc,
//                               hint: "Description",
//                               isValidator: true,
//                               line: 5,
//                               validatorString: "Description is requird.",
//                               inputType: TextInputType.text,
//                             ),
//                             SizedBox(
//                               height: dimen30,
//                             ),
//                             Container(
//                                 alignment: FractionalOffset.centerLeft,
//                                 child: Text(
//                                   "Preparation Time",
//                                   style: textSegoeUiColorBlackSize16,
//                                 )),
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CommonInputWidget(
//                                     _controllerTime,
//                                     hint: "Time  01 - 99",
//                                     isValidator: true,
//                                     maxlength: 2,
//                                     validatorString: "Time is requird.",
//                                     inputType: TextInputType.number,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: dimen10,
//                                 ),
//                                 Expanded(
//                                     child: Column(children: [
//                                   Container(
//                                     height: dimen50,
//                                     padding: EdgeInsets.only(
//                                       left: dimen10,
//                                       right: dimen10,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: const Color(colorF7F8F9),
//                                         border: Border.all(
//                                             width: 2.0,
//                                             color: const Color(colorDADADA)),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(dimen10))),
//                                     child: SizedBox(
//                                       width: MediaQuery.of(context).size.width -
//                                           dimen40,
//                                       child: Stack(
//                                         alignment: FractionalOffset.center,
//                                         children: [
//                                           Container(
//                                               padding: EdgeInsets.only(
//                                                   top: dimen12,
//                                                   bottom: dimen12),
//                                               alignment:
//                                                   FractionalOffset.bottomLeft,
//                                               child: Text(
//                                                   selectTimeUnit != ""
//                                                       ? selectTimeUnit
//                                                       : "Minutes",
//                                                   style: selectTimeUnit != ""
//                                                       ? textSegoeUiColorBlackSize16
//                                                       : textSegoeUiColorContentSize16)),
//                                           Container(
//                                             alignment:
//                                                 FractionalOffset.centerRight,
//                                             child: DropdownButton<String>(
//                                               isExpanded: true,
//                                               underline: Container(),
//                                               icon: Image.asset(
//                                                 "assets/icons/arrow_down.png",
//                                                 width: dimen15,
//                                                 height: dimen15,
//                                               ),
//                                               items: [
//                                                 "Minutes",
//                                                 "Hours",
//                                                 "Days"
//                                               ].map((String value) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (_) {
//                                                 selectTimeUnit = _!;
//                                                 setState(() {});
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   if (_erroTimeUnit != "")
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: dimen10, left: dimen20),
//                                       child: SizedBox(
//                                           height: dimen20,
//                                           child: Text(
//                                             "",
//                                             textAlign: TextAlign.start,
//                                             style: textSegoeUiColorRedSize16,
//                                           )),
//                                     ),
//                                 ])),
//                               ],
//                             ),
//                             SizedBox(
//                               height: dimen30,
//                             ),
//                             Container(
//                                 alignment: FractionalOffset.centerLeft,
//                                 child: Text(
//                                   "Video Links",
//                                   style: textSegoeUiColorBlackSize16,
//                                 )),
//                             SizedBox(
//                               height: dimen20,
//                             ),
//                             CommonInputWidget(
//                               _controllerVidoeLink,
//                               hint: "Video Links",
//                               inputType: TextInputType.text,
//                             )
//                           ],
//                         ),
//                       )))),
//           Container(
//               margin: EdgeInsets.only(top: dimen30, bottom: dimen30),
//               height: dimen50,
//               child: Row(children: [
//                 Expanded(
//                     child: GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child:
//                             const CustomButtonColorLightRedWidget("Cancel", false))),
//                 SizedBox(
//                   width: dimen10,
//                 ),
//                 Expanded(
//                     child: GestureDetector(
//                         onTap: () {
//                           categoryError = "";
//                           _errProductImages = "";
//                           _erroTimeUnit = "";
//                           if (selectedCategory.intGlcode == null) {
//                             categoryError = "Category is required.";
//                           }
//                           if (selectedImages.length == 1) {
//                             _errProductImages = "Product image required";
//                           }
//                           if (_controllerTime.text == "") {
//                             _erroTimeUnit = "time error";
//                           }
//
//                           _formKey.currentState!.validate();
//                           if (_formKey.currentState!.validate() &&
//                               selectedCategory.intGlcode != null &&
//                               selectedImages.length != 1 &&
//                               validateVariation()) {
//                             addProduct();
//                           }
//                           if (mounted) {
//                             setState(() {});
//                           }
//                         },
//                         child: CustomButtonColorSecondaryWidget(
//                             "Save",
//                             _addProductRepository.accountResp.status ==
//                                 Status.LOADING))),
//               ]))
//         ])),
//         "Add Product");
//   }
//
//   final AddProductRepository _addProductRepository = AddProductRepository();
//   addProduct() {
//     var data = <String, dynamic>{};
//     data["fk_category"] = selectedCategory.intGlcode!;
//     data["fk_vendor"] = _userId;
//     data["var_title"] = _controllerTitle.text;
//     data["var_price"] = _controllerOldPrice.text;
//     data["var_new_price"] = _controllerNewPrice.text;
//     data["is_variation_available"] = _forVariation ? "Y" : "N";
//     List<String> arrsizes = [];
//     List<String> arrfkUnit = [];
//     List<String> arrfkColor = [];
//     List<String> arrvarVariationPrice = [];
//     List<String> arrvarVariationDiscountedPrice = [];
//     for (var element in variationModel) {
//       arrsizes.add(element.varSize != null ? element.varSize!.text : "");
//
//       arrvarVariationPrice.add(element.varVariationPrice != null
//           ? element.varVariationPrice!.text
//           : "");
//
//       arrvarVariationDiscountedPrice.add(
//           element.discountPrice != null ? element.discountPrice!.text : "");
//       arrfkUnit.add(
//           element.fkUnit!.intGlcode != null ? element.fkUnit!.intGlcode! : "");
//       arrfkColor.add(element.fkColor!.intGlcode != null
//           ? element.fkColor!.intGlcode!
//           : "");
//     }
//
//     data["var_size"] = json.encode(arrsizes);
//     data["fk_unit"] = json.encode(arrfkUnit);
//     data["fk_color"] = json.encode(arrfkColor);
//     data["var_variation_price"] = json.encode(arrvarVariationPrice);
//     data["var_variation_discounted_price"] =
//         json.encode(arrvarVariationDiscountedPrice);
//     data["var_short_description"] = _controllerShortDesc.text;
//     data["txt_description"] = _controllerLongDesc.text;
//     data["var_time"] = _controllerTime.text;
//     data["var_min"] = selectTimeUnit == "Minutes" ? _controllerTime.text : "";
//     data["var_hr"] = selectTimeUnit == "Hours" ? _controllerTime.text : "";
//     data["var_day"] = selectTimeUnit == "Days" ? _controllerTime.text : "";
//     List<String> varimages = [];
//
//     for (int i = 1; i < selectedImages.length; i++) {
//       varimages.add(selectedImages[i].varImageUrl != null
//           ? selectedImages[i].varImageUrl!
//           : "");
//     }
//
//     data["var_video_links"] = _controllerVidoeLink.text;
//     data["var_image_url"] = json.encode(varimages);
//     _addProductRepository
//         .addProduct(
//             data: data,
//             stateChange: () {
//               if (mounted) {
//                 setState(() {});
//               }
//             })
//         .then((value) {
//       if (value["body"]["code"] == 200) {
//         showDialog<void>(
//           context: context,
//           barrierDismissible: true, // user must tap button!
//           builder: (BuildContext context) {
//             return AlertDialog(
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     Container(
//                         alignment: FractionalOffset.centerLeft,
//                         child: Text(
//                           value["body"]["msg"],
//                           style: textSegoeUiColorContentSize14,
//                         )),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 Container(
//                     alignment: FractionalOffset.centerRight,
//                     child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(
//                                   builder: (context) => DashboardScreen()),
//                               (Route<dynamic> route) => false);
//                         },
//                         child: Container(
//                             margin: EdgeInsets.only(right: dimen20),
//                             color: Colors.transparent,
//                             child: Text(
//                               'Okay',
//                               style: textSegoeUiColorContentSize14,
//                             )))),
//               ],
//             );
//           },
//         );
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(value["body"]["msg"])));
//       }
//     });
//   }
// }
