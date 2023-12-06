// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wena_partners/professional/controller/comment_controller.dart';



class CommentsScreen extends StatefulWidget {
  final String feedId;

  const CommentsScreen({Key? key, required this.feedId}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController comments = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                      "Comments",
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
                  height: 15,
                ),
                GetBuilder<CommentController>(
                    init: CommentController(widget.feedId),
                    builder: (controller) {
                      return controller.isLoading
                          ? Container(
                              height: h * 0.75,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Color(0xFF149C48),
                              )),
                            )
                          : Container(
                              height: h * 0.75,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: controller.commentList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = controller.commentList[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.only(),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              height: 45,
                                              width: 45,
                                              fit: BoxFit.cover,
                                              imageUrl: data.userImgLink ?? '',
                                              placeholder: (context, url) =>
                                                  Center(child: const CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          // Image.asset(
                                          //   "assets/images/homepage/man.png",
                                          //   height: 45,
                                          // ),
                                          title: Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Johanson_willson ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontFamily: "SEGOEUI",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: data.txtDescription,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: "SEGOEUI",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Text(
                                              // "10 August 2022 at 11:27",
                                              '${DateFormat('d MMMM yyyy').format(data.dtCreateddate!)} at ${data.dtCreateddate!.hour}:${data.dtCreateddate!.minute}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF8391A1),
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            );
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFE8ECF4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 0.2)),
                  child: TextFormField(
                    controller: comments,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:
                          Icon(Icons.send, color: Color(0xFF149C48), size: 20),
                      hintText: 'Comments',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      hintStyle: TextStyle(
                        color: Color(0xFF8391A1),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SEGOEUI',
                        fontSize: 13,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
