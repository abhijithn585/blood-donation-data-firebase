import 'package:b/model/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DataModel> donorsRef;
  Reference main = FirebaseStorage.instance.ref();

  DatabaseService() {
    donorsRef = firestore.collection("blood donation").withConverter<DataModel>(
          fromFirestore: (snapshot, snapshotOptions) =>
              DataModel.fromJson(snapshot.data()!),
          toFirestore: (data, setOptions) => data.toJson(),
        );
  }
}
