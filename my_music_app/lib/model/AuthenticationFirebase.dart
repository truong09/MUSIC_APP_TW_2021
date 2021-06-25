import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final auth = FirebaseAuth.instance;
  AuthenticationService();
  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (auth.currentUser.uid != null) {
        print("da dang nhap thanh cong");
        return "Signed In";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }
}
