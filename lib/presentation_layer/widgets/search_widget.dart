import 'package:flutter/material.dart';
import '../../data/models/tracks_model.dart';

class SongSearchDelegate extends SearchDelegate<String> {
  final List<Data> allSongs; // All songs to filter from

  SongSearchDelegate( this.allSongs);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {

    final filteredSongs = allSongs
        .where((song) => song.title?.toLowerCase().startsWith(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: filteredSongs.length,
      itemBuilder: (context, index) {
        final song = filteredSongs[index];
        return ListTile(
          title: Text(song.title.toString()),
          onTap: () {
            close(context, '');
          },
        );
      },
    );
  }
}
