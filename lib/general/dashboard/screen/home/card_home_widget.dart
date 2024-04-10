import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/home/data/card_data_dummy.dart';

class CardHomeWidget extends StatefulWidget {
  const CardHomeWidget({super.key});

  @override
  State<CardHomeWidget> createState() => _CardHomeWidgetState();
}

class _CardHomeWidgetState extends State<CardHomeWidget> {
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
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: 100,
          child: Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index){
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_,i) {
                return Card(
                    elevation: 0,
                    color: const Color(0xFF4DA9AC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: const ListTile(
                      title: Text(
                        '"It is better to conquer yourself than to win a thousand battles"',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFF6F1F1)
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: Icon(Icons.format_quote),
                      iconColor: Color(0xFFF6F1F1),
                      contentPadding: EdgeInsets.all(16.0),
                    )
                );
              },
            ),
          ),

        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                    (index) => buildDot(index),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 8,
      width: currentIndex == index ? 30 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? const Color(0xFFF6F1F1)
            : const Color(0xFFC6D1D2),
      ),
    );
  }
}
