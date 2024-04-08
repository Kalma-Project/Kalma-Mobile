import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';

const Color bDarkBlueColor = Color(0xFFF6F1F1);
const Color fBlackColor = Color(0xFF3D3D3D);
const Color fGreyColor = Color(0xFF727272);
const Color bGreenColor = Color(0xFF2F9296);
const Color backgroundColor = Color(0xFFF6F1F1);

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: bGreenColor,
      ),
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: bGreenColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: bGreenColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      controllerColor: bGreenColor,
      totalPage: 4,
      headerBackgroundColor: backgroundColor,
      pageBackgroundColor: backgroundColor,
      background: [
        Image.asset(
          'images/onboarding_1.png',
          height: 400,
        ),
        Image.asset(
          'images/onboarding_2.png',
          height: 400,
        ),
        Image.asset(
          'images/onboarding_3.png',
          height: 400,
        ),
        Image.asset(
          'images/onboarding_4.png',
          height: 400,
        ),
      ],
      speed: 1.0,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 450,
              ),
              Text(
                'Identifikasi emosimu',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fBlackColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Kenali emosimu dan dapatkan wawasan berharga dalam perjalanan kesehatan mentalmu',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fGreyColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 450,
              ),
              Text(
                'Bebas ekspresikan dirimu',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fBlackColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Abadikan pengalaman harianmu, tetapkan tujuan, dan kembangkan self-awareness kamu lewat jurnal',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fGreyColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 450,
              ),
              Text(
                'Temukan kedamaian',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fBlackColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Jelajahi latihan pernapasan yang disesuaikan untuk mengurangi stres dan meningkatkan relaksasi',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fGreyColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 450,
              ),
              Text(
                'Rasakan ketenangan melodi',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fBlackColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Tingkatkan latihan meditasi, kurangi kecemasan, dan rasakan relaksasi mendalam melalui keajaiban musik',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: fGreyColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}