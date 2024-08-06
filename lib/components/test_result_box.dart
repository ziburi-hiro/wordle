import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Consumer<Controller>(
          builder: (_ , notifier, __) {
            return SizedBox(
              width: size.width*0.8,
              height: size.height*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('単語テスト結果',style: GoogleFonts.yuseiMagic(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900,
                    ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: size.height*0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          notifier.testCounter/notifier.tapButtonList.length > 0.6 ?
                          Lottie.asset(
                              'assets/images/Great.json',
                              errorBuilder: (context, error, stackTrace) {
                                return const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(),
                                );
                              }
                          ) :
                          Container(
                            height: size.height*0.2,
                            child: Lottie.asset(
                                'assets/images/bad.json',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(),
                                  );
                                }
                            ),
                          ),

                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('${(notifier.testCounter/notifier.tapButtonList.length*100).ceil().toString()}点',style: GoogleFonts.yuseiMagic(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900
                            ),),
                          ),

                          Text('正解数：${notifier.testCounter}問(全${notifier.tapButtonList.length}問)',style: GoogleFonts.yuseiMagic(

                          ),),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height*0.08,
                    child: notifier.testCounter/notifier.tapButtonList.length > 0.6 ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('素晴らしい!',style: GoogleFonts.yuseiMagic(
                          color: Colors.red,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                    ) :
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('もう少し...',style: GoogleFonts.yuseiMagic(
                          color: Colors.red,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: size.width*0.7,
                      height: size.height*0.07,
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
                        child: Text('単語帳へ戻る',style: GoogleFonts.yuseiMagic(
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
