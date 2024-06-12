import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/general/update_user.dart';
import 'package:flutter_ta/general/profile/widget/pick_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import '../../../model/general/general.dart';
import '../../../widget/primary_custom_button.dart';
import '../../../widget/success_alert.dart';
import '../widget/change_profile_widget.dart';

class ChangeProfile extends StatefulWidget {
  final UserPropertyData data;
  const ChangeProfile({super.key, required this.data});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  UpdateUser updateUser = UpdateUser();
  Uint8List? _image;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool userPrivacy = false;
  bool isLoading = false;

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    userPrivacy = widget.data.allowJournal;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void updateProfile() async {
    setState(() {
      isLoading = true;
    });

    if (fullNameController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      FocusScope.of(context).requestFocus(fullNameFocusNode);
      return;
    } else if (userNameController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      FocusScope.of(context).requestFocus(userNameFocusNode);
      return;
    } else if (ageController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      FocusScope.of(context).requestFocus(ageFocusNode);
      return;
    } else if (emailController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      FocusScope.of(context).requestFocus(emailFocusNode);
      return;
    }

    try {
      await updateUser.updateProfile(
        fullName: fullNameController.text,
        age: ageController.text,
        email: emailController.text,
        username: userNameController.text,
        userPrivacy: userPrivacy,
        avatar: _image,
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SuccessAlert(
              title: 'Yay!, Profile Sudah Terupdate', message: '');
        },
      );
      log('Profile Updated $updateProfile');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Error Updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
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
                          const Icon(Icons.arrow_back, color: Color(0xff3D3D3D)),
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
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          if (_image != null)
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(_image!),
                                ),
                              ),
                            )
                          else if (widget.data.avatarLink != null)
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.data.avatarLink!),
                                ),
                              ),
                            )
                          else
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/profile_icon.png'),
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
                  height: 15,
                ),
                CustomTextField(
                  labelText: 'Nama Lengkap',
                  placeHolder: widget.data.fullName,
                  controller: fullNameController,
                  focusNode: fullNameFocusNode,
                ),
                CustomTextField(
                  labelText: 'UserName',
                  placeHolder: widget.data.username,
                  controller: userNameController,
                  focusNode: userNameFocusNode,
                ),
                CustomTextField(
                  labelText: 'Umur',
                  placeHolder: widget.data.age.toString(),
                  controller: ageController,
                  focusNode: ageFocusNode,
                ),
                CustomTextField(
                  labelText: 'Email',
                  placeHolder: widget.data.email,
                  controller: emailController,
                  focusNode: emailFocusNode,
                ),
                SwitchListTile(
                    title: Text('Privasi Jurnal'),
                    secondary: Icon(Icons.privacy_tip),
                    subtitle: Text(
                      '*Dengan mengaktifkan tombol ini, pengguna bersedia data jurnal diakses oleh psikolog',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: userPrivacy,
                    activeColor: const Color(0xff2F9296),
                    onChanged: (bool value) {
                      setState(() {
                        userPrivacy = value;
                      });
                    }),
                const SizedBox(
                  height: 24,
                ),
                CustomPrimaryButton(
                  function: updateProfile,
                  isLoading: isLoading,
                  buttonTitle: 'Simpan',
                  horizontalPadding: 54.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}