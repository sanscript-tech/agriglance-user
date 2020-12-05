import 'package:agriglance/Models/usermodel.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService = FirestoreService();
  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(_firebaseAuth.currentUser);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(String email, String password, String fullName, String dob,
      String qualification, String university) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _currentUser = UserModel(_firebaseAuth.currentUser.uid, fullName, email, dob,
          qualification, university);
      await _firestoreService.createOrUpdateUser(_currentUser);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut().then((_) => googleSignIn.signOut());
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');
      if (_firestoreService.isUserRegistered(user.uid) != null) {
        _currentUser = UserModel(user.uid, "", user.email,"", "", "");
        await _firestoreService.createOrUpdateUser(_currentUser);
      } else {
        await _populateCurrentUser(user);
      }
      return '$user';
    }

    return null;
  }

  Future editProfile(String email, String fullName, String dob,
      String qualification, String university) async {
    try {
      _firebaseAuth.currentUser.updateEmail(email);
      _currentUser = UserModel(_firebaseAuth.currentUser.uid, fullName, email, dob,
          qualification, university);
      await _firestoreService.createOrUpdateUser(_currentUser);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetPassword(String email) async {
    await _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => print("Email sent"));
  }

  Future _populateCurrentUser(User firebaseUser) async {
    if (firebaseUser != null) {
      _currentUser = await _firestoreService.getUser(firebaseUser.uid);
    }
  }
}
