import 'dart:convert';

import 'package:amount_formatter/amount_formatter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/theme/theme_service.dart';
import 'package:wena_partners/vendor/contollers/wallet/wallet_controller.dart';
import 'package:wena_partners/widgets/app_buttons.dart';



class VendorWalletScreen extends StatefulWidget {
  const VendorWalletScreen({Key? key}) : super(key: key);

  @override
  State<VendorWalletScreen> createState() => _VendorWalletScreenState();
}

class _VendorWalletScreenState extends State<VendorWalletScreen> {
  // final userStorage = GetStorage();


  final VendorWalletController walletController = Get.put(
      VendorWalletController(walletId: userStorage.read('vendorWalletId').toString()));

  final AmountFormatter amountFormatter = AmountFormatter(separator: ',');

  final TextEditingController amountCont = TextEditingController();

  final TextEditingController borrowAmountCont = TextEditingController();
  final TextEditingController itemsCont = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _borrowFormKey = GlobalKey<FormState>();

  int balance = 0;

  final amountValidator = MultiValidator([
    RequiredValidator(errorText: 'Amount required'),
    MinLengthValidator(4, errorText: 'min is 1000/='),
    MaxLengthValidator(8, errorText: 'amount above max'),
  ]);

  final borrowAmountValidator = MultiValidator([
    RequiredValidator(errorText: 'Amount required'),
    MinLengthValidator(4, errorText: 'min is 1000/=2'),
    MaxLengthValidator(8, errorText: 'amount above max'),
  ]);

  final itemsValidator = MultiValidator([
    RequiredValidator(errorText: 'Items required'),
    MinLengthValidator(4, errorText: 'too short'),
  ]);



  // void walletReminder(BuildContext context) {
  //   Get.snackbar('Note:', 'Wallet in testing');
  // }

  void createWalletDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text('Create Wallet', style: AppTheme.appTitle,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Click below to finalize', style: AppTheme.greenNormal,),
              Icon(Icons.wallet)
            ],
          ),
          SizedBox(height: 2.h,),
          Obx(() {
            return AppButton(
              isLoading: walletController.isCreateWalletLoading.value,
              title: 'Create Wallet',
              color: AppTheme.primaryColor,
              function: () {
                walletController.createWallet(
                    userStorage.read('vendorUserId').toString());
              },
            );
          })
        ],
      ),

    );

    showDialog(
        context: context, builder: (context) {
      return alert;
    });
  }

  // walletAlert() async {
  //   await Future.delayed(const Duration(milliseconds: 100)).then((value) =>
  //       createWalletDialog(context));
  // }

  @override
  void initState() {
    // userStorage.read('walletId') == null ? walletAlert() : null;
    super.initState();

    print(
        'WAAAAALLLLEEEETTTT IIIIDDDD walletId ${userStorage.read('vendorWalletId')}');
    print('WAAAAALLLLEEEETTTT IIIIDDDD userId ${userStorage.read('vendorUserId')}');


  }

  final List<String> stageItems = [
    'Re-stocking',
    'Compliance',
  ];

  String greeting() {
    var hour = DateTime
        .now()
        .hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amountCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final WalletController walletController = Get.put(
    //     WalletController(walletId: '21e03923'));

    print(
        'WAAAAALLLLEEEETTTT IIIIDDDD IIISSS ${walletController.walletModel.value
            .wallet?.walletId.toString()}');

    Future sendBorrowEmail() async {
      const serviceId = 'service_9ihetpk';
      const templateId = 'template_6r8gln2';
      const userId = 'EIVIcBzEvsqZjICPN';

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
          url,
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'user_name': '${userStorage.read('user')['customer']['first_name']
                  .toString()} ${userStorage.read('user')['customer']['surname']
                  .toString()}',
              'user_email': userStorage.read('email'),
              'amount': borrowAmountCont.text.toString(),
              'items': itemsCont.text,
              'cStage': walletController.selectedStage.value.toString(),
            }
          }),
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          }
      );
      print(response.body);
      print(response);
      return response.body;
    }

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: ThemeService().isSavedDarkMode() ? Brightness
              .light : Brightness.dark,

        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Wallet', style: AppTheme.appTitle,),
        centerTitle: true,
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(top: 1.h, right: 5.w),
          //   child: Bounceable(
          //       onTap: () {
          //         Get.to(() => const AddCreditCardScreen());
          //       },
          //       child: Icon(Icons.add_outlined, color: AppTheme.primaryColor,
          //           size: 22.5.sp)),
          // ),

          // Padding(
          //   padding: EdgeInsets.only(top: 1.h, right: 5.w),
          //   child: Bounceable(
          //       onTap: () {
          //         userStorage.remove('walletId');
          //       },
          //       child: Icon(Icons.delete, color: AppTheme.primaryColor,
          //           size: 22.5.sp)),
          // ),

        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        child: Obx(() {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(greeting(), style: AppTheme.greenSectionTitle,),
                    SizedBox(width: 2.w,),
                    Text(userStorage.read('vendor') == null ? '' : '${userStorage
                        .read('vendorName')}',
                      style: AppTheme.appTitle,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,),

                  ],
                ),
                SizedBox(height: 2.h,),

                GlassContainer.clearGlass(
                  margin: EdgeInsets.only(bottom: 2.h),
                  height: 17.5.h,
                  width: 90.w,
                  borderRadius: BorderRadius.circular(20.sp),
                  blur: 12,
                  color: ThemeService().isSavedDarkMode() ? null : AppTheme.primaryLightColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text('Balance', style: AppTheme.cardTitle,),
                              SizedBox(height: 2.h,),
                              Row(
                                children: [
                                  Text('UGX', style: AppTheme.cardTitle,),
                                  SizedBox(width: 2.w,),

                                  AnimatedFlipCounter(
                                    thousandSeparator: ',',
                                    duration: const Duration(seconds: 0),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    textStyle: AppTheme.greenWalletPrice,
                                    value: userStorage.read('vendorWalletId') == ''
                                        ? balance
                                        : walletController.walletModel.value.wallet?.balance ==
                                        null ? 0 : walletController.walletModel.value.wallet!
                                        .balance!,
                                    // value: userStorage.read('walletId') == ''
                                    //     ? balance
                                    //     : walletController.walletModel.value.wallet!.balance == null ? 0 : walletController.walletModel.value.wallet!.balance!,
                                  ),

                                  // AnimatedFlipCounter(
                                  //   thousandSeparator: ',',
                                  //   duration: const Duration(seconds: 3),
                                  //   curve: Curves.fastLinearToSlowEaseIn,
                                  //   textStyle: AppTheme.greenWalletPrice,
                                  //   value: userStorage.read('walletId') == ''
                                  //       ? balance
                                  //       : walletController.walletModel.value.wallet?.balance ==
                                  //       null ? 0 : walletController.walletModel.value.wallet!
                                  //       .balance!,
                                  //   // value: userStorage.read('walletId') == ''
                                  //   //     ? balance
                                  //   //     : walletController.walletModel.value.wallet!.balance == null ? 0 : walletController.walletModel.value.wallet!.balance!,
                                  // ),
                                ],
                              )
                            ],
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Bounceable(
                        //         onTap: (){
                        //           if (userStorage.read('walletId') == null) {
                        //             Get.snackbar('INFO', 'Please create wallet');
                        //
                        //           } else {
                        //             Get.bottomSheet(
                        //               backgroundColor: Theme
                        //                   .of(context)
                        //                   .scaffoldBackgroundColor,
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius
                        //                       .only(
                        //                       topRight: Radius
                        //                           .circular(
                        //                           20.sp),
                        //                       topLeft: Radius
                        //                           .circular(
                        //                           20.sp)
                        //                   )
                        //               ),
                        //               Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     horizontal: 5.w),
                        //                 child: SizedBox(
                        //                     height: 32.5.h,
                        //                     child: Form(
                        //                       key: _formKey,
                        //                       child: Column(
                        //                         children: [
                        //                           Padding(
                        //                             padding: EdgeInsets
                        //                                 .only(
                        //                                 top: 1.h),
                        //                             child: Container(
                        //                               height: 0.75.h,
                        //                               width: 20.w,
                        //                               decoration: BoxDecoration(
                        //                                 borderRadius: BorderRadius
                        //                                     .circular(
                        //                                     15.sp),
                        //                                 color: Colors
                        //                                     .black,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           Padding(
                        //                             padding: EdgeInsets
                        //                                 .only(
                        //                                 top: 1.h),
                        //                             child: Text(
                        //                               'Enter Deposit Amount',
                        //                               style: AppTheme
                        //                                   .sectionMediumBoldTitle,),
                        //                           ),
                        //
                        //                           Padding(
                        //                             padding: EdgeInsets
                        //                                 .only(
                        //                                 top: 3.h),
                        //                             child: Container(
                        //                               clipBehavior: Clip
                        //                                   .antiAlias,
                        //                               decoration: BoxDecoration(
                        //                                 borderRadius: BorderRadius
                        //                                     .circular(
                        //                                     15.sp),
                        //                               ),
                        //                               child: TextFormField(
                        //                                 style: TextStyle(
                        //                                   color: ThemeService()
                        //                                       .isSavedDarkMode()
                        //                                       ? Colors
                        //                                       .white
                        //                                       : Colors
                        //                                       .black,
                        //                                 ),
                        //                                 keyboardType: TextInputType
                        //                                     .number,
                        //                                 controller: amountCont,
                        //                                 decoration: InputDecoration(
                        //                                   border: InputBorder
                        //                                       .none,
                        //                                   filled: true,
                        //                                   fillColor: ThemeService()
                        //                                       .isSavedDarkMode()
                        //                                       ? Colors
                        //                                       .white10
                        //                                       : AppTheme
                        //                                       .borderColor2,
                        //                                   hintText: 'Amount',
                        //                                   hintStyle: const TextStyle(
                        //                                       color: Colors
                        //                                           .grey),
                        //                                   enabledBorder: InputBorder
                        //                                       .none,
                        //                                   focusedBorder: InputBorder
                        //                                       .none,
                        //                                   focusedErrorBorder: InputBorder
                        //                                       .none,
                        //                                   errorBorder: InputBorder
                        //                                       .none,
                        //                                 ),
                        //                                 validator: amountValidator,
                        //                               ),
                        //                             ),
                        //                           ),
                        //
                        //                           Padding(
                        //                             padding: EdgeInsets
                        //                                 .only(
                        //                                 top: 2.h),
                        //                             child: Obx(() {
                        //                               return AppButton(
                        //                                   isLoading: walletController
                        //                                       .isDepositWalletLoading
                        //                                       .value,
                        //                                   title: 'Deposit',
                        //                                   color: AppTheme
                        //                                       .primaryColor,
                        //                                   function: () async {
                        //                                     if (_formKey
                        //                                         .currentState!
                        //                                         .validate()) {
                        //                                       var inputAmount = int
                        //                                           .parse(
                        //                                           amountCont
                        //                                               .text);
                        //                                       if (inputAmount <=
                        //                                           10000000) {
                        //                                         _formKey
                        //                                             .currentState!
                        //                                             .save();
                        //
                        //                                         walletController
                        //                                             .depositWallet(
                        //                                             userStorage.read(
                        //                                                 'walletId'),
                        //                                             inputAmount
                        //                                                 .toString());
                        //                                         amountCont.clear();
                        //                                         // setState(() {
                        //                                         //   balance =
                        //                                         //       balance +
                        //                                         //           inputAmount;
                        //                                         // });
                        //                                       } else {
                        //                                         print(
                        //                                             'over');
                        //                                         Fluttertoast
                        //                                             .showToast(
                        //                                             msg: 'amount above max deposit 10m',
                        //                                             backgroundColor: Colors
                        //                                                 .red);
                        //                                       }
                        //                                     } else {
                        //
                        //                                     }
                        //                                   }
                        //                               );
                        //                             }),
                        //                           )
                        //
                        //                         ],
                        //                       ),
                        //                     )),
                        //               ),
                        //             );
                        //
                        //           }
                        //         },
                        //         child: Icon(
                        //           Icons.add_circle_outlined,
                        //           color: AppTheme.primaryColor,
                        //           size: 25.sp,
                        //         )),
                        //   ],
                        // )


                      ],
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounceable(
                      onTap: (){

                                  // if (userStorage.read('vendorWalletId') == null) {
                                  //   Get.snackbar('INFO', 'Please create wallet');
                                  //
                                  // } else {
                                  //   Get.bottomSheet(
                                  //     backgroundColor: Theme
                                  //         .of(context)
                                  //         .scaffoldBackgroundColor,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius
                                  //             .only(
                                  //             topRight: Radius
                                  //                 .circular(
                                  //                 20.sp),
                                  //             topLeft: Radius
                                  //                 .circular(
                                  //                 20.sp)
                                  //         )
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: 5.w),
                                  //       child: SizedBox(
                                  //           height: 32.5.h,
                                  //           child: Form(
                                  //             key: _formKey,
                                  //             child: Column(
                                  //               children: [
                                  //                 Padding(
                                  //                   padding: EdgeInsets
                                  //                       .only(
                                  //                       top: 1.h),
                                  //                   child: Container(
                                  //                     height: 0.75.h,
                                  //                     width: 20.w,
                                  //                     decoration: BoxDecoration(
                                  //                       borderRadius: BorderRadius
                                  //                           .circular(
                                  //                           15.sp),
                                  //                       color: Colors
                                  //                           .black,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 Padding(
                                  //                   padding: EdgeInsets
                                  //                       .only(
                                  //                       top: 1.h),
                                  //                   child: Text(
                                  //                     'Enter Deposit Amount',
                                  //                     style: AppTheme
                                  //                         .sectionMediumBoldTitle,),
                                  //                 ),
                                  //
                                  //                 Padding(
                                  //                   padding: EdgeInsets
                                  //                       .only(
                                  //                       top: 3.h),
                                  //                   child: Container(
                                  //                     clipBehavior: Clip
                                  //                         .antiAlias,
                                  //                     decoration: BoxDecoration(
                                  //                       borderRadius: BorderRadius
                                  //                           .circular(
                                  //                           15.sp),
                                  //                     ),
                                  //                     child: TextFormField(
                                  //                       style: TextStyle(
                                  //                         color: ThemeService()
                                  //                             .isSavedDarkMode()
                                  //                             ? Colors
                                  //                             .white
                                  //                             : Colors
                                  //                             .black,
                                  //                       ),
                                  //                       keyboardType: TextInputType
                                  //                           .number,
                                  //                       controller: amountCont,
                                  //                       decoration: InputDecoration(
                                  //                         border: InputBorder
                                  //                             .none,
                                  //                         filled: true,
                                  //                         fillColor: ThemeService()
                                  //                             .isSavedDarkMode()
                                  //                             ? Colors
                                  //                             .white10
                                  //                             : AppTheme
                                  //                             .borderColor2,
                                  //                         hintText: 'Amount',
                                  //                         hintStyle: const TextStyle(
                                  //                             color: Colors
                                  //                                 .grey),
                                  //                         enabledBorder: InputBorder
                                  //                             .none,
                                  //                         focusedBorder: InputBorder
                                  //                             .none,
                                  //                         focusedErrorBorder: InputBorder
                                  //                             .none,
                                  //                         errorBorder: InputBorder
                                  //                             .none,
                                  //                       ),
                                  //                       validator: amountValidator,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //
                                  //                 Padding(
                                  //                   padding: EdgeInsets
                                  //                       .only(
                                  //                       top: 2.h),
                                  //                   child: Obx(() {
                                  //                     return AppButton(
                                  //                         isLoading: walletController
                                  //                             .isDepositWalletLoading
                                  //                             .value,
                                  //                         title: 'Deposit',
                                  //                         color: AppTheme
                                  //                             .primaryColor,
                                  //                         function: () async {
                                  //                           if (_formKey
                                  //                               .currentState!
                                  //                               .validate()) {
                                  //                             var inputAmount = int
                                  //                                 .parse(
                                  //                                 amountCont
                                  //                                     .text);
                                  //                             if (inputAmount <=
                                  //                                 10000000) {
                                  //                               _formKey
                                  //                                   .currentState!
                                  //                                   .save();
                                  //
                                  //                               walletController
                                  //                                   .depositWallet(
                                  //                                   userStorage.read(
                                  //                                       'vendorWalletId'),
                                  //                                   inputAmount
                                  //                                       .toString());
                                  //                               amountCont.clear();
                                  //                               // setState(() {
                                  //                               //   balance =
                                  //                               //       balance +
                                  //                               //           inputAmount;
                                  //                               // });
                                  //                             } else {
                                  //                               print(
                                  //                                   'over');
                                  //                               Fluttertoast
                                  //                                   .showToast(
                                  //                                   msg: 'amount above max deposit 10m',
                                  //                                   backgroundColor: Colors
                                  //                                       .red);
                                  //                             }
                                  //                           } else {
                                  //
                                  //                           }
                                  //                         }
                                  //                     );
                                  //                   }),
                                  //                 )
                                  //
                                  //               ],
                                  //             ),
                                  //           )),
                                  //     ),
                                  //   );
                                  //
                                  // }

                      },
                      child: Container(
                        width: 25.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Center(child: Text('Withdraw', style: AppTheme.whiteButtonText,),

                        ),
                      ),
                    ),

                    // Bounceable(
                    //   onTap: (){
                    //     Get.snackbar('Interest Rate', 'Make more wallet topups');
                    //     print(userStorage.read('customerId'));
                    //   },
                    //   child: Container(
                    //     width: 30.w,
                    //     height: 6.h,
                    //     decoration: BoxDecoration(
                    //         color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
                    //         borderRadius: BorderRadius.circular(15.sp)
                    //     ),
                    //     child: Center(
                    //       child: Text('Interest:\n UGX ${walletController.walletModel.value.wallet?.interest == null ? '0' : walletController.walletModel.value.wallet?.interest.toString()}', style: AppTheme.buttonText2, textAlign: TextAlign.center),
                    //     ),
                    //   ),
                    // ),

                    Bounceable(
                      onTap: (){

                                        if (userStorage.read('vendorWalletId') == null) {
                                          Get.snackbar('INFO', 'Please create wallet');

                                          // walletAlert();
                                        } else {
                                          Get.bottomSheet(
                                            backgroundColor: Theme
                                                .of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        20.sp),
                                                    topLeft: Radius.circular(20.sp)
                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: SizedBox(
                                                  height: 50.h,
                                                  child: Form(
                                                    key: _borrowFormKey,
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 1.h),
                                                            child: Container(
                                                              height: 0.75.h,
                                                              width: 20.w,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    15.sp),
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 1.h),
                                                            child: Text('Borrow',
                                                              style: AppTheme
                                                                  .sectionMediumBoldTitle,),
                                                          ),


                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 3.h),
                                                            child: Container(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    15.sp),
                                                              ),
                                                              child: TextFormField(
                                                                style: TextStyle(
                                                                  color: ThemeService()
                                                                      .isSavedDarkMode()
                                                                      ? Colors.white
                                                                      : Colors
                                                                      .black,
                                                                ),
                                                                keyboardType: TextInputType
                                                                    .number,
                                                                controller: borrowAmountCont,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder
                                                                      .none,
                                                                  filled: true,
                                                                  fillColor: ThemeService()
                                                                      .isSavedDarkMode()
                                                                      ? Colors
                                                                      .white10
                                                                      : AppTheme
                                                                      .borderColor2,
                                                                  hintText: 'Amount',
                                                                  hintStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  enabledBorder: InputBorder
                                                                      .none,
                                                                  focusedBorder: InputBorder
                                                                      .none,
                                                                  focusedErrorBorder: InputBorder
                                                                      .none,
                                                                  errorBorder: InputBorder
                                                                      .none,
                                                                ),
                                                                validator: borrowAmountValidator,
                                                              ),
                                                            ),
                                                          ),

                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 3.h),
                                                            child: Container(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    15.sp),
                                                              ),
                                                              child: TextFormField(
                                                                style: TextStyle(
                                                                  color: ThemeService()
                                                                      .isSavedDarkMode()
                                                                      ? Colors.white
                                                                      : Colors
                                                                      .black,
                                                                ),
                                                                keyboardType: TextInputType
                                                                    .text,
                                                                controller: itemsCont,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder
                                                                      .none,
                                                                  filled: true,
                                                                  fillColor: ThemeService()
                                                                      .isSavedDarkMode()
                                                                      ? Colors
                                                                      .white10
                                                                      : AppTheme
                                                                      .borderColor2,
                                                                  hintText: 'Items i.e cement',
                                                                  hintStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  enabledBorder: InputBorder
                                                                      .none,
                                                                  focusedBorder: InputBorder
                                                                      .none,
                                                                  focusedErrorBorder: InputBorder
                                                                      .none,
                                                                  errorBorder: InputBorder
                                                                      .none,
                                                                ),
                                                                validator: itemsValidator,
                                                              ),
                                                            ),
                                                          ),


                                                          Obx(() {
                                                            return Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  'Current Stage: ',
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  style: AppTheme
                                                                      .sectionMediumBoldTitle,),
                                                                Text(
                                                                  walletController
                                                                      .selectedStage
                                                                      .toString(),
                                                                  style: AppTheme
                                                                      .greenSectionTitle2,)
                                                              ],
                                                            );
                                                          }),

                                                          Obx(() {
                                                            return DropdownButton<
                                                                String>(

                                                              value: walletController
                                                                  .selectedStage
                                                                  .value,
                                                              items: stageItems
                                                                  .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                        item),
                                                                  ))
                                                                  .toList(),
                                                              onChanged: (
                                                                  newValue) {
                                                                walletController
                                                                    .updateSelectedStage(
                                                                    newValue!);
                                                              },
                                                            );
                                                          }),


                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 2.h),
                                                            child: AppButton(
                                                                title: 'Submit',
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                function: () async {
                                                                  if (_borrowFormKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    await sendBorrowEmail();
                                                                    Get.back();
                                                                    borrowAmountCont
                                                                        .clear();
                                                                    itemsCont
                                                                        .clear();
                                                                    Get.snackbar(
                                                                        'Wena',
                                                                        'Transact more to qualify',
                                                                        duration: const Duration(
                                                                            seconds: 5),
                                                                        titleText: Text(
                                                                          'Wena',
                                                                          style: TextStyle(
                                                                              color: AppTheme
                                                                                  .primaryColor,
                                                                              fontWeight: FontWeight
                                                                                  .bold),));
                                                                  } else {

                                                                  }
                                                                }
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }

                      },
                      child: Container(
                        width: 25.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Center(child: Text('Borrow', style: AppTheme.whiteButtonText,),),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    'Transaction History', style: AppTheme.sectionMediumBoldTitle,),
                ),

                Obx(() {
          return
          // walletController.isPaymentsLoading.value ? Center(child: LoadingSpinner(loaderColor: AppTheme.primaryColor),)
          //   :
          walletController.paymentsList.isEmpty ? Center(child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text('No Wallet Transactions', style: AppTheme.greenSectionTitle2,),
          ),)
              :
          Expanded(
          child: Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: FadeInUp(
          child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: walletController.paymentsList.length,
          itemBuilder: (context, index) {
          var transaction = walletController.paymentsList[index];
          return Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
          ),
          child: ListTile(
          leading: Image.asset(transaction.reason.toString() == 'payment for products' ? 'assets/wallet/p1.png' :'assets/wallet/d1.png'),
          //       leading: CircleAvatar(
          //         backgroundColor: Colors.transparent,
          // backgroundImage: AssetImage(transaction.reason.toString() == 'payment for products' ? 'assets/wallet/p1.png' :'assets/wallet/d1.png'),
          //       //   child: Text(transaction.status == 'successful' ? 'S' : 'F', style: AppTheme.sectionWhiteBigTitle,),
          //       //   backgroundColor: transaction.status == 'successful' ? AppTheme.primaryColor : AppTheme.warningTextColor,
          //       // ),
          //       ),
          title: Text(transaction.walletPaymentId.toString(),
          style: AppTheme.cardTitle,),
          subtitle: Text(
          DateFormat('E, d MMM yyyy').format(
          transaction.createdAt!),
          style: AppTheme.subtitleSmall,),
          trailing: transaction.status ==
          'successful'
          ?
          Text('${transaction.reason.toString() == 'payment for products' ? '-' : '+'}' + '${amountFormatter.format(
          transaction.amount.toString())}/=',
          style: TextStyle(
          color: AppTheme.primaryColor,
          ),)
              : Text('${transaction.reason.toString() == 'payment for products' ? '-' : '+'}' + '${amountFormatter.format(
          transaction.amount.toString())}/=',
          style: TextStyle(
          color: Colors.red,
          ),),
          ),
          ),
          );
          },
          ),
          ),
          ),
          );
          }
                )

              ]
          );
        },
        ),
      ),
    );
  }

}



              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('UGX  ', style: AppTheme.cardTitle,),
              //     walletController.isAmountLoading.value ? Text(
              //         '...') : AnimatedFlipCounter(
              //       thousandSeparator: ',',
              //       duration: const Duration(seconds: 3),
              //       curve: Curves.fastLinearToSlowEaseIn,
              //       textStyle: AppTheme.greenWalletPrice,
              //       value: userStorage.read('walletId') == ''
              //           ? balance
              //           : walletController.walletModel.value.wallet?.balance ==
              //           null ? 0 : walletController.walletModel.value.wallet!
              //           .balance!,
              //
              //       // value: userStorage.read('walletId') == ''
              //       //     ? balance
              //       //     : walletController.walletModel.value.wallet!.balance == null ? 0 : walletController.walletModel.value.wallet!.balance!,
              //     ),
              //
              //     // Text('${amountFormatter.format(balance.toString())}', style: AppTheme.greenWalletPrice,)
              //   ],
              // ),

              // FadeInDown(
              //   child: CreditCardWidget(
              //       height: 20.5.h,
              //       cardType: CardType.visa,
              //       textStyle: AppTheme.greenTitle,
              //       cardNumber: '5464563757587887',
              //       expiryDate: '23/12/26',
              //       cardHolderName: userStorage.read(
              //           'user')['customer']['first_name'] + ' ' +
              //           userStorage.read('user')['customer']['surname'],
              //       cvvCode: '256',
              //       showBackView: false,
              //       onCreditCardWidgetChange: (c) {}),
              // ),



              // Padding(
              //   padding: EdgeInsets.only(top: 1.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //
              //       FadeInLeft(
              //         child: SizedBox(
              //           height: 8.5.h,
              //           width: 30.w,
              //           child: Bounceable(
              //               onTap: () {
              //                 if (userStorage.read('walletId') == null) {
              //                   Get.snackbar('INFO', 'Please create wallet');
              //
              //                   // walletAlert();
              //                 } else {
              //                   Get.bottomSheet(
              //                     backgroundColor: Theme
              //                         .of(context)
              //                         .scaffoldBackgroundColor,
              //                     shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.only(
              //                             topRight: Radius.circular(20.sp),
              //                             topLeft: Radius.circular(20.sp)
              //                         )
              //                     ),
              //                     Padding(
              //                       padding: EdgeInsets.symmetric(
              //                           horizontal: 5.w),
              //                       child: SizedBox(
              //                           height: 50.h,
              //                           child: Form(
              //                             key: _borrowFormKey,
              //                             child: SingleChildScrollView(
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: EdgeInsets.only(
              //                                         top: 1.h),
              //                                     child: Container(
              //                                       height: 0.75.h,
              //                                       width: 20.w,
              //                                       decoration: BoxDecoration(
              //                                         borderRadius: BorderRadius
              //                                             .circular(15.sp),
              //                                         color: Colors.black,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Padding(
              //                                     padding: EdgeInsets.only(
              //                                         top: 1.h),
              //                                     child: Text('Borrow',
              //                                       style: AppTheme
              //                                           .sectionMediumBoldTitle,),
              //                                   ),
              //
              //
              //                                   Padding(
              //                                     padding: EdgeInsets.only(
              //                                         top: 3.h),
              //                                     child: Container(
              //                                       clipBehavior: Clip
              //                                           .antiAlias,
              //                                       decoration: BoxDecoration(
              //                                         borderRadius: BorderRadius
              //                                             .circular(15.sp),
              //                                       ),
              //                                       child: TextFormField(
              //                                         style: TextStyle(
              //                                           color: ThemeService()
              //                                               .isSavedDarkMode()
              //                                               ? Colors.white
              //                                               : Colors.black,
              //                                         ),
              //                                         keyboardType: TextInputType
              //                                             .number,
              //                                         controller: borrowAmountCont,
              //                                         decoration: InputDecoration(
              //                                           border: InputBorder
              //                                               .none,
              //                                           filled: true,
              //                                           fillColor: ThemeService()
              //                                               .isSavedDarkMode()
              //                                               ? Colors.white10
              //                                               : AppTheme
              //                                               .borderColor2,
              //                                           hintText: 'Amount',
              //                                           hintStyle: const TextStyle(
              //                                               color: Colors.grey),
              //                                           enabledBorder: InputBorder
              //                                               .none,
              //                                           focusedBorder: InputBorder
              //                                               .none,
              //                                           focusedErrorBorder: InputBorder
              //                                               .none,
              //                                           errorBorder: InputBorder
              //                                               .none,
              //                                         ),
              //                                         validator: borrowAmountValidator,
              //                                       ),
              //                                     ),
              //                                   ),
              //
              //                                   Padding(
              //                                     padding: EdgeInsets.only(
              //                                         top: 3.h),
              //                                     child: Container(
              //                                       clipBehavior: Clip
              //                                           .antiAlias,
              //                                       decoration: BoxDecoration(
              //                                         borderRadius: BorderRadius
              //                                             .circular(15.sp),
              //                                       ),
              //                                       child: TextFormField(
              //                                         style: TextStyle(
              //                                           color: ThemeService()
              //                                               .isSavedDarkMode()
              //                                               ? Colors.white
              //                                               : Colors.black,
              //                                         ),
              //                                         keyboardType: TextInputType
              //                                             .text,
              //                                         controller: itemsCont,
              //                                         decoration: InputDecoration(
              //                                           border: InputBorder
              //                                               .none,
              //                                           filled: true,
              //                                           fillColor: ThemeService()
              //                                               .isSavedDarkMode()
              //                                               ? Colors.white10
              //                                               : AppTheme
              //                                               .borderColor2,
              //                                           hintText: 'Items i.e cement',
              //                                           hintStyle: const TextStyle(
              //                                               color: Colors.grey),
              //                                           enabledBorder: InputBorder
              //                                               .none,
              //                                           focusedBorder: InputBorder
              //                                               .none,
              //                                           focusedErrorBorder: InputBorder
              //                                               .none,
              //                                           errorBorder: InputBorder
              //                                               .none,
              //                                         ),
              //                                         validator: itemsValidator,
              //                                       ),
              //                                     ),
              //                                   ),
              //
              //
              //                                   Obx(() {
              //                                     return Row(
              //                                       mainAxisAlignment: MainAxisAlignment
              //                                           .start,
              //                                       crossAxisAlignment: CrossAxisAlignment
              //                                           .center,
              //                                       children: [
              //                                         Text(
              //                                           'Current Stage: ',
              //                                           textAlign: TextAlign
              //                                               .center,
              //                                           style: AppTheme
              //                                               .sectionMediumBoldTitle,),
              //                                         Text(walletController
              //                                             .selectedStage
              //                                             .toString(),
              //                                           style: AppTheme
              //                                               .greenSectionTitle2,)
              //                                       ],
              //                                     );
              //                                   }),
              //
              //                                   Obx(() {
              //                                     return DropdownButton<String>(
              //
              //                                       value: walletController
              //                                           .selectedStage.value,
              //                                       items: stageItems
              //                                           .map((item) =>
              //                                           DropdownMenuItem<
              //                                               String>(
              //                                             value: item,
              //                                             child: Text(item),
              //                                           ))
              //                                           .toList(),
              //                                       onChanged: (newValue) {
              //                                         walletController
              //                                             .updateSelectedStage(
              //                                             newValue!);
              //                                       },
              //                                     );
              //                                   }),
              //
              //
              //                                   Padding(
              //                                     padding: EdgeInsets.only(
              //                                         top: 2.h),
              //                                     child: AppButton(
              //                                         title: 'Submit',
              //                                         color: AppTheme
              //                                             .primaryColor,
              //                                         function: () async {
              //                                           if (_borrowFormKey
              //                                               .currentState!
              //                                               .validate()) {
              //                                             await sendBorrowEmail();
              //                                             Get.back();
              //                                             borrowAmountCont
              //                                                 .clear();
              //                                             itemsCont.clear();
              //                                             Get.snackbar('Wena',
              //                                                 'Transact more to qualify',
              //                                                 duration: const Duration(
              //                                                     seconds: 5),
              //                                                 titleText: Text(
              //                                                   'Wena',
              //                                                   style: TextStyle(
              //                                                       color: AppTheme
              //                                                           .primaryColor,
              //                                                       fontWeight: FontWeight
              //                                                           .bold),));
              //                                           } else {
              //
              //                                           }
              //                                         }
              //                                     ),
              //                                   )
              //
              //                                 ],
              //                               ),
              //                             ),
              //                           )),
              //                     ),
              //                   );
              //                 }
              //
              //                 // Get.snackbar('Wena', 'Transact more to qualify' ,
              //                 //     duration: Duration(seconds: 5),
              //                 //     titleText: Text('Wena', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),));
              //               },
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15.sp),
              //                 ),
              //                 child: Center(
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment
              //                         .spaceEvenly,
              //                     children: [
              //                       Image.asset(
              //                         'assets/wallet/borrow.png', width: 5.w,
              //                         color: Colors.deepPurpleAccent,),
              //                       Text('Borrow',
              //                         style: AppTheme.sectionMediumBoldTitle,),
              //                     ],
              //                   ),
              //                 ),
              //               )),
              //         ),
              //       ),
              //
              //       // FadeInDown(
              //       //   child: Bounceable(
              //       //     child: SizedBox(
              //       //       height: 8.5.h,
              //       //       width: 30.w,
              //       //       child: Card(
              //       //         shape: RoundedRectangleBorder(
              //       //           borderRadius: BorderRadius.circular(15.sp),
              //       //         ),
              //       //         child: Center(
              //       //           child: Row(
              //       //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       //             children: [
              //       //               Image.asset('assets/wallet/with.png', width: 5.w, color: Colors.red,),
              //       //               Text('Withdraw', style: AppTheme.sectionMediumBoldTitle,),
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //     onTap: (){
              //       //       Get.bottomSheet(
              //       //         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              //       //         shape: RoundedRectangleBorder(
              //       //             borderRadius: BorderRadius.only(
              //       //                 topRight: Radius.circular(20.sp),
              //       //                 topLeft: Radius.circular(20.sp)
              //       //             )
              //       //         ),
              //       //         Padding(
              //       //           padding: EdgeInsets.symmetric(horizontal: 5.w),
              //       //           child: SizedBox(
              //       //               height: 32.5.h,
              //       //               child: Form(
              //       //                 key: _formKey,
              //       //                 child: Column(
              //       //                   children: [
              //       //                     Padding(
              //       //                       padding: EdgeInsets.only(top: 1.h),
              //       //                       child: Container(
              //       //                         height: 0.75.h,
              //       //                         width: 20.w,
              //       //                         decoration: BoxDecoration(
              //       //                           borderRadius: BorderRadius.circular(15.sp),
              //       //                           color: Colors.black,
              //       //                         ),
              //       //                       ),
              //       //                     ),
              //       //                     Padding(
              //       //                       padding: EdgeInsets.only(top: 1.h),
              //       //                       child: Text('Enter Withdraw Amount', style: AppTheme.sectionMediumBoldTitle,),
              //       //                     ),
              //       //
              //       //                     Padding(
              //       //                       padding: EdgeInsets.only(top: 3.h),
              //       //                       child: Container(
              //       //                         clipBehavior: Clip.antiAlias,
              //       //                         decoration: BoxDecoration(
              //       //                           borderRadius: BorderRadius.circular(15.sp),
              //       //                         ),
              //       //                         child: TextFormField(
              //       //                           style: TextStyle(
              //       //                             color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
              //       //                           ),
              //       //                           keyboardType: TextInputType.number,
              //       //                           controller: amountCont,
              //       //                           decoration: InputDecoration(
              //       //                             border: InputBorder.none,
              //       //                             filled: true,
              //       //                             fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
              //       //                             hintText: 'Amount',
              //       //                             hintStyle:  const TextStyle(color: Colors.grey),
              //       //                             enabledBorder: InputBorder.none,
              //       //                             focusedBorder: InputBorder.none,
              //       //                             focusedErrorBorder: InputBorder.none,
              //       //                             errorBorder: InputBorder.none,
              //       //                           ),
              //       //                           validator: amountValidator,
              //       //                         ),
              //       //                       ),
              //       //                     ),
              //       //
              //       //                     Padding(
              //       //                       padding: EdgeInsets.only(top: 2.h),
              //       //                       child: AppButton(
              //       //                           title: 'Withdraw',
              //       //                           color: AppTheme.primaryColor,
              //       //                           function: (){
              //       //
              //       //                             if(_formKey.currentState!.validate()){
              //       //                               var inputAmount = int.parse(amountCont.text);
              //       //                               if(inputAmount <= balance){
              //       //                                 _formKey.currentState!.save();
              //       //                                 print('under');
              //       //                                 print('under and very okay');
              //       //                                 setState((){
              //       //                                   balance = balance - inputAmount;
              //       //                                 });
              //       //                                 Get.back();
              //       //                                 Get.snackbar('Withdraw Successful', '${amountFormatter.format(inputAmount.toString())}/= has been withdrawn');
              //       //
              //       //                               } else {
              //       //                                 print('over');
              //       //                                 Fluttertoast.showToast(msg: 'amount above balance',backgroundColor: Colors.red);
              //       //                               }
              //       //
              //       //                             }  else {
              //       //
              //       //                             }
              //       //                           }
              //       //                       ),
              //       //                     )
              //       //
              //       //                   ],
              //       //                 ),
              //       //               )),
              //       //         ),
              //       //       );
              //       //     },
              //       //   ),
              //       // ),
              //
              //       FadeInRight(
              //         child: Bounceable(
              //           onTap: () {
              //             if (userStorage.read('walletId') == null) {
              //               Get.snackbar('INFO', 'Please create wallet');
              //
              //             } else {
              //               Get.bottomSheet(
              //                 backgroundColor: Theme
              //                     .of(context)
              //                     .scaffoldBackgroundColor,
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius
              //                         .only(
              //                         topRight: Radius
              //                             .circular(
              //                             20.sp),
              //                         topLeft: Radius
              //                             .circular(
              //                             20.sp)
              //                     )
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 5.w),
              //                   child: SizedBox(
              //                       height: 32.5.h,
              //                       child: Form(
              //                         key: _formKey,
              //                         child: Column(
              //                           children: [
              //                             Padding(
              //                               padding: EdgeInsets
              //                                   .only(
              //                                   top: 1.h),
              //                               child: Container(
              //                                 height: 0.75.h,
              //                                 width: 20.w,
              //                                 decoration: BoxDecoration(
              //                                   borderRadius: BorderRadius
              //                                       .circular(
              //                                       15.sp),
              //                                   color: Colors
              //                                       .black,
              //                                 ),
              //                               ),
              //                             ),
              //                             Padding(
              //                               padding: EdgeInsets
              //                                   .only(
              //                                   top: 1.h),
              //                               child: Text(
              //                                 'Enter Deposit Amount',
              //                                 style: AppTheme
              //                                     .sectionMediumBoldTitle,),
              //                             ),
              //
              //                             Padding(
              //                               padding: EdgeInsets
              //                                   .only(
              //                                   top: 3.h),
              //                               child: Container(
              //                                 clipBehavior: Clip
              //                                     .antiAlias,
              //                                 decoration: BoxDecoration(
              //                                   borderRadius: BorderRadius
              //                                       .circular(
              //                                       15.sp),
              //                                 ),
              //                                 child: TextFormField(
              //                                   style: TextStyle(
              //                                     color: ThemeService()
              //                                         .isSavedDarkMode()
              //                                         ? Colors
              //                                         .white
              //                                         : Colors
              //                                         .black,
              //                                   ),
              //                                   keyboardType: TextInputType
              //                                       .number,
              //                                   controller: amountCont,
              //                                   decoration: InputDecoration(
              //                                     border: InputBorder
              //                                         .none,
              //                                     filled: true,
              //                                     fillColor: ThemeService()
              //                                         .isSavedDarkMode()
              //                                         ? Colors
              //                                         .white10
              //                                         : AppTheme
              //                                         .borderColor2,
              //                                     hintText: 'Amount',
              //                                     hintStyle: const TextStyle(
              //                                         color: Colors
              //                                             .grey),
              //                                     enabledBorder: InputBorder
              //                                         .none,
              //                                     focusedBorder: InputBorder
              //                                         .none,
              //                                     focusedErrorBorder: InputBorder
              //                                         .none,
              //                                     errorBorder: InputBorder
              //                                         .none,
              //                                   ),
              //                                   validator: amountValidator,
              //                                 ),
              //                               ),
              //                             ),
              //
              //                             Padding(
              //                               padding: EdgeInsets
              //                                   .only(
              //                                   top: 2.h),
              //                               child: Obx(() {
              //                                 return AppButton(
              //                                     isLoading: walletController
              //                                         .isDepositWalletLoading
              //                                         .value,
              //                                     title: 'Deposit',
              //                                     color: AppTheme
              //                                         .primaryColor,
              //                                     function: () async {
              //                                       if (_formKey
              //                                           .currentState!
              //                                           .validate()) {
              //                                         var inputAmount = int
              //                                             .parse(
              //                                             amountCont
              //                                                 .text);
              //                                         if (inputAmount <=
              //                                             10000000) {
              //                                           _formKey
              //                                               .currentState!
              //                                               .save();
              //
              //                                           walletController
              //                                               .depositWallet(
              //                                               userStorage.read(
              //                                                   'walletId'),
              //                                               inputAmount
              //                                                   .toString());
              //                                           amountCont.clear();
              //                                           // setState(() {
              //                                           //   balance =
              //                                           //       balance +
              //                                           //           inputAmount;
              //                                           // });
              //                                         } else {
              //                                           print(
              //                                               'over');
              //                                           Fluttertoast
              //                                               .showToast(
              //                                               msg: 'amount above max deposit 10m',
              //                                               backgroundColor: Colors
              //                                                   .red);
              //                                         }
              //                                       } else {
              //
              //                                       }
              //                                     }
              //                                 );
              //                               }),
              //                             )
              //
              //                           ],
              //                         ),
              //                       )),
              //                 ),
              //               );
              //
              //               // Get.bottomSheet(
              //               //   backgroundColor: Theme
              //               //       .of(context)
              //               //       .scaffoldBackgroundColor,
              //               //   shape: RoundedRectangleBorder(
              //               //       borderRadius: BorderRadius.only(
              //               //           topRight: Radius.circular(20.sp),
              //               //           topLeft: Radius.circular(20.sp)
              //               //       )
              //               //   ),
              //               //   Padding(
              //               //     padding: EdgeInsets.symmetric(horizontal: 5.w),
              //               //     child: SizedBox(
              //               //         height: 25.h,
              //               //         child: Column(
              //               //           children: [
              //               //             Padding(
              //               //               padding: EdgeInsets.only(top: 1.h),
              //               //               child: Container(
              //               //                 height: 0.75.h,
              //               //                 width: 20.w,
              //               //                 decoration: BoxDecoration(
              //               //                   borderRadius: BorderRadius.circular(
              //               //                       15.sp),
              //               //                   color: Colors.black,
              //               //                 ),
              //               //               ),
              //               //             ),
              //               //             Padding(
              //               //               padding: EdgeInsets.only(top: 1.h),
              //               //               child: Text('Select Deposit Method',
              //               //                   style: AppTheme
              //               //                       .sectionMediumBoldTitle),
              //               //             ),
              //               //
              //               //             Padding(
              //               //               padding: EdgeInsets.only(top: 3.h),
              //               //               child: AppButton(
              //               //                   title: 'Mobile Money',
              //               //                   color: AppTheme.primaryColor,
              //               //                   function: () {
              //               //                     Get.back();
              //               //                     Get.bottomSheet(
              //               //                       backgroundColor: Theme
              //               //                           .of(context)
              //               //                           .scaffoldBackgroundColor,
              //               //                       shape: RoundedRectangleBorder(
              //               //                           borderRadius: BorderRadius
              //               //                               .only(
              //               //                               topRight: Radius
              //               //                                   .circular(
              //               //                                   20.sp),
              //               //                               topLeft: Radius
              //               //                                   .circular(
              //               //                                   20.sp)
              //               //                           )
              //               //                       ),
              //               //                       Padding(
              //               //                         padding: EdgeInsets.symmetric(
              //               //                             horizontal: 5.w),
              //               //                         child: SizedBox(
              //               //                             height: 32.5.h,
              //               //                             child: Form(
              //               //                               key: _formKey,
              //               //                               child: Column(
              //               //                                 children: [
              //               //                                   Padding(
              //               //                                     padding: EdgeInsets
              //               //                                         .only(
              //               //                                         top: 1.h),
              //               //                                     child: Container(
              //               //                                       height: 0.75.h,
              //               //                                       width: 20.w,
              //               //                                       decoration: BoxDecoration(
              //               //                                         borderRadius: BorderRadius
              //               //                                             .circular(
              //               //                                             15.sp),
              //               //                                         color: Colors
              //               //                                             .black,
              //               //                                       ),
              //               //                                     ),
              //               //                                   ),
              //               //                                   Padding(
              //               //                                     padding: EdgeInsets
              //               //                                         .only(
              //               //                                         top: 1.h),
              //               //                                     child: Text(
              //               //                                       'Enter Deposit Amount',
              //               //                                       style: AppTheme
              //               //                                           .sectionMediumBoldTitle,),
              //               //                                   ),
              //               //
              //               //                                   Padding(
              //               //                                     padding: EdgeInsets
              //               //                                         .only(
              //               //                                         top: 3.h),
              //               //                                     child: Container(
              //               //                                       clipBehavior: Clip
              //               //                                           .antiAlias,
              //               //                                       decoration: BoxDecoration(
              //               //                                         borderRadius: BorderRadius
              //               //                                             .circular(
              //               //                                             15.sp),
              //               //                                       ),
              //               //                                       child: TextFormField(
              //               //                                         style: TextStyle(
              //               //                                           color: ThemeService()
              //               //                                               .isSavedDarkMode()
              //               //                                               ? Colors
              //               //                                               .white
              //               //                                               : Colors
              //               //                                               .black,
              //               //                                         ),
              //               //                                         keyboardType: TextInputType
              //               //                                             .number,
              //               //                                         controller: amountCont,
              //               //                                         decoration: InputDecoration(
              //               //                                           border: InputBorder
              //               //                                               .none,
              //               //                                           filled: true,
              //               //                                           fillColor: ThemeService()
              //               //                                               .isSavedDarkMode()
              //               //                                               ? Colors
              //               //                                               .white10
              //               //                                               : AppTheme
              //               //                                               .borderColor2,
              //               //                                           hintText: 'Amount',
              //               //                                           hintStyle: const TextStyle(
              //               //                                               color: Colors
              //               //                                                   .grey),
              //               //                                           enabledBorder: InputBorder
              //               //                                               .none,
              //               //                                           focusedBorder: InputBorder
              //               //                                               .none,
              //               //                                           focusedErrorBorder: InputBorder
              //               //                                               .none,
              //               //                                           errorBorder: InputBorder
              //               //                                               .none,
              //               //                                         ),
              //               //                                         validator: amountValidator,
              //               //                                       ),
              //               //                                     ),
              //               //                                   ),
              //               //
              //               //                                   Padding(
              //               //                                     padding: EdgeInsets
              //               //                                         .only(
              //               //                                         top: 2.h),
              //               //                                     child: AppButton(
              //               //                                         title: 'Deposit',
              //               //                                         color: AppTheme
              //               //                                             .primaryColor,
              //               //                                         function: () {
              //               //                                           if (_formKey
              //               //                                               .currentState!
              //               //                                               .validate()) {
              //               //                                             var inputAmount = int
              //               //                                                 .parse(
              //               //                                                 amountCont
              //               //                                                     .text);
              //               //                                             if (inputAmount <=
              //               //                                                 10000000) {
              //               //                                               _formKey
              //               //                                                   .currentState!
              //               //                                                   .save();
              //               //                                               print(
              //               //                                                   'under');
              //               //                                               print(
              //               //                                                   'under and very okay');
              //               //                                               setState(() {
              //               //                                                 balance =
              //               //                                                     balance +
              //               //                                                         inputAmount;
              //               //                                               });
              //               //                                               Get
              //               //                                                   .back();
              //               //                                               Get
              //               //                                                   .snackbar(
              //               //                                                   'Deposit Successful',
              //               //                                                   '${amountFormatter
              //               //                                                       .format(
              //               //                                                       inputAmount
              //               //                                                           .toString())}/= has been deposited');
              //               //                                             } else {
              //               //                                               print(
              //               //                                                   'over');
              //               //                                               Fluttertoast
              //               //                                                   .showToast(
              //               //                                                   msg: 'amount above max deposit 10m',
              //               //                                                   backgroundColor: Colors
              //               //                                                       .red);
              //               //                                             }
              //               //                                           } else {
              //               //
              //               //                                           }
              //               //                                         }
              //               //                                     ),
              //               //                                   )
              //               //
              //               //                                 ],
              //               //                               ),
              //               //                             )),
              //               //                       ),
              //               //                     );
              //               //                   }),
              //               //             ),
              //               //
              //               //
              //               //             Padding(
              //               //               padding: EdgeInsets.only(top: 1.h),
              //               //               child: AppButton(
              //               //                   textStyle: ThemeService()
              //               //                       .isSavedDarkMode() ? AppTheme
              //               //                       .blackButtonText : AppTheme
              //               //                       .whiteButtonText,
              //               //                   title: 'Credit Card',
              //               //                   color: ThemeService()
              //               //                       .isSavedDarkMode()
              //               //                       ? Colors.white
              //               //                       : Colors.black,
              //               //                   function: () {
              //               //                     Get.back();
              //               //                     Get.snackbar('Coming Soon',
              //               //                         'Credit card deposits in testing');
              //               //                   }),
              //               //             ),
              //               //
              //               //           ],
              //               //         )),
              //               //   ),
              //               // );
              //
              //             }
              //           },
              //           child: SizedBox(
              //             height: 8.5.h,
              //             width: 30.w,
              //             child: Card(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(15.sp),
              //               ),
              //               child: Center(
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment
              //                       .spaceEvenly,
              //                   children: [
              //                     Image.asset(
              //                       'assets/wallet/deposit.png', width: 5.w,
              //                       color: AppTheme.primaryColor,),
              //                     Text('Deposit',
              //                       style: AppTheme.sectionMediumBoldTitle,),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              // ),

              // Bounceable(
              //   onTap: (){
              //
              //   },
              //   child: Container(
              //     width: 30.w,
              //     height: 5.h,
              //     decoration: BoxDecoration(
              //       color: AppTheme.primaryColor,
              //       borderRadius: BorderRadius.circular(15.sp)
              //     ),
              //     child: Center(child: Text('Borrow', style: AppTheme.whiteButtonText,),),
              //   ),
              // ),


              // Padding(
              //   padding: EdgeInsets.only(top: 1.h),
              //   child: Text(
              //     'Transaction History', style: AppTheme.sectionMediumBoldTitle,),
              // ),
              //
              // // userStorage.read('walletId') == null ? Center(child: Text('No Wallet Transactions', style: AppTheme.greenSectionTitle2,),)
              // // :
              // Obx(() {
              //   return
              //     // walletController.isPaymentsLoading.value ? Center(child: LoadingSpinner(loaderColor: AppTheme.primaryColor),)
              //     //   :
              //   walletController.paymentsList.isEmpty ? Center(child: Padding(
              //         padding: EdgeInsets.only(top: 5.h),
              //         child: Text('No Wallet Transactions', style: AppTheme.greenSectionTitle2,),
              //       ),)
              //       : Expanded(
              //     child: Padding(
              //       padding: EdgeInsets.only(top: 0.5.h),
              //       child: FadeInUp(
              //         child: ListView.builder(
              //           physics: const BouncingScrollPhysics(),
              //           itemCount: walletController.paymentsList.length,
              //           itemBuilder: (context, index) {
              //             var transaction = walletController.paymentsList[index];
              //             return Padding(
              //               padding: EdgeInsets.only(top: 0.5.h),
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15.sp),
              //                 ),
              //                 child: ListTile(
              //                   leading: Image.asset(transaction.reason.toString() == 'payment for products' ? 'assets/wallet/p1.png' :'assets/wallet/d1.png'),
              //             //       leading: CircleAvatar(
              //             //         backgroundColor: Colors.transparent,
              //             // backgroundImage: AssetImage(transaction.reason.toString() == 'payment for products' ? 'assets/wallet/p1.png' :'assets/wallet/d1.png'),
              //             //       //   child: Text(transaction.status == 'successful' ? 'S' : 'F', style: AppTheme.sectionWhiteBigTitle,),
              //             //       //   backgroundColor: transaction.status == 'successful' ? AppTheme.primaryColor : AppTheme.warningTextColor,
              //             //       // ),
              //             //       ),
              //                   title: Text(transaction.walletPaymentId.toString(),
              //                     style: AppTheme.cardTitle,),
              //                   subtitle: Text(
              //                     DateFormat('E, d MMM yyyy').format(
              //                         transaction.createdAt!),
              //                     style: AppTheme.subtitleSmall,),
              //                   trailing: transaction.status ==
              //                       'successful'
              //                       ?
              //                   Text('${transaction.reason.toString() == 'payment for products' ? '-' : '+'}' + '${amountFormatter.format(
              //                       transaction.amount.toString())}/=',
              //                     style:  TextStyle(
              //                       color: AppTheme.primaryColor,
              //                     ),)
              //                       : Text('${transaction.reason.toString() == 'payment for products' ? '-' : '+'}' + '${amountFormatter.format(
              //                       transaction.amount.toString())}/=',
              //                     style: TextStyle(
              //                       color: Colors.red,
              //                     ),),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
