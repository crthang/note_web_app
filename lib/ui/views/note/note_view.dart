import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'note_viewmodel.dart';

enum RepoSettings { showDeleted, deleteItemsPermanently }

class NoteView extends StatelessWidget {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (NoteViewModel model) => model.initialised,
      builder: (context, NoteViewModel model, child) => Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text(model.title),
          actions: [
            PopupMenuButton<RepoSettings>(
              onSelected: (RepoSettings result) {
                switch (result) {
                  case RepoSettings.showDeleted:
                    model.showDeleted = !model.showDeleted;
                    break;
                  case RepoSettings.deleteItemsPermanently:
                    model.deleteItemsPermanently();
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<RepoSettings>>[
                PopupMenuItem<RepoSettings>(
                  value: RepoSettings.showDeleted,
                  child: model.showDeleted
                      ? Text('Ẩn bản ghi đã xóa')
                      : Text('Hiện bản ghi đã xóa'),
                ),
                PopupMenuItem<RepoSettings>(
                  value: RepoSettings.deleteItemsPermanently,
                  child: Text('Xóa vĩnh viễn bản ghi đã xóa'),
                ),
              ],
            )
          ],
        ),
        body: ListView.builder(
          itemCount: model.items?.length,
          itemBuilder: (BuildContext ctxt, int index) {
            var item = model.items[index];

            /// Wrap ListTitle vào Dismissible để vuốt
            return Dismissible(
              /// Mỗi một Dismissible phải có một Key để cho phép Flutter
              /// xác định được widgets.
              key: UniqueKey(), //Key(item.id),
              onDismissed: (direction) async {
                await model.remove(item);
                final snackBar = SnackBar(
                  content: Text('Item removed!'),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () async {
                        await model.undoRemove(index, item);
                      }),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              // Show a red background as the item is swiped away.
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete),
                alignment: Alignment.centerRight,
              ),
              child: ListTile(
                title: Text('${item?.title ?? 'N/A'}'),
                subtitle: Text('${item?.desc ?? 'N/A'}'),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    item.isDeleted ? Chip(label: Text('đã xóa')) : SizedBox(),
                    item.isDeleted
                        ? IconButton(
                            icon: Icon(Icons.undo),
                            onPressed: () {
                              item.isDeleted = false;
                              item.save();
                              model.notifyListeners();
                            })
                        : IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => model.editItem(context, item),
                          )
                  ],
                ),
                onTap: () => model.detailItem(context, item),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            model.editItem(context, null);
          },
        ),
      ),
      viewModelBuilder: () => NoteViewModel(),
    );
  }
}
