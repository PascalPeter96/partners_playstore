import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
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
          title: 'Wena Help Center',
          titleWidget: Container(width: 10.w,),
        ),
      ),
      body: Tawk(
        directChatLink: 'https://tawk.to/chat/637e1270daff0e1306d904b6/1gii7g2ji',
        visitor: TawkVisitor(
          name: 'Wilson Jonson',
          email: 'demo@gmail.com',
        ),
      ),
    );
  }
}
