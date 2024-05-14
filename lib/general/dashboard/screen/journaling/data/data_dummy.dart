class DataCardJournaling {

  String content;
  String title;
  DateTime date;
  String emotion;

  DataCardJournaling({
    required this.content,
    required this.title,
    required this.date,
    required this.emotion
  });
}

List<DataCardJournaling> contents = [
  DataCardJournaling(
      content:
          'Setelah pulang, saya langsung duduk di meja kerja dan mulai menyelesaikan pekerjaan yang tertunda. Meskipun sedikit tertekan dengan deadline yang mendekat, saya tetap bersemangat dan yakin bisa menyelesaikan semuanya dengan baik.',
      title: 'Sarapan Pagi',
      emotion: 'sedih',
      date: DateTime(2024,11,22)
  ),
  DataCardJournaling(
      content:
      'Setelah pulang, saya langsung duduk di meja kerja dan mulai menyelesaikan pekerjaan yang tertunda. Meskipun sedikit tertekan dengan deadline yang mendekat, saya tetap bersemangat dan yakin bisa menyelesaikan semuanya dengan baik.',
      title: 'Bersama Bapak',
      emotion: 'senang',
      date: DateTime(2024,11,22)
  ),
  DataCardJournaling(
      content:
      'Setelah pulang, saya langsung duduk di meja kerja dan mulai menyelesaikan pekerjaan yang tertunda. Meskipun sedikit tertekan dengan deadline yang mendekat, saya tetap bersemangat dan yakin bisa menyelesaikan semuanya dengan baik.',
      title: 'Menghadapi Wanita Ganas',
      emotion: 'bahagia',
      date: DateTime(2024,11,22)
  ),
];
