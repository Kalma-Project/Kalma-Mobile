import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    Widget emailSvg = SvgPicture.asset(
      'images/email_verification_icon.svg',
      semanticsLabel: 'email icon',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF2F9296),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'images/ellipse_bg_mobile_top.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'images/ellipse_bg_mobile_bottom.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    emailSvg,
                  ],
                ),
                const SizedBox(
                  height: 21.0,
                ),
                const Text(
                  'Verifikasi Emailmu!',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFFFFFF)
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      'Silahkan periksa email dan klik link verifikasi email untuk memverifikasi emailmu',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: FilledButton.tonal(
                      onPressed: () async {
                        await apiService.clearTokens();
                        Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => const LoginScreen())
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFFFFFF)),
                      ),
                      child: const Text(
                        'Kembali ke Halaman Login',
                        style: TextStyle(
                          color: Color(0xFF2F9296),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
