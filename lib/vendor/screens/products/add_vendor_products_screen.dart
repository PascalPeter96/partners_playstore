import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/contollers/bulk/bulk_store_products_controller.dart';
import 'package:wena_partners/vendor/contollers/retail/store_products_controller.dart';
import 'package:wena_partners/vendor/contollers/store/store_details_controller.dart';
import 'package:wena_partners/vendor/models/retail/store_products_variants_model.dart';
import 'package:wena_partners/vendor/models/store/store_details_model.dart';
import 'package:wena_partners/vendor/screens/products/add_bulk_tab.dart';
import 'package:wena_partners/vendor/screens/products/add_retail_tab.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_drop_downs.dart';


class AddVendorProductsScreen extends StatefulWidget {
  const AddVendorProductsScreen({super.key});

  @override
  State<AddVendorProductsScreen> createState() =>
      _AddVendorProductsScreenState();
}

class _AddVendorProductsScreenState extends State<AddVendorProductsScreen> {

  final StoreProductsController storeProductsController = Get.put(
      StoreProductsController());

  final StoreDetailsController storeDetailsController = Get.put(
      StoreDetailsController(storeId: userStorage.read('storeId')));

  final BulkStoreProductsController bulkStoreProductsController = Get.put(BulkStoreProductsController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product', style: AppTheme.whiteAppTitle,),
          centerTitle: true,
          bottom: TabBar(
              tabs: [
                Tab(child: Text('Retail'),),
                Tab(child: Text('Bulk'),),
              ],),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: TabBarView(children: [
              AddRetailTab(storeProductsController: storeProductsController, storeDetailsController: storeDetailsController),
              AddBulkTab(bulkStoreProductsController: bulkStoreProductsController, storeDetailsController: storeDetailsController),
            ]),
          ),
        ),
      ),
    );
  }
}
