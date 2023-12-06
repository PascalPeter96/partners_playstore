// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:wena_partners/widgets/title_app_bar.dart';
//
//
//
// class AddCreditCardScreen extends StatefulWidget {
//   const AddCreditCardScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
// }
//
// class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
//
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     border = OutlineInputBorder(
//       borderSide: BorderSide.none,
//       borderRadius: BorderRadius.circular(15.sp)
//     );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: ThemeService().isSavedDarkMode() ? Brightness.light : Brightness.dark,
//
//         ),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: TitleAppBar(
//           title: 'Add Card',
//           titleWidget: Container(width: 10.w,),
//         ),
//       ),
//
//
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.w),
//         child: Column(
//           children: <Widget>[
//
//             FadeInDown(
//               child: CreditCardWidget(
//                 height: 32.5.h,
//                 cardNumber: cardNumber,
//                 expiryDate: expiryDate,
//                 cardHolderName: cardHolderName,
//                 cvvCode: cvvCode,
//                 showBackView: isCvvFocused,
//                 textStyle: AppTheme.greenTitle,
//                 obscureCardNumber: true,
//                 obscureCardCvv: true,
//                 isHolderNameVisible: true,
//                 cardBgColor: Colors.red,
//                 cardType: CardType.visa,
//                 isSwipeGestureEnabled: true,
//                 onCreditCardWidgetChange:
//                     (CreditCardBrand creditCardBrand) {},
//                 customCardTypeIcons: <CustomCardTypeIcon>[
//                   CustomCardTypeIcon(
//                     cardType: CardType.mastercard,
//                     cardImage: Image.asset(
//                       'assets/mastercard.png',
//                       height: 48,
//                       width: 48,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 5.w),
//                 child: FadeInUp(
//                   child: SingleChildScrollView(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: <Widget>[
//                           CreditCardForm(
//                             cursorColor: AppTheme.primaryColor,
//                             formKey: formKey,
//                             obscureCvv: false,
//                             obscureNumber: false,
//                             cardNumber: cardNumber,
//                             cvvCode: cvvCode,
//                             isHolderNameVisible: true,
//                             isCardNumberVisible: true,
//                             isExpiryDateVisible: true,
//                             cardHolderName: cardHolderName,
//                             expiryDate: expiryDate,
//                             themeColor: AppTheme.primaryColor,
//                             cardNumberDecoration: InputDecoration(
//                               hintText: 'Number - XXXX XXXX XXXX XXXX',
//                               hintStyle: AppTheme.subtitleSmall,
//                               focusedBorder: border,
//                               enabledBorder: border,
//                               filled: true,
//                               fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
//
//                             ),
//                             expiryDateDecoration: InputDecoration(
//                               hintStyle: AppTheme.subtitleSmall,
//                               focusedBorder: border,
//                               enabledBorder: border,
//                               hintText: 'Expiry Date - XX/XX',
//                               filled: true,
//                               fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
//                             ),
//                             cvvCodeDecoration: InputDecoration(
//                               hintStyle: AppTheme.subtitleSmall,
//                               focusedBorder: border,
//                               enabledBorder: border,
//                               hintText: 'CVV - XXX',
//                               filled: true,
//                               fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
//                             ),
//                             cardHolderDecoration: InputDecoration(
//                               hintStyle: AppTheme.subtitleSmall,
//                               focusedBorder: border,
//                               enabledBorder: border,
//                               hintText: 'Card Holder\'s Name',
//                               filled: true,
//                               fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
//                             ),
//                             onCreditCardModelChange: onCreditCardModelChange,
//                             textStyle: AppTheme.sectionNormalText,
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(top: 7.h, bottom: 5.h, left: 5.w, right: 5.w),
//                             child: AppButton(
//                               title: 'Add card',
//                               color: AppTheme.primaryColor,
//                               function: (){
//                                 if (formKey.currentState!.validate()) {
//                                   Get.back();
//                                   Get.snackbar('Success', 'Credit Card Added Scuccessfuly');
//                                   print('valid!');
//                                 } else {
//                                   print('invalid!');
//                                 }
//                               },
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
//
// }
