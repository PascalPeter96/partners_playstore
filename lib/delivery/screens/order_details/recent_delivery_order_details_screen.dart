
import 'package:amount_formatter/amount_formatter.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';
import 'package:wena_partners/delivery/screens/delivery_location/nearby_delivery_location_map_screen.dart';
import 'package:wena_partners/delivery/screens/delivery_location/recent_delivery_location_map_screen.dart';
import 'package:wena_partners/delivery/screens/home/delivery_bottom_navbar.dart';
import 'package:wena_partners/delivery/screens/location/recent_order_delivery_screen.dart';
import 'package:wena_partners/delivery/widgets/order_details_product_card.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/section_title.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';





class RecentDeliveryOrderDetailsScreen extends StatefulWidget {
  final RecentJobs recentJobs;

  const RecentDeliveryOrderDetailsScreen({Key? key, required this.recentJobs}) : super(key: key);

  @override
  State<RecentDeliveryOrderDetailsScreen> createState() => _RecentDeliveryOrderDetailsScreenState();
}

class _RecentDeliveryOrderDetailsScreenState extends State<RecentDeliveryOrderDetailsScreen> {

  late String selectedValue;

  int locationIndex = 0;
  int number = 0;

  int? prodIndex;

  final amountFormatter = AmountFormatter(separator: ',');

  // final ProductCartPdfInvoiceService service = ProductCartPdfInvoiceService();


  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Pick Up",
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: StepperText("Plot 37/45 Kampala Road, P.O Box 7120, Kampala, Uganda, 61059"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.car_rental, color: Colors.black),
        )),
    StepperData(
        title: StepperText("Delivery Location", textStyle: const TextStyle(
          color: Colors.grey,),),
        subtitle: StepperText("Plot 37/45 Kampala Road, P.O Box 7120, Kampala, Uganda, 61059"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.location_on, color: Colors.black),
        )),
  ];

  LatLng storeLocation = LatLng(0.3858431573515069, 32.65144595438129);


  late Distance distance;

  Dio dio  = new Dio();

  String storeTime = '';

  getTime(double lat, double long) async{
    var response = await dio.get(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=0.3858431573515069,32.65144595438129&destinations=$lat,$long&key=AIzaSyDBMJHAZDTZti1Y88i8TL-kmz_7qR9Tp5I'
    );

    String time = response.data['rows'][0]['elements'][0]['duration']['text'];

    setState((){
      storeTime = time;
    });

    print(storeTime);

    // await response.data['rows'][0]['elements'][0]['duration']['text'];

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = 'Delivery';
    distance = new Distance();
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
        title:  TitleAppBar(
          title: '#${widget.recentJobs.orderId.toString()}',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                     // backgroundImage: AssetImage('assets/images/man.png'),
                      child: Image.asset('assets/images/man.png', fit: BoxFit.cover,),
                    ),
                    title: Text('${widget.recentJobs.name}'),
                    subtitle:  Text('${widget.recentJobs.location}'),
                    trailing: GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: 20.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Bounceable(
                                onTap: () async{
                                  final Uri phoneUri = Uri(
                                    scheme: 'tel',
                                    path: '${widget.recentJobs.phone}'
                                  );
                                  if(await canLaunchUrl(phoneUri)){
                                    await launchUrl(phoneUri);
                                  } else {
                                    print('Cannot make Call');
                                  }

                                },
                                child: CircleAvatar(
                                    radius: 17.5.sp,
                                    backgroundColor: AppTheme.borderColor2,
                                    child: Image.asset('assets/icons/icon_call.png', height: 3.h,)),
                              ),
                              SizedBox(width: 2.w,),
                              Bounceable(
                                onTap: (){

                                },
                                child: CircleAvatar(
                                    radius: 17.5.sp,
                                    backgroundColor: AppTheme.borderColor2,
                                    child: Image.asset('assets/icons/icon_play.png', height: 3.h,)),
                              )
                            ],
                          ),
                        ),),
                  ),
                ),
              ),

              Divider(height: 2, color: Colors.black,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Order ID', style: AppTheme.sectionMediumTitle,),
                Text('#${widget.recentJobs.orderId}', style: AppTheme.sectionMediumBoldTitle,),
              ],),
              Divider(height: 2, color: Colors.grey,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date', style: AppTheme.sectionMediumTitle,),
                  Text('${DateFormat('E, d MMM yyyy').format(widget.recentJobs.date)}', style: AppTheme.sectionMediumBoldTitle,),
                ],),
              Divider(height: 2, color: Colors.grey,),

              Divider(height: 2, color: Colors.black,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time', style: AppTheme.sectionMediumTitle,),
                  Text('${widget.recentJobs.time}', style: AppTheme.sectionMediumBoldTitle,),
                ],),
              Divider(height: 2, color: Colors.grey,),


              AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                activeBarColor: AppTheme.borderColor2,
                inActiveBarColor: Colors.grey,
                gap: 3.h,
                activeIndex: 1,
              ),

              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: SectionTitle(title: 'Order Details', fontSize: 10.sp,),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.recentJobs.product.length,
                itemBuilder: (context, index){
                  return OrderProductDetailsCard(
                      name: widget.recentJobs.product[index].productName!,
                      quantity: widget.recentJobs.product[index].quantity!,
                  );
                },
              ),


              // Padding(
              //   padding: EdgeInsets.only(top: 1.h),
              //   child: Bounceable(
              //     onTap: () async{
              //       // final data = await service.createInvoicePdf(controller, controller.total, null, null);
              //       // await service.savePdfFile('Wena-Multiple-Invoice_$number', data);
              //       number++;
              //     },
              //     child: Container(
              //       height: 7.5.h,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15.sp),
              //           border: Border.all(
              //             color: AppTheme.primaryColor,
              //             width: 2,
              //           )
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 3.w),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text('Download Invoice', style: TextStyle(
              //                 color: AppTheme.primaryColor,
              //                 decoration: TextDecoration.underline,
              //                 fontFamily: 'SEGOEUI',
              //                 fontSize: 17.5.sp
              //             ),),
              //             Image.asset('assets/download.png', scale: 3,)
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: AppButton(
                          title: 'Cancel',
                          color: AppTheme.redFillColor2,
                          function: (){
                            Get.back();
                            print('good');
                            print(selectedValue);
                          }),
                      width: 40.w,
                    ),
                    SizedBox(
                      child: AppButton(
                          title: 'Go to Map',
                          color: AppTheme.primaryColor,
                          function: (){
                            var km = distance.as(LengthUnit.Kilometer,
                                new LatLng(widget.recentJobs.latitude, widget.recentJobs.longitude), storeLocation);
                            Get.to(() => RecentDeliveryLocationMapScreen(recentJobs: widget.recentJobs, userDistance: km));
                            print('good');
                          }),
                      width: 40.w,
                    ),
                  ],
                ),
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
            Image.asset("assets/images/thankyou.png", height: 130,),
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
                function: () {
                  Get.offAll(() => const DeliveryBottomNavBar());
                  print('object');
                })
          ],
        ),

      );
    },
  );


}


