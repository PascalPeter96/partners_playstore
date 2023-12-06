import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'loading_widget.dart';

class CustomButtonColorSecondaryWidget extends StatelessWidget {
  final String title;

  final bool isLoading;

  const CustomButtonColorSecondaryWidget(this.title, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(colorSecondary),
          borderRadius: BorderRadius.circular(dimen15)),
      child: Align(
          alignment: FractionalOffset.center,
          child: Row(children: [
            Expanded(
              flex: 9,
              child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        Container(
                          height: dimen15,
                          width: dimen15,
                          margin: EdgeInsets.only(right: dimen05),
                          child: LoadingWidget(),
                        ),
                      Container(
                        child: Text(
                          title,
                          style: textSegoeUiWhiteSize16,
                        ),
                      )
                    ],
                  )),
            ),
          ])),
    );
  }
}

class CustomButtonColorLightRedWidget extends StatelessWidget {
  final String title;

  final bool isLoading;

  const CustomButtonColorLightRedWidget(this.title, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(colorLightRed).withOpacity(0.15),
          border: Border.all(
              width: 1, color: const Color(colorLightRed).withOpacity(0.5)),
          borderRadius: BorderRadius.circular(dimen15)),
      child: Align(
          alignment: FractionalOffset.center,
          child: Row(children: [
            Expanded(
              flex: 9,
              child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        Container(
                          height: dimen15,
                          width: dimen15,
                          margin: EdgeInsets.only(right: dimen05),
                          child: LoadingWidget(),
                        ),
                      Container(
                        child: Text(
                          title,
                          style: textSegoeUiColorOpacityLightRedSize14,
                        ),
                      )
                    ],
                  )),
            ),
          ])),
    );
  }
}

class CustomButtonColorLightGreenWidget extends StatelessWidget {
  final String title;

  final bool isLoading;

  const CustomButtonColorLightGreenWidget(this.title, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(colorSecondary).withOpacity(0.15),
          borderRadius: BorderRadius.circular(dimen15)),
      child: Align(
          alignment: FractionalOffset.center,
          child: Row(children: [
            Expanded(
              flex: 9,
              child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        Container(
                          height: dimen15,
                          width: dimen15,
                          margin: EdgeInsets.only(right: dimen05),
                          child: LoadingWidget(),
                        ),
                      Container(
                        child: Text(
                          title,
                          style: textSegoeUiColorOpacityLightGreenSize14,
                        ),
                      )
                    ],
                  )),
            ),
          ])),
    );
  }
}
