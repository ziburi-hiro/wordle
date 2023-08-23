import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index){
          return Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Center(child: Text(index.toString()),),
          );
        }
    );
  }
}
