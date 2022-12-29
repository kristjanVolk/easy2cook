import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference -> doesnt matter if it isnt created
  final CollectionReference e2cCollection =
      FirebaseFirestore.instance.collection('e2c');
}
