
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/vendor/models/retail/add_retail_product_model.dart';
import 'package:wena_partners/vendor/models/retail/store_products_variants_model.dart';
import 'package:wena_partners/vendor/services/store_products_repository.dart';

class StoreProductsController extends GetxController {

  final userStorage = GetStorage();
  
  var productVariantList = <StoreProductVariants>[].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;

  var orderUnits = [
    'Dozen',
    'Bag',
    'Box',
    'Pieces',
    'Rolls',
    'Meter(m)',
    'Inc(in)',
    'Kilogram(kg)',
    'Ton(T)',
    'Gram(g)',
    'Litres(L)',
  ].obs;

  var durationUnits = [
    'Hours',
    'Days',
    'Weeks'
  ].obs;

  var orderUnitType = ''.obs;
  var durationUnitType = ''.obs;
  var productVariantId = ''.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProductVariants();

  }

  setOrderUnitType(String unit){
    orderUnitType.value = unit;
    print(orderUnitType);
  }

  setDurationUnitType(String unit){
    durationUnitType.value = unit;
    print(durationUnitType);
    print(productVariantId.value);
    print(unit);
  }

  setProductVariantIdType(String id){
    productVariantId.value = id;
    print(productVariantId.value);
    print(id);
  }


  getAllProductVariants() async {
    var products =  await StoreProductVariantsRepository().fetchStoreProductVariants(userStorage.read('vendorAccessToken'));
    if(products != null) {
      productVariantList.value = products;
      isLoading.value = false;


    } else {
      isLoading(true);
    }
    return productVariantList;
  }

  addRetailProduct(String orderUnit, String prepTime, String prepTimeUnit,
      String price, String prodVariantId, String storeBranchId
      ) async{
    isAddLoading(true);

    AddRetailProductModel addRetailProductModel = AddRetailProductModel(
        orderUnit: orderUnit,
        prepTime: prepTime,
      prepTimeUnit: prepTimeUnit,
      price: price,
      productVariantId: prodVariantId,
      storeBranchId: storeBranchId,
    );

    var response = await NetworkHandler.post(addRetailProductModelToJson(addRetailProductModel), 'store/products/retail-products', userStorage.read('vendorAccessToken'));

    var data = json.decode(response);
    print(response);
    print(data);

    if(data['status'] == 'success'){
      isAddLoading(false);
      Get.back();
      Get.snackbar('Success', 'Product Added Successfully');

    } else {
      isAddLoading(false);
      Get.snackbar('Failed', data['message'].toString(), titleText: Text('Failed', style: AppTheme.sectionMediumBoldTitle,));
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      print(data);
    }

  }

}