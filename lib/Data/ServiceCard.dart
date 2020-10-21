

class ServiceCard {

  final int serviceCardId;
  final String userId;
  final String title;
  final String photo;
  final String category;
  final String serviceType;
  final String location;
  final String description;
  final String estimatedTime;
  final String createdAt;
  final bool isActive;


  ServiceCard({this.serviceCardId, this.userId, this.title, this.photo,
      this.category, this.serviceType, this.location, this.description,
      this.estimatedTime, this.createdAt, this.isActive});


  factory ServiceCard.fromJson(Map<String, dynamic>json){
    return ServiceCard(
        serviceCardId: json['serviceCardId'],
        userId: json['userId'],
        title: json['title'],
        photo: json['photo'],
        category: json['category'],
        serviceType: json['serviceType'],
        location: json['location'],
        description: json['description'],
        estimatedTime: json['estimatedTime'],
        createdAt: json['createdAt'],
        isActive: json['isActive']);
  }



}

