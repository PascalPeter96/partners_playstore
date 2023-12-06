import 'package:amount_formatter/amount_formatter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';

import 'package:wena_partners/vendor/contollers/retail/store_products_controller.dart';
import 'package:wena_partners/vendor/contollers/store/store_details_controller.dart';
import 'package:wena_partners/vendor/models/retail/store_products_variants_model.dart';

import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_drop_downs.dart';



class AddRetailProductTab extends StatefulWidget {

  const AddRetailProductTab({Key? key,}) : super(key: key);

  @override
  State<AddRetailProductTab> createState() => _AddRetailProductTabState();
}

class _AddRetailProductTabState extends State<AddRetailProductTab> {

  final StoreProductsController storeProductsController = Get.put(
      StoreProductsController());

  final StoreDetailsController storeDetailsController = Get.put(
      StoreDetailsController(storeId: userStorage.read('storeId')));

  final _formKey = GlobalKey<FormState>();

  final TextEditingController priceCont = TextEditingController();
  final TextEditingController prepTimeCont = TextEditingController();


  final priceValidator = MultiValidator([
    RequiredValidator(errorText: 'price required'),

  ]);

  final prepTimeValidator = MultiValidator([
    RequiredValidator(errorText: 'prep time required'),
    MinLengthValidator(1, errorText: 'min is 1'),
  ]);

  late SingleValueDropDownController productVariantCont;
  // late SingleValueDropDownController orderUnitsCont;
  // late SingleValueDropDownController durationUnitsCont;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productVariantCont = SingleValueDropDownController();
    // orderUnitsCont = SingleValueDropDownController();
    // durationUnitsCont = SingleValueDropDownController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // productVariantCont.dispose();
    // orderUnitsCont.dispose();
    // durationUnitsCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: FadeInUp(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20.h,),

                  Obx(() {
                    return ProductVariantsApiDropdown<StoreProductVariants>(
                      hintText: 'Branch',
                      menuItems: storeProductsController.productVariantList.value,
                      onChanged: (value) {
                     storeProductsController.setProductVariantIdType(value!.productVariantId.toString());
                        print(value);

                      },
                    );
                  }),

                  // Obx(() {
                  //   return SearchableProductVariantsDropDown<StoreProductVariants>(
                  //     hintText: 'Product',
                  //     menuItems: storeProductsController.productVariantList.value,
                  //     controller: productVariantCont,
                  //     onChanged: (value) {
                  //       // storeProductsController.setProductVariantIdType(value);
                  //       print(value);
                  //
                  //     },
                  //   );
                  // }),

                  // Obx(() {
                  //   return CustomGenericSearchableDropDown<StoreBranch>(
                  //     hintText: 'Branch',
                  //     menuItems: widget.storeDetailsController.storeDetails.value
                  //         .branches == null ? [] : widget.storeDetailsController
                  //         .storeDetails.value
                  //         .branches!,
                  //     controller: productVariantCont,
                  //     onChanged: (value) {
                  //       // storeDetailsController.setStoreBranchId(value);
                  //       print(value);
                  //
                  //     },
                  //   );
                  // }),
                  //
                  //
                  // Obx(() {
                  //   return SearchableDropDown<String>(
                  //     hintText: 'Order Unit',
                  //     menuItems: widget.storeProductsController.orderUnits.value,
                  //     controller: orderUnitsCont,
                  //     onChanged: (value) {
                  //       widget.storeProductsController.setOrderUnitType(value.toString());
                  //
                  //     },
                  //   );
                  // }),
                  //
                  // Container(
                  //   clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15.sp)
                  //   ),
                  //   child: TextFormField(
                  //     style: TextStyle(color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black),
                  //     keyboardType: TextInputType.number,
                  //     controller: priceCont,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //       fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
                  //       hintText: 'Price',
                  //       // hintStyle: const TextStyle(color: Colors.grey),
                  //       enabledBorder: InputBorder.none,
                  //       focusedBorder: InputBorder.none,
                  //       focusedErrorBorder: InputBorder.none,
                  //       errorBorder: InputBorder.none,
                  //     ),
                  //     validator: priceValidator,
                  //   ),
                  // ),
                  //
                  // SizedBox(height: 3.h,),
                  //
                  // Obx(() {
                  //   return SearchableDropDown<String>(
                  //     hintText: 'Preparation Duration',
                  //     menuItems: widget.storeProductsController.durationUnits.value,
                  //     controller: durationUnitsCont,
                  //     onChanged: (value){
                  //       widget.storeProductsController.setProductVariantIdType(value.toString());
                  //       print(value.toString());
                  //
                  //     },
                  //   );
                  // }),
                  //
                  // Container(
                  //   clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15.sp)
                  //   ),
                  //   child: TextFormField(
                  //     style: TextStyle(color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black),
                  //     keyboardType: TextInputType.number,
                  //     controller: prepTimeCont,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //       fillColor: ThemeService().isSavedDarkMode() ? Colors.white10 : AppTheme.borderColor2,
                  //       hintText: 'Prep Time',
                  //       // hintStyle: const TextStyle(color: Colors.grey),
                  //       enabledBorder: InputBorder.none,
                  //       focusedBorder: InputBorder.none,
                  //       focusedErrorBorder: InputBorder.none,
                  //       errorBorder: InputBorder.none,
                  //     ),
                  //     validator: prepTimeValidator,
                  //   ),
                  // ),

                  SizedBox(height: 2.h,),

                  AppButton(
                      title: 'Add Retail Product',
                      color: AppTheme.primaryColor,
                      function: (){
                        if(_formKey.currentState!.validate()
                            && storeDetailsController.storeBranchId.value.isNotEmpty
                            && storeProductsController.productVariantId.value.isNotEmpty
                            && storeProductsController.orderUnitType.value.isNotEmpty
                            && storeProductsController.durationUnitType.value.isNotEmpty
                        ){
                          Get.snackbar('Success', 'Added Retail Product');
                        } else {
                          Fluttertoast.showToast(msg: 'Fill in all Fields');
                        }
                      }),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}