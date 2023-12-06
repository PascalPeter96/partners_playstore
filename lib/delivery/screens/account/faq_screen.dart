import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List generalList = [
    {
      'title' : 'What is Wena?',
      'more' : 'Wena is the greatest Hardware and Household Mobile App platform in this century'
    },
    {
      'title' : 'How to use Wena?',
      'more' : 'Signup to the platform with your phone or email, login & navigate the app using our user guides'
    },
    {
      'title' : 'Can I create my own Wena Account?',
      'more' : 'Yes you can, Upon 1st time use of the up we have 2 safe options of account creation (Phone & email/password)'
    },
    {
      'title' : 'How to sell my Service?',
      'more' : 'Use the Wena Professional Mobile App (link below) to Upload your Service Profile'
    },
    {
      'title' : 'How can I upload documentation?',
      'more' : 'Wena has a rich invested user friendly screen that is self explanatory to guide you'
    },
    {
      'title' : 'Is there free tips to use this app?',
      'more' : 'Very many... use the free tips tab to get all tips and promotions'
    },
    {
      'title' : 'Is Wena free to use?',
      'more' : 'Yes... We are completely free...charges come upon buying products and services'
    },
    {
      'title' : 'How to make offer on Wena?',
      'more' : 'We invite all suggestions, please use the help center for inquiries'
    },
  ];

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
          title: 'FAQ',
          titleWidget: Container(width: 10.w,),
        ),
      ),
      body: ListView.builder(
          itemCount: generalList.length,
          itemBuilder: (context, index){
            var list = generalList[index];
            return FadeInUp(
              child: Padding(
                padding: EdgeInsets.only(bottom: 1.h,  left: 1.w, right: 1.w),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: Card(
                    child: ExpansionTile(
                      iconColor: AppTheme.primaryColor,
                      title: Text(list['title'], style: AppTheme.sectionNormalText,),
                      trailing: Icon(Icons.keyboard_arrow_down_outlined),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(list['more'], style: AppTheme.greenNormal,),
                        ),
                      ],

                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}