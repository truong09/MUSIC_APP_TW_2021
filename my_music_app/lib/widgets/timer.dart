// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:my_music_app/comon_variable.dart';
// import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
// import 'package:my_music_app/features/stream/timer.dart';

// import '../injection_container.dart';

// String _printDuration(Duration duration) {
//   String twoDigits(int n) => n.toString().padLeft(2, "0");
//   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//   return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
// }

// change() {
//   return isTimed = !isTimed;
// }

// class MTimer extends StatefulWidget {
//   @override
//   _MTimerState createState() => _MTimerState();
// }

// class _MTimerState extends State<MTimer> {
//   TextEditingController text = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
//       ],
//       child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
//         builder: (context, mediaPlayerState) {
//           var _playCallback = () async {
//             print('play tap');
//           };

//           var _pauseCallback = () {
//             BlocProvider.of<MediaPlayerCubit>(context).pause();
//             print('pause tap');
//           };
//           return 
//         },
//       ),
//     );
//   }
// }
