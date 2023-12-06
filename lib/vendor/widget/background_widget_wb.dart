
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/vendor/product/screen/add_product_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';

class BackgroundWithBackWidget extends StatelessWidget {
  final Widget contentWidget;
  final String title;
  var backListner;
  bool enabledAddButton;
  BackgroundWithBackWidget(this.contentWidget, this.title,
      {this.backListner, this.enabledAddButton = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(left: dimen20, right: dimen20, top: dimen20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                      onTap: () {
                        if (backListner != null) {
                          backListner();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                          alignment: FractionalOffset.topLeft,
                          padding: EdgeInsets.all(dimen08),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(colorE8ECF4)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(dimen15))),
                          margin: EdgeInsets.only(right: 0, bottom: dimen20),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            size: dimen24,
                          ))),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              bottom: dimen20, left: dimen20, right: dimen20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: FractionalOffset.center,
                                  margin: EdgeInsets.only(
                                    right: dimen20,
                                  ),
                                  child: Text(
                                    title,
                                    style: textSegoeUiColor161616Size20,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          ))),
                  if (enabledAddButton)
                    GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AddProductScreen(),
                          //     ));
                        },
                        child: SizedBox(
                            height: dimen40,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: const Color(colorSecondary),
                                    size: dimen16,
                                  ),
                                  Text(
                                    " ADD",
                                    style: textSegoeUiColorSecondarySize16,
                                  )
                                ])))
                ]),
              ),
              contentWidget
            ],
          )),
    );
  }
}

class BackgroundWithBackMaterialWidget extends StatelessWidget {
  final Widget contentWidget;
  final String title;
  bool enabledAddButton;
  BackgroundWithBackMaterialWidget(this.contentWidget, this.title,
      {this.enabledAddButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Container(
                      margin: EdgeInsets.only(left: dimen20, right: dimen20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: dimen15,
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          alignment: FractionalOffset.topLeft,
                                          padding: EdgeInsets.only(
                                              left: dimen08,
                                              right: dimen08,
                                              bottom: dimen08,
                                              top: dimen08),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: const Color(colorE8ECF4)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(dimen15))),
                                          margin: EdgeInsets.only(
                                              right: 0, bottom: dimen20),
                                          child: const Icon(
                                              Icons.arrow_back_ios_sharp))),
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: dimen20,
                                              left: dimen20,
                                              right: dimen20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment:
                                                      FractionalOffset.center,
                                                  margin: EdgeInsets.only(
                                                    right: dimen20,
                                                  ),
                                                  child: Text(
                                                    title,
                                                    style:
                                                        textSegoeUiColor161616Size20,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                            ],
                                          ))),
                                  if (enabledAddButton)
                                    GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           AddProductScreen(),
                                          //     ));
                                        },
                                        child: SizedBox(
                                            height: dimen40,
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color:
                                                        const Color(colorSecondary),
                                                    size: dimen16,
                                                  ),
                                                  Text(
                                                    " ADD",
                                                    style:
                                                        textSegoeUiColorSecondarySize16,
                                                  )
                                                ])))
                                ]),
                          ),
                          contentWidget
                        ],
                      )),
                )))));
  }
}
