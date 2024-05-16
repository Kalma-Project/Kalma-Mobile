import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/journaling/data/data_dummy.dart';
import 'package:flutter_ta/self_management/journaling/widget/journal_history_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({super.key});

  @override
  State<JournalingScreen> createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  String dropDownValue = 'judul';
  List<DataCardJournaling> sortedContents = List.from(contents);
  bool isAscending = true;

  void dropDownCallback(String? selectedValue) {
    setState(() {
      dropDownValue = selectedValue!;
      _sortContents();
    });
  }

  void _sortContents() {
    if (dropDownValue == 'judul') {
      sortedContents.sort((a, b) => isAscending ? a.title.compareTo(b.title) : b.title.compareTo(a.title));
    } else if (dropDownValue == 'tanggal') {
      sortedContents.sort((a, b) => isAscending ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
    }
  }

  void _toggleSortOrder() {
    setState(() {
      isAscending = !isAscending;
      _sortContents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          color: const Color(0xffF6F1F1),
          child: Padding(
            padding: const EdgeInsets.only(right: 14, left: 14, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: Color(0xff3D3D3D),
                          ),
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
                SizedBox(
                  height: 27,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffAAA4A4)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropDownValue,
                            items: [
                              DropdownMenuItem<String>(
                                value: 'tanggal',
                                child: Text('Tanggal Dibuat',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'judul',
                                child: Text(
                                  'Judul',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: dropDownCallback,
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: _toggleSortOrder, icon: Icon(Icons.swap_vert)),
                  ],
                ),
                SizedBox(
                  height: 33,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 153),
                      itemCount: sortedContents.length,
                      itemBuilder: (_, index) {
                        return HistoryJournalWidget(
                          index: index,
                          data: sortedContents[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
