import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/self_management/service.dart';
import 'package:flutter_ta/widget/back_button.dart';
import 'dart:developer';

import 'package:flutter_ta/widget/primary_custom_button.dart';
import 'package:flutter_ta/widget/success_alert.dart';

class InputJournal extends StatefulWidget {
  final String emotion;

  const InputJournal({
    Key? key,
    required this.emotion
  }): super(key: key);

  @override
  State<InputJournal> createState() => _InputJournalState();
}

class _InputJournalState extends State<InputJournal> {
  SelfManagementService selfManagementService = SelfManagementService();
  TextEditingController journalingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool journalError = false;
  bool titleError = false;
  bool isLoading = false;

  FocusNode titleFocusNode = FocusNode();
  FocusNode journalingFocusNode = FocusNode();


  void submitJournal() async {
    const validEmotions = {
      'marah': 'angry',
      'sedih': 'sad',
      'senang': 'glad',
      'bahagia': 'elated'
    };

    setState(() {
      isLoading = true;
    });

    setState(() {
      titleError = titleController.text.isEmpty;
      journalError = journalingController.text.isEmpty;
    });

    if (titleError) {
      FocusScope.of(context).requestFocus(titleFocusNode);
    } else if (journalError) {
      FocusScope.of(context).requestFocus(journalingFocusNode);
    }

    if (!titleError && !journalError) {
      var emotionValue = validEmotions[widget.emotion] ?? widget.emotion;

      try {
        await selfManagementService.postNewJournal(
            titleController.text,
            emotionValue,
            journalingController.text
        );
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessAlert(
                title: 'Yay!, Journal Sudah Terupload',
                message: 'Terima kasih telah mempercayakan Kalma sebagai teman cerita anda hari ini, senang rasanya bisa menjadi teman terpercaya kapanpun anda butuhkan!'
            );
          },
        );
        journalingController.clear();
        titleController.clear();
        log('Journal Submitted $submitJournal');
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        log('Error submitting journal: $e');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      log('Data Inputted still wrong');
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
                  CustomBackButton(text: 'Journaling', onPressed: () => Navigator.pop(context),),
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
                  TextFormField(
                    controller: titleController,
                    focusNode: titleFocusNode,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        labelText: 'Berikan judul untuk cerita kamu hari ini',
                        errorText: titleError ? "Jangan lupa untuk mengisi judul disini" : null
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 275,
                    child: TextFormField(
                      controller: journalingController,
                      focusNode: journalingFocusNode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                          labelText: 'Tuangkan perasaanmu disini!',
                          errorText: journalError ? "Ceritakan apa yang kamu rasakan hari ini disini" : null
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  CustomPrimaryButton(
                    function: submitJournal,
                    isLoading: isLoading,
                    buttonTitle: 'Kumpulkan',
                    horizontalPadding: 54.0,
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
