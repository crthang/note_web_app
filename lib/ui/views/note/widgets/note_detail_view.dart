import 'package:flutter/material.dart';

import '../note_model.dart';

class NoteDetail extends StatelessWidget {
  final Note item;

  const NoteDetail({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.desc),
      ),
    );
  }
}
