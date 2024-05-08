import 'package:flutter/material.dart';
import 'package:flutter_ta/widget/back_button.dart';
import 'dart:developer';

class InputJournal extends StatefulWidget {
  final String? emotion;

  const InputJournal({
    Key? key,
    this.emotion
  }): super(key: key);

  @override
  State<InputJournal> createState() => _InputJournalState();
}

class _InputJournalState extends State<InputJournal> {

  TextEditingController journalingController = TextEditingController();
  bool journalError = false;

  void submitJournal() async{
    if (journalingController.text.isNotEmpty) {

      var submitJournal = {
        "emotion":widget.emotion,
        "journal":journalingController.text
      };
      log('Journal $submitJournal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CustomBackButton(text: 'Journaling'),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text(
                    'Ceritakan apa saja pengalaman dan perasaan yang kamu rasakan!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3D3D3D)
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TextFormField(
                      controller: journalingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Tuangkan perasaanmu disini!',
                          errorText: journalError ? "Form harus diisi" : null
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  FilledButton.tonal(
                    onPressed: ()=>{
                      submitJournal()
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF2F9296)),
                    ),
                    child: const Text(
                      'Kumpulkan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
