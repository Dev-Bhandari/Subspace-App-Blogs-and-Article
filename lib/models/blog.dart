class Blog {
  final String id;

  final String imageUrl;

  final String title;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory Blog.fromJson(Map<dynamic, dynamic> json) {
    return Blog(
      id: json["id"].toString(),
      imageUrl: json["image_url"].toString(),
      title: json["title"].toString(),
    );
  }
}
