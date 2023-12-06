// ignore_for_file: avoid_print, unused_local_variable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:wena_partners/professional/utils/text.dart';

import 'auth_screen/signning_screen.dart';

class ProStartScreen extends StatefulWidget {
  const ProStartScreen({Key? key}) : super(key: key);

  @override
  State<ProStartScreen> createState() => _ProStartScreenState();
}

class _ProStartScreenState extends State<ProStartScreen> {

  final TextEditingController phoneNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Color(0xFFF5F5F5),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.080),
                  child: Center(
                    child: Image.asset("assets/images/wena.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.1),
                  child: Center(
                    child: Image.asset(
                      "assets/images/start.png",
                      height: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * .030),
                  child: const Center(
                    child: Text(
                      getStartedText,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,fontFamily: 'Tahoma'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * .025),
                  child:   const Center(
                    child: Text(
                      loremIpsumText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Color(0xFF7B8295),fontFamily: 'SEGOEUI'),
                    ),
                  ),
                ),
                 SizedBox(height: h * 0.22,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFE8ECF4),
                        borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CountryCodePicker(
                            // hideSearch: true,
                            // hideMainText: true,
                            countryFilter: const ["UG","KE"],
                            enabled: false,
                            textStyle: const TextStyle(color: Color(0xFf8391A1)),
                            onInit: (value) => "256",
                            initialSelection: '256',
                            dialogSize: const Size.fromWidth(330),
                            onChanged: (value) {
                              setState(() {
                                print('codesign====${value.dialCode}');
                              });
                            },
                            flagDecoration: BoxDecoration(
                              color: const Color(0xFF8391A1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            flagWidth: 40,
                            padding: const EdgeInsets.all(0),
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          const VerticalDivider(
                            indent: 7,
                            endIndent: 7,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           const Center(child: Text(phoneNoText, style: TextStyle(color: Color(0xFF8391A1),fontSize: 16,fontFamily: 'SEGOEUI')))

                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
