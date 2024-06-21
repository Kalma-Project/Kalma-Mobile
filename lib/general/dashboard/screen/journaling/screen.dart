import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/self_management/service.dart';
import 'package:flutter_ta/self_management/journaling/widget/journal_history_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../model/general/general.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({super.key});

  @override
  State<JournalingScreen> createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  final SelfManagementService _managementService = SelfManagementService();

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1);

  String dropDownValue = 'judul';
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void _fetchPage(int pageKey) {
    _managementService.getJournalData(
        pageKey,
        _pagingController,
        isAscending ? 'asc' : 'desc',
        dropDownValue == 'judul' ? 'content' : 'created_at'
    );
  }

  void dropDownCallback(String? selectedValue) async {
    setState(() {
      dropDownValue = selectedValue!;
    });
      _pagingController.refresh();
  }

  void _toggleSortOrder() async{
    setState(() {
      isAscending = !isAscending;
    });
      _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
                    onPressed: () => Navigator.pop(context),
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
                          'Journal',
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
                height: 27,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffAAA4A4)),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  IconButton(
                      onPressed: _toggleSortOrder, icon: const Icon(Icons.swap_vert)),
                ],
              ),
              const SizedBox(
                height: 33,
              ),
              Expanded(
                child: PagedListView<int, Map<String, dynamic>>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
                    itemBuilder: (context, item, index) {
                      if (_pagingController.itemList != null && index < _pagingController.itemList!.length) {
                        JournalData journalData = JournalData.fromJson(_pagingController.itemList![index]);
                        return HistoryJournalWidget(
                          data: journalData,
                        );
                      } else {
                        return const Center(
                          child: Text('Invalid data index.'),
                        );
                      }
                    },
                    firstPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(color: Color(0xFF64CDC2)),
                    ),
                    newPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(color: Color(0xFF64CDC2)),
                    ),
                    firstPageErrorIndicatorBuilder: (context) => const Center(
                      child: Text('Failed to load data. Please try again.'),
                    ),
                    newPageErrorIndicatorBuilder: (context) => const Center(
                      child: Text('Failed to load more data. Please try again.'),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => const Center(
                      child: Text('No data found.'),
                    ),
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
