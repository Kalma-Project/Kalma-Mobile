import 'package:flutter/material.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/self_management/journaling/screen/detail_journaling_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryJournalWidget extends StatelessWidget {
  const HistoryJournalWidget({super.key, required this.data});

  final JournalData data;

  @override
  Widget build(BuildContext context) {
    DateTime originalDate = DateFormat("MMMM d'th' y, HH:mm:ss").parse(data.createdDate);
    String createdDate = DateFormat('dd MMM yyyy').format(originalDate);

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JournalingDetail(
                  title: data.title,
                  emotion: data.emotion,
                  description: data.content,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF0E7E7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xff2F9296),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.content.length > 200
                      ? '${data.content.substring(0, 200)}...'
                      : data.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(data.title, style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700, fontSize: 12),),
            const SizedBox(
              height: 5,
            ),
            Text(createdDate, style: GoogleFonts.plusJakartaSans(
                color: const Color(0xff7D7D7D),
                fontSize: 12,
                fontWeight: FontWeight.w500),),
          ],
        ),
      );
  }
}
