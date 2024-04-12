import 'package:flutter/material.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
              child: Column(
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
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
                      Icon(
                        Icons.account_circle,
                        color: Color(0xFFF6F1F1),
                        size: 36.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 34.0,
                  ),
                  Card(
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
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 69.0,
                        height: 102.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: const Icon(
                                  Icons.sticky_note_2_rounded,
                                  color: Color(0xFF2F9296),
                                ),
                              ),
                            ),
                            const Text(
                              'Self Screening',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        width: 66.0,
                        height: 102.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: const Icon(
                                  Icons.note_alt_rounded,
                                  color: Color(0xFF2F9296),
                                ),
                              ),
                            ),
                            const Text(
                              'Journaling',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        width: 80.0,
                        height: 102.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: const Icon(
                                  Icons.air_sharp,
                                  color: Color(0xFF2F9296),
                                ),
                              ),
                            ),
                            const Text(
                              'Breath work',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        width: 66.0,
                        height: 102.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: const Icon(
                                  Icons.music_note_rounded,
                                  color: Color(0xFF2F9296),
                                ),
                              ),
                            ),
                            const Text(
                              'Therapy Music',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
