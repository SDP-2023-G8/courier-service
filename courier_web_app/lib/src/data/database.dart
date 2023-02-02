import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static void write(
      {required String deliveryId, required Map<String, dynamic> data}) async {
    try {
      DatabaseReference _dbRef =
          FirebaseDatabase.instance.ref("deliveries/$deliveryId");

      await _dbRef.set(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> read({required String deliveryId}) async {
    try {
      DatabaseReference _dbRef =
          FirebaseDatabase.instance.ref("deliveries/$deliveryId");
      final snapshot = await _dbRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        return _snapshotValue['hash'] ?? 'NOTHING';
      } else {
        return "SNAPSHOT DOES NOT EXIST";
      }
    } catch (e) {
      rethrow;
    }
  }
}
