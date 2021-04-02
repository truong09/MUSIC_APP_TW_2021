import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_project_team_2021_app/src/constants/PageRouteAnimation.dart';

import 'package:music_project_team_2021_app/src/model/song_model.dart';
import 'package:music_project_team_2021_app/src/page/play_home.dart';

// ignore: must_be_immutable
class MBottomTabBar extends StatelessWidget {
  Song song;
  MBottomTabBar({this.song});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, PageRouteAnimation(PlayHome()));
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                    child: Lottie.asset('assets/lotties/sounds.json')),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      song.singer,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                        height: 40,
                        child: Image.asset('assets/icons/play.png')),
                    onTap: () {},
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                        height: 40,
                        child: Image.asset('assets/icons/list.png')),
                    onTap: () {},
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
