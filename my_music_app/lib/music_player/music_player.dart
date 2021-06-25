import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/comon_variable.dart';

import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';

import 'package:my_music_app/music_player/bottom_bar.dart';
import 'package:my_music_app/music_player/progress_bar.dart';

import 'package:my_music_app/widgets/add_song_to_playList.dart';

String idnow;

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool showTimer = false;

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final mediaQuery = MediaQuery.of(context);
    TextEditingController text = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
          builder: (context, mediaPlayerState) {
        // if (secondGV > 0 && isTimed == true) {
        //   MTimer().count(() {
        //     if (this.mounted) {
        //       setState(() {
        //         if (secondGV > 0) {
        //           secondGV--;
        //           print(secondGV);
        //         } else {
        //           MTimer.timer.cancel();

        //           BlocProvider.of<MediaPlayerCubit>(context).pause();
        //           secondGV = 0;
        //           if (this.mounted) {
        //             setState(() {
        //               isTimed = false;
        //             });
        //           }
        //         }
        //       });
        //     }
        //   });
        // }

        idnow = mediaPlayerState.audioTrack?.id ?? "0";
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      mediaPlayerState.audioTrack?.art ?? defaultImage),
                  fit: BoxFit.cover,
                )),
                // color: theme.colorScheme.primaryVariant,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 20.0),
                  child: Stack(children: [
                    Column(
                      //   mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 50),
                                    Stack(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Image.network(
                                              mediaPlayerState
                                                      .audioTrack?.art ??
                                                  defaultImage,
                                              fit: BoxFit.cover,
                                            )),
                                        (() {
                                          /// styling ProgressIndicator
                                          if (mediaPlayerState
                                              is MediaPlayerLoadingTrackState) {
                                            return SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                  CircularProgressIndicator(),
                                                ],
                                              ),
                                            );
                                          }

                                          return SizedBox();
                                        }()),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            mediaPlayerState
                                                    .audioTrack?.title ??
                                                'Không có bài hát nào được phát',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            mediaPlayerState
                                                    .audioTrack?.author ??
                                                'Không có ca sĩ',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: theme.hintColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    ProgressBar(),
                                    OptionMenu(
                                      callback: () {
                                        setState(() {
                                          showTimer = !showTimer;
                                        });
                                      },
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        BottomBar(),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        bottom: 0,
                        child: showTimer != true
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  if (this.mounted) {
                                    setState(() {
                                      showTimer = false;
                                    });
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: Colors.blue.withOpacity(0.5),
                                  child: Center(
                                    child: Container(
                                      height: 300,
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                Material(
                                                    child: Switch(
                                                        value: isTimed,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isTimed = value;
                                                            print(isTimed);
                                                          });
                                                        })),
                                                Text(
                                                    "Đã hẹn giờ tắt: ${secondGV.toString()} phút"),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              color: Colors.white,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Material(
                                                      child: TextField(
                                                        controller: text,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        if ((text.text !=
                                                                null &&
                                                            text.text != "")) {
                                                          secondGV = int.parse(
                                                              text.text);
                                                          if (this.mounted) {
                                                            setState(() {
                                                              isTimed = true;
                                                              showTimer = false;
                                                            });
                                                          }
//                                                           MTimer.seconds =
//                                                               int.parse(
//                                                                   text.text);
// //                                                           MTimer().count(() {
// //                                                             if (this.mounted) {
// //                                                               setState(() {
// //                                                                 if (secondGV >
// //                                                                     0) {
// //                                                                   secondGV--;
// //                                                                   print(
// //                                                                       secondGV);
// //                                                                 } else {
// //                                                                   MTimer.timer
// //                                                                       .cancel();

//                                                                   BlocProvider.of<
//                                                                               MediaPlayerCubit>(
//                                                                           context)
//                                                                       .pause();

//                                                                   if (this
//                                                                       .mounted) {
//                                                                     setState(
//                                                                         () {
//                                                                       isTimed =
//                                                                           false;
//                                                                     });
//                                                                   }
//                                                                 }
//                                                               });
//                                                             }
//                                                           });
// //
                                                          if (secondGV > 0) {
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds:
                                                                        secondGV),
                                                                () {
                                                              BlocProvider.of<
                                                                          MediaPlayerCubit>(
                                                                      context)
                                                                  .pause();
                                                              if (this
                                                                  .mounted) {
                                                                setState(() {
                                                                  isTimed =
                                                                      false;
                                                                });
                                                              }
                                                            });
                                                          }
                                                          Timer.periodic(
                                                              Duration(
                                                                  seconds: 1),
                                                              (value) {
                                                            if (this.mounted) {
                                                              setState(() {
                                                                if (secondGV >
                                                                    0) {
                                                                  secondGV--;
                                                                  print(
                                                                      secondGV);
                                                                } else {
                                                                  value
                                                                      .cancel();
                                                                }
                                                              });
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: Text("Hẹn giờ"),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                  ]),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class OptionMenu extends StatefulWidget {
  Function callback;
  OptionMenu({this.callback});
  @override
  _OptionMenuState createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                loop = !loop;
              });
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(40, 40)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child:
                Icon(loop == false ? Icons.repeat : Icons.repeat_one, size: 30),
          ),
          TextButton(
            onPressed: () {
              widget.callback();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(40, 40)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Icon(Icons.timer, size: 30),
          ),
          TextButton(
            onPressed: () {
              print('list');
              addSongToPlaylist(
                context,
                idnow,
              );
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(40, 40)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Icon(Icons.playlist_add, size: 30),
          ),
        ],
      ),
    );
  }
}
