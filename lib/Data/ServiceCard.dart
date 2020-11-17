import 'dart:convert';

class ServiceCard {

  final int serviceCardId;
  final String title;
  final String category;
  final String photo;
  final String photo2;
  final String photo3;
  final String photo4;
  final String serviceType;
  final String description;
  final String location;
  final String estimatedTime;
  final String createdAt;
  final bool active;

  ServiceCard({this.serviceCardId, this.title, this.category, this.photo, this.photo2, this.photo3, this.photo4, this.serviceType, this.description, this.location, this.estimatedTime, this.createdAt, this.active});

  factory ServiceCard.fromJson(Map<String, dynamic>json) => ServiceCard(
    serviceCardId: json['serviceCardId'],
    title: json['title'] == null ? null : json['title'],
    category: json['category'] == null ? null : json['category'],
    photo: json['photo'] == null ? null : json['photo'],
    photo2: json['serviceCardPhoto_2'] == null ? null : json['serviceCardPhoto_2'],
    photo3: json['serviceCardPhoto_3'] == null ? null : json['serviceCardPhoto_3'],
    photo4: json['serviceCardPhoto_4'] == null ? null : json['serviceCardPhoto_4'],
    serviceType: json['serviceType'] == null ? null : json['serviceType'],
    description: json['description'] == null ? null : json['description'],
    location: json['location'] == null ? null : json['location'],
    estimatedTime: json['estimatedTime'] == null ? null : json['estimatedTime'],
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
    active: json['active'] == null ? null : json['active'],
  );


  List<ServiceCard> parseServiceCard(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ServiceCard>((json) => ServiceCard.fromJson(json))
        .toList();
  }

  @override
  String toString() {
    return 'ServiceCard{serviceCardId: $serviceCardId, title: $title, photo: $photo, category: $category, serviceType: $serviceType, location: $location, description: $description, estimatedTime: $estimatedTime, createdAt: $createdAt, active: $active}';
  }
}




