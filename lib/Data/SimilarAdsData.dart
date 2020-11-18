import 'dart:convert';

class SimilarAdsData {

  final int serviceCardId;
  final String title;
  final String category;
  final String photo;
  final String serviceType;
  final String description;
  final String location;
  final String estimatedTime;
  final String createdAt;
  final bool active;

  SimilarAdsData({this.serviceCardId, this.title, this.category, this.photo, this.serviceType, this.description, this.location, this.estimatedTime, this.createdAt, this.active});

  factory SimilarAdsData.fromJson(Map<String, dynamic>json) => SimilarAdsData(
    serviceCardId: json['serviceCardId'],
    title: json['title'] == null ? null : json['title'],
    category: json['category'] == null ? null : json['category'],
    photo: json['photo'] == null ? null : json['photo'],
    serviceType: json['serviceType'] == null ? null : json['serviceType'],
    description: json['description'] == null ? null : json['description'],
    location: json['location'] == null ? null : json['location'],
    estimatedTime: json['estimatedTime'] == null ? null : json['estimatedTime'],
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
    active: json['active'] == null ? null : json['active'],
  );


  List<SimilarAdsData> parseServiceCard(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SimilarAdsData>((json) => SimilarAdsData.fromJson(json))
        .toList();
  }

  @override
  String toString() {
    return 'ServiceCard{serviceCardId: $serviceCardId, title: $title, photo: $photo, category: $category, serviceType: $serviceType, location: $location, description: $description, estimatedTime: $estimatedTime, createdAt: $createdAt, active: $active}';
  }
}




