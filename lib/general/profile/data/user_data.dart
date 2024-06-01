class User{
  User({required this.userName, required this.userPhoneNumber, required this.userEmail, required this.userImg});

  String userName;
  String userPhoneNumber;
  String userEmail;
  String userImg;

  // User.fromJson(json){
  //   userImg = json[userImg];
  //   userPhoneNumber = json[userPhoneNumber];
  //   userEmail = json[userEmail];
  //   userName = json[userName];
  // }
}

//dummy data
User dataUser = User(userEmail: 'jokowi@gmail.com', userImg: 'https://i.ytimg.com/vi/nyvwx7o277U/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBPtV7J2Yrdb-9Kwvxj5NvMcvaB4g', userName: 'Jokowi', userPhoneNumber: '081299847210');


