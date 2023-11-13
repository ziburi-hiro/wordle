import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class RandomWordTestPage extends StatefulWidget {
  const RandomWordTestPage({super.key});

  @override
  State<RandomWordTestPage> createState() => _RandomWordTestPageState();
}

class _RandomWordTestPageState extends State<RandomWordTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('RANDOMWORDTESTMODE'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Text(index.toString()),
              );
            },
            itemCount: 10,
            viewportFraction: 1,
            //itemWidth: MediaQuery.of(context).size.width * 0.5,
            //itemHeight: MediaQuery.of(context).size.height * 0.5,
            layout: SwiperLayout.DEFAULT,
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.green,
                color: Colors.grey,
                activeSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
