import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'article_viewmodel.dart';

class ArticleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, ArticleViewModel model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.items.length.toString()),
          ),
          body: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
          ),
        );
      },
      viewModelBuilder: () => ArticleViewModel(),
    );
  }
}

