import 'package:flutter/material.dart';

class StatsTile extends StatelessWidget {
  const StatsTile({
    super.key, required this.heading, required this.value,
  });

  final String heading;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: const Alignment(0,1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(value.toString(),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 40,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ))
          ),
          Expanded(
              child: FittedBox(
                alignment: const Alignment(0,-1.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(heading,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ))
          )
        ],
      ),
    );
  }
}
