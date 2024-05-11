import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galano_final_project/models/song.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchLyric = TextEditingController();
  static List<Song> songList = [
    Song(songId: 12345, title: "Fallen", artist: "Lola Amour"),
  ];
  int numberOfResults = songList.length;

  Map<String, String> headers = {
    'X-RapidAPI-Key': '57f1fbaf59mshbefe6f1c5f28d6fp12ddd7jsnedb955315929',
    'X-RapidAPI-Host': 'genius-song-lyrics1.p.rapidapi.com',
  };

  void searchSong(String input) async {
    // print("test");
    songList.clear();
    if (searchLyric.text.isEmpty || searchLyric.text == "") {
      print('no input');
      return;
    }
    //url for searching
    String url =
        'https://genius-song-lyrics1.p.rapidapi.com/search/?q=$input&per_page=10&page=1';

    try {
      // Search song (GET)
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> hits = jsonData['hits'];
        print("NUMBER OF ITEMS (HITS): ");
        print(hits.length);
        setState(() {
          numberOfResults = hits.length;

          for (int i = 0; i < hits.length; i++) {
            print(jsonData['hits'][i]['result']['full_title']);
            songList.add(
              Song(
                songId: jsonData['hits'][i]['result']['id'],
                title: jsonData['hits'][i]['result']['full_title'],
                artist: jsonData['hits'][i]['result']['artist_names'],
              ),
            );
          }
        });
      } else {
        print(
            'Request to search for songs failed with status: ${response.statusCode}');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Connection error.")));
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An error occurred. Please try again later.")));
    }
  }

  void getLyrics(int songId) async {
    //url for getting the lyrics
    String lyricsUrl =
        'https://genius-song-lyrics1.p.rapidapi.com/song/lyrics/?id=$songId';
    //Get song lyrics
    final responseLyrics =
        await http.get(Uri.parse(lyricsUrl), headers: headers);

    if (responseLyrics.statusCode == 200) {
      final jsonData = jsonDecode(responseLyrics.body);
      print("LYRICS!!!!");
    } else {
      print(
          'Request to get lyrics failed with status: ${responseLyrics.statusCode}');
    }
  }

//bakbakan na
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //serach bar
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    onSubmitted: (value) {
                      searchSong(value);
                    },
                    controller: searchLyric,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        label: const Text("Search"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                searchSong(searchLyric.text);
                              },
                              icon: const Icon(Icons.search)),
                        )),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Expanded(
            child: ListView.builder(
              itemCount: numberOfResults,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: const Color(0xffE8E8E8),
                    child: ListTile(
                      onTap: () => getLyrics(songList[index].songId),
                      title: Text(
                        songList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(songList[index].artist),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
