import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/journaling/screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryJournalButton extends StatelessWidget {
  const HistoryJournalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const JournalingScreen())),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: 40,
        width: 137,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.green.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.list, color: Colors.green.shade600,),
            Text('Daftar Jurnal', style: GoogleFonts.plusJakartaSans(
              fontSize: 14, color: Colors.green.shade600,
            ),)
          ],
        ),
      ),
    );
  }
}
