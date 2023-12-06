// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/controller/home_controller.dart';


class AllCommunityScreen extends StatefulWidget {
  const AllCommunityScreen({Key? key}) : super(key: key);

  @override
  State<AllCommunityScreen> createState() => _AllCommunityScreenState();
}

class _AllCommunityScreenState extends State<AllCommunityScreen> {

  List <int> tapped = [];

  bool tappedError = false;

  String? userId;

  id() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userId = sp.getString("user_id");
    });
    print("USER_ID----------${userId.toString()}");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Join Community",
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
                      const SizedBox(height: 15,),
                      tappedError == true ?const Text(
                        "Please select join community",
                        textAlign: TextAlign.start,
                        style:  TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontFamily: "SEGOEUI",
                          fontWeight: FontWeight.w600,
                        ),
                      ):Container(),
                      const SizedBox(height: 15,),
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
                                  itemCount: controller.joinCommuiry!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("JOINCOMMUITYINDEX------------$index");
                                        if(tapped.contains(index)){
                                          setState(() {tapped.remove(index);});
                                        }
                                        else {
                                          setState(() {tapped.add(index);});

                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: const Color(0xffE8EFF3),width: 2),
                                                borderRadius: BorderRadius.circular(15)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.network(controller.joinCommuiry![index].varIcon.toString(),height: 40,),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 10,right: 5,left: 5),
                                                  child: Center(
                                                    child: Text(
                                                      controller.joinCommuiry![index].varTitle.toString(),
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
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2,left: 2),
                                            child: Icon(Icons.check_circle,
                                              color: tapped.contains(index) ? const Color(0xFF149C48) : Colors.grey.withOpacity(0.60),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                            if(tapped.isNotEmpty){
                              tappedError = false;
                             controller.joinCommunitySelect(
                              // communityId: [tapped.length],
                              communityId: tapped,
                              professionalId: userId,
                              context: context,
                            );
                          }
                          else{
                            print("Please selected");
                            setState(() {
                              tappedError = true;
                            });
                          }
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyFeedScreen()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            color: const Color(0xFF149C48),
                            child: const Center(
                              child: Text(
                                "Join",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'SEGOEUI',
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
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
