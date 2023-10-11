import 'package:flutter/material.dart';

class StaticsPage extends StatefulWidget {
  const StaticsPage({Key? key}) : super(key: key);

  @override
  State<StaticsPage> createState() => _StaticsPageState();
}

class _StaticsPageState extends State<StaticsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('STATICS'),
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(text: '4WORDS',),
              Tab(text: '5WORDS',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.orangeAccent,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        )
      ),
    );
  }
}
