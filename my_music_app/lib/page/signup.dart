import 'package:flutter/material.dart';
import 'package:my_music_app/model/AuthenticationFirebase.dart';
import 'package:my_music_app/page/home.dart';
import 'package:my_music_app/page/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _name = TextEditingController();
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
              "Tên hiển thị",
              Icons.email,
              _email,
            ),
            mTextfied(
              "Email",
              Icons.email,
              _email,
            ),
            mTextfied(
              "Mật khẩu",
              Icons.lock,
              _password,
            ),
            mButton("Đăng ký", () async {
              String resl = await AuthenticationService()
                  .signUp(email: _email.text, password: _password.text);
              if (resl == "Signed In") {
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
              child: Text("Đăng nhập"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
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
