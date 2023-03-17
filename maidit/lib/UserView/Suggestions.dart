// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import '../../Controller/MaidFirebaseService.dart';
import '../model/MaidModel.dart';
import '../widgets/Bloc/SuggestionBloc.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  List<Maid> randomMaids = [];

  Future<void> getRandomMaids() async {
    MaidFirebaseService md = MaidFirebaseService();
    List<Maid> _randomMaids = await md.getSomeMaids();
    setState(() {
      randomMaids = _randomMaids;
    });
  }

  @override
  void initState() {
    super.initState();
    getRandomMaids();
  }

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
              child: randomMaids.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 10),
                      children: randomMaids
                          .map((maid) => SuggestionBloc(maid: maid))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
