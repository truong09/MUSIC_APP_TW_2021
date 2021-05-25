import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_music_app/page/login.dart';

class MDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: CircleAvatar(
                child: Text("A"),
              ),
            ),
            Expanded(
              child: Text(FirebaseAuth.instance.currentUser.email),
            ),
            Expanded(
                child: TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              },
              child: Text("Đăng xuất"),
            ))
          ],
        ),
      ),
    );
  }
}
