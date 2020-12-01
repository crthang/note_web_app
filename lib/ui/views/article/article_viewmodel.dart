import 'package:stacked/stacked.dart';

import 'article_model.dart';

class ArticleViewModel extends BaseViewModel {
  List<Article> _items = [];

  List<Article> get items => _items;

  Article _article;
//get title
  String get title {
    return _article.title;
  }

//get description
  String get description {
    return _article.description;
  }

  //get author
  String get author {
    return _article.author;
  }

  //get content
  String get content {
    return _article.content;
  }

  //get url
  String get url {
    return _article.url;
  }

  //get urlToImage
  String get urlToImage {
    return _article.urlToImage;
  }

  //get publishedAt
  String get publishedAt {
    return _article.publishedAt;
  }
}
