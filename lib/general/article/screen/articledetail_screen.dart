import 'package:flutter/material.dart';
import 'package:flutter_ta/widget/back_button.dart';

class ArticleDetail extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String author;
  final List<String>? paragraph;

  const ArticleDetail({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.author,
    this.paragraph
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomBackButton(text: 'Artikel',  onPressed: () => Navigator.pop(context),),
                  const SizedBox(
                    height: 24,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3D3D3D)
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7D7D7D)
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ...?paragraph?.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      p,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7D7D7D),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
