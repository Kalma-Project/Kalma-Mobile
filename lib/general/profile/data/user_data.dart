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
User dataUser = User(userEmail: 'jokowi@gmail.com', userImg: 'images/profile_icon.png', userName: 'Jokowi', userPhoneNumber: '081299847210');


