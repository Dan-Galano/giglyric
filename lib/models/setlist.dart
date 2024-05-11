import 'package:galano_final_project/models/song.dart';

class Setlist {
  int id;
  String name;
  String date;
  List<Song> songs;

  Setlist({
    required this.id,
    required this.name,
    required this.date,
    this.songs = const [],
  });
}