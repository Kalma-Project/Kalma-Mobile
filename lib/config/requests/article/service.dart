import 'package:dio/dio.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/config/endpoints.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:developer';

class ArticleService {
  ApiService apiService = ApiService();

  Future<void> getArticle(int pageKey, PagingController<int, Map<String, dynamic>> pagingController) async {
    try {
      Response response = await apiService.dio.get(
          get_article,
          data: {
            "size": 6,
            "page": pageKey
          }
      );

      if (response.statusCode == 200) {
        var body = response.data;

        if (body['is_success']) {
          List<Map<String, dynamic>> selfScreeningData = List<Map<String, dynamic>>.from(body['data']);

          bool isLastPage = body['page'] >= body['total_pages'];

          if (isLastPage) {
            pagingController.appendLastPage(selfScreeningData);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(selfScreeningData, nextPageKey);
          }
        } else {
          log(body['message']);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

}