import 'package:flutter/material.dart';
import 'package:flutter_ta/general/article/screen/articledetail_screen.dart';
import 'package:flutter_ta/general/dashboard/screen/home/data/card_data_dummy.dart';
import 'package:flutter_ta/widget/back_button.dart';

import '../../../model/general/general.dart';
import '../../dashboard/widget/home/article_card_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomBackButton(text: 'Artikel Terkini'),
              const SizedBox(
                height: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.863,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: articleData.length,
                      itemBuilder: (context, index) {
                        ArticleData articleModel = articleData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ArticleDetail(
                                  title: articleModel.title,
                                  imageUrl: articleModel.imageUrl,
                                  author: articleModel.author,
                                  description: articleModel.description,
                                ))
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.0,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE9E0E0),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: ArticleCard(
                                      title: articleModel.title,
                                      author: articleModel.author,
                                      imageUrl: articleModel.imageUrl
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
