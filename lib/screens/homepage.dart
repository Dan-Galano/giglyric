import 'package:flutter/material.dart';
import 'package:galano_final_project/screens/home_screen.dart';
import 'package:galano_final_project/screens/search_screen.dart';
import 'package:galano_final_project/screens/setlist_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.newIndex});

  int? newIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List screens = [
    HomeScreen(),
    SetlistScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    widget.newIndex != null ? currentIndex = widget.newIndex! : currentIndex;
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
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              widget.newIndex = null;
              currentIndex = value;
            });
            // print(value);
          },
          selectedItemColor: const Color(0xff2b2b2b),
          unselectedItemColor: const Color(0xffcecece),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Setlist",
              icon: Icon(Icons.queue_music),
            ),
            BottomNavigationBarItem(
              label: "Search Online",
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
