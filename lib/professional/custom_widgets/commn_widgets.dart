import 'package:flutter/material.dart';

Widget textField(
    {controller,
    hintText,
    suffixImage,
    keyBoardType,
    style,
    validator,
    fillColor,
    textAlign,
    prefix,
    prefixIcon,
      enabled,
      maxLines,
      textInputAction,
    }) {

  return TextFormField(
    maxLines: maxLines,
    enabled: enabled,
    textInputAction: textInputAction,
    cursorColor: const Color(0xFF8391A1),
    textAlign: textAlign,
    validator: validator,
    style: const TextStyle(
      fontFamily: 'SEGOEUI',
      fontSize: 16,
      letterSpacing: 0.2,
      color: Colors.black,
      fontWeight: FontWeight.bold
    ),
    controller: controller,
    keyboardType: keyBoardType,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      errorStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Color(0xFFF44336),letterSpacing: 0.2, fontFamily: 'SEGOEUI',),
     prefix: prefix,
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
      hintStyle: const TextStyle(
        color: Color(0xFF8391A1),
        fontWeight: FontWeight.w600,
        fontFamily: 'SEGOEUI',
        fontSize: 14,
        letterSpacing: 0.2,
      ),

      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: Colors.grey,width: 0.6)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: Colors.grey,width: 0.6)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: Colors.grey,width: 0.6)
      ),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  const BorderSide(color: Colors.grey,width: 0.6)
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  const BorderSide(color: Colors.grey,width: 0.6)
      ),


      filled: true,
      fillColor: fillColor,
      // suffixIcon: Image.asset(suffixImage,scale: 2.5)

    ),

  );
}

Widget appText(
    {txt,
    fontSize,
    fontColor,
    fontWeight,
    letterSpacing,
    maxLine,
    textAlign,
    fontFamily}) {
  return Text(txt,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      ),
      maxLines: maxLine,
      textAlign: textAlign);
}
