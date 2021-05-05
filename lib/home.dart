import 'package:flutris/gameblocks.dart';
import 'package:flutris/next_block.dart';
import 'package:flutris/widgets/score.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text('Tetris', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          ScoreBar(),
          Expanded(
              child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                      child: GameBlocks()),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NextBlock(),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child:
                                Text("Start", style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
