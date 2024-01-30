import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/models/tracks_model.dart';
import '../data/service.dart';

class SongsProvider extends ChangeNotifier {
  List<Data>? _trackList;
  List<bool>? _isPlayingList;
  AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;

  int? get currentlyPlayingIndex => _currentlyPlayingIndex;
  List<Data>? get trackList => _trackList;
  List<bool>? get isPlayingList => _isPlayingList;
  Duration get totalDuration => _totalDuration;
  Timer? _positionTimer;

  Future<void> getData() async {
    _trackList = await SongsService().fetchData();
    _isPlayingList = List.generate(_trackList!.length, (index) => false);

    notifyListeners();
  }

  Duration _currentPosition = Duration.zero;
  Duration get currentPosition => _currentPosition;
  Duration _totalDuration = Duration.zero;
  void shuffleSongs() {
    _trackList?.shuffle();
    notifyListeners();
  }
  void playPause(List<Data>? trackList, List<bool>? isPlayingList, int index) {
    if (_currentlyPlayingIndex != null && _currentlyPlayingIndex != index) {
      _audioPlayer.stop();
      isPlayingList![_currentlyPlayingIndex!] = false;
      notifyListeners();
    }

    isPlayingList![index] = !isPlayingList[index];
    _currentlyPlayingIndex = isPlayingList[index] ? index : null;

    if (isPlayingList[index]) {
      _audioPlayer.play(UrlSource(trackList![index].preview!));
      _currentlyPlayingIndex = index;

      _audioPlayer.onPlayerComplete.listen((event) {
        if (_currentlyPlayingIndex != null) {
          isPlayingList[_currentlyPlayingIndex!] = false;
          notifyListeners();
          if (_currentlyPlayingIndex! < trackList!.length - 1) {
            playPause(trackList, isPlayingList, _currentlyPlayingIndex! + 1);
          }
        }
      });

      _audioPlayer.onPositionChanged.listen((Duration position) {
        _currentPosition = position;
        notifyListeners();
      });

      _audioPlayer.onDurationChanged.listen((Duration duration) {
        _totalDuration = duration;
        notifyListeners();
      });
    } else {
      _audioPlayer.pause();
      _currentlyPlayingIndex = index;
    }

    notifyListeners();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);

    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.resume();
    } else if (_audioPlayer.state == PlayerState.paused) {
      await _audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    super.dispose();
  }
}
