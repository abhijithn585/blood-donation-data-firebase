import 'dart:ffi';
import 'package:b/model/data_model.dart';
import 'package:b/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  String imagename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = "";
  Stream<QuerySnapshot<DataModel>> getDonors() {
    return service.donorsRef.snapshots();
  }

  imageAdder(image) async {
    try {
      Reference imagefolder = service.main.child('images');
      Reference uploadimage = imagefolder.child("${imagename}.jpg");
      await uploadimage.putFile(image);
      downloadurl = await uploadimage.getDownloadURL();
      print(downloadurl);
    } catch (error) {
      return Exception('image cant be added $error');
    }
  }

  imageUpdate(imageurl, updatedimage) async {
    try {
      Reference editpic = FirebaseStorage.instance.refFromURL(imageurl);
      await editpic.putFile(updatedimage);
      downloadurl = await editpic.getDownloadURL();
    } catch (error) {
      return Exception('image is not updated$error');
    }
  }

  deleteImage(imageurl) async {
    try {
      Reference delete = FirebaseStorage.instance.refFromURL(imageurl);
      await delete.delete();
      print('image deleted successfully');
    } catch (error) {
      return Exception('image is not deleted $error');
    }
  }

  Future<void> addDonor(DataModel data) async {
    try {
      await service.donorsRef.add(data);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateDonor(id, DataModel donors) async {
    service.donorsRef.doc(id).update(donors.toJson());
    notifyListeners();
  }

  Future<void> deleteDonor(id) async {
    service.donorsRef.doc(id).delete();
    notifyListeners();
  }
}
