import 'package:flutris/gameblocks.dart';
import 'package:flutris/next_block.dart';
import 'package:flutris/widgets/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocks.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<GameBlocksState> _keyGame = GlobalKey();
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
                      child: GameBlocks(key: _keyGame)),
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
                            onPressed: () {
                              Provider.of<Data>(context, listen: false)
                                      .isPlaying
                                  ? _keyGame.currentState.endGame()
                                  : _keyGame.currentState.startGame();
                            },
                            child: Text(
                                Provider.of<Data>(
                                  context,
                                ).isPlaying
                                    ? 'End'
                                    : 'Start',
                                style: TextStyle(fontSize: 18)),
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

class Data with ChangeNotifier {
  int score = 0;
  bool isPlaying = false;
  Blocks nextbloc;
  void setscore(score) {
    this.score = score;
    notifyListeners();
  }

  void addScore(score) {
    this.score += score;
    notifyListeners();
  }

  void setisPlaying(isPlaying) {
    this.isPlaying = isPlaying;
    notifyListeners();
  }

  void setNextblock(Blocks nxtblock) {
    this.nextbloc = nxtblock;
    notifyListeners();
  }

  Widget getNxtBlocksWidget() {
    if (!isPlaying) {
      return Container();
    }
    var width = nextbloc.width;
    var height = nextbloc.height;
    var color;
    List<Widget> columns = [];
    for (var y = 0; y < height; y++) {
      List<Widget> rows = [];
      for (var x = 0; x < width; x++) {
        if (nextbloc.subBlocks.where((sb) => sb.x == x && sb.y == y).length >
            0) {
          color = nextbloc.color;
        } else {
          color = Colors.transparent;
        }
        rows.add(Container(
          width: 12,
          height: 12,
          color: color,
        ));
      }
      columns.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: columns,
    );
  }
}
