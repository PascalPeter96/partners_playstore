
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/models/retail/store_products_variants_model.dart';
import 'package:wena_partners/vendor/models/store/branch_products_model.dart';
import 'package:wena_partners/vendor/services/store_branch_products_repository.dart';
import 'package:wena_partners/vendor/services/store_products_repository.dart';

class StoreBranchProductsListController extends GetxController {


  var branchProductList = <StoreBranchProduct>[].obs;
  var isLoading = true.obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStoreBranchProducts();

  }



  getAllStoreBranchProducts() async {
    var products =  await StoreBranchProductsRepository().fetchStoreBranchProducts(userStorage.read('vendorAccessToken').toString());
    if(products != null) {
      branchProductList.value = products;
      isLoading.value = false;


    } else {
      isLoading(true);
    }
    return branchProductList;
  }

}