import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/main.dart';
import 'package:flutter_ta/self_screening/screen/self_screening_screen.dart';

class SelfScreeningResult extends StatelessWidget {
  final String depressionScore;
  final String anxietyScore;
  final String stressScore;
  final String depressionStatus;
  final String anxietyStatus;
  final String stressStatus;
  final String? message;

  const SelfScreeningResult({
    Key? key,
    required this.depressionScore,
    required this.anxietyScore,
    required this.stressScore,
    required this.depressionStatus,
    required this.anxietyStatus,
    required this.stressStatus,
    this.message
  }): super(key: key);

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

    return Scaffold(
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
          Positioned(
              top: 40,
              child: Text(
                'Skor Hasil Pemeriksaan',
                style: statusStyle,
              )
          ),
          Container(
            padding: const EdgeInsets.only(top: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      depressionScore,
                      style: scoreStyle,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      anxietyScore,
                      style: scoreStyle,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      stressScore,
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
                          depressionStatus,
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
                          anxietyStatus,
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
                          stressStatus,
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
                    child: Text(
                      message ?? 'Berikut adalah detail dari data yang anda pilih, silahkan lakukan tes ulang jika anda merasa berbeda dari hasil tes ini.',
                      style: const TextStyle(
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
                  onPressed: (){
                    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => const DashboardScreen()));
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
    );
  }
}

