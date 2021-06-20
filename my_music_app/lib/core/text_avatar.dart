import 'package:firebase_auth/firebase_auth.dart';

textToAvatar() {
  String name = FirebaseAuth.instance.currentUser.email;
  return name[0].toUpperCase();
}
