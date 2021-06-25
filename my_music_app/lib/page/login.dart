import 'package:flutter/material.dart';
import 'package:my_music_app/model/AuthenticationFirebase.dart';

import 'package:my_music_app/page/home.dart';
import 'package:my_music_app/page/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mTextfied(
              "email",
              Icons.email,
              _email,
            ),
            mTextfied(
              "password",
              Icons.lock,
              _password,
            ),
            mButton("Đăng nhập", () async {
              var result = await AuthenticationService()
                  .signIn(email: _email.text, password: _password.text);
              if (result == 'Signed In') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              }
            }),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text("Tạo tài khoản"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  mTextfied(String lable, IconData icon,
      TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: lable,
      ),
    );
  }

  mButton(String lable, Function onPressed) {
    return FloatingActionButton.extended(
        onPressed: onPressed, label: Text(lable));
  }
}
