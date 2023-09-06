import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.centerRight,
              onPressed: (){},
              icon: Icon(Icons.clear)
          ),
          Expanded(
              child: Text('STATISTICS',textAlign: TextAlign.center,)
          ),
        ],
      ),
    );
  }
}
