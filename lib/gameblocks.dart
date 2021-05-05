import 'dart:async';
import 'dart:math';

import 'package:flutris/blocks.dart';
import 'package:flutter/material.dart';

const Blocks_X = 10;
const Blocks_Y = 20;
const RefreshRate = 300;
const GAME_AREA_BORDER_WIDTH = 2.0;
const SUB_BLOCK_E_WIDTH = 2.0;

class GameBlocks extends StatefulWidget {
  GameBlocks({Key key}) : super(key: key);
  @override
  GameBlocksState createState() => GameBlocksState();
}

class GameBlocksState extends State<GameBlocks> {
  double subBlockWidth;
  Duration duration = Duration(milliseconds: RefreshRate);
  GlobalKey _keyGamearea = GlobalKey();
  Timer timer;
  Blocks blocks;
  bool isPLaying = false;

  Blocks getNewBlock() {
    int blockType = Random().nextInt(7);
    int orientationindex = Random().nextInt(4);
    switch (blockType) {
      case 0:
        return IBlock(orientationindex);
      case 1:
        return JBlock(orientationindex);
      case 2:
        return LBlock(orientationindex);
      case 3:
        return OBlock(orientationindex);
      case 4:
        return TBlock(orientationindex);
      case 5:
        return SBlock(orientationindex);
      case 6:
        return TBlock(orientationindex);
      default:
        return null;
    }
  }

  void startGame() {
    isPLaying = true;
    RenderBox renderBoxGame = _keyGamearea.currentContext.findRenderObject();
    subBlockWidth =
        (renderBoxGame.size.width - GAME_AREA_BORDER_WIDTH * 2) / Blocks_X;
    blocks = getNewBlock();

    timer = Timer.periodic(duration, onPlay);
  }

  void endGame() {
    isPLaying = false;
    timer.cancel();
  }

  void onPlay(Timer timer) {
    setState(() {
      blocks.move(BlockMovement.DOWN);
    });
  }

  Widget getPosContainer(Color color, int x, int y) {
    return Positioned(
      left: x * subBlockWidth,
      top: y * subBlockWidth,
      child: Container(
        width: subBlockWidth - SUB_BLOCK_E_WIDTH,
        height: subBlockWidth - SUB_BLOCK_E_WIDTH,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(const Radius.circular(3.0))),
      ),
    );
  }

  Widget drawBlock() {
    if (blocks == null) return null;
    List<Positioned> subblocks = List();
    blocks.subBlocks.forEach((sb) {
      subblocks
          .add(getPosContainer(sb.color, sb.x + blocks.x, sb.y + blocks.y));
    });
    return Stack(children: subblocks);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      key: _keyGamearea,
      aspectRatio: Blocks_X / Blocks_Y,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.indigo),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: drawBlock(),
      ),
    );
  }
}
