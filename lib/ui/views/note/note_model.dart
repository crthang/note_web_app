import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './../../../repository/cloud_store.dart';

/// Note là một mô hình dữ liệu (data model) mô tả cấu trúc một Ghi chú
/// dưới dạng một Lớp (class)
class Note {
  static String get tableName => 'Notes';

  /// mã định danh thường được lưu vào thuộc tính có tên là [id].
  String _id =
      UniqueKey().hashCode.toUnsigned(20).toRadixString(16).padLeft(6, '0');
  String get id => _id;

  String title;
  String desc;

  /// Mỗi một ghi chú được tạo ra sẽ có trạng thái xóa tạm hoặc xóa vĩnh
  /// viễn khỏi CSDL, khi bị xóa tạm nó chỉ thay đổi thuộc tính
  /// [isDeleted], khi bi xóa vĩnh viễn thì nó sẽ bị xóa khỏi CSDL.
  bool isDeleted = false;

  /// Thời gian tạo, tương thích với Cloud Firestore
  Timestamp timestamp = Timestamp.now();

  /// Last changed date
  Timestamp lcd;

  /// Toán tử so sánh
  bool operator <=(Note o) =>
      timestamp.compareTo(o.timestamp) <= 0 || lcd.compareTo(o.lcd) <= 0;
  bool operator >=(Note o) =>
      timestamp.compareTo(o.timestamp) >= 0 || lcd.compareTo(o.lcd) >= 0;
  bool operator >(Note o) =>
      timestamp.compareTo(o.timestamp) > 0 || lcd.compareTo(o.lcd) > 0;
  bool operator <(Note o) =>
      timestamp.compareTo(o.timestamp) < 0 || lcd.compareTo(o.lcd) < 0;
  bool operator ==(o) => o is Note && id == o.id;
  int get hashCode => id.hashCode;

  /// Phương thức này được thiết lập để tạo nên danh sách các ghi chú
  /// được lấy về từ CSDL, nó được tạo dưới dạng danh sách các ghi chú
  /// theo cấu trúc Map mà không cần khởi tạo đối tượng nên nó là static.
  static List<Note> fromList(List<Map<String, dynamic>> queryList) {
    List<Note> items = List<Note>();
    for (Map map in queryList) {
      items.add(Note.fromMap(map));
    }
    return items;
  }

  /// Hàm tạo có tên, đây là một hàm tạo từ đối số là dữ liệu đưa vào
  /// dưới dạng Map
  Note.fromMap(Map data)
      : _id = data['id'] ??
            UniqueKey()
                .hashCode
                .toUnsigned(20)
                .toRadixString(16)
                .padLeft(6, '0'),
        title = data['title'],
        desc = data['desc'],
        isDeleted = data['isDeleted'] ?? false,
        timestamp = data['timestamp'] ?? Timestamp.now(),
        lcd = data['lcd'];

  /// Phương thức của đối tượng, nó cho phép tạo ra dữ liệu dạng Map từ
  /// dữ liệu của một đối tượng ghi chú.
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'desc': desc,
        'isDeleted': isDeleted,
        'timestamp': timestamp,
        'lcd': Timestamp.now(),
      };

  Future<dynamic> delete() async {
    final db = await CloudStore.instance.firestoreInstance();
    return await db.collection(tableName).doc(id).delete();
  }

  Future<dynamic> save() async {
    final db = await CloudStore.instance.firestoreInstance();
    return await db.collection(tableName).doc(id).set(toMap());
  }

  static Future<List<Note>> items({bool showDeleted = false}) async {
    final db = await CloudStore.instance.firestoreInstance();

    var querySnapshot = await db.collection(tableName).get();
    if (querySnapshot.docs.isNotEmpty) {
      var queryList = querySnapshot.docs.map((e) => e.data()).toList();
      return Note.fromList(queryList);
    }
    return [];
  }
}
