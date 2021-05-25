import 'package:my_music_app/features/audio_track/domain/entities/audio_track.dart';

abstract class AudioTrackRepositoryAbstract {
  Future<AudioTrack> next({int currentTrackIndex});

  Future<AudioTrack> previous(int currentTrackIndex);
}
