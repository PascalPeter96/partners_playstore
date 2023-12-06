import 'dart:convert';
import 'dart:io';

import 'package:amount_formatter/amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/theme/theme_service.dart';
import 'package:wena_partners/vendor/contollers/wallet/wallet_controller.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class WalletDepositScreen extends StatefulWidget {
  final String paymentUrl;
  final String amount;
  const WalletDepositScreen({Key? key, required this.paymentUrl, required this.amount,}) : super(key: key);

  @override
  State<WalletDepositScreen> createState() => _WalletDepositScreenState();
}

class _WalletDepositScreenState extends State<WalletDepositScreen> {
  final AmountFormatter amountFormatter = AmountFormatter(separator: ',');

  late WebViewController webViewController;

  final VendorWalletController walletController = Get.find();

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: ThemeService().isSavedDarkMode() ? Brightness.light : Brightness.dark,

        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
          title: 'Wena Wallet Deposit',
          titleWidget: Row(
            children: const [
            ],
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController){
          this.webViewController = webViewController;
        },
        onPageFinished: (finish)async{
          final response = await webViewController.runJavascriptReturningResult("document.documentElement.innerText");
          var dataResponse = jsonDecode(response);
          var data = json.decode(dataResponse);
          print(dataResponse);
          print(data);

          if(data['status'] == 'success'){

            walletController.fetchWalletDetails();
            Get.back();
            Get.snackbar('SUCCESS', 'You have topped up ${amountFormatter.format(widget.amount.toString())}/= to your wallet', titleText: Text('SUCCESS', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),));

          } else {
            print('Deposit failed');
            Get.back();
            Fluttertoast.showToast(
                msg: 'Deposit Failed, try again later',
                backgroundColor: AppTheme.redFillColor2,
                textColor: Colors.white
            );
          }

        },
      ),
    );
  }
}