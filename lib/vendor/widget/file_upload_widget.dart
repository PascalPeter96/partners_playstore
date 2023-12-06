import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';


class FileUploadWidget extends StatefulWidget {
  String hint;
  var onFileSelect;
  var file;
  String onlineUrl;
  bool isError;
  FileUploadWidget(this.hint, this.onFileSelect,
      {this.file, this.onlineUrl = "", this.isError = false});

  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          filePick();
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(dimen40)),
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
                widget.file != null
                    ? Text(
                        widget.file.path.toString().split("/")[
                            widget.file.path.toString().split("/").length - 1],
                        style: textSegoeUiColorContentSize16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : widget.onlineUrl != ""
                        ? GestureDetector(
                            onTap: () async {
                              if (!await launchUrl(Uri.parse(widget.onlineUrl),
                                  mode: LaunchMode.externalApplication)) {
                                throw 'Could not launch $widget.onlineUrl';
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: dimen20, right: dimen20),
                                child: Text(
                                  "View file",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textSegoeUiColorBlueSize18,
                                )))
                        : Text(
                            widget.hint,
                            style: textSegoeUiColorContentSize16,
                          )
              ]),
        ));
  }

  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["pdf", "jpeg", "jpg", "png"],
      type: FileType.custom,
      allowCompression: true,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      widget.onFileSelect(file);
      widget.file = file;
    } else {
      // User canceled the picker
    }
    if (mounted) {
      setState(() {});
    }
  }
}
