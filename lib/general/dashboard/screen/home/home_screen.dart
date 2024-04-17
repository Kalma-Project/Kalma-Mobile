import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/home/card_home_widget.dart';
import 'package:flutter_ta/general/dashboard/screen/home/data/card_data_dummy.dart';
import 'package:flutter_ta/general/dashboard/widget/home/article_card_widget.dart';
import 'package:flutter_ta/general/dashboard/widget/home/icons_card_widget.dart';
import 'package:flutter_ta/model/general/general.dart';

import '../../../profile/screen/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF64CDC2),
                      Color(0xFF137378)
                    ]
                )
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Selamat Pagi',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFF6F1F1)
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                'Jok Owi',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF6F1F1)
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          IconButton(
                            icon : const Icon(Icons.account_circle,
                              color: Color(0xFFF6F1F1),
                              size: 36.0,),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile(),),);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 34.0,
                      ),
                      const CardHomeWidget(),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconCard(iconData: Icons.sticky_note_2_rounded, title: 'Self Screening'),
                          IconCard(iconData: Icons.note_alt_rounded, title: 'Journal'),
                          IconCard(iconData: Icons.air_sharp, title: 'Breath Work'),
                          IconCard(iconData: Icons.music_note_rounded, title: 'Melodies'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 14.0),
                    padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 22.0),
                    width: double.infinity,
                    height: double.infinity,
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
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color(0xFFE9E0E0)
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: (){},
                                child: const Text(
                                    'Lihat Semua',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Color(0xFF2F9296)
                                  ),
                                )
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.89,
                              height: MediaQuery.of(context).size.height * 0.26,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: articleData.length,
                                itemBuilder: (context, index) {
                                  ArticleData articleModel = articleData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // diisi nanti setelah ada API
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: MediaQuery.of(context).size.width / 2.01,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 1.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE9E0E0),
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                          ),
                                          ArticleCard(
                                              title: articleModel.title,
                                              author: articleModel.author,
                                              imageUrl: articleModel.imageUrl
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}