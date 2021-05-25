import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/features/media_player/playing_position_cudit/playing_position_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/music_player/music_player.dart';

class MiniBar extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
          builder: (context, mediaPlayerState) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayer(),
                ));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: theme.colorScheme.primaryVariant,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mediaPlayerState.audioTrack?.title ?? '',
                          style: TextStyle(fontSize: 18),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          mediaPlayerState.audioTrack?.author ??
                              'no selected track',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: theme.hintColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: MiniBottomBar()),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MiniBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
        BlocProvider.value(value: serviceLocator<PlayingPositionCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
          builder: (context, mediaPlayerState) {
        var _playCallback = () async {
          print('play tap');

          BlocProvider.of<MediaPlayerCubit>(context).play();
        };

        var _resumeCallback = () async {
          print('resume tap');

          BlocProvider.of<MediaPlayerCubit>(context).resume();
        };

        var _pauseCallback = () {
          BlocProvider.of<MediaPlayerCubit>(context).pause();
          print('pause tap');
        };

        return BlocBuilder<PlayingPositionCubit, PlayingPositionStateAbstract>(
            builder: (context, playingPositionState) {
          return Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: TextButton(
                    onPressed: mediaPlayerState is MediaPlayerPlayingState
                        ? _pauseCallback
                        : mediaPlayerState is MediaPlayerInitialState ||
                                mediaPlayerState is MediaPlayerStoppedState
                            ? _playCallback
                            : _resumeCallback,
                    child: mediaPlayerState is MediaPlayerPlayingState
                        ? Icon(
                            Icons.pause,
                            color: theme.colorScheme.onPrimary,
                            size: 30,
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: theme.colorScheme.onPrimary,
                            size: 30,
                          ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            theme.colorScheme.secondary),
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('next track');
                    serviceLocator<MediaPlayerCubit>().nextTrack();
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(40, 40)),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: Icon(Icons.skip_next_sharp, size: 30),
                ),
              ],
            )
          ]);
        });
      }),
    );
  }
}