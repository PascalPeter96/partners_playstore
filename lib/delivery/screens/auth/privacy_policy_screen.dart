import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
          title: 'Privacy',
          titleWidget: Row(
            children: [
                  Center(
                    child: IconButton(
                        onPressed: () async{
                          if(await webViewController.canGoBack()){
                            webViewController.goBack();
                          }
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.black,)),
                  ),

                  Center(
                    child: IconButton(
                        onPressed: () async {
                          await webViewController.reload();
                        },
                        icon: Icon(Icons.refresh, color: Colors.black)),
                  ),

                  Center(
                    child: IconButton(
                        onPressed: () async{
                          if(await webViewController.canGoForward()){
                            webViewController.goForward();
                          }
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.black)),
                  ),
            ],
          ),
        ),
      ),
      body: WebView(
        initialUrl: 'https://wenahardware.com/privacy-policy/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController){
          this.webViewController = webViewController;
        },
      ),
    );
  }
}