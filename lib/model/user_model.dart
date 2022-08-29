class UserModel {
  String? email;
  String? password;
  String? uuid;
  UserModel({required this.email, required this.password, required this.uuid});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'], password: json['password'], uuid: json['uuid']);

  Map<String?, dynamic> toJson() {
    return {'email': email, 'password': password, 'uuid': uuid};
  }
}
