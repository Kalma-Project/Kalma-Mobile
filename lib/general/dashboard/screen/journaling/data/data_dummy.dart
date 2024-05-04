class DataCardJournaling {
  DataCardJournaling(
      {required this.content, required this.title, required this.date});

  String content;
  String title;
  String date;
}

List<DataCardJournaling> contents = [
  DataCardJournaling(
      content:
          'Setelah pulang, saya langsung duduk di meja kerja dan mulai menyelesaikan pekerjaan yang tertunda. Meskipun sedikit tertekan dengan deadline yang mendekat, saya tetap bersemangat dan yakin bisa menyelesaikan semuanya dengan baik.',
      title: 'Hari-hari',
      date: '22 Nov, 2024'),
  DataCardJournaling(
      content:
      'Setelah sarapan ringan, saya pergi ke taman untuk berolahraga pagi. Udara segar dan aroma bunga-bunga di sekitar membuat saya merasa hidup kembali. Saya merasa bersyukur bisa menikmati momen indah seperti ini setiap pagi.',
      title: 'Sarapan Pagi',
      date: '22 Nov, 2024'),
  DataCardJournaling(
      content:
      'Setelah pulang, saya langsung duduk di meja kerja dan mulai menyelesaikan pekerjaan yang tertunda. Meskipun sedikit tertekan dengan deadline yang mendekat, saya tetap bersemangat dan yakin bisa menyelesaikan semuanya dengan baik.',
      title: 'Hari-hari',
      date: '22 Nov, 2024'),
];
