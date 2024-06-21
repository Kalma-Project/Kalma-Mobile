import 'package:flutter/material.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/general/onboarding/data/data.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        contents[i].image,
                        height: 300,
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        contents[i].title,
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF3D3D3D),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        contents[i].description,
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF727272),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 80, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                        (index) => buildDot(index),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (currentIndex == contents.length - 1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen())
                          );
                        }
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0xFF2F9296),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
            ? const Color(0xFF2F9296)
            : const Color(0xFFC6D1D2),
      ),
    );
  }
}