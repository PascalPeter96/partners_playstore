import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/feed_class.dart';


class FeedController extends GetxController{

  bool isLoading = false;
  late FeedClass feedClass;
  List<FeedDetailClass> feedList = [];

  loading(bool value){
    isLoading = value;
    update(['list']);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllFeed();
  }

  fetchAllFeed() async{
    feedList.clear();
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');
    try {
      final response = await http.post(Uri.parse('${SERVER_ADDRESS}api/professional/getAllFeedsByProfessionalId'),
          body: {'professionalId': userId});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          feedClass = FeedClass.fromJson(jsonResponse);
          feedList.addAll(feedClass.feedDetailClass??[]);
          loading(false);
        } else if(jsonResponse['code'] == 400){
          AppToast.showToast(jsonResponse['msg']);
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

  onLikeButtonClick({required String feedId,required int listIndex}){
    if(feedList[listIndex].isLiked == 'Y'){
      feedList[listIndex].isLiked = 'N';
      feedLikeApi(feedId);
    }else{
      feedList[listIndex].isLiked = 'Y';
      feedLikeApi(feedId);
    }
    update(['list']);
  }


  feedLikeApi(id) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');
    try {
      final response = await http.post(Uri.parse('${SERVER_ADDRESS}api/professional/like_feed_by_id'),
          body: {'professional_id': userId,'feed_id': id,});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          // AppToast.showToast(jsonResponse['msg']);
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
