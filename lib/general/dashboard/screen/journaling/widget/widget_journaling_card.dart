import 'package:flutter/material.dart';

class CardJournaling extends StatelessWidget {
  const CardJournaling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 153,
          child: Card(
            elevation: 0,
            color: Color(0xfF6F1F1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfF0E7E7),
                      border: Border.all(color: Color(0xf2F9296), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Your Text Here',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Text size
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
