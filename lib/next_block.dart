import 'package:flutris/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextBlock extends StatefulWidget {
  @override
  _NextBlockState createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Next',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Provider.of<Data>(context).getNxtBlocksWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
