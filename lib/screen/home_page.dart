import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                ));
              },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Consumer<ThemeProvider>(
        builder: (_, notifier, __) {
          return Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                  fixedSize: Size(size.width * 0.7, size.height * 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  side: BorderSide(
                    width: 5,
                    color: notifier.isDark ? Colors.white : Colors.grey,
                  )
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GamePage()));
                },
                child: const Text('4WORDS WORDLE',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic
                ),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      fixedSize: Size(size.width * 0.7, size.height * 0.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      side: BorderSide(
                        width: 5,
                        color: notifier.isDark ? Colors.white : Colors.grey,
                      )
                  ),
                  onPressed: (){
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GamePage()));
                    print('now implement');
                  },
                  child: const Text('5WORDS WORDLE',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic
                  ),),
                ),
              ),

            ],
          ),
        );
        },
      ),
    );
  }
}
