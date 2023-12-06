import 'dart:convert';

import 'package:amount_formatter/amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/vendor/models/wallet/create_wallet_model.dart';
import 'package:wena_partners/vendor/models/wallet/deposit_wallet_model.dart';
import 'package:wena_partners/vendor/models/wallet/wallet_model.dart';
import 'package:wena_partners/vendor/models/wallet/wallet_payments_model.dart';
import 'package:wena_partners/vendor/screens/wallet/wallet_deposit_screen.dart';
import 'package:wena_partners/vendor/services/wallet/wallet_payments_repository.dart';
import 'package:wena_partners/vendor/utils/constants.dart';



class VendorWalletController extends GetxController {


  final String? walletId;
  VendorWalletController({this.walletId});

  var walletModel = VendorWalletModel().obs;

  final userStorage = GetStorage();
  var isLoading = false.obs;
  var isWalletLoading = true.obs;
  var isCreateWalletLoading = false.obs;
  var isDepositWalletLoading = false.obs;
  var isAmountLoading = false.obs;
  var selectedStage = 'Re-stocking'.obs;
  var paymentsList = <VendorWalletPayment>[].obs;
  var isPaymentsLoading = true.obs;

  static var client = http.Client();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWalletDetails();
  }


  void updateSelectedStage(String newStage) {
    selectedStage.value = newStage;
  }


  createWallet(String userId) async {
    isCreateWalletLoading(true);

    VendorCreateWallet createWallet = VendorCreateWallet(userId: userId);

    var response = await NetworkHandler.post(createWalletToJson(createWallet), 'create-wallet', userStorage.read('access_token'));

    var data = json.decode(response);
    print(data);

    if(data['success'] == 'Wallet created successful'){
      isCreateWalletLoading(false);
      print(data);
      await userStorage.write('vendorWalletId', data['data']['wallet_id']);
      await userStorage.write('vendorWalletBalance', data['data']['balance']);
      await userStorage.write('walletUserId', data['data']['user_id']).then((value) {
        fetchWalletDetails();
        Get.back();
      });
      fetchWalletDetails();
      print(userStorage.read('vendorWalletId'));
      print(userStorage.read('vendorWalletBalance'));
      print(userStorage.read('walletUserId'));

      // await userStorage.write('walletId', '');
      // await userStorage.write('isLoggedIn', true);
      // await userStorage.write('email', data['data']['user']['email']);

      Get.snackbar('Success', 'Wallet Created Successfully', titleText: Text('Success', style: AppTheme.greenTitle,));
      // print( userStorage.read('email'));

    } else {
      Get.back();
      isCreateWalletLoading(false);

      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      print(data);
    }

  }

  depositWallet(String walletId, String amount) async {
    isDepositWalletLoading(true);

    VendorDepositWalletModel depositWalletModel = VendorDepositWalletModel(walletId: walletId, amount: amount);

    var response = await NetworkHandler.post(depositWalletModelToJson(depositWalletModel), 'deposit-on-wallet', '');

    var data = json.decode(response);

    if(data['status'] == 'success'){
      isDepositWalletLoading(false);
      Get.back();
      Get.to(() => WalletDepositScreen(paymentUrl: data['payment_link'], amount: amount));

      print(data);
      // await userStorage.write('isLoggedIn', true);
      // await userStorage.write('email', data['data']['user']['email']);
      // print( userStorage.read('email'));

    } else {
      isDepositWalletLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      print(data);
    }

  }


  void fetchWalletDetails() async {
    // isAmountLoading(true);
    var response = await client.get(Uri.parse('${Constants.BASE_URL}wallet/$walletId'));
    if (response.statusCode == 200) {
      walletModel.value = VendorWalletModel.fromJson(jsonDecode(response.body));
      getAllWalletPayments();
      print(walletModel.value.status);
      print(walletModel.value.wallet.toString());
      print(response.body);
      print(jsonDecode(response.body)['status']);
      isLoading.value = false;
      // isAmountLoading(false);

    } else {
      isLoading(true);
      // isAmountLoading(false);

      throw Exception('Failed to fetch wallet');
    }
  }


  getAllWalletPayments() async {
    var payments = await WalletPaymentsRepository().fetchWalletTransactions(walletId.toString());
    if(payments != null) {
      paymentsList.value = payments;
      isPaymentsLoading.value = false;

    } else {
      isPaymentsLoading.value = false;
    }
    return paymentsList;
  }

}