import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/journaling/widget/widget_journaling_card.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalingScreen extends StatefulWidget {
  JournalingScreen({super.key});


  @override
  State<JournalingScreen> createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  @override
  Widget build(BuildContext context) {
    String _dropdownValue = 'tanggal';
    void dropdownCallback(String? selectedValue){
      if (selectedValue is String){
        _dropdownValue = selectedValue;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF6F1F1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back,
                              color: Color(0xff3D3D3D)),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Daftar Journal',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          child: Text('Tanggal Dibuat'),
                          value: 'tanggal',
                        ),
                        DropdownMenuItem(
                          child: Text('Judul'),
                          value: 'judul',
                        ),
                      ],
                      value: _dropdownValue,
                      onChanged: dropdownCallback,
                    ),
                    IconButton(onPressed: () {}, icon : Icon(Icons.swap_vert)),
                  ],
                ),
                CardJournaling(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
