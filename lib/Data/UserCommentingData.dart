class UserCommentingData {

  final int userId;
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String phoneNumber;
  final String profilePhoto;
  final String description;
  final String role;
  final String createdAt;

  UserCommentingData({this.userId, this.email, this.password, this.name, this.lastName, this.phoneNumber, this.profilePhoto, this.description, this.role, this.createdAt,});

  factory UserCommentingData.fromJson(Map<String, dynamic> json) => UserCommentingData(
    userId: json['userId'] == null ? null : json['userId'],
    email: json['email'] == null ? null : json['email'],
    password: json['password'] == null ? null : json['password'],
    name: json['name'] == null ? null : json['name'],
    lastName: json['lastName'] == null ? null : json['lastName'],
    phoneNumber: json['phoneNumber'] == null ? null : json['phoneNumber'],
    profilePhoto: json['profilePhoto'] == null ? null : json['profilePhoto'],
    description: json['description'] == null ? null : json['description'],
    role: json['role'] == null ? null : json['role'],
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
  );
}

