

class AdData {

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
  final List<ServiceCardList> serviceCardLists;

  AdData({this.userId, this.email, this.password, this.name, this.lastName, this.phoneNumber, this.profilePhoto, this.description, this.role, this.createdAt, this.serviceCardLists, });

  factory AdData.fromJson(Map<String, dynamic> json) => AdData(
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
    serviceCardLists: json['serviceCardList'] == null ? null : List<ServiceCardList>.from(json['serviceCardList'].map((x) => ServiceCardList.fromJson(x))),
  );
}

class ServiceCardList {

  final int serviceCardId;
  final String title;
  final String category;
  final String photo;
  final String serviceCardPhoto_2;
  final String serviceCardPhoto_3;
  final String serviceCardPhoto_4;
  final String serviceType;
  final double price;
  final String exchangeDescription;
  final String description;
  final String location;
  final String estimatedTime;
  final String createdAt;
  final bool active;

  ServiceCardList({this.serviceCardId, this.title, this.category, this.photo, this.serviceType, this.price, this.exchangeDescription, this.description, this.location, this.estimatedTime, this.createdAt, this.active, this.serviceCardPhoto_2, this.serviceCardPhoto_3, this.serviceCardPhoto_4,});

  factory ServiceCardList.fromJson(Map<String, dynamic> json) => ServiceCardList(
    serviceCardId: json['serviceCardId'] == null ? null : json['serviceCardId'],
    title: json['title'] == null ? null : json['title'],
    category: json['category'] == null ? null : json['category'],
    photo: json['photo'] == null ? null : json['photo'],
    serviceCardPhoto_2: json['serviceCardPhoto_2'] == null ? null : json['serviceCardPhoto_2'],
    serviceCardPhoto_3: json['serviceCardPhoto_3'] == null ? null : json['serviceCardPhoto_3'],
    serviceCardPhoto_4: json['serviceCardPhoto_4'] == null ? null : json['serviceCardPhoto_4'],
    serviceType: json['serviceType'] == null ? null : json['serviceType'],
    price: json['price'] == null ? null : json['price'],
    exchangeDescription: json['exchangeDescription'] == null ? null : json['exchangeDescription'],
    description: json['description'] == null ? null : json['description'],
    location: json['location'] == null ? null : json['location'],
    estimatedTime: json['estimatedTime'] == null ? null : json['estimatedTime'],
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
    active: json['active'] == null ? null : json['active'],
  );

}