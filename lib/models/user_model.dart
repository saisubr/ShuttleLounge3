class UserModel {
  String firstName;
  String email;
  String lastName;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String customerId;
  String password;
  String roleCode;

  UserModel({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.customerId,
    required this.password,
    required this.roleCode,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      customerId: map['customerId'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      roleCode: map['roleCode'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "customerId": customerId,
      "password": password,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "email": email,
      "roleCode":roleCode,
    };
  }
}
