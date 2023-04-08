import 'package:flutter/material.dart';

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
  bool chk2 = false;
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
                      labelText: 'Click here to Search',
                      suffixIcon: Icon(Icons.search)),
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
                              color: Color.fromARGB(255, 58, 58, 58),
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
                                  // leading: Text(
                                  //   _foundlanguage[index]["language"]
                                  //       .toString(),
                                  //   style: const TextStyle(
                                  //       fontSize: 24, color: Colors.white),
                                  // ),
                                  contentPadding: EdgeInsets.only(
                                      left: 18, top: 3, bottom: 3),
                                  title: Text(_foundlanguage[index]['language'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 36)),
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
        backgroundColor: Color.fromARGB(255, 255, 253, 253),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 36),
              Text(
                "Text  Translation",
                style: TextStyle(
                    fontSize: 36,
                    color: Color.fromARGB(255, 77, 76, 76),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 9,
              ),
              Divider(
                color: Color.fromARGB(255, 55, 55, 55),
              ),
              SizedBox(
                height: 21,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  SizedBox(
                    height: 45,
                    width: 145,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color.fromARGB(255, 58, 58, 58),
                            Color.fromARGB(255, 173, 173, 173),
                          ],
                        ),
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(54),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  54), /*side: BorderSide(color: Colors.red)*/
                            ))),
                        onPressed: () {
                          bottomsheet(context, true);
                        },
                        child: (currentlanguage == "")
                            ? Text(
                                "Select",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            : Text(
                                currentlanguage,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.compare_arrows_sharp,
                    size: 36,
                    color: Color.fromARGB(255, 23, 23, 23),
                  ),
                  SizedBox(
                    height: 45,
                    width: 145,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color.fromARGB(255, 58, 58, 58),
                            Color.fromARGB(255, 173, 173, 173),
                          ],
                        ),
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(54),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  54), /*side: BorderSide(color: Colors.red)*/
                            ))),
                        onPressed: () {
                          bottomsheet(context, false);
                          //print(targetedlanguage);
                        },
                        child: (targetlanguage == "")
                            ? Text(
                                "Select",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            : Text(
                                targetlanguage,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 138, bottom: 3, top: 21),
                child: Text(
                  "Translate from (${currentlanguage})",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 9),
              SizedBox(
                //   height: 270,
                width: 300,
                child: TextField(
                  maxLength: 250,
                  // expands: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                      // hintText: hintText,
                      filled: true,
                      fillColor: Color.fromARGB(255, 64, 64, 64),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      ))),
                  keyboardType: TextInputType.multiline,
                  minLines: null, //Normal textInputField will be displayed
                  maxLines: null,
                  controller: controller,
                ),
              ),
              SizedBox(
                height: 45,
                width: 210,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Color.fromARGB(255, 58, 58, 58),
                        Color.fromARGB(255, 173, 173, 173),
                      ],
                    ),
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(54),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              54), /*side: BorderSide(color: Colors.red)*/
                        ))),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('wait a while loading data may take time')));
                      model = await translate(controller.text, targetlanguage)
                          .then((value) {
                        if (value != Null) {
                          setState(() {
                            chk = true;
                            // chk2 = true;
                          });
                        }
                        return value;
                      });
                    },
                    child: Text('Translate',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 27),
              // Text("Translate to Spanish"),
              // SizedBox(height: 9),
              // (chk) ? Text("" + model.q) : Text("no working")
              (chk)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 3),
                          child: Text(
                            "Translate to (${targetlanguage})",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            height: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "" + model.q,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 27),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 64, 64, 64),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                )),
                          ),
                        ),
                      ],
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
