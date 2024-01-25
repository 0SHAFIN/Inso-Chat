class UsersModel {
  String? fname;
  String? lname;
  String? phone;
  String? gender;
  String? dob;
  String? email;
  String? password;

  UsersModel(
      {required this.fname,
      required this.lname,
      required this.phone,
      required this.gender,
      required this.dob,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      "Name": "$fname $lname",
      "phone": phone,
      "gender": gender,
      "dob": dob,
      "email": email,
      "password": password,
    };
  }
}
