import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songapp/service/provider.dart';

import '../../data/models/tracks_model.dart';

class PlayNowScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
        actions: [

        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 120,
            backgroundImage: NetworkImage(
              'https://media.npr.org/assets/img/2013/06/17/davidblack-ca8a5d8bac16559aadf019c79f37450f57d3ed51-s1100-c50.jpg',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  // Handle favorite button tap
                },
                icon: Icon(Icons.favorite),
                label: Text('Follow'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white, // Border color
                  side: BorderSide(color: Colors.white, width: 2.0), // Border width and color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust border radius
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle shuffle button tap
                },
                icon: Icon(Icons.shuffle),
                label: Text('Shuffle'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent, // Customize button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust border radius
                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: 20),
          Text(
            songsProvider.trackList![songsProvider.currentlyPlayingIndex ?? 0].title!,
            style: TextStyle(fontSize: 24 , color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            songsProvider.trackList![songsProvider.currentlyPlayingIndex ?? 0].artist!.name!,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  songsProvider.playPause(songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex! - 1);
                },
                child: const Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.skip_previous, size: 36.0, color: Colors.white),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  // Handle skip backward 3 seconds
                },
                child: const Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_back_ios, size: 36.0, color: Colors.white),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white, // Adjust the color as needed
                radius: 30,
                child: IconButton(
                  icon: Icon(
                    songsProvider.isPlayingList != null ? Icons.pause : Icons.play_arrow,
                    size: 36.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    songsProvider.playPause(songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex ?? 0);
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(70.0),
                onTap: () {
                  // Handle skip forward 3 seconds
                },
                child: const Padding(
                  padding:  EdgeInsets.all(30.0),
                  child: Icon(Icons.arrow_forward, size: 36.0, color: Colors.white),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  songsProvider.playPause(songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex! + 1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.skip_next, size: 36.0, color: Colors.white),
                ),
              ),
            ],
          )




        ],
      ),
    );
  }
}



