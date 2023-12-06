import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/common_input_widget.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:icons_plus/icons_plus.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUsScreen> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();

  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeSurname = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeMessage = FocusNode();
  final String _errMobile = "";
  String countryCode = "256";

  launchWhatsAppUri() async {
    final link = WhatsAppUnilink(
      phoneNumber: '256755516055',
      text: "Hey! I'm inquiring about FPL Champs",
    );
    // Convert the WhatsAppUnilink instance to a Uri.
    // The "launch" method is part of "url_launcher".
    await launchUrl(link.asUri(), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
                      //
                      // GestureDetector(
                      //   onTap: () async{
                      //
                      //     const url = 'https://twitter.com/FantasyChamps22';
                      //     if (await canLaunchUrl(Uri.parse(url))) {
                      //       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication,);
                      //     } else {
                      //       throw 'Could not launch $url';
                      //     }
                      //
                      //   },
                      //   child: Card(
                      //     clipBehavior: Clip.antiAlias,
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      //       child: ListTile(
                      //         leading: Logo(Logos.twitter),
                      //         title: Text('Twitter'),
                      //         subtitle: Text('get quick help & keep in touch with the latest FPL updates '),
                      //         trailing: Icon(Icons.arrow_circle_right_rounded, color: Theme.of(context).primaryColor,),
                      //
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // Bounceable(
                      //   onTap: () async{
                      //
                      //     launchWhatsAppUri();
                      //
                      //     // final Uri fplchat = Uri(
                      //     //     path: 'https://api.whatsapp.com/send?phone=256755516055'
                      //     // );
                      //
                      //     // final Uri fplchat = Uri.parse('https://api.whatsapp.com/send?phone=256755516055',);
                      //     // final String fplchat = 'https://api.whatsapp.com/send?phone=256755516055';
                      //
                      //     // final String fplchat = 'https://wa.me/256756791203?text=bye';
                      //     // if(await canLaunch(fplchat)){
                      //     //   await launch(fplchat, forceWebView: true, enableJavaScript: true,);
                      //     // } else{
                      //     //   print('Cant open the URL');
                      //     // }
                      //
                      //     // const url = 'https://flutter.dev';
                      //     // const url = 'https://api.whatsapp.com/send?phone=256755516055';
                      //     // const url = 'https://chat.whatsapp.com/IsvN9ghJl4F2ZtfouRG29y';
                      //     // if (await canLaunchUrl(Uri.parse(url))) {
                      //     //   await launchUrl(Uri.parse(url),);
                      //     // } else {
                      //     //   throw 'Could not launch $url';
                      //     // }
                      //
                      //   },
                      //   child: Card(
                      //     clipBehavior: Clip.antiAlias,
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      //       child: ListTile(
                      //         leading: Logo(Logos.whatsapp),
                      //         title: Text('Whatsapp'),
                      //         subtitle: Text('request for live chat assistance via our  official group chat'),
                      //         trailing: Icon(Icons.arrow_circle_right_rounded, color: Theme.of(context).primaryColor,),
                      //
                      //       ),
                      //     ),
                      //   ),
                      // ),

            ]))),

          ]),
        ),
        "Contact Us");
  }
}
