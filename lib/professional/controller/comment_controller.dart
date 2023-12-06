import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/comment_class.dart';


class CommentController extends GetxController{

  bool isLoading = false;
  late CommentClass commentClass;
  List<CommentDetail> commentList = [];
  final String feedId;
  CommentController(this.feedId);

  loading(bool value){
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllComment();
  }

  fetchAllComment() async{
    commentList.clear();
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    print('user ud $userId');
    try {
      final response = await http.post(Uri.parse('${SERVER_ADDRESS}api/professional/getAllCommentsByFeedId'),
          body: {'fk_professional': userId,'feed_id':feedId});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          commentClass = CommentClass.fromJson(jsonResponse);
          commentList.addAll(commentClass.commentDetail??[]);
          loading(false);
        } else if(jsonResponse['code'] == 400){
          // AppToast.showToast(jsonResponse['msg']);
          loading(false);
        }else {
          AppToast.showToast('Something went to wrong');
          loading(false);
        }
      }
    } catch (e) {
      AppToast.showToast('Something went to wrong');
      loading(false);
    }
  }

}