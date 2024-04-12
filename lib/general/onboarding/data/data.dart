class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Identifikasi emosimu',
    image: 'images/onboarding_1.png',
    description: 'Kenali emosimu dan dapatkan wawasan berharga dalam perjalanan kesehatan mentalmu',
  ),
  OnboardingContent(
    title: 'Bebas ekspresikan dirimu',
    image: 'images/onboarding_2.png',
    description:
    'Abadikan pengalaman harianmu, tetapkan tujuan, dan kembangkan self-awareness kamu lewat jurnal',
  ),
  OnboardingContent(
    title: 'Temukan kedamaian',
    image: 'images/onboarding_3.png',
    description:
    'Jelajahi latihan pernapasan yang disesuaikan untuk mengurangi stres dan meningkatkan relaksasi',
  ),
  OnboardingContent(
    title: 'Rasakan ketenangan melodi',
    image: 'images/onboarding_4.png',
    description:
    'Tingkatkan latihan meditasi, kurangi kecemasan, dan rasakan relaksasi mendalam melalui keajaiban musik',
  ),
];
