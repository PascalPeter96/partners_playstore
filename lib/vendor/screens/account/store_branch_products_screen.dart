import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/contollers/store/store_branch_products_controller.dart';
import 'package:wena_partners/vendor/contollers/store/store_details_controller.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';
import 'package:wena_partners/vendor/widget/loading_widget.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class StoreBranchProductsScreen extends StatefulWidget {
  final String name;

  const StoreBranchProductsScreen({super.key, required this.name});

  @override
  State<StoreBranchProductsScreen> createState() =>
      _StoreBranchProductsScreenState();
}

class _StoreBranchProductsScreenState extends State<StoreBranchProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final StoreBranchProductsListController storeBranchProductsListController = Get
        .put(StoreBranchProductsListController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
            title: widget.name,
            titleWidget: Container(width: 10.w,),

        ),
      ),

      body: Obx(() {
        return OverlayLoaderWithAppIcon(
          isLoading: storeBranchProductsListController.isLoading.value,
          appIcon: Image.asset('assets/images/logo.png'),
          overlayBackgroundColor: AppTheme.primaryLightColor,
          appIconSize: 40.sp,
          overlayOpacity: 0.4,

          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  storeBranchProductsListController.branchProductList.length ==
                      1 ? Text('1 Product', style: AppTheme.greenSectionTitle2,)
                      : storeBranchProductsListController.branchProductList
                      .length == 0 ? Text(
                    '', style: AppTheme.greenSectionTitle2,)
                      : Text(
                    '${storeBranchProductsListController.branchProductList
                        .length} Products',
                    style: AppTheme.greenSectionTitle2,),

                  SizedBox(height: 2.h,),

                  Expanded(
                    child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: storeBranchProductsListController
                            .branchProductList.length,
                        itemBuilder: (context, index) {
                          var product = storeBranchProductsListController
                              .branchProductList[index];
                          return FadeInUp(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp)
                              ),
                              child: ListTile(
                                title: Text(product.product!.name.toString(),
                                  style: AppTheme.greenSectionTitle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.product!.description.toString(),
                                      style: AppTheme.greySmallSegoe,),
                                  ],
                                ),
                                trailing: Text(
                                  product.price == null ? 'ugx' : product.price
                                      .toString(),
                                  style: AppTheme.sectionMediumBoldTitle,),
                              ),
                            ),
                          );
                        }),
                  ),

                ],
              ),
            ),
          ),
        );
      }),

    );
  }
}
