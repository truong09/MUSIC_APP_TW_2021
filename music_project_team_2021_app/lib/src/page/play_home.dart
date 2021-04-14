import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/list_singer_to_text.dart';
import 'package:music_project_team_2021_app/src/core/play_song.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

// ignore: must_be_immutable
class PlayHome extends StatefulWidget {
  Song song;
  PlayHome({this.song});
  @override
  _PlayHomeState createState() => _PlayHomeState();
}

class _PlayHomeState extends State<PlayHome> {
  double rate = 0;
  PlaySong play = PlaySong();
  Song song;
  @override
  // void initState() {
  //   super.initState();
  //   if (this.mounted) {
  //     setState(() {
  //       song = widget.song;
  //     });
  //   }

  //   print('day la song nhan duoc ${song.name}');
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {
      song = widget.song;
      print('day la song nhan duoc ${song.name}');
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: IconButton(
              //     icon: Icon(Icons.keyboard_arrow_down_sharp),
              //     onPressed: () {},
              //   ),
              // ),
              Container(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Slider(
                    value: rate,
                    onChanged: (newRating) {
                      // setState(() {
                      //   rate = newRating;
                      // });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0.0"),
                  Text("2:28"),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  song.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                alignment: Alignment.center,
                child: Text(
                  singer(song),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/pre.png'),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/icons/play.png'),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/next.png'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/list_play.png')),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/none_repeat.png')),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/clock.png')),
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
