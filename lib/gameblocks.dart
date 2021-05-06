import 'dart:async';
import 'dart:math';

import 'package:flutris/blocks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'sub_block.dart';

enum Collision { LANDED, LANDED_BLOCK, HITWALL, HIYBLOCK, NONE }

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
  bool isgameover = false;
  double subBlockWidth;
  Duration duration = Duration(milliseconds: RefreshRate);
  GlobalKey _keyGamearea = GlobalKey();

  BlockMovement action;
  Timer timer;
  Blocks blocks;

  List<SubBlock> oldsubblocks;

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

  void updateScore() {
    var combo = 1;
    Map<int, int> rows = Map();
    List<int> rowstoberemoved = List();
    oldsubblocks?.forEach((sb) {
      rows.update(sb.y, (value) => ++value, ifAbsent: () => 1);
    });
    rows.forEach((rownum, count) {
      if (count == Blocks_X) {
        Provider.of<Data>(context, listen: false).addScore(combo++);
        rowstoberemoved.add(rownum);
      }
    });
    if (rowstoberemoved.length > 0) {
      removeRows(rowstoberemoved);
    }
  }

  void removeRows(List<int> rm) {
    rm.sort();
    rm.forEach((rownum) {
      oldsubblocks.removeWhere((s) => s.y == rownum);
      oldsubblocks.forEach((sb) {
        if (sb.y < rownum) {
          ++sb.y;
        }
      });
    });
  }

  void startGame() {
    oldsubblocks = List<SubBlock>();
    Provider.of<Data>(context, listen: false).setisPlaying(true);
    isgameover = false;
    Provider.of<Data>(context, listen: false).setscore(0);
    RenderBox renderBoxGame = _keyGamearea.currentContext.findRenderObject();
    subBlockWidth =
        (renderBoxGame.size.width - GAME_AREA_BORDER_WIDTH * 2) / Blocks_X;
    Provider.of<Data>(context, listen: false).setNextblock(getNewBlock());
    blocks = getNewBlock();

    timer = Timer.periodic(duration, onPlay);
  }

  void endGame() {
    Provider.of<Data>(context, listen: false).setisPlaying(false);
    timer.cancel();
  }

//TODO = problem on L BLock
  void onPlay(Timer timer) {
    var status = Collision.NONE;
    setState(() {
      if (action != null) {
        if (!checkOnEdge(action)) {
          blocks.move(action);
        }
      }

      for (var oldsb in oldsubblocks) {
        for (var sb in blocks.subBlocks) {
          var x = blocks.x + sb.x;
          var y = blocks.y + sb.y;
          if (x == oldsb.x && y == oldsb.y) {
            switch (action) {
              case BlockMovement.LEFT:
                blocks.move(BlockMovement.RIGHT);
                break;
              case BlockMovement.RIGHT:
                blocks.move(BlockMovement.LEFT);
                break;
              case BlockMovement.ROTATECLK:
                blocks.move(BlockMovement.ROTATECOUNTERCLK);
                break;
              default:
                break;
            }
          }
        }
      }

      if (!checkAtBottom()) {
        if (!checkBlockabove()) {
          blocks.move(BlockMovement.DOWN);
        } else {
          status = Collision.LANDED_BLOCK;
        }
      } else {
        status = Collision.LANDED;
      }
      if (status == Collision.LANDED_BLOCK && blocks.y < 0) {
        isgameover = true;
        endGame();
      }
      if (status == Collision.LANDED || status == Collision.LANDED_BLOCK) {
        blocks.subBlocks.forEach((sb) {
          sb.x += blocks.x;
          sb.y += blocks.y;
          oldsubblocks.add(sb);
        });
        blocks = Provider.of<Data>(context, listen: false).nextbloc;
        Provider.of<Data>(context, listen: false).setNextblock(getNewBlock());
      }
      action = null;
      updateScore();
    });
  }

  bool checkAtBottom() {
    return blocks.y + blocks.height == Blocks_Y;
  }

  bool checkOnEdge(BlockMovement action) {
    return (action == BlockMovement.LEFT && blocks.x <= 0) ||
        (action == BlockMovement.RIGHT && blocks.x + blocks.width >= Blocks_X);
  }

  bool checkBlockabove() {
    for (var oldblock in oldsubblocks) {
      for (var subblock in blocks.subBlocks) {
        var x = blocks.x + subblock.x;
        var y = blocks.y + subblock.y;
        if (x == oldblock.x && y + 1 == oldblock.y) {
          return true;
        }
      }
    }
    return false;
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
    oldsubblocks?.forEach((oldblock) {
      subblocks.add(getPosContainer(oldblock.color, oldblock.x, oldblock.y));
    });
    if (isgameover) {
      subblocks.add(getGameoverrect());
    }
    return Stack(children: subblocks);
  }

  Widget getGameoverrect() {
    return Positioned(
        left: subBlockWidth * 1.0,
        top: subBlockWidth * 6.0,
        child: Container(
          height: subBlockWidth * 3,
          width: subBlockWidth * 8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text(
            'Game Over',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          action = BlockMovement.RIGHT;
        } else {
          action = BlockMovement.LEFT;
        }
      },
      onTap: () {
        action = BlockMovement.ROTATECLK;
      },
      child: AspectRatio(
        key: _keyGamearea,
        aspectRatio: Blocks_X / Blocks_Y,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: GAME_AREA_BORDER_WIDTH, color: Colors.indigo),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: drawBlock(),
        ),
      ),
    );
  }
}
