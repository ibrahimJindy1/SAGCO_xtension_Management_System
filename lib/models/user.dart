class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String exNO;
  final bool isActivated;
  final String mobileNum;
  final String mobileCode;

  const User(this.id, this.username, this.password, this.isActivated,
      this.email, this.exNO, this.mobileNum, this.mobileCode);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'username': username,
        'password': password,
        'isActivated': isActivated.toString(),
        'email': email.toString(),
        'exNO': exNO.toString(),
        'mobileNum': mobileNum,
        'mobileCode': mobileCode,
      };
}
