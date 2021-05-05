import 'package:flutter/material.dart';

const Blocks_X = 10;
const Blocks_Y = 20;

class GameBlocks extends StatefulWidget {
  @override
  _GameBlocksState createState() => _GameBlocksState();
}

class _GameBlocksState extends State<GameBlocks> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Blocks_X / Blocks_Y,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.indigo),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}
