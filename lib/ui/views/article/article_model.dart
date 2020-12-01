class Article {
  final String title;
  final String author;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article(
      {this.title,
      this.author,
      this.description,
      this.content,
      this.url,
      this.urlToImage,
      this.publishedAt});

  factory Article.fromJSON(Map<String, dynamic> json) {
    return new Article(
      title: json["title"],
      author: json["author"],
      description: json["description"],
      content: json["content"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
    );
  }
}
