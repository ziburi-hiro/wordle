import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class RuleBox extends StatefulWidget {
  const RuleBox({super.key});

  @override
  State<RuleBox> createState() => _RuleBoxState();
}

class _RuleBoxState extends State<RuleBox> {

  List<Widget> list = [Text('11'),Text('22'),Text('33')];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      content: SizedBox(
        width: size.width*0.9,
        height: size.height*0.7,
        child: Column(
          children: [
            Text('Game Rule',style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),

            SizedBox(
              height: 10,
            ),

            Container(
              height: size.height*0.57,
              color: Colors.grey,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Step 1',style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  );
                },
                loop: false,
                itemCount: 3,
                viewportFraction: 1,
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

            SizedBox(
              height: 10,
            ),

            Container(
              width: size.width*0.5,
              height: size.height*0.07,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text('Close',style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
