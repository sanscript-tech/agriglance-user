import 'package:agriglance/Models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  CollectionReference get getReference => _userCollectionReference;

  Future createUser(UserModel user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(uid) async {
    try {
      var userDate = await _userCollectionReference.doc(uid).get();
      return UserModel.fromData(userDate.data());
    } catch (e) {
      return e.message;
    }
  }
}
