class Photos {
  final String photo1;
  final String photo2;
  final String photo3;
  final String photo4;

  Photos({this.photo1, this.photo2, this.photo3, this.photo4});

  factory Photos.fromJson(Map<String, dynamic>json) => Photos(
    photo1: json['photo1'] == null ? null : json['photo1'],
    photo2: json['photo2'] == null ? null : json['photo2'],
    photo3: json['photo3'] == null ? null : json['photo3'],
    photo4: json['photo4'] == null ? null : json['photo4'],
  );
}