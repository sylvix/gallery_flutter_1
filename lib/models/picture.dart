class Picture {
  final String id;
  final String title;
  final String image;

  const Picture({required this.id, required this.title, required this.image});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(id: json['id'], title: json['title'], image: json['image']);
  }
}
