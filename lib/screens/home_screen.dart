import 'package:flutter/material.dart';
import 'package:galano_final_project/components/home_empty.dart';
import 'package:galano_final_project/data/hive_boxes.dart';
import 'package:galano_final_project/models/lyrics.dart';
import 'package:galano_final_project/screens/lyrics.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchLyrics();
  }

  List<SongLyrics> downloadedSongsList = [];

  Future<void> fetchLyrics() async {
    for (int i = 0; i < lyricsBox.length; i++) {
      SongLyrics songLyrics = lyricsBox.getAt(i) as SongLyrics;
      setState(() {
        downloadedSongsList.add(songLyrics);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(downloadedSongsList);

    return downloadedSongsList.isNotEmpty
        ? Column(
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
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            label: const Text("Search"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search)),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(14),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Lyrics",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: downloadedSongsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        color: const Color(0xffE8E8E8),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LyricsScreen(
                                songLyrics: downloadedSongsList[index],
                              ),
                            ));
                          },
                          title: Text(
                            downloadedSongsList[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(downloadedSongsList[index].artist),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : SingleChildScrollView(
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
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              label: const Text("Search"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(14),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "All Lyrics",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                const EmptyHomeScreen()
              ],
            ),
          );
  }
}
