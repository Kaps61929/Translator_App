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
  bool chk = false;
  Translatemodel model = Translatemodel(q: "", detectlanguage: "");
  var targetedlanguage;
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
                      translate("asd", "alksd");
                    },
                    child: Text('English'),
                  ),
                ),
                Icon(
                  Icons.compare_arrows_sharp,
                  size: 18,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Spanish'),
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
              onSubmitted: (value) async {
                print(value);

                model = await translate(value, "es").then((value) {
                  if (value != Null) {
                    setState(() {
                      chk = true;
                    });
                  }
                  return value;
                });
              },

              // keyboardType: TextInputType.multiline,
              // minLines: 1, //Normal textInputField will be displayed
              // maxLines: null,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            Text("Translate to Spanish"),
            SizedBox(height: 9),
            (chk) ? Text("" + model!.q) : Text("no working")
          ],
        ),
      ),
    );
  }
}
