import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';

class TestResultBox extends StatefulWidget {
  const TestResultBox({super.key});

  @override
  State<TestResultBox> createState() => _TestResultBoxState();
}

class _TestResultBoxState extends State<TestResultBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: AlertDialog(
        content: Consumer<Controller>(
          builder: (_ , notifier, __) {
            return SizedBox(
              width: size.width*0.8,
              height: size.height*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Test Result',style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Your score is ...',style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('${notifier.testCounter} out of ${notifier.tapButtonList.length}',style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900
                            ),),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('questions correct!!',style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900
                            ),),
                          ),
                        ),

                        notifier.testCounter/notifier.tapButtonList.length > 0.6 ?
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Great!!',style: TextStyle(
                              color: Colors.red,
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),),
                          ),
                        ) :
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Try Harder!!',style: TextStyle(
                              color: Colors.red,
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: size.width*0.7,
                      height: size.height*0.08,
                      child: ElevatedButton(
                        onPressed: (){
                          notifier.testReset();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        child: Text('Back to CheckList',style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
