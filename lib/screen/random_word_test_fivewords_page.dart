import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/test_cancel_box.dart';
import 'package:wordle/components/test_result_box.dart';
import 'package:wordle/constants/five_words_means.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/checkList_preferences_fivewords.dart';

class RandomWordTestFiveWordsPage extends StatefulWidget {
  const RandomWordTestFiveWordsPage({super.key});

  @override
  State<RandomWordTestFiveWordsPage> createState() => _RandomWordTestFiveWordsPageState();
}

class _RandomWordTestFiveWordsPageState extends State<RandomWordTestFiveWordsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('単語テスト',style: GoogleFonts.yuseiMagic(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          actions: [
            Visibility(
              visible: (Provider.of<Controller>(context, listen: false)
                  .tapButtonList
                  .where((element) => element == true)
                  .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length),
              child: IconButton(
                onPressed: (){
                  showDialog(context: context, builder: (_) => const TestResultBox());
                },
                icon: const Icon(Icons.description_outlined),
              ),
            ),
            IconButton(
              onPressed: (){
                showDialog(context: context, builder: (_) => const TestCancelBox());
              },
              icon: const Icon(Icons.clear),
            )
          ],
        ),
        body: ScreenUtilInit(
          designSize: const Size(393, 852),
          child: FutureBuilder(
              future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
              builder: (context,snapshot){
                List<String> checkList = [];
                if(snapshot.hasData){
                  checkList = snapshot.data as List<String>;
                }
                return Consumer<Controller>(
                  builder: (_, notifier, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.80,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 5,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.transparent : Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      Text('No.${index + 1}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 35.sp,
                                            fontWeight: FontWeight.w900
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      SizedBox(
                                        height: size.height*0.2,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(notifier.testList[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w900
                                              ),
                                            ),

                                            Visibility(
                                              visible: notifier.answeredCorrectList[index],
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Text('○',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 150.sp,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.green,
                                                  ),),
                                              ),
                                            ),

                                            Visibility(
                                              visible: notifier.answeredCorrectList[index],
                                              child: const Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Text('Good!',style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.green
                                                ),),
                                              ),
                                            ),

                                            Visibility(
                                              visible: notifier.answeredFalseList[index],
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Text('×',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 150.sp,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.red,
                                                  ),),
                                              ),
                                            ),

                                            Visibility(
                                              visible: notifier.answeredFalseList[index],
                                              child: const Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Text('Bad..',style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.redAccent
                                                ),),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      SizedBox(
                                        height: size.height*0.35,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 10.h),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              ///1番が正解のパターン
                                              if(notifier.positionNum[index] == 0) ...[
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:  EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredCorrectList[index] = true;
                                                          notifier.testCounter++;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(FiveWordsMeans[notifier.testList[index].toUpperCase()]![0],style:  TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][1],style:  TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][2],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                ///2番が正解のパターン
                                              ] else if(notifier.positionNum[index] == 1) ...[
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredCorrectList[index] = true;
                                                          notifier.testCounter++;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(FiveWordsMeans[notifier.testList[index].toUpperCase()]![0],style:  TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][1],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][2],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                ///3番が正解のパターン
                                              ] else if(notifier.positionNum[index] == 2) ...[
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][1],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredCorrectList[index] = true;
                                                          notifier.testCounter++;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(FiveWordsMeans[notifier.testList[index].toUpperCase()]![0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][2],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                ///4番が正解のパターン
                                              ] else if(notifier.positionNum[index] == 3) ...[
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][1],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredFalseList[index] = true;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(notifier.fakeMeanList[index][2],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(5.0.h),
                                                      child: ElevatedButton(
                                                        onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                                          notifier.tapButtonList[index] = true;
                                                          notifier.answeredCorrectList[index] = true;
                                                          notifier.testCounter++;
                                                          if(Provider.of<Controller>(context, listen: false)
                                                              .tapButtonList
                                                              .where((element) => element == true)
                                                              .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                            showDialog(context: context, builder: (_) => const TestResultBox());
                                                          }
                                                          setState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                            fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            side: BorderSide(
                                                              width: 5,
                                                              color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                            )
                                                        ),
                                                        child: Text(FiveWordsMeans[notifier.testList[index].toUpperCase()]![0],style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Transform.scale(
                                              scale: 1.0.sp,
                                              child: Checkbox(
                                                activeColor: Colors.green,
                                                value: notifier.checkRemove[index],
                                                onChanged: (bool? value) {
                                                  if(value == true){
                                                    notifier.deleteCheckListFiveWords(word: notifier.testList[index], list: checkList);
                                                  }else if(value == false){
                                                    notifier.addCheckListFiveWords(word: notifier.testList[index], list: checkList);
                                                  }
                                                  setState(() {
                                                    notifier.checkRemove[index] = !notifier.checkRemove[index];
                                                  });
                                                },
                                              ),
                                            ),
                                            Text('単語帳から消す',style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w900,
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              loop: false,
                              itemCount: (checkList.length < 10) ? notifier.tapButtonList.length : 10,
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
                        ),
                      ],
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}
