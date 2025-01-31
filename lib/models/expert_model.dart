class ExpertModel {
  String firstName;
  String email;
  String lastName;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String expertId;
  String password;
  String qualified;
  String roleCode;

  ExpertModel({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.expertId,
    required this.password,
    required this.qualified,
    required this.roleCode,
  });

  // from map
  factory ExpertModel.fromMap(Map<String, dynamic> map) {
    return ExpertModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      expertId: map['expertId'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      qualified: map['qualified'] ?? '',
      roleCode: map['roleCode'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "expertId": expertId,
      "password": password,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "email": email,
      "qualified":qualified,
      "roleCode":roleCode,
    };
  }
}
