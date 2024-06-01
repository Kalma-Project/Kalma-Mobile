import 'package:flutter/material.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/general/profile/screen/change_profile_screen.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/self_screening/screen/history_self_screening_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final UserPropertyData data;

  const Profile({
    Key? key,
    required this.data
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back, color: Color(0xff3D3D3D)),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Halaman Profile',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xff3D3D3D),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xffEAF4F5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('images/profile_icon.png'),
                        width: 36,
                        height: 36,
                      ),
                      SizedBox(
                        width: 204,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.username,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF3D3D3D),
                              ),
                            ),
                            Text(
                                data.email,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: const Color(0xff3D3D3D),
                                )),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeProfile(),
                            ),
                          );
                        },
                        child: Text('Ubah',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: const Color(0xFF2F9296),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Akun',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff3D3D3D),
                ),
              ),
              const SizedBox(height: 16,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistorySelfScreening())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset('images/fluent_person-note-24-filled.png',width: 28, height: 28,),
                        const SizedBox(width: 10,),
                        Text('Riwayat Self Screening', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500),)
                      ],
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              const Divider(
                color: Color(0xffE0DBDB),
                thickness: 1,
              ),
              const SizedBox(height: 12,),
              GestureDetector(
                onTap: () async {
                  await apiService.clearTokens();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.logout, size: 28, color: Colors.red.shade300,),
                        const SizedBox(width: 10,),
                        Text('Logout', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red.shade300),)
                      ],
                    ),
                    // Icon(Icons.chevron_right, color: Colors.red.shade300,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
