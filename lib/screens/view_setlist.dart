import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galano_final_project/models/setlist.dart';
import 'package:galano_final_project/screens/homepage.dart';
import 'package:galano_final_project/screens/lyrics.dart';
import 'package:galano_final_project/screens/search_screen.dart';
import 'package:gap/gap.dart';

class ViewSetlistScreen extends StatefulWidget {
  ViewSetlistScreen({super.key, required this.setlist});

  final Setlist setlist;

  @override
  State<ViewSetlistScreen> createState() => _ViewSetlistScreenState();
}

class _ViewSetlistScreenState extends State<ViewSetlistScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "GigLyric",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding: const EdgeInsets.only(right: 10),
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
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.075),
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.setlist.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: const Color(0xfff4f4f4),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(newIndex: 2),
                    ));
                  },
                  leading: const Icon(Icons.add),
                  title: const Text(
                    'Add song',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.setlist.songs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      color: const Color(0xffE8E8E8),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LyricsScreen(),
                          ));
                        },
                        title: Text(
                          widget.setlist.songs[index].title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.setlist.songs[index].artist),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
