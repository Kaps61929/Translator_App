import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:translator_app/controller/translator_services.dart';
import 'package:translator_app/model/tranlastemode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late bool chk;
  late Translatemodel model;
  List<dynamic> _all_language = [];
  List<dynamic> _foundUsers = [];
  List<dynamic> _foundlanguage = [];
  String currentlanguage = "";
  String targetlanguage = "";
  fetchlanguage() async {
    _all_language = await fetchlanguages();

    _foundlanguage = _all_language;
    print(_foundlanguage);
  }

  @override
  initState() {
    chk = false;
    model = Translatemodel(q: "", detectlanguage: "");

    fetchlanguage();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _all_language;
    } else {
      results = _all_language
          .where((language) => language['language'].contains(enteredKeyword))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _foundlanguage = results;
    });
  }

  void bottomsheet(BuildContext context, bool chk) {
    //print(_foundUsers[1]['language']);
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: true,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        )),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _foundlanguage.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foundlanguage.length,
                          itemBuilder: (context, index) => Card(
                              key: ValueKey(_foundlanguage[index]["language"]),
                              color: Colors.blue,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  if (chk) {
                                    setState(() {
                                      currentlanguage = _foundlanguage[index]
                                              ["language"]
                                          .toString();
                                    });
                                  } else {
                                    setState(() {
                                      targetlanguage = _foundlanguage[index]
                                              ["language"]
                                          .toString();
                                    });
                                  }
                                },
                                child: ListTile(
                                  leading: Text(
                                    _foundlanguage[index]["language"]
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  title: Text(_foundlanguage[index]['language'],
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            ),
          );
        });
    _foundlanguage = _all_language;
  }

  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              "Text  Translation",
              style: TextStyle(fontSize: 36),
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      bottomsheet(context, true);
                      print(currentlanguage);
                    },
                    child: Text(currentlanguage),
                  ),
                ),
                Icon(
                  Icons.compare_arrows_sharp,
                  size: 18,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      bottomsheet(context, false);
                      //print(targetedlanguage);
                    },
                    child: Text(targetlanguage),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text("Translate for English"),
            SizedBox(height: 9),
            TextField(
              maxLength: 250,

              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: null,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                model = await translate(controller.text, targetlanguage)
                    .then((value) {
                  if (value != Null) {
                    setState(() {
                      chk = true;
                    });
                  }
                  return value;
                });
              },
              child: Text('English'),
            ),
            SizedBox(height: 12),
            Text("Translate to Spanish"),
            SizedBox(height: 9),
            (chk) ? Text("" + model.q) : Text("no working")
          ],
        ),
      ),
    );
  }
}
