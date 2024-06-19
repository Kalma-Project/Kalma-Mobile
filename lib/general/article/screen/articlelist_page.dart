import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/article/service.dart';
import 'package:flutter_ta/general/article/screen/articledetail_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../widget/back_button.dart';
import '../../dashboard/widget/home/article_card_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  ArticleService articleService = ArticleService();

  final PagingController<int, Map<String, dynamic>> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      articleService.getArticle(pageKey, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JakartaSans'),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomBackButton(
                text: 'Artikel Terkini',
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: PagedListView<int, Map<String, dynamic>>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetail(
                              title: item['title'],
                              imageUrl: item['image'],
                              author: item['created_by'],
                              paragraph: List<String>.from(item['content']),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9E0E0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: ArticleCard(
                                title: item['title'],
                                imageUrl: item['image'],
                                author: item['created_by'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
