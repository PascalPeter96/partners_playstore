import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/product/models/ChooseImageProductModel.dart';
import 'package:wena_partners/vendor/product/repository/product_image_repository.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class ChooseImagesScreen extends StatefulWidget {
  String productName;
  String category;
  var selectImageLister;
  ChooseImagesScreen(this.productName, this.category, this.selectImageLister);
  @override
  _ChooseImagesState createState() => _ChooseImagesState();
}

class _ChooseImagesState extends State<ChooseImagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductImage();
  }

  Map<String, ChooseImageProductModel> selectedImages = {};

  final ProductImageRepository _productImagesRepository = ProductImageRepository();
  List<ChooseImageProductModel> _productImageModel = [];
  getProductImage() async {
    _productImagesRepository.getProductImages(
        data: {"product_name": widget.productName, "category": widget.category},
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_productImagesRepository.productResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_productImagesRepository.productResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["code"] == 200) {
        _productImageModel = value["body"]["data"]
            .map<ChooseImageProductModel>(
                (json) => ChooseImageProductModel.fromJson(json))
            .toList();
        String s = "";
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: Container(
                alignment: FractionalOffset.centerLeft,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: GridView.builder(
                                itemCount: _productImageModel.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: dimen10,
                                        crossAxisSpacing: dimen10),
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    GestureDetector(
                                      onTap: () {
                                        if (selectedImages.length <= 9) {
                                          if (!selectedImages.containsKey(
                                              _productImageModel[index]
                                                  .intGlcode!)) {
                                            selectedImages[
                                                    _productImageModel[index]
                                                        .intGlcode!] =
                                                _productImageModel[index];
                                          } else {
                                            selectedImages.removeWhere(
                                                ((key, element) =>
                                                    _productImageModel[index]
                                                        .intGlcode! ==
                                                    element.intGlcode!));
                                          }
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(dimen20)),
                                              border: Border.all(
                                                  width: 2,
                                                  color: selectedImages
                                                          .containsKey(
                                                              _productImageModel[
                                                                      index]
                                                                  .intGlcode!)
                                                      ? const Color(colorSecondary)
                                                      : const Color(colorDADADA))),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      dimen20),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    _productImageModel[index]
                                                        .varImageUrl!,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  'assets/images/placeholder.png',
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  'assets/images/placeholder.png',
                                                ),
                                              ))),
                                    )))),
                    Container(
                      margin: EdgeInsets.only(bottom: dimen200),
                      width: MediaQuery.of(context).size.width - dimen80,
                      padding: EdgeInsets.all(dimen20),
                      decoration: BoxDecoration(
                          color: const Color(colorF7F7F7),
                          borderRadius:
                              BorderRadius.all(Radius.circular(dimen20)),
                          border: Border.all(
                            width: 1,
                            color: const Color(colorDADADA),
                          )),
                      child: Text("Request For Image",
                          style: textSegoeUiColorContentSize16),
                    ),
                    GestureDetector(
                        onTap: () {
                          widget.selectImageLister(selectedImages.entries
                              .map((e) => e.value)
                              .toList());
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: dimen40),
                            height: dimen60,
                            child: const CustomButtonColorSecondaryWidget(
                                "Sign Up", false)))
                  ],
                ))),
        "Choose Images (${selectedImages.length}/9)");
  }
}
