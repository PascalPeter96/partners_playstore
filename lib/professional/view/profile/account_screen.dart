
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/view/auth_screen/signning_screen.dart';
import 'package:wena_partners/professional/view/profile/profile_screen.dart';
import 'package:wena_partners/professional/view/profile/review_ratting_screen.dart';
import 'package:wena_partners/professional/view/profile/timeslote_screen.dart';
import 'add_next_of_kin_screen.dart';
import 'myproject_screen.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


  List name = [
    "Booking History",
    "Your Account",
    "Community",
    "Material Calculator",
    "Find a Local Store",
    "Support",
    "FAQ",
    "Settings",
    "Notification",
    "Privacy Policy",
    "Help Center",
    "Contact Us",
    // "Logout",
  ];
  List subName = [
    "Wallet",
    "Time Slots",
    "My Projects",
    "Next of Kin",
    "Review & Rating",
  ];

  List image = [
    "assets/images/account/Booking History.svg",
    "assets/images/account/account.svg",
    "assets/images/account/Community.svg",
    "assets/images/account/Material Calculator.svg",
    "assets/images/account/Find a Local store.svg",
    "assets/images/account/Support.svg",
    "assets/images/account/FAQ.svg",
    "assets/images/account/Setting.svg",
    "assets/images/account/Notification.svg",
    "assets/images/account/Privacy.svg",
    "assets/images/account/Help center.svg",
    "assets/images/account/Contact us.svg",
  ];
  List subImage = [
    "assets/images/account/Wallet.svg",
    "assets/images/account/Time slot.svg",
    "assets/images/account/My Project.svg",
    "assets/images/account/Next to kin.svg",
    "assets/images/account/review.svg",
  ];

int? selected;
int? selected1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("assets/images/man.png",height: 50,),
                title: const Text(
                  "Wilson Jonson",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  "demo@domain.com",
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.2,
                    color: Colors.black,
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
                    },
                child: SvgPicture.asset("assets/images/edit.svg",height: 30,)),
              ),

              // const Divider(indent: 20,endIndent: 20),

              // GestureDetector(
              //   onTap: (){
              //     Get.to(()=>MyFeedScreen());
              //   },
              //   child: Container(
              //     height: 50,
              //     color: Colors.red,
              //   ),
              // ),

              Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                       padding: const EdgeInsets.only(bottom: 20,top: 20),
                         shrinkWrap: true,
                       physics: const BouncingScrollPhysics(),
                     itemCount: name.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: [
                           const Divider(indent: 20,endIndent: 20,height: 0.5),
                           Theme(
                             data: ThemeData().copyWith(dividerColor: Colors.transparent,),
                             child: ExpansionTile(
                               key: Key(index.toString()),
                               initiallyExpanded: index==selected,
                               onExpansionChanged: ((newState){

                                 if(index==8){
                                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                                 }
                                 if(newState){
                                   setState(() {
                                     print("Select first");
                                     selected = index;
                                   });
                                 }
                                 else{
                                   setState(() {
                                     print("select second");
                                     selected = -1;
                                   });
                                 }
                               }),
                               trailing: selected == index?const Icon(Icons.keyboard_arrow_down,color: Colors.black):const Icon(Icons.navigate_next,color: Colors.black,),
                               title: Text(
                                 "${name[index]}",
                                 style:  TextStyle(
                                   fontSize: 15,
                                   letterSpacing: 0.2,
                                   color: name[index]=="Logout"?const Color(0xFFFF0000):const Color(0xFF4C5967),
                                   fontFamily: "SEGOEUI",
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                               leading: SvgPicture.asset(image[index],fit: BoxFit.cover, color: Colors.red,),
                               children:  <Widget> [
                                 index == 1? Column(
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.only(top: 8),
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(12),
                                         child: Container(
                                           color: const Color(0xFFE29547).withOpacity(0.25),
                                            height: 45,
                                           width: 220,
                                           child:  Center(
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 5,bottom: 8,left: 8,right: 8),
                                               child: Text(
                                                 "please fillup next kin of detail in order to activate your wallet",
                                                 style: TextStyle(
                                                   fontSize: 12,
                                                   color: const Color(0xFFE29547).withOpacity(0.70),
                                                   fontFamily: "SEGOEUI",
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(
                                       height: MediaQuery.of(context).size.height * 0.4,
                                       child: ListView.builder(
                                           physics: const BouncingScrollPhysics(),
                                           itemCount: subName.length,
                                           itemBuilder: (BuildContext context, int index) {
                                             print("INDEX-------$index");
                                             return Column(
                                               children: [
                                                 const Divider(indent: 20,endIndent: 20,height: 0.1),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 30),
                                                   child: Theme(
                                                     data: ThemeData().copyWith(dividerColor: Colors.transparent,),
                                                     child: ExpansionTile(
                                                       key: Key(index.toString()),
                                                       initiallyExpanded: index==selected1,
                                                       onExpansionChanged: ((newState){

                                                           if(index==1){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const TimeSlot()));
                                                           }
                                                           if(index==2){
                                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProject()));
                                                           }
                                                           if(index==3){
                                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNextOfKinScreen()));
                                                           }
                                                           if(index==4){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReviewRatingScreen()));
                                                           }

                                                         if(newState){
                                                           setState(() {
                                                             print("Select first");
                                                             selected1 = index;
                                                           });
                                                         }
                                                         else{
                                                           setState(() {
                                                             print("select second");
                                                             selected1 = -1;
                                                           });
                                                         }

                                                       }),
                                                       trailing: selected1 == index?const Icon(Icons.keyboard_arrow_down,color: Colors.black,):const Icon(Icons.navigate_next,color: Colors.black,),
                                                       title: Text(
                                                         "${subName[index]}",
                                                         style: const TextStyle(
                                                           fontSize: 15,
                                                           letterSpacing: 0.2,
                                                           color: Color(0xFF4C5967),
                                                           fontFamily: "SEGOEUI",
                                                           fontWeight: FontWeight.w600,
                                                         ),
                                                       ),
                                                       leading: Padding(
                                                         padding: const EdgeInsets.only(top: 5,left: 20),
                                                         child: SvgPicture.asset(subImage[index],fit: BoxFit.cover,),
                                                       ),
                                                       children:  const <Widget>[
                                                       ],
                                                     ),
                                                   ),
                                                 ),

                                               ],
                                             );
                                           }),
                                     )
                                   ],
                                 ) :Container(),
                               ],
                             ),
                           ),
                           index==11?const SizedBox(height: 15,):Container(),
                           index==11?GestureDetector(
                             onTap:() async{
                               SharedPreferences sp = await SharedPreferences.getInstance();
                               sp.remove('user_id');
                               Get.offAll(()=>const SignScreen());
                             },
                             child: Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 15),
                                   child: Image.asset('assets/icons/logout.png',height: 25,width: 20,),
                                 ),
                                 const Padding(
                                   padding: EdgeInsets.only(left: 38),
                                   child: Text(
                                     "Logout",
                                     style: TextStyle(
                                       fontSize: 17,
                                       letterSpacing: 0.2,
                                       color: Color(0xFFFF0000),
                                       fontFamily: "SEGOEUI",
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ):Container(),

                         ],
                       );
                     }),

                    const SizedBox(height: 15,),

                  ],
                ),
              ),
            ),

            ],
          ),
        ),
      ),
    );
  }
}
