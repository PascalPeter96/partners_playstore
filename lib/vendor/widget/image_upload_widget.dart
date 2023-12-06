import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';

class ImageUploadWidget extends StatefulWidget {
  String hint;
  var onImageSelect;
  var image;
  String onlineUrl;
  bool isError;
  ImageUploadWidget(this.hint, this.onImageSelect,
      {this.image, this.onlineUrl = "", this.isError = false});

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Container(
                            alignment: FractionalOffset.centerLeft,
                            child: Text(
                              "Choose photo",
                              style: textSegoeUiColorContentSize16,
                            )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                alignment: FractionalOffset.center,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      pickImageFromCamera();
                                    },
                                    child: Container(
                                        alignment: FractionalOffset.center,
                                        color: Colors.transparent,
                                        child: Text(
                                          'Camera',
                                          textAlign: TextAlign.center,
                                          style: textSegoeUiColor4C5967Size18,
                                        ))))),
                        Container(
                          height: dimen20,
                          width: dimen02,
                          color: Colors.black12,
                        ),
                        Expanded(
                            child: Container(
                                width: dimen100,
                                alignment: FractionalOffset.center,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);

                                      pickImageFromGallery();
                                    },
                                    child: Container(
                                        alignment: FractionalOffset.center,
                                        color: Colors.transparent,
                                        child: Text(
                                          'Gallery',
                                          textAlign: TextAlign.center,
                                          style: textSegoeUiColor4C5967Size18,
                                        ))))),
                      ],
                    )
                  ],
                );
              },
            );
          } else if (Platform.isIOS) {
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                content: Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Choose station photo",
                      style: textSegoeUiColorContentSize16,
                    )),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {},
                    child: Container(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              pickImageFromCamera();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: dimen20),
                                color: Colors.transparent,
                                child: Text(
                                  'Camera',
                                  style: textSegoeUiColor4C5967Size18,
                                )))),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {},
                    child: Container(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              pickImageFromGallery();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: dimen20),
                                color: Colors.transparent,
                                child: Text(
                                  'Gallery',
                                  style: textSegoeUiColor4C5967Size18,
                                )))),
                  )
                ],
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(dimen20),
          decoration: BoxDecoration(
              color: const Color(colorF7F8F9),
              borderRadius: BorderRadius.all(Radius.circular(dimen10)),
              border: Border.all(
                width: 2,
                color: widget.isError ? Colors.red : const Color(colorDADADA),
              )),
          child: widget.image != null
              ? Stack(
                  alignment: FractionalOffset.topRight,
                  children: [
                    SizedBox(
                        height: dimen100,
                        width: dimen100,
                        child: Image.file(
                          File(widget.image.path),
                        )),
                    GestureDetector(
                        onTap: () {
                          widget.image = null;
                          widget.onImageSelect(null);
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: const Icon(Icons.delete)),
                  ],
                )
              : widget.onlineUrl != ""
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/placeholder.png',
                      ),
                      image: widget.onlineUrl,
                      fit: BoxFit.fitWidth,
                      width: dimen100,
                      height: dimen100,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(dimen40)),
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(colorDADADA),
                                  )),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(dimen40),
                                  child: Container(
                                      padding: EdgeInsets.all(dimen15),
                                      child: Image.asset(
                                        "assets/icons/icon_upload.png",
                                        width: dimen30,
                                        height: dimen30,
                                      )))),
                          SizedBox(
                            height: dimen10,
                          ),
                          Text(
                            widget.hint,
                            style: textSegoeUiColorContentSize16,
                          )
                        ]),
        ));
  }

  final ImagePicker _picker = ImagePicker();
  pickImageFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    widget.onImageSelect(image);
    widget.image = image;
    fileCrop(File(image!.path));
    if (mounted) {
      setState(() {});
    }
  }

  pickImageFromCamera() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    fileCrop(File(photo!.path));
    if (mounted) {
      setState(() {});
    }
  }

  fileCrop(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      widget.onImageSelect(File(croppedFile.path));
      widget.image = File(croppedFile.path);
    }
  }
}
