import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStore {
  CloudStore._internal() {
    firestoreInstance();
  }

  /// Lưu cache để không phải tạo nhiều đối tượng
  static final _cache = <String, CloudStore>{};

  static CloudStore get instance =>
      _cache.putIfAbsent('CloudStore', () => CloudStore._internal());

  bool isInitialized = false;

  FirebaseFirestore _firebaseFirestore;

  Future<FirebaseFirestore> firestoreInstance() async {
    if (!isInitialized) await _init();
    return _firebaseFirestore;
  }

  Future _init() async {
    _firebaseFirestore = FirebaseFirestore.instance;
    isInitialized = true;
  }
}
