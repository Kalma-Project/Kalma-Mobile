
List<Map<String, dynamic>> questions = [
  {
    'key': 1,
    'question': 'Saya menjadi marah karena hal-hal kecil/sepele',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'stress'
  },
  {
    'key': 2,
    'question': 'Mulut saya terasa kering',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'anxiety'
  },
  {
    'key': 3,
    'question': 'Saya tidak dapat melihat hal yang positif dari suatu kejadian',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'depression'
  },
  {
    'key': 4,
    'question': 'Saya merasakan gangguan dalam bernapas (napas cepat, sulit bernapas)',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'anxiety'
  },
  {
    'key': 5,
    'question': 'Saya merasa seperti tidak kuat lagi untuk melakukan suatu kegiatan',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'depression'
  },
  {
    'key': 6,
    'question': 'Saya cenderung bereaksi berlebihan pada situasi',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'stress'
  },
  {
    'key': 7,
    'question': 'Saya memiliki kelemahan pada anggota tubuh',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'anxiety'
  },
  {
    'key': 8,
    'question': 'Saya kesulitan untuk relaksasi/bersantai',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'stress'
  },
  {
    'key': 9,
    'question': 'Saya memiliki rasa cemas yang berlebihan dalam suatu situasi namun bisa lega jika hal/situasi itu berakhir',
    'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
    'category': 'anxiety'
  },
  // {
  //   'key': 10,
  //   'question': 'Saya merasa pesimis',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 11,
  //   'question': 'Saya mudah merasa kesal',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 12,
  //   'question': 'Saya merasa banyak menghabiskan energi karena cemas',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 13,
  //   'question': 'Saya merasa sedih dan depresi',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 14,
  //   'question': 'Saya merasa tidak sabaran',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 15,
  //   'question': 'Saya merasa kelelahan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 16,
  //   'question': 'Saya kehilangan minat pada banyak hal (misal: makan, ambulasi, sosialisasi)',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 17,
  //   'question': 'Saya merasa diri tidak layak',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 18,
  //   'question': 'Saya merasa mudah tersinggung',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 19,
  //   'question': 'Saya merasa mudah berkeringat tanpa stimulasi oleh cuaca maupun latihan fisik',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 20,
  //   'question': 'Saya ketakutan tanpa alasan yang jelas',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 21,
  //   'question': 'Saya merasa hidup tidak berharga',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 22,
  //   'question': 'Saya merasa sulit untuk beristirahat',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 23,
  //   'question': 'Saya merasa kesulitan dalam menelan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 24,
  //   'question': 'Saya merasa tidak dapat menikmati hal-hal yang saya lakukan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 25,
  //   'question': 'Saya merasakan perubahan detak jantung dan denyut nadi tanpa stimulasi oleh latihan fisik',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 26,
  //   'question': 'Saya merasa hilang harapan dan putus asa',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 27,
  //   'question': 'Saya merasa mudah marah',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 28,
  //   'question': 'Saya merasa mudah panik',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 29,
  //   'question': 'Saya merasa kesulitan untuk tenang setelah sesuatu yang mengganggu',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 30,
  //   'question': 'Saya takut jika diri terhambat oleh tugas-tugas yang tidak biasa dilakukan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 31,
  //   'question': 'Saya merasa sulit untuk antusias pada banyak hal',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 32,
  //   'question': 'Saya sulit mentoleransi gangguan-gangguan terhadap hal yang sedang dilakukan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 33,
  //   'question': 'Saya merasa berada pada keadaan tegang',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 34,
  //   'question': 'Saya merasa tidak berharga',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 35,
  //   'question': 'Saya merasa tidak dapat memaklumi hal apapun yang menghalangi saya untuk menyelesaikan hal yang sedang saya lakukan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 36,
  //   'question': 'Saya merasa ketakutan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 37,
  //   'question': 'Saya merasa tidak ada harapan untuk masa depan',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 38,
  //   'question': 'Saya merasa hidup tidak berarti',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // },
  // {
  //   'key': 39,
  //   'question': 'Saya mudah gelisah',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'stress'
  // },
  // {
  //   'key': 40,
  //   'question': 'Saya merasa khawatir dengan situasi saat diri saya mungkin menjadi panik dan mempermalukan diri sendiri',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 41,
  //   'question': 'Saya merasa gemetar',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'anxiety'
  // },
  // {
  //   'key': 42,
  //   'question': 'Saya merasa sulit untuk meningkatkan inisiatif dalam melakukan sesuatu',
  //   'answer': ['Tidak Pernah', 'Kadang - Kadang', 'Sering', 'Hampir Setiap Saat'],
  //   'category': 'depression'
  // }
];