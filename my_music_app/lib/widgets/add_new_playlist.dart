import 'package:flutter/material.dart';
import 'package:my_music_app/model/service/playlist_service.dart';

addNewPlaylist(BuildContext context) {
  TextEditingController text = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                  child: TextField(
                controller: text,
              )),
              TextButton(
                onPressed: () async {
                  await PlaylistService().createNewPLayList(text.text, []);
                  Navigator.pop(context);
                },
                child: Text("Tạo danh sách"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
