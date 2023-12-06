import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/delivery/screens/auth/privacy_policy_screen.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/account/repository/logout_repository.dart';
import 'package:wena_partners/vendor/account/screens/edit_profile_screen.dart';
import 'package:wena_partners/vendor/account/screens/login_screen.dart';
import 'package:wena_partners/vendor/account/screens/notification_screen.dart';
import 'package:wena_partners/vendor/branches/screens/branches_screnn.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/contactus/screen/chat_boat_screen.dart';
import 'package:wena_partners/vendor/contactus/screen/contact_us_screen.dart';
import 'package:wena_partners/vendor/contollers/store/store_details_controller.dart';
import 'package:wena_partners/vendor/orders/screens/order_history_screnn.dart';
import 'package:wena_partners/vendor/report/screens/account_statement_screen.dart';
import 'package:wena_partners/vendor/report/screens/sale_report_screen.dart';
import 'package:wena_partners/vendor/screens/account/edit_vendor_profile_screen.dart';
import 'package:wena_partners/vendor/screens/account/store_details_screen.dart';
import 'package:wena_partners/vendor/screens/wallet/wallet_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/subscription/models/subscription_detail_model.dart';
import 'package:wena_partners/vendor/subscription/repository/cancel_subscription_repository.dart';
import 'package:wena_partners/vendor/subscription/repository/user_subscription_repository.dart';
import 'package:wena_partners/vendor/subscription/screens/premium_screen.dart';
import 'package:wena_partners/vendor/transaction/screen/transaction_list.dart';
import 'package:wena_partners/vendor/transaction/screen/wallet_screen.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class AccountScreen extends StatefulWidget {
  var backListner;

  AccountScreen(this.backListner);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {


  bool _isReportExpanded = false;

  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    _profilePic = await LocalStorage.getUserProfilePic();
    _email = await LocalStorage.getUserEmail();
    _userName = await LocalStorage.getUserName();

    getsubscribe();
  }

  SubscriptionDetailsModel subscriptionDetailsModel =
  SubscriptionDetailsModel();
  String _userId = "";
  String _userToken = "";
  String _profilePic = "";
  String _email = "";
  String _userName = "";

  final UserSubscribeRepository _subscribeRepository = UserSubscribeRepository();

  getsubscribe() async {
    _subscribeRepository.getUserSubScribe(
        data: {
          "fk_vendor": _userId,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_subscribeRepository.subResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_subscribeRepository.subResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        subscriptionDetailsModel =
            SubscriptionDetailsModel.fromJson(value["body"]["data"]);
        _isSubscription = true;
      } else {
        _isSubscription = false;
      }
    });
  }

  bool _isSubscription = true;

  final CancelSubscriptionRepository _cancelSubscriptionRepository =
  CancelSubscriptionRepository();

  cancelsubscribe() async {
    _cancelSubscriptionRepository.cancelSubscription(
        data: {
          "vendor_id": _userId,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_cancelSubscriptionRepository.subResp.status ==
                Status.LOADING) {
              showLoadingDialog();
            } else if (_cancelSubscriptionRepository.subResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _isSubscription = false;
      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  convertDate(String date) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat("dd MMM yyyy ").format(tempDate);
  }

  @override
  Widget build(BuildContext context) {
    final StoreDetailsController storeDetailsController = Get.put(
        StoreDetailsController(storeId: userStorage.read('storeId')));

    return BackgroundWithBackWidget(
      Expanded(
          child: SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 1.h),
                    child:
                    Row(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15.sp),
                              child: CachedNetworkImage(
                                imageUrl: storeDetailsController
                                    .storeDetails.value.storeImgUrl
                                    .toString(),
                                width: 20.w,
                              ),
                            );
                          }),
                          SizedBox(
                            width: dimen20,
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return Text(
                                        storeDetailsController.storeDetails.value
                                            .businessName == null ? '...' : storeDetailsController.storeDetails.value
                                          .businessName.toString(),
                                      style: textSegoeUiColor161616Size20,
                                    );
                                  }),
                                  SizedBox(
                                    height: dimen05,
                                  ),
                                  Text(
                                    userStorage.read('vendorEmail').toString(),
                                    style: textSegoeUiColorContentSize16,
                                  )
                                ],
                              )),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => EditVendorScreen(
                                  businessName: storeDetailsController.storeDetails.value.businessName.toString(),
                                  businessImage: storeDetailsController.storeDetails.value.storeImgUrl.toString(),
                                  businessPhone: storeDetailsController.storeDetails.value.businessTel.toString(),
                                  frontId: storeDetailsController.storeDetails.value.nationalIdFront.toString(),
                                  backId: storeDetailsController.storeDetails.value.nationalIdBack.toString(),
                                ),
                                    transition: Transition.downToUp
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const EditProfileScreen()));
                              },
                              child: Image.asset(
                                "assets/icons/edit_circle.png",
                                width: dimen30,
                                height: dimen30,
                              )),
                        ]),
                  ),

                  
                  // if (_isSubscription &&
                  //     subscriptionDetailsModel.intGlcode != null &&
                  //     _subscribeRepository.subResp.status != Status.LOADING)
                  //   Container(
                  //     padding: EdgeInsets.all(dimen10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(dimen15)),
                  //         border: Border.all(
                  //             width: 1.0, color: const Color(colorSecondary))),
                  //     margin: EdgeInsets.only(top: dimen20),
                  //     child: Column(children: [
                  //       Container(
                  //         child: Row(children: [
                  //           Expanded(
                  //               child: Text(
                  //                 "My Active Plan",
                  //                 style: textSegoeUiColor292D32Size16,
                  //               )),
                  //           Text(
                  //             "Heighlight Products",
                  //             style: textSegoeUiColorSecondarySize16,
                  //           )
                  //         ]),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.only(top: dimen20),
                  //         child: Row(children: [
                  //           Expanded(
                  //               child: Text(
                  //                 "Renew on: " +
                  //                     convertDate(
                  //                         subscriptionDetailsModel.endDate!),
                  //                 style: textSegoeUiColor292D32Size16,
                  //               )),
                  //           GestureDetector(
                  //               onTap: () {
                  //                 cancelsubscribe();
                  //               },
                  //               child: SizedBox(
                  //                   width: dimen100,
                  //                   height: dimen40,
                  //                   child: const CustomButtonColorLightRedWidget(
                  //                       "Cancel", false)))
                  //         ]),
                  //       )
                  //     ]),
                  //   ),
                  // if (subscriptionDetailsModel.intGlcode == null &&
                  //     _subscribeRepository.subResp.status != Status.LOADING)
                  //   GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => PremiumScreen()));
                  //       },
                  //       child: Container(
                  //         margin: EdgeInsets.only(top: dimen20),
                  //         padding: EdgeInsets.all(dimen20),
                  //         decoration: BoxDecoration(
                  //             color: const Color(colorSecondary),
                  //             borderRadius: BorderRadius.all(
                  //                 Radius.circular(dimen20))),
                  //         child: Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Image.asset(
                  //                 "assets/icons/star.png",
                  //                 width: dimen60,
                  //                 height: dimen60,
                  //               ),
                  //               Expanded(
                  //                   child: Container(
                  //                     margin: EdgeInsets.only(left: dimen20),
                  //                     child: Column(
                  //                         crossAxisAlignment: CrossAxisAlignment
                  //                             .start,
                  //                         mainAxisAlignment: MainAxisAlignment
                  //                             .center,
                  //                         children: [
                  //                           Text(
                  //                             "Upgrade to Premium",
                  //                             style: textGilroyWhiteSize16Bold,
                  //                           ),
                  //                           SizedBox(
                  //                             height: dimen10,
                  //                           ),
                  //                           Text(
                  //                             "Enjoy our services with full access and without restrictions",
                  //                             style: textGilroyWhiteSize14,
                  //                           )
                  //                         ]),
                  //                   )),
                  //               Icon(
                  //                 Icons.arrow_forward_ios,
                  //                 color: Colors.white,
                  //                 size: dimen30,
                  //               )
                  //             ]),
                  //       )),


                  SizedBox(
                    height: dimen30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) => const OrderHistoryScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/orders.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Order History",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => StoreDetailsScreen());

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const EditProfileScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/user.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "My Profile",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => PremiumScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/subscription.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Subscription",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => BranchesScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/store.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Store Branches",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransctionlistScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/transaction.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Transactions",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => VendorWalletScreen());
                        // Navigator.push(context,
                        //     MaterialPageRoute(
                        //         builder: (context) => WalletScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wallet_outlined,
                                color: Color(colorContent),
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Wallet",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Icon(
                                Icons.contact_page_outlined,
                                size: dimen24,
                                color: const Color(colorContent),
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Contact Us",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => ChatBoatScreen()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.contact_support_outlined,
                            size: dimen24,
                            color: const Color(colorContent),
                          ),
                          SizedBox(
                            width: dimen20,
                          ),
                          Expanded(
                              child: Text(
                                "Support",
                                style: textSegoeUiColorContentSize16,
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color(colorContent),
                            size: dimen20,
                          )
                        ],
                      )),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen());
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/tandc.png",
                            width: dimen30,
                            height: dimen30,
                          ),
                          SizedBox(
                            width: dimen20,
                          ),
                          Expanded(
                              child: Text(
                                "Terms & Conditions",
                                style: textSegoeUiColorContentSize16,
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color(colorContent),
                            size: dimen20,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) => const NotificationListScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications_active_outlined,
                                color: Color(colorContent),
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Notifications",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(colorContent),
                                size: dimen20,
                              )
                            ],
                          ))),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        _isReportExpanded = !_isReportExpanded;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/report.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Reports",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                              if (!_isReportExpanded)
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: const Color(colorContent),
                                  size: dimen20,
                                ),
                              if (_isReportExpanded)
                                Image.asset(
                                  "assets/icons/arrow_down.png",
                                  width: dimen20,
                                  height: dimen20,
                                  color: const Color(colorContent),
                                )
                            ],
                          ))),
                  if (_isReportExpanded)
                    Container(
                      margin: EdgeInsets.only(top: dimen10, bottom: dimen10),
                      child: Column(children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SalesReportScreen()));
                            },
                            child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: dimen50,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "Sales Report",
                                          style: textSegoeUiColorContentSize16,
                                        )),
                                  ],
                                ))),
                        SizedBox(
                          height: dimen15,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AccountStatementScreen()));
                            },
                            child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: dimen50,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "Account Statement",
                                          style: textSegoeUiColorContentSize16,
                                        )),
                                  ],
                                ))),
                        SizedBox(
                          height: dimen15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: dimen50,
                            ),
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.snackbar('Coming Soon',
                                        'Store Performance in testing');
                                  },
                                  child: Text(
                                    "Store Performance",
                                    style: textSegoeUiColorContentSize16,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    ),
                  SizedBox(
                    height: dimen20,
                  ),
                  Container(
                    height: 1,
                    color: const Color(colorContent).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  GestureDetector(
                      onTap: () {
                        showLoadingDialog();
                        LogoutRepository().logout(
                            data: {"var_vendor_id": _userId},
                            stateChange: () {
                              setState(() {});
                            }).then((value) {
                          hideLoadingDialog();
                          if (value["body"]["status"] == 200) {
                            LocalStorage.setUserId("");
                            LocalStorage.setToken("");
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);
                          }
                        });
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/logout.png",
                                width: dimen30,
                                height: dimen30,
                              ),
                              SizedBox(
                                width: dimen20,
                              ),
                              Expanded(
                                  child: Text(
                                    "Logout",
                                    style: textSegoeUiColorContentSize16,
                                  )),
                            ],
                          ))),
                  SizedBox(
                    height: dimen50,
                  )
                ]),
              ))),
      "Account",
      backListner: widget.backListner,
    );
  }
}
