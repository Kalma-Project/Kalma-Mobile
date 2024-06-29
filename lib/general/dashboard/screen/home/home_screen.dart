import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/article/service.dart';
import 'package:flutter_ta/general/dashboard/screen/home/card_home_widget.dart';
import 'package:flutter_ta/general/dashboard/widget/home/article_card_widget.dart';
import 'package:flutter_ta/general/dashboard/widget/home/icons_card_widget.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/general/article/screen/articlelist_page.dart';
import 'package:flutter_ta/self_screening/screen/self_screening_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../article/screen/articledetail_screen.dart';
import '../../../profile/screen/profile_screen.dart';
import '../../widget/home/icon_card_2_widget.dart';

class HomeScreen extends StatefulWidget {
  final String user;
  final UserProperty userProperty;
  final Function(int index) onItemTapped;
  const HomeScreen({super.key, required this.user, required this.userProperty, required this.onItemTapped});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticleService articleService = ArticleService();

  final PagingController<int, Map<String, dynamic>> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      articleService.getArticle(pageKey, _pagingController).catchError((error) {
        log('Error fetching articles: $error');
      });
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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF64CDC2), Color(0xFF137378)]
              )
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 40,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Bagaimana Kabarmu,',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFF6F1F1)
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.userProperty.data.username,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF6F1F1)
                      ),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: GestureDetector(
                  child: widget.userProperty.data.avatarLink != null
                      ? CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.userProperty.data.avatarLink!),
                  )
                      : IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            data: widget.userProperty.data,
                          ),
                        ),
                      );
                      },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(
                          data: widget.userProperty.data,
                        ),
                      ),
                    );
                    },
                ),
              ),
              const Positioned(
                  top: 128,
                  left: 16,
                  right: 16,
                  child: CardHomeWidget()
              ),
              Positioned(
                  top: 130,
                  bottom: 150,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const IconCard(
                        iconData: Icons.sticky_note_2_rounded,
                        title: 'Pemeriksaan',
                        urlPage: SelfScreening(),
                      ),
                      IconCard2(
                        iconData: Icons.note_alt_rounded,
                        title: 'Jurnal',
                        onPressed: () => widget.onItemTapped.call(1),
                      ),
                      IconCard2(
                        iconData: Icons.air_sharp,
                        title: 'Pernapasan',
                        onPressed: () => widget.onItemTapped.call(2),
                      ),
                      IconCard2(
                        iconData: Icons.music_note_rounded,
                        title: 'Musik',
                        onPressed: () => widget.onItemTapped.call(3),
                      ),
                    ],
                  ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(top: 14.0),
                    padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 22.0),
                    height: 285,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF6F1F1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Bacaan Hari Ini!',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3D3D3D)
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all<double>(0),
                                backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFE9E0E0)),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ArticleListPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Color(0xFF2F9296)
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.89,
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: PagedListView<int, Map<String, dynamic>>(
                                pagingController: _pagingController,
                                scrollDirection: Axis.horizontal,
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
                                        margin: const EdgeInsets.only(right: 10),
                                        width: MediaQuery.of(context).size.width / 2.01,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width / 1.0,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFFE9E0E0),
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                            ),
                                            ArticleCard(
                                              title: item['title'],
                                              imageUrl: item['image'],
                                              author: item['created_by'],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}
