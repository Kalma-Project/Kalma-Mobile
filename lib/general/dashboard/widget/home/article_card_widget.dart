import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  final String title;
  final String author;
  final String imageUrl;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.author,
    required this.imageUrl
  }): super(key: key);

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  int currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 195,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 11.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3D3D3D)
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.author,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3D3D3D)
              ),
            ),
          ),
        ],
      )
    );
  }
}