import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ta/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../model/general/general.dart';
import '../../../self_management/music/provider/playlist_provider.dart';
import '../../api_service.dart';
import '../../endpoints.dart';

class SelfManagementService {
  ApiService apiService = ApiService();

  Future<void> postNewJournal(String title,
      String emotion,
      String content,) async {
    try {
      Response response = await apiService.dio.post(
        post_journaling,
        data: {
          'title': title,
          'emotion': emotion,
          'content': content,
        },
      );
      log('New Journal Post Status: ${response.data.toString()}');
    } catch (e) {
      log('Error Add New Journal: $e');
      if (e is DioException) {
        log('DioException Add New Journal: ${e.response?.data}');
      }
    }
  }

  Future<void> getJournalData(int pageKey, PagingController<int, Map<String, dynamic>> pagingController, String sortValue, String sortColumn) async {
    try {
      Response response = await apiService.dio.post(
        get_journaling_data,
        data: {
          "size": 6,
          "page": pageKey,
          "sort_value": sortValue,
          "sort_column": sortColumn,
        },
      );

      if (response.statusCode == 200) {
        var data = response.data;

        if (data['is_success']) {
          List<Map<String, dynamic>> journalingData = List<Map<String, dynamic>>.from(data['data']);

          bool isLastPage = data['page'] >= data['total_pages'];

          if (isLastPage) {
            pagingController.appendLastPage(journalingData);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(journalingData, nextPageKey);
          }
        } else {
          log('API response not successful: ${data['message']}');
          pagingController.error = data['message'];
        }
      } else {
        final data = response.data;
        log(data.toString());
        log('Error: ${response.statusCode}');
        pagingController.error = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      log('Error: $e');
      pagingController.error = 'Error: $e';
    }
  }

  Future<JournalData?> getDetailJournal(String id) async {
    try {
      Response response = await apiService.dio.get(
          'self-management/journals/users-journal/get/$id'
      );
      if (response.statusCode == 200) {
        final body = response.data;
        log('Data fetched successfully');
        return JournalData.fromJson(body);
      }
    } catch (e) {
      log('Error getting detail data: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getMusicData(
      int pageKey,
      PagingController<int, Map<String, dynamic>> pagingController,
      String? searchValue,
      String? searchColumn
      ) async {
    try {
      Response response = await apiService.dio.post(
        get_music_data,
        data: {
          "size": 10,
          "page": pageKey,
          "sort_value": searchValue,
          "sort_column": searchColumn,
        },
      );

      if (response.statusCode == 200) {
        var data = response.data;

        if (data['is_success']) {
          List<Map<String, dynamic>> musicData = List<Map<String, dynamic>>.from(data['data']);

          bool isLastPage = data['page'] >= data['total_pages'];

          if (isLastPage) {
            pagingController.appendLastPage(musicData);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(musicData, nextPageKey);
          }
          return musicData;
        } else {
          log(data['message']);
        }
      } else {
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return [];
  }

  Future<MusicData?> getDetailMusic(String id) async {
    try {
      Response response = await apiService.dio.get(
          'self-management/journals/users-journal/get/$id'
      );
      if (response.statusCode == 200) {
        final body = response.data;
        log('data fetched successfully');
        return MusicData.fromJson(body);
      }
    } catch (e) {
      log('Error getting detail data: $e');
    }
    return null;
  }

  Future<void> stopMusicWhenLogout(BuildContext context) async {
    await apiService.clearTokens();

    final playListProvider = Provider.of<PlayListProvider>(context, listen: false);
    playListProvider.stop();
  }
}