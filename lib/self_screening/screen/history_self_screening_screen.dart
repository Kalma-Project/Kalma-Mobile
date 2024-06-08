import 'package:flutter/material.dart';
import 'package:flutter_ta/model/self_screening/screening.dart';
import 'package:flutter_ta/self_screening/screen/detail_self_screening_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/requests/self_screening/service.dart';

class HistorySelfScreening extends StatefulWidget {
  const HistorySelfScreening({super.key});

  @override
  State<HistorySelfScreening> createState() => _HistorySelfScreeningState();
}

class _HistorySelfScreeningState extends State<HistorySelfScreening> {
  final SelfScreeningService _selfScreeningService = SelfScreeningService();

  final PagingController<int, Map<String, dynamic>> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _selfScreeningService.getSelfScreeningData(pageKey, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Screening Data'),
      ),
      body: PagedListView<int, Map<String, dynamic>>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
          itemBuilder: (context, item, index) => GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelfScreeningDetailScreen(id: item['id']))
              );
            },
            child: ListTile(
              leading: const Icon(Icons.file_copy),
              title: Text(item['created_date']),
            ),
          ),
          firstPageProgressIndicatorBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          newPageProgressIndicatorBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Failed to load data. Please try again.'),
          ),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Failed to load more data. Please try again.'),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
            child: Text('No data found.'),
          ),
        ),
      ),
    );
  }
}
