import 'package:flutter/material.dart';
import 'package:note_web_app/ui/views/note/widgets/note_detail_view.dart';
import 'package:note_web_app/ui/views/note/widgets/note_edit.dart';
import 'package:stacked/stacked.dart';

import './../../../repository/cloud_store.dart';

import 'note_model.dart';

class NoteViewModel extends BaseViewModel {
  final title = 'Notes';
  final path = 'Notes';

  /// Hiện / Ẩn bản ghi đã xóa tạm
  bool _showDeleted = false;
  get showDeleted => _showDeleted;
  set showDeleted(value) {
    _showDeleted = value;
    notifyListeners();
  }

  var _items = <Note>[];
  List<Note> get items {
    if (showDeleted == false) {
      return _items.where((element) => element.isDeleted == false).toList();
    } else {
      return _items;
    }
  }

  /// Bản ghi cập nhật
  Note editingItem;

  /// Các control input dùng để cập nhật đối tượng
  var textTitleEditingController = TextEditingController();
  var textDescEditingController = TextEditingController();

  /// Form key
  final formKey = GlobalKey<FormState>();

  @override
  bool get initialised {
    /// Lắng nghe sự thay đổi từ Cloud Firestore theo thời gian thực
    CloudStore.instance
        .firestoreInstance()
        .then((store) => store.collection(path).snapshots().listen((event) {
              _items = event.docs.map((e) => Note.fromMap(e.data())).toList();

              /// Thông báo khi có sự thay đổi
              notifyListeners();
            }));
    return true;
  }

  Future<int> remove(Note item, {bool isPermanent = false}) async {
    var result;
    if (isPermanent || item.isDeleted) {
      result = await item.delete();
    } else {
      item.isDeleted = true;
      result = await item.save();
    }
    return result;
  }

  Future<int> undoRemove(int index, Note item) async {
    var result;
    item.isDeleted = false;
    result = await item.save();
    return result;
  }

  Future<void> deleteItemsPermanently() async {
    setBusy(true);
    await Note.items(showDeleted: true).then((value) {
      _items = value;
      _items.forEach((item) async {
        if (item.isDeleted) {
          await item.delete();
        }
      });
    });
  }

  /// Người dùng nhấn nút lưu ở giao diện thêm mới / sửa
  /// Phương thức này được gọi từ EditView thông qua model
  Future<int> update(BuildContext ctx) async {
    print("updated");
    var result;
    var title = textTitleEditingController.text.trim();
    var desc = textDescEditingController.text.trim();
    if (editingItem != null) {
      editingItem.title = title;
      editingItem.desc = desc;
      result = await editingItem.save();
      editingItem = null;
    } else {
      var item = Note.fromMap({
        'title': title,
        'desc': desc,
      });
      await item.save();
      editingItem = null;
    }
    Navigator.pop(ctx);
    return result;
  }

  /// Người dùng chọn xem chi tiết
  /// Điều hướng đến DetailView kèm theo item
  void detailItem(BuildContext ctx, Note item) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => NoteDetail(
          item: item,
        ),
      ),
    );
  }

  /// Người dùng chọn xem chi tiết
  /// Điều hướng đến DetailView kèm theo item
  void editItem(BuildContext ctx, Note item) {
    print("sửa/thêm");
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => NoteEdit(
          item: item, // Truyền vào EditView model hiện tại
        ),
      ),
    );
  }
}
