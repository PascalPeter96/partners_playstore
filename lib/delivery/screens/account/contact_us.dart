import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final TextEditingController firstnameCont = TextEditingController();
  final TextEditingController surnameCont = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController messageCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String fnameError = '';
  String snameError = '';
  String phoneError = '';
  String emailError = '';
  String messageError = '';

  String _countryCode = "+256";

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
          title: 'Contact Us',
          titleWidget: Container(width: 10.w,),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: AppButton(
            title: 'Save',
            color: AppTheme.primaryColor,
            function: (){
              if(_formKey.currentState!.validate()){
                if(firstnameCont.text.isEmpty){
                  setState(() {
                    fnameError = 'first name required';
                  });
                  print(fnameError);
                  Fluttertoast.showToast(msg: fnameError,backgroundColor: Colors.red);
                } else if(surnameCont.text.isEmpty){
                  setState(() {
                    snameError = 'surname required';
                  });
                  print(snameError);
                  Fluttertoast.showToast(msg: snameError, backgroundColor: Colors.red);
                } else if(phoneCont.text.isEmpty){
                  setState(() {
                    phoneError = 'phone required';
                  });
                  print(snameError);
                  Fluttertoast.showToast(msg: phoneError, backgroundColor: Colors.red);
                } else if(phoneCont.length <9){
                  setState(() {
                    phoneError = 'phone number short';
                  });
                  print(snameError);
                  Fluttertoast.showToast(msg: phoneError, backgroundColor: Colors.red);
                }  else if(messageCont.text.isEmpty){
                  Fluttertoast.showToast(msg: 'write your message', backgroundColor: Colors.red);
                } else if (messageCont.length > 100){
                  print('Upload back');
                  Fluttertoast.showToast(msg: 'message too long', backgroundColor: Colors.red);
                } else {
                  print('Okay ALL Good');
                  Get.snackbar('Success', 'Message Sent To Wena Successfully',);
                }
              } else {
                print('hmmm...!!');
              }

            }),
      ),

      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            body:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              controller: firstnameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.fillColor2,
                                hintText: 'First Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              controller: surnameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.fillColor2,
                                hintText: 'Surname',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 3.h,
                    ),

                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCont,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppTheme.fillColor2,
                          hintText: 'Email',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 3.h,
                    ),



                    SizedBox(
                      height: 3.h,
                    ),

                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 10,
                        controller: messageCont,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppTheme.fillColor2,
                          hintText: 'Message',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),


                  ],
                    ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
