import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/music_player/bottom_bar.dart';
import 'package:my_music_app/music_player/progress_bar.dart';
import 'package:my_music_app/music_player/top_bar.dart';
import 'package:my_music_app/widgets/add_new_playlist.dart';
import 'package:my_music_app/widgets/add_song_to_playList.dart';

String idnow;

class MusicPlayer extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
          builder: (context, mediaPlayerState) {
        idnow = mediaPlayerState.audioTrack.id;
        return MaterialApp(
          home: Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     'assets/dali.png',
                  //   ),
                  //   fit: BoxFit.cover,
                  // )
                ),
                // color: theme.colorScheme.primaryVariant,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(children: [
                            SizedBox(height: 8),
                            Stack(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.9,
                                  // child: Image.asset(
                                  //   'assets/dali.png',
                                  // ),
                                ),
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
                                            color:
                                                Colors.black.withOpacity(0.7),
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
                            SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    mediaPlayerState.audioTrack?.title ??
                                        'no selected track',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    mediaPlayerState.audioTrack?.author ??
                                        'no selected track',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: theme.hintColor),
                                  ),
                                ),
                              ],
                            ),
                            ProgressBar(),
                            OptionMenu(),
                          ]),
                        ),
                      ),
                      BottomBar(),
                    ],
                  ),
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
              print('loop');
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(40, 40)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Icon(Icons.repeat, size: 30),
          ),
          TextButton(
            onPressed: () {
              print('timer');
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
