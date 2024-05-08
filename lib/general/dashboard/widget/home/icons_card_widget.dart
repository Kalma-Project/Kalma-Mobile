import 'package:flutter/material.dart';
import 'dart:developer';

import '../../../../error_page/under_construction/under_construction_page.dart';

class IconCard extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Widget urlPage;

  const IconCard({
    Key? key,
    required this.iconData,
    required this.title,
    required this.urlPage
  }): super(key: key);

  @override
  State<IconCard> createState() => _IconCardState();
}

class _IconCardState extends State<IconCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        try {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.urlPage),
          );
        } catch (e) {
          log("Error navigating to page: $e");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UnderConstruction()),
          );
        }
      },
      child: SizedBox(
        height: 102.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 66.0,
                height: 66.0,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xFFF6F1F1),
                  child: Icon(
                    widget.iconData,
                    color: const Color(0xFF2F9296),
                  ),
                ),
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3D3D3D)
                ),
                textAlign: TextAlign.center,
                softWrap: true
              )
            ]
        ),
      ),
    );
  }
}
