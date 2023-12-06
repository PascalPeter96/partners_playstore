import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wena_partners/professional/controller/feed_controller.dart';


import 'comments.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({Key? key}) : super(key: key);

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/icons/icon_back.png",
                      height: 40,
                    ),
                  ),
                  const Spacer(flex: 2),
                  const Text(
                    "Home & Living",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "SEGOEUI",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GetBuilder<FeedController>(
                  init: FeedController(),
                  id: 'list',
                  builder: (controller) {
                    return controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF149C48),
                            ),
                          )
                        : controller.feedList.isEmpty
                            ? const Center(
                                child: Text(
                                  'Feed not found',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFF8391A1),
                                    fontFamily: "SEGOEUI",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.feedList.length,
                                itemBuilder: (context, index) {
                                  var data = controller.feedList[index];
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      elevation: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    data.userImgLink ?? '',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                  color: Color(0xFF149C48),
                                                )),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            title: Text(
                                              '${data.varFname} ${data.varLname}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${DateFormat('d MMMM yyyy').format(data.dtCreateddate!)} at ${data.dtCreateddate!.hour}:${data.dtCreateddate!.minute}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF8391A1),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            trailing: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Image.asset(
                                                  "assets/images/More.png"),
                                            ),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            child: Text(
                                              data.txtDescription ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF292D32),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                              visible: data.txtDescription
                                                      ?.isNotEmpty ??
                                                  false,
                                              child: const Divider()),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    data.feedImgLink ?? '',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                  color: Color(0xFF149C48),
                                                )),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 14),
                                                child: GestureDetector(
                                                  onTap:(){
                                                    controller.onLikeButtonClick(feedId: data.intGlcode??'0',listIndex: index);
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/myfeed/vector-18.svg",
                                                    height: 20,
                                                    color: data.isLiked == 'Y'
                                                        ? Colors.red
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 18),
                                                child: SvgPicture.asset(
                                                  "assets/images/myfeed/Vector-21.svg",
                                                  height: 20,
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, right: 14),
                                                child: Text(
                                                  // "4 minutes ago",
                                                  Jiffy(data.dtCreateddate,
                                                          "yyyy-MM-dd hh:mm")
                                                      .fromNow(),
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFFC4C4C4),
                                                      fontFamily: "SEGOEUI",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.2),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 15),
                                            child: Text(
                                              '48 Like',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => CommentsScreen(
                                                    feedId:
                                                        data.intGlcode ?? '0',
                                                  ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12,
                                                  left: 15,
                                                  bottom: 12),
                                              child: Text(
                                                'View all ${data.commentCount} comments',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF149C48),
                                                  fontFamily: "SEGOEUI",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
