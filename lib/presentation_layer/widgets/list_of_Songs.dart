import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import '../../data/models/tracks_model.dart';
import '../../data/service.dart';
import '../../service/provider.dart';
import '../screens/playing_now.dart';

class ListOfSongs extends StatefulWidget {
  List<Data>? trackList;
  List<bool>? isPlayingList;

  ListOfSongs({Key? key, this.trackList, this.isPlayingList}) : super(key: key);

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  int? currentlyPlayingIndex;
  AudioPlayer audioPlayer = AudioPlayer();
  late List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, child) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: widget.trackList?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: songsProvider.isPlayingList![index]
                            ? Colors.pinkAccent
                            : Colors.white,
                        child: IconButton(
                          icon: Icon(
                            songsProvider.isPlayingList![index]
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: songsProvider.isPlayingList![index]
                                ? Colors.white
                                : Colors.pinkAccent,
                          ),
                          onPressed: () {
                            songsProvider.playPause(
                                widget.trackList, widget.isPlayingList, index);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.trackList![index].title.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.trackList![index].artist!.name.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    formatDuration(widget.trackList![index].duration!.toInt()),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () {
                    songsProvider.playPause(
                        widget.trackList, widget.isPlayingList, index);
                  },
                );
              },
            ),

            Positioned(
              left: 5,
              right: 5,
              bottom: 4,
              child: Container(
                height: 70,
                width: 40,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    transform: GradientRotation(1),
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF9D9DA0).withOpacity(0.9),
                      Color(0xFF3B3B3B),
                      Color(0xFF3B3B3B),
                      Color(0xFF3B3B3B),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 2,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayNowScreen(),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network('https://media.npr.org/assets/img/2013/06/17/davidblack-ca8a5d8bac16559aadf019c79f37450f57d3ed51-s1100-c50.jpg')
                          ),
                          title: Text(
                            widget.trackList![songsProvider.currentlyPlayingIndex ?? 0].title
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                    Icons.pause, color: Colors.white),
                                onPressed: () {
                                  if (widget
                                      .isPlayingList![songsProvider.currentlyPlayingIndex!] &&
                                      widget.isPlayingList != null) {
                                    songsProvider.playPause(
                                        widget.trackList,
                                        widget.isPlayingList,
                                        songsProvider.currentlyPlayingIndex!);
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                    Icons.skip_next, color: Colors.white),
                                onPressed: () {
                                  songsProvider.playPause(
                                      widget.trackList,
                                      widget.isPlayingList,
                                      songsProvider.currentlyPlayingIndex!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.transparent,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatDuration(int duration) {
    int minutes = (duration ~/ 60);
    int seconds = (duration % 60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}