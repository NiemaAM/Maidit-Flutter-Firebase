// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../widgets/Bloc/SuggestionBloc.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Suggestions pour vous",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16),
                      )),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                    padding: const EdgeInsets.only(top: 10, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "voir plus",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 340,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10),
                children: const [
                  SuggestionBloc(),
                  SuggestionBloc(),
                  SuggestionBloc(),
                  SuggestionBloc(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
