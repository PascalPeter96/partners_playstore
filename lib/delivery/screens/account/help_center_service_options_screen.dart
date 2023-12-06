import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/account/help_center_screen.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class HelpCenterServiceOptionsScreen extends StatefulWidget {
  const HelpCenterServiceOptionsScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterServiceOptionsScreen> createState() => _HelpCenterServiceOptionsScreenState();
}

class _HelpCenterServiceOptionsScreenState extends State<HelpCenterServiceOptionsScreen> {

  // final Uri whatsappUri = Uri(scheme: 'https', path: 'https://wa.me/message/NGRU7GV2WAUYD1');
  final Uri whatsappUri = Uri.parse('https://api.whatsapp.com/message/NGRU7GV2WAUYD1');
  // final Uri whatsappUri = Uri.parse('https://chat.whatsapp.com/NGRU7GV2WAUYD1');

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
          title: 'Help Center Service Options',
          titleWidget: Container(width: 10.w,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bounceable(
                onTap: () async{
                  if(await canLaunchUrl(whatsappUri)){
                    // await launchUrl(whatsappUri,);
                    await launch('https://api.whatsapp.com/message/NGRU7GV2WAUYD1',forceWebView: false ,);
                    // await launchUrlString('https://api.whatsapp.com/message/NGRU7GV2WAUYD1', mode: LaunchMode.externalApplication);
                  } else {
                    print('Cannot make Call');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.asset('assets/lotties/what2.json', height: 25.h, width: 40.w),
                    Expanded(child: Text('Chat with us via Whatsapp ', style: AppTheme.sectionMediumBoldTitle,)),
                  ],
                ),
              ),


              Bounceable(
                onTap: () {
                 Get.to(() => HelpCenterScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.asset('assets/lotties/message.json', height: 25.h, width: 40.w),
                    Expanded(child: Text('Live conversation with Wena support', style: AppTheme.sectionMediumBoldTitle,)),
                  ],
                ),
              ),

              Bounceable(
                onTap: () async {
                  final Uri phoneUri = Uri(
                      scheme: 'tel',
                      path: '0742467382'
                  );
                  if(await canLaunchUrl(phoneUri)){
                  await launchUrl(phoneUri);
                  } else {
                  print('Cannot make Call');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.asset('assets/lotties/call.json', height: 11.h, width: 40.w),
                    Expanded(child: Text('Directly call us', style: AppTheme.sectionMediumBoldTitle,)),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
