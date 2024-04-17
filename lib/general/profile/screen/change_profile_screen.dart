import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ta/general/profile/widget/pick_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

import '../widget/change_profile_widget.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  Uint8List? _image;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void updateProfile()async{
    if (fullNameController.text.isNotEmpty && phoneController.text.isNotEmpty && emailController.text.isNotEmpty){

      var updateProfile = {
        "fullName":fullNameController.text,
        "phone":phoneController.text,
        "email":emailController.text
      };

      log('updateProfile $updateProfile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back,
                              color: Color(0xff3D3D3D)),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Ubah Profile',
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
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _image != null
                              ? Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(_image!),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 68,
                                  height: 68,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage('images/profile_icon.png'),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                          onPressed: selectImage,
                          child: Text(
                            'Ubah foto profil',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: const Color(0xff3D3D3D),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                CustomTextField(
                    labelText: 'Nama Lengkap', placeHolder: 'Jokowi', controller: fullNameController,
                ),
                CustomTextField(
                    labelText: 'Nomor HP', placeHolder: '081233448879', controller: phoneController,
                ),
                CustomTextField(
                    labelText: 'Email', placeHolder: 'jokowi@gmail.com', controller: emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: true,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=>{
                        updateProfile()
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2F9296),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffF6F1F1),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
