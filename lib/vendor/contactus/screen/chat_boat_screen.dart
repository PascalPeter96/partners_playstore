import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/background_widget_wb.dart';
import '../../widget/loading_dialog.dart';

class ChatBoatScreen extends StatefulWidget {
  @override
  ChatBoatState createState() => ChatBoatState();
}

class ChatBoatState extends State<ChatBoatScreen> {
  late WebViewController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showLoadingDialog();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: Container(
          child: WebView(
            onPageFinished: (url) {
              if (mounted) {
                hideLoadingDialog();
              }
            },
            initialUrl:
                'https://tawk.to/chat/635151b5daff0e1306d309cc/1gfqqec91',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) async {
              _controller = webViewController;

              //I've left out some of the code needed for a webview to work here, fyi
            },
          ),
        )),
        "Support");
  }
}
