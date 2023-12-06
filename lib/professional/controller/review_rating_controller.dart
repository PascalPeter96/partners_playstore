import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/review_and_rating_class.dart';


class ReviewRatingController extends GetxController{

  bool isLoading = false;
  late ReviewAndRatingClass reviewAndRatingClass;
  List<ReviewDetail> reviewList = [];

  loading(bool value){
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchReview();
  }

  fetchReview() async{
    reviewList.clear();
    loading(true);

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    print('user ud $userId');

    try {
      final response = await http.post(
          Uri.parse(
              '${SERVER_ADDRESS}api/professional/get_reviews_by_professional_id'),
          body: {'professionalId': userId});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          reviewAndRatingClass = ReviewAndRatingClass.fromJson(jsonResponse);
          reviewList.addAll(reviewAndRatingClass.reviewDetail??[]);
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