import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {},
                  child: Text('English'),
                ),
              ),
              Icon(
                Icons.compare_arrows_sharp,
                size: 18,
              ),
              Expanded(
                  child: Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Spanish'),
                ),
              ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text("Translate for English"),
          SizedBox(height: 9),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it
          ),
          SizedBox(height: 12),
          Text("Translate to Spanish"),
          SizedBox(height: 9),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it
          ),
        ],
      ),
    );
  }
}
