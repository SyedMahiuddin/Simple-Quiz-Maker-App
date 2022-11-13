import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/pages/instantquiz_page.dart';
import 'package:quizz_app/pages/quizmaker_page.dart';

class ResultShowingPage extends StatefulWidget {
  static const String routeName = '/resultshowing';
  const ResultShowingPage({Key? key}) : super(key: key);

  @override
  State<ResultShowingPage> createState() => _ResultShowingPageState();
}

class _ResultShowingPageState extends State<ResultShowingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
           body: Center(
             child: Container(
               height: 400,
               width: 250,
               decoration:  BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topRight,
                   end: Alignment(0.8, 1),
                   colors: <Color>[
                     Color(0x6F000000),
                     Color(0x20000000),
                   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                   tileMode: TileMode.mirror,
                 ),

                 borderRadius: BorderRadius.all(Radius.circular(14)),
                 border: Border.all(
                     color: Colors.black, width: 1),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   RichText(
                     text: TextSpan(
                       children:<TextSpan> [
                         TextSpan(
                           text: status=='Satisfactory'? '✌': status=='Good! Study More'?'😊' :status=='Not So Good!'? '🙂':'😞', // emoji characters
                           style: TextStyle(
                             fontSize: 100,
                             fontFamily: 'EmojiOne',
                           ),
                         ),
                       ],),
                   ),
                   SizedBox(height: 25,),
                   RichText(
                     text: TextSpan(
                       children:<TextSpan> [
                         TextSpan(
                           text: status,style: const TextStyle(fontSize: 24),  // non-emoji characters
                         ),
                       ],),
                   ),
                   SizedBox(height: 15,),
                   RichText(
                     text: TextSpan(
                       children:<TextSpan> [
                         TextSpan(
                           text: '✔ ', // emoji characters
                           style: TextStyle(
                             fontSize: 28,
                             fontFamily: 'EmojiOne',
                           ),
                         ),
                         TextSpan(
                           text: ' ${finalpoint.toString()} out of $tottalpointofquiz',style: const TextStyle(fontSize: 28),  // non-emoji characters
                         ),
                       ],),
                   ),
                   SizedBox(height: 15,),
                   IconButton(
                       iconSize: 50, icon: Icon(Icons.arrow_back_rounded,color: Colors.black),
                       onPressed: (){
                         finalpoint=0;
                         status='Null';
                         tottalpointofquiz=0;
                         Navigator.pushNamed(context, QuizMakerPage.routeName);
                       }
                   ),
                   Text('Go back to Home Page')
                 ],
               )
             ),
           ),
    );
  }
}
