import 'package:amount_formatter/amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/home/delivery_bottom_navbar.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/section_title.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';



class CanceledOrderDetailsScreen extends StatefulWidget {

  const CanceledOrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CanceledOrderDetailsScreen> createState() => _CanceledOrderDetailsScreenState();
}

class _CanceledOrderDetailsScreenState extends State<CanceledOrderDetailsScreen> {

  late String selectedValue;


  int number = 0;

  int? prodIndex;

  final amountFormatter = AmountFormatter(separator: ',');

  // final ProductCartPdfInvoiceService service = ProductCartPdfInvoiceService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = 'Delivery';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const TitleAppBar(
          title: 'CheckOut',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: SectionTitle(title: 'Shipping Address', fontSize: 10.sp,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    title: const Text('Home'),
                    subtitle: const Text('BTM Layout 500627'),
                    trailing: GestureDetector(
                        onTap: (){

                        },
                        child: const Icon(Icons.edit)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: SectionTitle(title: 'Order List', fontSize: 10.sp,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: SectionTitle(title: 'Promo Code', fontSize: 10.sp,),
              ),

              TextField(
                decoration: InputDecoration(
                  fillColor: AppTheme.borderColor2,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  suffix: Text('Apply', style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold
                  ),),
                  hintText: 'MHA2923F',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: SectionTitle(title: 'Choose Delivery Option', fontSize: 10.sp,),
              ),

              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: RadioListTile(
                  activeColor: AppTheme.primaryColor,
                  value: 'Delivery',
                  groupValue: selectedValue.toString(),
                  onChanged: (value){
                    setState((){
                      selectedValue = value as String;
                    });
                  },
                  title: const Text('DELIVERY'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                      side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: RadioListTile(
                  activeColor: AppTheme.primaryColor,
                  value: 'PickUp',
                  groupValue: selectedValue.toString(),
                  onChanged: (value){
                    setState((){
                      selectedValue = value as String;
                    });
                  },
                  title: const Text('PICKUP'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                      side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300
                      )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount', style: AppTheme.greySmallSegoe,),
                  Text('UGX ${amountFormatter.format('')}', style: AppTheme.greySmallSegoe,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax', style: AppTheme.greySmallSegoe,),
                  Text('UGX 0', style: AppTheme.greySmallSegoe,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping', style: AppTheme.greySmallSegoe,),
                  Text('UGX 0', style: AppTheme.greySmallSegoe,)
                ],
              ),
              Divider(height: 2.h,color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTheme.sectionBigTitle),
                  Text('UGX ${amountFormatter.format('')}', style: AppTheme.sectionBigTitle,)
                ],
              ),
              Divider(height: 2.h,color: Colors.black),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Bounceable(
                  onTap: () async{
                    // final data = await service.createInvoicePdf(controller, controller.total, null, null);
                    // await service.savePdfFile('Wena-Multiple-Invoice_$number', data);
                    number++;
                  },
                  child: Container(
                    height: 7.5.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(
                          color: AppTheme.primaryColor,
                          width: 2,
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Download Invoice', style: TextStyle(
                              color: AppTheme.primaryColor,
                              decoration: TextDecoration.underline,
                              fontFamily: 'SEGOEUI',
                              fontSize: 17.5.sp
                          ),),
                          Image.asset('assets/download.png', scale: 3,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: AppButton(
                    title: 'Checkout',
                    color: AppTheme.primaryColor,
                    function: (){
                      showSuccessOrder(context, selectedValue);
                      print('good');
                      print(selectedValue);
                    }),
              )

            ],
          ),
        ),
      ),
    );
  }
}
void showSuccessOrder(BuildContext context, String selectedValue) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.sp),
        ),
        // title: const Text("Alert!!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/thankyou.png",height: 130,),
            SizedBox(height: 3.h,),
            Text(
              "Thank You !",
              style: AppTheme.greenTitle,
            ),
            SizedBox(height: 3.h,),
            Center(
              child: Text(
                "Your order has been successfully completed.",
                textAlign: TextAlign.center,
                style: AppTheme.subtitleSmall,
              ),
            ),
            SizedBox(height: 5.h,),
            AppButton(
                title: 'Back',
                color: AppTheme.primaryColor,
                function: (){
                  Get.offAll(() => const DeliveryBottomNavBar());
                  print('object');
                })
          ],
        ),

      );
    },
  );
}

