import 'package:agriglance/Models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createOrUpdateUser(UserModel user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(uid) async {
    try {
      var userData = await _userCollectionReference.doc(uid).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  String isUserRegistered(uid) {
    try {
      _userCollectionReference.doc(uid).get().then((value) {
        print("******************${value.exists}*********************");
        return value.exists ? "true" : "false";
      });
      return "Null";
    } catch (e) {
      return e.message;
    }
  }
}
