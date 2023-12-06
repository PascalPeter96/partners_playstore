import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:wena_partners/professional/controller/home_controller.dart';


class JoinCommunity extends StatefulWidget {
  const JoinCommunity({Key? key}) : super(key: key);

  @override
  State<JoinCommunity> createState() => _JoinCommunityState();
}

class _JoinCommunityState extends State<JoinCommunity> {

  List text = [
    "Home & Living",
    "Electronics & Appliances",
    "Cleaning & Storage",
    "Garden & Outdoor",
    "Painting & Interior Design",
    "Plumbing & Electricals",
    "Roofing & Finishes",
    "Safety & Security",
    "Tiling & Flooring",
    "Building & Hardware",
    "Tools & Equipment",
    "Uncategorized",
  ];

  List image = [
    "assets/images/allcommunity/1.png",
    "assets/images/allcommunity/2.png",
    "assets/images/allcommunity/3.png",
    "assets/images/allcommunity/4.png",
    "assets/images/allcommunity/5.png",
    "assets/images/allcommunity/6.png",
    "assets/images/allcommunity/7.png",
    "assets/images/allcommunity/8.png",
    "assets/images/allcommunity/9.png",
    "assets/images/allcommunity/10.png",
    "assets/images/allcommunity/11.png",
    "assets/images/allcommunity/12.png",
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
            id: 'home',
            init: HomeController(),
            builder: (controller) {
              return controller.isHomeLoad == true?const Center(child: CircularProgressIndicator(),):
              Padding(
                padding: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
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
                          const Spacer(flex: 2),
                          const Text(
                            "Community",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "SEGOEUI",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(flex: 3,),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100,
                                    childAspectRatio: 1.8 / 2.2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 20,
                                  ),
                                  itemCount: controller.homePageCommuity.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffE8EFF3),width: 2),
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.network(controller.homePageCommuity[index].varIcon.toString(),height: 40,),
                                              Container(
                                                margin: const EdgeInsets.only(top: 10,right: 5,left: 5),
                                                child: Center(
                                                  child: Text(
                                                    controller.homePageCommuity[index].varTitle.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xFF292D32),
                                                      fontFamily: "SEGOEUI",
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),)
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(top: 2,left: 2),
                                        //   child: Icon(Icons.check_circle,
                                        //     color: tapped.contains(index) ? const Color(0xFF149C48) : Colors.grey.withOpacity(0.60),
                                        //   ),
                                        //
                                        // )
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      // Container(height: h * 0.8,)
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
