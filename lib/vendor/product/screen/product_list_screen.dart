import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/product/models/ProductModel.dart';
import 'package:wena_partners/vendor/product/repository/delete_product_repository.dart';
import 'package:wena_partners/vendor/product/repository/product_list_repository.dart';
import 'package:wena_partners/vendor/product/repository/products_bydate_repository.dart';
import 'package:wena_partners/vendor/product/screen/edit_product_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class ProducListScreen extends StatefulWidget {
  var backListner;
  ProducListScreen({this.backListner});
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProducListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();

    super.initState();
  }

  String _userId = "";
  String _userToken = "";
  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    getProducts("", false);
  }

  final TextEditingController _controllerSearch = TextEditingController();
  final TextEditingController _controllerStartDate = TextEditingController();
  final TextEditingController _controllerEndDate = TextEditingController();

  final ProductListRepository _productRepository = ProductListRepository();
  ProductModel _productModel = ProductModel(data: []);
  getProducts(String productKeyword, bool isSearching) async {
    if (_productModel.data != null) {
      _productModel.data!.clear();
    }
    _productRepository.getProducts(
        data: {"fk_vendor": _userId, "keyword": productKeyword},
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (!isSearching) {
              if (_productRepository.productResp.status == Status.LOADING) {
                showLoadingDialog();
              } else if (_productRepository.productResp.status ==
                  Status.COMPLETED) {
                hideLoadingDialog();
              }
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _productModel = ProductModel.fromJson(value['body']);
      } else {}
    });
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1901, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        _controllerStartDate.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(1901, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      setState(() {
        _controllerEndDate.text = picked.toString().split(" ")[0];
      });
    }
  }

  final ProductListByDateRepository _productByDateRepository =
      ProductListByDateRepository();

  getByDateProducts(String productKeyword, bool isSearching) async {
    if (_productModel.data != null) {
      _productModel.data!.clear();
    }
    _productByDateRepository.getProducts(
        data: {
          "fk_vendor": _userId,
          "start_date": _controllerStartDate.text,
          "end_date": _controllerEndDate.text
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (!isSearching) {
              if (_productByDateRepository.productResp.status ==
                  Status.LOADING) {
                showLoadingDialog();
              } else if (_productByDateRepository.productResp.status ==
                  Status.COMPLETED) {
                hideLoadingDialog();
              }
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _productModel = ProductModel.fromJson(value['body']);
      } else {}
    });
  }

  FilterAscDec _filterAscDec = FilterAscDec.ASCENDING;

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackWidget(
      Expanded(
        child: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: const Color(colorDADADA)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(dimen10))),
              padding: EdgeInsets.all(dimen12),
              child: Row(children: [
                Image.asset(
                  "assets/icons/icon_search.png",
                  width: dimen30,
                  height: dimen30,
                ),
                Expanded(
                    child: TextFormField(
                        cursorColor: const Color(colorContent),
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.done,
                        controller: _controllerSearch,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        onChanged: (v) {
                          if (_controllerSearch.text.length > 2) {
                            getProducts(_controllerSearch.text, true);
                          }
                          if (_controllerSearch.text == "") {
                            getProducts(_controllerSearch.text, true);
                          }
                        },
                        onSaved: (value) {},
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: "Search Order...",
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.only(
                                left: 1,
                                top: 5,
                                bottom: 5,
                                right: 5), // Added this
                            border: InputBorder.none,
                            hintStyle: textSegoeUiColorContentSize16),
                        style: textSegoeUiColorBlackSize16)),
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0))),
                        builder: (BuildContext dcontext) {
                          return Container(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(dimen60),
                                      topRight: Radius.circular(dimen60))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(dcontext);
                                      },
                                      child: Container(
                                        width: dimen40,
                                        height: 4,
                                        color: const Color(colorContent),
                                      )),
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  Text(
                                    'Search by Date',
                                    style: textTahomaBlackSize20,
                                  ),
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  const Divider(
                                    height: 2,
                                    color: Color(colorContent),
                                  ),
                                  SizedBox(
                                    height: dimen30,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.only(left: dimen20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: textTahomaBlackSize16,
                                              ),
                                              SizedBox(
                                                height: dimen20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _selectDate(context);
                                                },
                                                child: TextFormField(
                                                    cursorColor:
                                                        const Color(colorContent),
                                                    textAlign: TextAlign.left,
                                                    enabled: false,
                                                    controller:
                                                        _controllerStartDate,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: dimen20,
                                                                top: dimen10,
                                                                bottom: dimen10,
                                                                right:
                                                                    dimen20), // Added this
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        suffixIcon: Container(
                                                          padding:
                                                              const EdgeInsets.all(3),
                                                          child: Image.asset(
                                                            "assets/icons/icon_calendar.png",
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                        ),
                                                        fillColor: const Color(
                                                            colorF7F8F9),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        hintStyle:
                                                            textSegoeUiColorContentSize16),
                                                    style:
                                                        textSegoeUiColorBlackSize16),
                                              )
                                            ]),
                                      )),
                                      SizedBox(
                                        width: dimen20,
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.only(right: dimen20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: textTahomaBlackSize16,
                                              ),
                                              SizedBox(
                                                height: dimen20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _selectDate2(context);
                                                },
                                                child: TextFormField(
                                                    cursorColor:
                                                        const Color(colorContent),
                                                    textAlign: TextAlign.left,
                                                    controller:
                                                        _controllerEndDate,
                                                    enabled: false,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: dimen20,
                                                                top: dimen10,
                                                                bottom: dimen10,
                                                                right:
                                                                    dimen20), // Added this
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        suffixIcon: Container(
                                                          padding:
                                                              const EdgeInsets.all(3),
                                                          child: Image.asset(
                                                            "assets/icons/icon_calendar.png",
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                        ),
                                                        fillColor: const Color(
                                                            colorF7F8F9),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  colorDADADA)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      dimen10),
                                                        ),
                                                        hintStyle:
                                                            textSegoeUiColorContentSize16),
                                                    style:
                                                        textSegoeUiColorBlackSize16),
                                              )
                                            ]),
                                      ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: dimen30,
                                  ),
                                  const Divider(
                                    height: 2,
                                    color: Color(colorContent),
                                  ),
                                  SizedBox(
                                    height: dimen30,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: dimen20,
                                      ),
                                      Text(
                                        "Filter",
                                        style: textSegoeUiColor161616Size18,
                                      ),
                                      Expanded(
                                          child: ListTile(
                                        title: Text(
                                          'Ascending',
                                          style: textSegoeUiColor161616Size16,
                                        ),
                                        leading: Radio(
                                          value: FilterAscDec.ASCENDING,
                                          groupValue: _filterAscDec,
                                          onChanged: (value) {
                                            setState(() {
                                              _filterAscDec =
                                                  value as FilterAscDec;
                                              Navigator.pop(dcontext);
                                              _productModel.data = _productModel
                                                  .data!.reversed
                                                  .toList();
                                            });
                                          },
                                        ),
                                      )),
                                      Expanded(
                                        child: ListTile(
                                            title: Text(
                                              'Descending',
                                              style:
                                                  textSegoeUiColor161616Size16,
                                            ),
                                            leading: Radio(
                                              value: FilterAscDec.DECENDING,
                                              groupValue: _filterAscDec,
                                              onChanged: (value) {
                                                setState(() {
                                                  _filterAscDec =
                                                      value as FilterAscDec;
                                                  Navigator.pop(dcontext);
                                                  _productModel.data =
                                                      _productModel
                                                          .data!.reversed
                                                          .toList();
                                                });
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dimen30,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: dimen20,
                                          right: dimen20,
                                          bottom: dimen30),
                                      height: dimen50,
                                      child: Row(children: [
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(dcontext);
                                                  getProducts("", false);
                                                },
                                                child:
                                                    const CustomButtonColorLightGreenWidget(
                                                        "Reset", false))),
                                        SizedBox(
                                          width: dimen10,
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(dcontext);
                                                  getByDateProducts("", false);
                                                },
                                                child:
                                                    const CustomButtonColorSecondaryWidget(
                                                        "Apply", false))),
                                      ]))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            color: const Color(colorSecondary),
                            borderRadius:
                                BorderRadius.all(Radius.circular(dimen10))),
                        child: Image.asset(
                          "assets/icons/icon_sort_menu.png",
                          width: dimen24,
                          height: dimen24,
                        )))
              ])),
          if (_productModel.data!.isNotEmpty)
            Container(
                margin: EdgeInsets.only(
                    left: dimen20, right: dimen20, top: dimen30),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0.0),
                    itemCount: _productModel.data!.length,
                    itemBuilder: ((context, index) => Container(
                        margin: EdgeInsets.only(bottom: dimen20),
                        padding: EdgeInsets.all(dimen15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(dimen20)),
                            border: Border.all(
                                width: 1, color: const Color(colorE8EFF3))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_productModel.data![index].images != null &&
                                _productModel
                                        .data![index].images![0].varImageUrl !=
                                    null)
                              GestureDetector(
                                  onTap: () {
                                    showDialog<void>(
                                        context: context,
                                        useSafeArea: true,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext dcontext) {
                                          return AlertDialog(
                                              insetPadding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.zero,
                                              content: Wrap(
                                                children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    dcontext)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            alignment:
                                                                FractionalOffset
                                                                    .topRight,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 24,
                                                                    right: 24),
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 26,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                            child:
                                                                CachedNetworkImage(
                                                          imageUrl:
                                                              _productModel
                                                                  .data![index]
                                                                  .images![0]
                                                                  .varImageUrl!,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Image.asset(
                                                            'assets/images/placeholder.png',
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'assets/images/placeholder.png',
                                                          ),
                                                        )),
                                                      ])
                                                ],
                                              ));
                                        });
                                  },
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/placeholder.png',
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/placeholder.png',
                                    ),
                                    image: _productModel
                                        .data![index].images![0].varImageUrl!,
                                    fit: BoxFit.fitWidth,
                                    width: dimen80,
                                    height: dimen80,
                                  )),
                            Expanded(
                                child: Container(
                              height: dimen80,
                              margin: EdgeInsets.only(left: dimen10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                          alignment:
                                              FractionalOffset.centerLeft,
                                          child: Text(
                                            _productModel
                                                .data![index].varTitle!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textSegoeUiColor303733Size16,
                                          ))),
                                  if (_productModel.data![index].oldPrice! !=
                                      "0")
                                    RichText(
                                        text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "$ugxSymbole ${_productModel
                                                  .data![index].oldPrice!}",
                                          style: TextStyle(
                                            color: const Color(colorContent),
                                            fontSize: dimen14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SegoeUi',
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    )),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "$ugxSymbole ${_productModel.data![index]
                                                              .newPrice! !=
                                                          "0"
                                                      ? _productModel
                                                          .data![index]
                                                          .newPrice!
                                                      : _productModel
                                                          .data![index]
                                                          .productVariations![0]
                                                          .varPrice!}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  textSegoeUiColor292D32Size18Light,
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                          ],
                                        )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProductScreen(
                                                          _productModel
                                                              .data![index]),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              child: Image.asset(
                                                "assets/icons/edit.png",
                                                width: dimen24,
                                                height: dimen24,
                                              ),
                                            )),
                                        SizedBox(
                                          width: dimen10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            deleteDialog(_productModel
                                                .data![index].intGlcode!);
                                          },
                                          child: Container(
                                              child: Image.asset(
                                            "assets/icons/disable.png",
                                            width: dimen24,
                                            height: dimen24,
                                          )),
                                        ),
                                      ])
                                ],
                              ),
                            ))
                          ],
                        ))))),
        ]))),
      ),
      "All Products",
      enabledAddButton: true,
      backListner: widget.backListner,
    );
  }

  deleteDialog(String productId) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext dcontext) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: Wrap(children: [
            Container(
              margin: EdgeInsets.only(left: dimen05, right: dimen05),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(dimen30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Delete",
                    textAlign: TextAlign.center,
                    style: textSegoeUiColor161616Size20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: dimen24, bottom: dimen32),
                    child: Text(
                      "Are you sure you want to Delete\nthis Product ?",
                      textAlign: TextAlign.center,
                      style: textSegoeUiColorContentSize16,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: dimen40,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(dcontext);
                            },
                            child: const CustomButtonColorLightRedWidget(
                                "Cancel", false)),
                      )),
                      SizedBox(
                        width: dimen20,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(dcontext);
                              DeleteProductRepository().deleteProducts(
                                  data: {
                                    "fk_vendor": _userId,
                                    "fk_product": productId,
                                    "var_auth_token": _userToken
                                  },
                                  stateChange: () {
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }).then((value) => getProducts("", false));
                            },
                            child: SizedBox(
                                height: dimen40,
                                child: const CustomButtonColorSecondaryWidget(
                                    "Yes, Remove", false))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimen30,
                  )
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}

enum FilterAscDec { ASCENDING, DECENDING }
