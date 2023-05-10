import 'package:firebase_database/firebase_database.dart';

class Working {
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference().child('ForRent');

  Stream<List<Map<String, dynamic>>> getDataStream() {
    return databaseReference.onValue.map((event) {
      List<Map<String, dynamic>> dataList = [];
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, item) {
          dataList.add({
            'id': key,
            'Book': item['Book'],
            'name': item['name'],
            'year': item['year'],
            'price' : item['price'],

            // add any other fields from your Firebase snapshot
          });
        });
      }
      return dataList;
    });
  }
}