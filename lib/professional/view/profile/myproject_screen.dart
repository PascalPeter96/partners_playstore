// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:wena_partners/professional/controller/my_project_controller.dart';
import 'package:wena_partners/professional/view/add_project_screen.dart';
import 'edite_project.dart';

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MyProjectController>(
            id: 'getProject',
            init: MyProjectController(),
            builder: (controller) {
              return controller.isHomeLoad == true?
              Center(child: CircularProgressIndicator(),):
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/icon_back.png",
                            height: 40,
                          ),
                        ),
                        // const Spacer(flex: 2),
                        const Text(
                          "My Projects",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "SEGOEUI",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(AddProjectScreen());
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProjectScreen()));
                          },
                            child: Icon(Icons.add_circle,color: Color(0xFF149C48),size: 35,))
                        // const Spacer(flex: 3,),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Expanded(
                      child: SizedBox(
                        child: controller.getMyProjectModel?.data==null?Container(child: Center(child: Text("Data Not Found")),):ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.getMyProjectModel?.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("IMAGE------>>>>>>>>>>>>----------${controller.getMyProjectModel?.data![index].varImageLink.toString()}");
                              // List image = [];
                              //
                              // for(int i = 0; i < (controller.getMyProjectModel?.data![index].varImages!.length as int);i++){
                              //   image.add(controller.getMyProjectModel?.data![index].varImages![i].varImagesLink);
                              // }
                              // print("Image----$image");


                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:  Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title:  Text(
                                              // "Project Title Here",
                                              "${controller.getMyProjectModel?.data![index].varTitle}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: const Text(
                                              "10 August 2022 at 11:27",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF8391A1),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            trailing: GestureDetector(
                                              onTap: (){
                                                controller.getMyProjectModel!.data![index].intGlcode.toString();

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProject(controller.getMyProjectModel!.data![index].intGlcode.toString())));

                                                print("INDEX_EDIT-------------${controller.getMyProjectModel!.data![index].intGlcode.toString()}");
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 18),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Container(
                                                    height: 22,width: 50,color: const Color(0xFF149C48),child: Center(
                                                      child: const Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontFamily: "SEGOEUI",
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  )),),
                                                ),
                                              ),
                                            ),
                                          ),


                                          // controller.getMyProjectModel?.data![index].varImageLink == null?
                                          // Center(child: SizedBox( height: 120,child: Icon(Icons.error),),):

                                          Center(
                                            child: CachedNetworkImage(
                                              imageUrl: "${controller.getMyProjectModel?.data![index].varImageLink.toString()}",
                                              imageBuilder: (context,
                                                  imageProvider) => Container(
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                  ),
                                                ),
                                              ),
                                              // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                              placeholder: (context, url) => Center(child: CupertinoActivityIndicator(),),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                          // Center(child: CircularProgressIndicator()):

                                          ///--------------carouselSlider-----------------
                                          // CarouselSlider.builder(
                                          //   carouselController: _controller,
                                          //   itemCount: controller.getMyProjectModel?.data?.length,
                                          //   itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                          //       // Image.network("${controller.getMyProjectModel?.data![index].varImages![itemIndex].varImagesLink}"),
                                          //   CachedNetworkImage(
                                          //     imageUrl: "${controller.getMyProjectModel?.data![index].varImageLink.toString()}",
                                          //     imageBuilder: (context,
                                          //         imageProvider) => Container(
                                          //       height: 120,
                                          //       decoration: BoxDecoration(
                                          //         image: DecorationImage(
                                          //           image: imageProvider,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                          //     placeholder: (context, url) => Center(child: CupertinoActivityIndicator(),),
                                          //     errorWidget: (context, url, error) => Icon(Icons.error),
                                          //   ),
                                          //     options: CarouselOptions(
                                          //       aspectRatio: 16/9,
                                          //       viewportFraction: 1,
                                          //       initialPage: 0,
                                          //       enableInfiniteScroll: true,
                                          //       reverse: false,
                                          //       autoPlay: false,
                                          //       autoPlayInterval: Duration(seconds: 3),
                                          //       autoPlayAnimationDuration: Duration(milliseconds: 800),
                                          //       autoPlayCurve: Curves.fastOutSlowIn,
                                          //       enlargeCenterPage: true,
                                          //       scrollDirection: Axis.horizontal,
                                          //         onPageChanged: (index, reason) {
                                          //           setState(() {
                                          //             current = index;
                                          //           });
                                          //         }),
                                          //     ),

                                          // SizedBox(height: 8,),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: image.asMap().entries.map((entry) {
                                          //     return GestureDetector(
                                          //       onTap: () => _controller.animateToPage(entry.key),
                                          //       child: Container(
                                          //         width: 10.0,
                                          //         height: 10.0,
                                          //         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                          //         decoration: BoxDecoration(
                                          //             shape: BoxShape.circle,
                                          //           color: current == entry.key?Color(0xFFD9D9D9):Color(0XFF149C48)
                                          //         ),
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          // ),



                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                            child: ReadMoreText(
                                              style: TextStyle(
                                                height: 1.5,
                                                fontSize: 14,
                                                color: Color(0xFF8391A1),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w500,
                                              ),
                                              '${controller.getMyProjectModel?.data![index].txtDescription}',
                                              trimLines: 3,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              moreStyle: TextStyle(fontSize: 14,
                                                letterSpacing: 0.2,
                                                height: 1.5,
                                                color: Color(0xFF149C48),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.bold,),
                                            ),

                                          )

                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
