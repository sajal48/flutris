import 'package:flutter/material.dart';

import 'sub_block.dart';

enum BlockMovement { UP, DOWN, LEFT, RIGHT, ROTATECLK, ROTATECOUNTERCLK }

class Blocks {
  List<List<SubBlock>> oriantations = List<List<SubBlock>>();
  int x;
  int y;
  int orientationindex;
  Blocks(this.oriantations, Color color, this.orientationindex) {
    x = 3;
    y = -width;
    this.color = color;
  }

  set color(Color color) {
    oriantations.forEach((orientation) {
      orientation.forEach((subBlock) {
        subBlock.color = color;
      });
    });
  }

  get color {
    return oriantations[0][0].color;
  }

  get subBlocks {
    return oriantations[orientationindex];
  }

  get width {
    int maxX = 0;
    subBlocks.forEach((subBlocks) {
      if (subBlocks.x > maxX) maxX = subBlocks.x;
    });
    return maxX + 1;
  }

  get height {
    int maxY = 0;
    subBlocks.forEach((subBlocks) {
      if (subBlocks.y > maxY) maxY = subBlocks.y;
    });
    return maxY + 1;
  }

  void move(BlockMovement blockMovement) {
    switch (blockMovement) {
      case BlockMovement.UP:
        y -= 1;
        break;
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.ROTATECLK:
        orientationindex = ++orientationindex % 4;
        break;
      case BlockMovement.ROTATECOUNTERCLK:
        orientationindex = (orientationindex + 3) % 4;
        break;
    }
  }
}

class IBlock extends Blocks {
  IBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 0, y: 2),
            SubBlock(x: 0, y: 3),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 3, y: 0),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 0, y: 2),
            SubBlock(x: 0, y: 3),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 3, y: 0),
          ],
        ], Colors.red[400], orientationindex);
}

class JBlock extends Blocks {
  JBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
            SubBlock(x: 0, y: 2),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 0, y: 2),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 2, y: 1),
          ]
        ], Colors.yellow[400], orientationindex);
}

class LBlock extends Blocks {
  LBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 0, y: 2),
            SubBlock(x: 1, y: 2),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
          ],
          [
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ]
        ], Colors.green[400], orientationindex);
}

class OBlock extends Blocks {
  OBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
          ],
          [
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ]
        ], Colors.blue[400], orientationindex);
}

class TBlock extends Blocks {
  TBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 1, y: 1),
          ],
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
          ],
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 0, y: 2),
          ]
        ], Colors.pink[400], orientationindex);
}

class SBlock extends Blocks {
  SBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
          ],
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 2, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 1, y: 2),
          ]
        ], Colors.orange[400], orientationindex);
}

class ZBlock extends Blocks {
  ZBlock(int orientationindex)
      : super([
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ],
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 0, y: 2),
          ],
          [
            SubBlock(x: 0, y: 0),
            SubBlock(x: 1, y: 0),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 2, y: 1),
          ],
          [
            SubBlock(x: 1, y: 0),
            SubBlock(x: 0, y: 1),
            SubBlock(x: 1, y: 1),
            SubBlock(x: 0, y: 2),
          ]
        ], Colors.cyan[400], orientationindex);
}
