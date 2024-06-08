import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/self_screening/service.dart';
import 'package:flutter_ta/model/self_screening/screening.dart';

class SelfScreeningDetailScreen extends StatefulWidget {
  final String id;

  const SelfScreeningDetailScreen({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  State<SelfScreeningDetailScreen> createState() => _SelfScreeningDetailScreenState();
}

class _SelfScreeningDetailScreenState extends State<SelfScreeningDetailScreen> {
  SelfScreeningService selfScreeningService = SelfScreeningService();
  SelfScreeningDetailData? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSelfScreeningDetail();
  }

  void getSelfScreeningDetail() async {
    SelfScreeningDetail? detailData = await selfScreeningService.getDetailSelfScreening(widget.id);
    if (detailData != null) {
      setState(() {
        data = detailData.data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle scoreStyle = const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFCFBFB)
    );

    TextStyle statusStyle = const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFCFBFB)
    );

    TextStyle categoryStyle = const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFCFBFB)
    );

    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'JakartaSans'
        ),
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else if (data == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'JakartaSans'
        ),
        home: Scaffold(
          body: Center(
            child: Text('Failed to load data. Please try again.'),
          ),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'JakartaSans'
        ),
        home: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset(
                  'images/bgsplash.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          data!.depression_result.score.toString(),
                          style: scoreStyle,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          data!.anxiety_result.score.toString(),
                          style: scoreStyle,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          data!.stress_result.score.toString(),
                          style: scoreStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data!.depression_result.status,
                              style: statusStyle,
                            ),
                            Text(
                              'Depresi',
                              style: categoryStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data!.anxiety_result.status,
                              style: statusStyle,
                            ),
                            Text(
                              'Kecemasan',
                              style: categoryStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data!.stress_result.status,
                              style: statusStyle,
                            ),
                            Text(
                              'Stress',
                              style: categoryStyle,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 270,
                      color: const Color(0xFFFCFBFB),
                    ),
                  )
              ),
              Positioned(
                  bottom: 100,
                  child: Card(
                    color: const Color(0xFFBFDDDE),
                    elevation: 0,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 24),
                        child: const Text(
                          'Berikut adalah detail dari data yang anda pilih, silahkan lakukan tes ulang jika anda merasa berbeda dari hasil tes ini.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3D3D3D)
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
              ),
              Positioned(
                  bottom: 20,
                  child: FilledButton.tonal(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF2F9296)
                        ),
                      ),
                      child: const Text(
                        'Kembali ke Dashboard',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFFF6F1F1)
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      );
    }
  }
}