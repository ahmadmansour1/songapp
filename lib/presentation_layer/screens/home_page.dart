import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/tracks_model.dart';
import '../../service/provider.dart';
import '../widgets/list_of_Songs.dart';
import '../widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data>? trackList;
  List<bool>? isPlayingList;



  @override
  void initState() {
    Provider.of<SongsProvider>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songs"),
        actions: [
          IconButton(
            onPressed: () async {
              final selectedSong = await showSearch<String>(
                context: context,
                delegate: SongSearchDelegate(songsProvider.trackList!),
              );
              if (selectedSong != null) {
                print("Selected Song: $selectedSong");
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: songsProvider.trackList == null
          ? const Center(child: CircularProgressIndicator())
          : ListOfSongs(
        trackList: songsProvider.trackList,
        isPlayingList: songsProvider.isPlayingList,
      ),
    );
  }
}
