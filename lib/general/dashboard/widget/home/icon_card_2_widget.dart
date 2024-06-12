import 'package:flutter/material.dart';
import 'dart:developer';

import '../../../../error_page/under_construction/under_construction_page.dart';

class IconCard2 extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onPressed;

  const IconCard2({
    Key? key,
    required this.iconData,
    required this.title,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
                    iconData,
                    color: const Color(0xFF2F9296),
                  ),
                ),
              ),
              Text(
                  title,
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
