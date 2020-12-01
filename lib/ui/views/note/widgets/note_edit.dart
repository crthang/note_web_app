import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../ui/views/note/note_model.dart';
import '../note_viewmodel.dart';

class NoteEdit extends StatelessWidget {
  final Note item;

  const NoteEdit({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (NoteViewModel model) {
        model.editingItem = item;
        model.textTitleEditingController.text = item?.title ?? '';
        model.textDescEditingController.text = item?.desc ?? '';
      },
      builder: (context, NoteViewModel model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.editingItem != null
              ? 'Update ${model.editingItem.title}'
              : 'Add new note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                // The first text field is focused on as soon as the app starts.
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title', hintText: ''),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: true,
                  controller: model.textTitleEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                // The first text field is focused on as soon as the app starts.
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Description', hintText: ''),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: false,
                  controller: model.textDescEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the button is pressed,
          // give focus to the text field using myFocusNode.
          onPressed: () async {
            if (model.formKey.currentState.validate()) {
              await model.update(context);
            }
          },
          tooltip: 'Save',
          child: Icon(Icons.save),
        ),
      ),
      viewModelBuilder: () => NoteViewModel(),
    );
  }
}
