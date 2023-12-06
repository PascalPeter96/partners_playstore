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
import 'package:wena_partners/vendor/contollers/store/store_details_controller.dart';
import 'package:wena_partners/vendor/screens/account/edit_vendor_profile_screen.dart';
import 'package:wena_partners/vendor/screens/account/store_branch_products_screen.dart';
import 'package:wena_partners/vendor/widget/loading_widget.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final StoreDetailsController storeDetailsController = Get.put(StoreDetailsController(storeId: userStorage.read('storeId')));
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
          title: 'My Store',
          titleWidget: Container(width: 10.w,),
        ),
      ),

      body: Obx(() {
        return storeDetailsController.isLoading.value ? LoadingWidget()
            : SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.sp),
                child: CachedNetworkImage(
                    imageUrl: storeDetailsController.storeDetails.value.storeImgUrl.toString(),
                  fit: BoxFit.fill,
                  height: 25.h,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),


            SizedBox(height: 3.h,),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text('Store Id'),
                  Text(storeDetailsController.storeDetails.value.storeId.toString(), style: AppTheme.cardTitle,),
                ],
            ),
            SizedBox(height: 1.h,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Business Name'),
                  Text(storeDetailsController.storeDetails.value.businessName.toString(), style: AppTheme.greenSectionTitle,),
                ],
            ),
            SizedBox(height: 1.h,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Telephone'),
                  Text(storeDetailsController.storeDetails.value.businessTel.toString(), style: AppTheme.cardTitle,),
                ],
            ),
            SizedBox(height: 1.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(storeDetailsController.storeDetails.value.branches!.length <=1 ? '${storeDetailsController.storeDetails.value.branches!.length} Branch' : '${storeDetailsController.storeDetails.value.branches!.length} Branches', style: AppTheme.appTitle,),

                SizedBox(
                  height: 5.h,
                  width: 20.w,
                    child: AppButton(
                        title: 'Add',
                        color: AppTheme.primaryColor,
                        function: (){
                          // Get.to(() => EditVendorScreen(
                          //     businessImage: storeDetailsController.storeDetails.value.storeImgUrl.toString(),
                          //     businessName: storeDetailsController.storeDetails.value.businessName.toString(),
                          //     businessPhone: storeDetailsController.storeDetails.value.businessTel.toString(),
                          //     frontId: storeDetailsController.storeDetails.value.nationalIdFront.toString(),
                          //     backId: storeDetailsController.storeDetails.value.nationalIdBack.toString()
                          // ),
                          //   transition: Transition.downToUp
                          // );
                        })),


              ],
            ),

            // CachedNetworkImage(imageUrl: storeDetailsController.storeDetails.value.storeImg.toString()),

            SizedBox(height: 1.h,),
            Expanded(
              child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: storeDetailsController.storeDetails.value.branches!.length,
                  itemBuilder: (context, index){
                    var branch = storeDetailsController.storeDetails.value.branches![index];
                    return FadeInUp(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: ListTile(
                          onTap: (){
                            Get.to(() => StoreBranchProductsScreen(name: branch.address.toString(),));
                          },
                          title: Text('@ ${branch.address}',
                            style: AppTheme.greenSectionTitle,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tel : ${branch.storeBranchTel.toString()}', style: AppTheme.greySmallSegoe,),
                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            ),

          ],
        ),
              ),
            );
      }),

    );
  }
}
