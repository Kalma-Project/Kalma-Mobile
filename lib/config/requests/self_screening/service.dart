import 'package:dio/dio.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/config/endpoints.dart';
import 'package:flutter_ta/model/self_screening/screening.dart';
import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SelfScreeningService {
  ApiService apiService = ApiService();
  String depressionStatus = '';
  String stressStatus = '';
  String anxietyStatus = '';
  String depressionScore = '';
  String anxietyScore = '';
  String stressScore = '';
  String postMessage = '';

  Future<void> postSelfScreening(int depressionScore, int anxietyScore, int stressScore) async {
    try {
      Response response = await apiService.dio.post(
        post_self_screening,
        data: {
          "depression_score": depressionScore,
          "anxiety_score": anxietyScore,
          "stress_score": stressScore
        }
      );
      if (response.statusCode == 200) {
        final body = response.data;
        depressionStatus = body['data']['depression_result']['status'];
        stressStatus = body['data']['stress_result']['status'];
        anxietyStatus = body['data']['anxiety_result']['status'];
        postMessage = body['message'];
        log(response.data.toString());
      }
    } catch (e) {
      log('Self Screening failed: server error $e');
    }
  }

  Future<void> getSelfScreeningData(int pageKey, PagingController<int, Map<String, dynamic>> pagingController) async {
    try {
      Response response = await apiService.dio.post(
        get_self_screening,
        data: {
          "size": 6,
          "page": pageKey,
        },
      );

      if (response.statusCode == 200) {
        var data = response.data;

        if (data['is_success']) {
          List<Map<String, dynamic>> selfScreeningData = List<Map<String, dynamic>>.from(data['data']);

          bool isLastPage = data['page'] >= data['total_pages'];

          if (isLastPage) {
            pagingController.appendLastPage(selfScreeningData);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(selfScreeningData, nextPageKey);
          }
        } else {
          log(data['message']);
        }
      } else {
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<SelfScreeningDetail?> getDetailSelfScreening(String id) async {
    try {
      Response response = await apiService.dio.get(
        'self-screening/history/$id'
      );
      if (response.statusCode == 200) {
        final body = response.data;
        log('data fetched successfully');
        return SelfScreeningDetail.fromJson(body);
      }
    } catch (e) {
      log('Error getting detail data: $e');
    }
    return null;
  }
}