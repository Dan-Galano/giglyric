import 'package:flutter/material.dart';
import 'package:galano_final_project/components/setlist_empty.dart';
import 'package:galano_final_project/data/hive_boxes.dart';
import 'package:galano_final_project/models/setlist.dart';
import 'package:galano_final_project/screens/view_setlist.dart';
import 'package:gap/gap.dart';

class SetlistScreen extends StatefulWidget {
  const SetlistScreen({super.key});

  @override
  State<SetlistScreen> createState() => _SetlistScreenState();
}

class _SetlistScreenState extends State<SetlistScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // setlistBox.clear();
    fetchData();
  }

  List<Setlist> setlist = [];

  Future<void> fetchData() async {
    setlist.clear();
    for (int i = 0; i < setlistBox.length; i++) {
      Setlist item = setlistBox.getAt(i) as Setlist;
      setState(() {
        setlist.add(item);
      });
    }
  }

  Future<void> showNewSetlistDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameCon = TextEditingController();
        final TextEditingController dateCon = TextEditingController();
        return AlertDialog(
          title: const Text(
            'New setlist',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required field.";
                    }
                    return null;
                  },
                  controller: nameCon,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: dateCon,
                  decoration: const InputDecoration(
                    hintText: 'Date',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameCon.clear();
                dateCon.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xffa6a6a6), fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String date;
                  if (dateCon.text.isEmpty || dateCon.text == "") {
                    date = "Unknown date";
                  } else {
                    date = dateCon.text;
                  }
                  setState(() {
                    setlist.add(
                      Setlist(
                        id: setlist.length + 1,
                        name: nameCon.text,
                        date: date,
                        songs: [],
                      ),
                    );
                  });
                  setlistBox.put(
                    setlist.length,
                    Setlist(
                      id: setlist.length,
                      name: nameCon.text,
                      date: date,
                      songs: [],
                    ),
                  );
                  print(setlist.length);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Setlist (${nameCon.text}) has been created.")));
                  fetchData();
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void viewSetlist(BuildContext context, Setlist setlist) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewSetlistScreen(setlist: setlist),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return setlist.isNotEmpty
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
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Setlist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Color(0xfff4f4f4),
                  child: ListTile(
                    onTap: () async => showNewSetlistDialog(context),
                    leading: const Icon(Icons.add),
                    title: const Text(
                      'New setlist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: setlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        color: const Color(0xffE8E8E8),
                        child: ListTile(
                          onTap: () {
                            viewSetlist(context, setlist[index]);
                          },
                          title: Text(
                            setlist[index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(setlist[index].date),
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
                        "Setlist",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                Column(
                  children: [
                    const EmptySetlistScreen(),
                    SizedBox(
                      width: 255,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async => showNewSetlistDialog(context),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff2B2B2B)),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Text(
                          "Create Setlist",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
