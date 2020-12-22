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

  Future<String> isUserRegistered(uid) async{
    try {
      String valueReturn;
     await _userCollectionReference.doc(uid).get().then((value) {
        print("******************${value.exists}*********************");
        valueReturn = value.exists ? "true" : "false";
        return value.exists ? "true" : "false";
      });
      return valueReturn;
    } catch (e) {
      return e.message;
    }
  }
}
