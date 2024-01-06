import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isPlayingList = List.generate(30, (index) => false);
  late List<String> songs;
  late List<String> songName;
  List<String> songTimes = List.generate(30, (index) {
    var doubleValue = Random().nextDouble() * 2 + 2;
    // Keep only the first two digits after the decimal point
    return doubleValue.toStringAsFixed(2);
  });

  @override
  void initState() {
    super.initState();
    // Initialize your song lists here
    songs = List.generate(30, (index) => 'Song ${index + 1}');
    songName = List.generate(30, (index) => 'SongName ${index + 1}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songs"),
        actions: [
          IconButton(
            onPressed: () async {
              final selectedSong = await showSearch<String>(
                context: context,
                delegate: SongSearchDelegate(songs),
              );

              if (selectedSong != null) {
                // Handle the selected song
                print("Selected Song: $selectedSong");
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _buildSongList(),
    );
  }

  Widget _buildSongList() {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              CircleAvatar(

                backgroundColor: isPlayingList[index] ? Colors.pinkAccent : Colors.white,
                child: IconButton(
                  icon: Icon(
                    isPlayingList[index] ? Icons.pause : Icons.play_arrow,
                    color: isPlayingList[index] ?Colors.white : Colors.pinkAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      isPlayingList[index] = !isPlayingList[index];
                    });
                    // Handle play/pause action for the specific item at index
                  },
                ),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songs[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    songName[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Text(
            songTimes[index],
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        );
      },
    );
  }
}


