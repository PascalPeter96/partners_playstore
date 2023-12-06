import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wena_partners/professional/utils/text.dart';
import 'package:wena_partners/professional/view/auth_screen/signning_screen.dart';


class PasswordChangedSuccessful extends StatefulWidget {
  const PasswordChangedSuccessful({Key? key}) : super(key: key);

  @override
  State<PasswordChangedSuccessful> createState() => _PasswordChangedSuccessfulState();
}

class _PasswordChangedSuccessfulState extends State<PasswordChangedSuccessful> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,width: 100,
              child: Image.asset("assets/images/check.png",fit: BoxFit.fill),
            ),
            const SizedBox(height: 20),
            const Text(
              PasswordChangedText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Tahoma'),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 40,right: 40),
              child: Text(
                passchangedSuccessText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF7B8295),
                  fontFamily: 'SEGOEUI',
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.offAll(const SignScreen());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 48,
                  width: w * 0.8,
                  color: const Color(0xFF149C48),
                  child: const Center(
                    child: Text(
                      backtoLoginText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'SEGOEUI',
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
