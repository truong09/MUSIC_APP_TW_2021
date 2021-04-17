import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/list_singer_to_text.dart';
import 'package:music_project_team_2021_app/src/core/play_song.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../constants/temp_varible.dart';
import '../core/stream/song_stream.dart';
import '../core/stream/song_stream.dart';
import '../core/stream/song_stream.dart';

// ignore: must_be_immutable
class PlayHome extends StatefulWidget {
  Song song;
  PlayHome({this.song});
  @override
  _PlayHomeState createState() => _PlayHomeState();
}

class _PlayHomeState extends State<PlayHome> {
  double rate = 0;
  PlaySong playSongController = PlaySong();
  Song song;
  StreamSong _streamSong;
  var _value = 0.0;
  @override
  void initState() {
    super.initState();
    _streamSong = StreamSong();
    setUpDuration();
  }

  void setUpDuration() {
    playSongController.audioPlayer.durationHandler = (d) {
      if (this.mounted) {
        setState(() {
          playSongController.musicLength = d;
        });
      }
    };
    playSongController.audioPlayer.positionHandler = (p) {
      if (this.mounted) {
        setState(() {
          playSongController.positon = p;
        });
      }
    };
  }

  Widget slider() {
    return Slider.adaptive(
        value: _value,
        max: playSongController.musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          if (this.mounted) {
            setState(() {
              _value = value;
            });
          }
          Duration newPos = Duration(seconds: _value.toInt());
          playSongController.audioPlayer.seek(newPos);
        });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      song = widget.song;
      print('day la song nhan duoc ${song.name}');
    });
    _value = playSongController.positon.inSeconds.toDouble();
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
                child: slider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${playSongController.positon.inMinutes}:${playSongController.positon.inSeconds.remainder(60)}"),
                  Text(
                      '${playSongController.musicLength.inMinutes}:${playSongController.musicLength.inSeconds.remainder(60)}'),
                ],
              ),
              StreamBuilder<Song>(
                  stream: _streamSong.songStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      song = snapshot.data;
                    }

                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                            song.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
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
                      ],
                    );
                  }),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        indexOfSongNow--;
                        if (indexOfSongNow < 0) {
                          indexOfSongNow = 0;
                        }
                        _streamSong.changesong(songsOffline[indexOfSongNow]);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/pre.png'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            if (playSongController.isPlaying == true) {
                              playSongController.pausePlaying();
                              playSongController.isPlaying = false;
                            } else {
                              playSongController.continuePlaying();
                              playSongController.isPlaying = true;
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        child: playSongController.isPlaying == true
                            ? Image.asset('assets/icons/playing.png')
                            : Image.asset('assets/icons/play.png'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        indexOfSongNow++;
                        if (indexOfSongNow >= songsOffline.length) {
                          indexOfSongNow = 0;
                        }
                        _streamSong.changesong(songsOffline[indexOfSongNow]);
                      },
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
