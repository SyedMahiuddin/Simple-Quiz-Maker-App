import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/quizlistpage.dart';
import 'package:quizz_app/pages/resultshowingpage.dart';
import 'package:quizz_app/pages/settins_page.dart';
import 'package:quizz_app/models/settingsmodel.dart';
import 'package:quizz_app/pages/settins_page.dart';
import 'package:quizz_app/temp_db.dart';

import '../quiz_provider.dart';

class InstantQuizPage extends StatefulWidget {
  static const String routeName = '/instantquizpage';
  const InstantQuizPage({Key? key}) : super(key: key);

  @override
  State<InstantQuizPage> createState() => _InstantQuizPageState();
}
int finalsec=finalseconds;
double finalpoint=0;
double tottalpointofquiz=0;
double percentofpoint=0;
String status='';
late Timer timer;
class _InstantQuizPageState extends State<InstantQuizPage> {
  late QuizProvider questionprovider;
  int index=0;
  int marks=0;
  int oponeclick=0, optwclick=0, opthrclick=0, opfrclick=0;
  String? buttext;
  Color anscolor1= Colors.black;
  Color anscolor2= Colors.black;
  Color anscolor3= Colors.black;
  Color anscolor4= Colors.black;

  Timer? countdownTimer;
  Duration myDuration = Duration(days: 1);
  @override
  void didChangeDependencies() {
    questionprovider = Provider.of<QuizProvider>(context);
    questionprovider.getallSettings();
    tottalpointofquiz= questionprovider.Questionsbytitlelist.length.toDouble();
    super.didChangeDependencies();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.black45,
           centerTitle: true,
           title: Text(questionprovider.Questionsbytitlelist[index].quiztitle),
         ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          questionprovider.settingslist[0].timelimitedswitch==1?
          Text('Quiz Time: '+minutenum.toString()+' Minutes '+ secnum.toString()+' Seconds',style: TextStyle(fontSize: 20),):
              Text('You Have Unlimited Time'),
        questionprovider.settingslist[0].timelimitedswitch==1?
        CircularCountDownTimer(
        duration: minutenum*60+secnum,
        initialDuration: 0,
        controller: CountDownController(),
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height / 5,
        ringColor: Colors.black12,
        ringGradient: null,
        fillColor: Colors.green,
        fillGradient: null,
        backgroundColor: Colors.black,
        backgroundGradient: null,
        strokeWidth: 5.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
          setState((){resstatus();});
          Navigator.pushNamed(context, ResultShowingPage.routeName);
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },

      ): Text('',style: TextStyle(fontSize: 1),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<QuizProvider>(
              builder: (context, provider, _) => Container(
                alignment: Alignment.center,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Q${index}: '
                        '${questionprovider.Questionsbytitlelist[index].question_name}'
                      ,
                      style: const TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      oponeclick++;
                      questionprovider.updateAns(index, questionprovider.Questionsbytitlelist[index].option_one);
                      setState((){
                        questionprovider.Questionsbytitlelist[index].option_one==questionprovider.questionlist1[index].rightans?
                            marks=marks+1: marks=marks;
                        chkpass!.ansshowchk==false? allopblack(questionprovider.Questionsbytitlelist[index].option_one):
                        optioncheacker(questionprovider.Questionsbytitlelist[index].option_one);

                      });
                    },
                    style: ButtonStyle(
                        textStyle:
                        MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                        backgroundColor: MaterialStateProperty.all(anscolor1)),
                    child: Text(questionprovider.Questionsbytitlelist[index].option_one),
                  ),),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          optwclick++;
                          questionprovider.updateAns(index, questionprovider.Questionsbytitlelist[index].option_two);
                          setState((){
                            chkpass!.ansshowchk==false? allopblack(questionprovider.Questionsbytitlelist[index].option_two):
                            optioncheacker(questionprovider.Questionsbytitlelist[index].option_two);
                          });
                        },
                        style: ButtonStyle(
                            textStyle:
                            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                            backgroundColor: MaterialStateProperty.all(anscolor2)),
                        child: Text(questionprovider.Questionsbytitlelist[index].option_two),
                      ),),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          opthrclick++;
                          questionprovider.updateAns(index, questionprovider.Questionsbytitlelist[index].option_three);
                          setState((){
                            chkpass!.ansshowchk==false? allopblack(questionprovider.Questionsbytitlelist[index].option_three):
                            optioncheacker(questionprovider.Questionsbytitlelist[index].option_three);
                          });
                        },
                        style: ButtonStyle(
                            textStyle:
                            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                            backgroundColor: MaterialStateProperty.all(anscolor3)),
                        child: Text(questionprovider.Questionsbytitlelist[index].option_three),
                      ),),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          opfrclick++;
                          questionprovider.updateAns(index, questionprovider.Questionsbytitlelist[index].option_four);
                          setState((){
                            anscolor1=Colors.black;
                            anscolor2=Colors.black;
                            anscolor3=Colors.black;
                            anscolor4=Colors.black;
                            chkpass!.ansshowchk==false? allopblack(questionprovider.Questionsbytitlelist[index].option_one):
                            optioncheacker(questionprovider.Questionsbytitlelist[index].option_four);

                          });
                          },
                        style: ButtonStyle(
                            textStyle:
                            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                            backgroundColor: MaterialStateProperty.all(anscolor4)),
                        child: Text(questionprovider.Questionsbytitlelist[index].option_four),
                      ),),
                    Column(
                      children: [
                        Row(
                          children: [
                            index>0?
                                chkpass!.prevchk==true?
                            Expanded(
                                child: IconButton(
                                  iconSize: 72, icon: Icon(Icons.skip_previous,),
                                  onPressed: (){
                                    setState((){index--;
                                    anscolor1=Colors.black;
                                    anscolor2=Colors.black;
                                    anscolor3=Colors.black;
                                    anscolor4=Colors.black;
                                    });},

                                )
                            ):
                                Expanded(
                                    child: IconButton(
                                      iconSize: 72, icon: Icon(Icons.skip_previous),
                                      color: Colors.black12,
                                      onPressed: (){},

                                    )
                                )
                                :
                            Expanded(
                                child: IconButton(
                                    iconSize: 72, icon: Icon(Icons.stop,),
                                    onPressed: (){}

                                )
                            ),
                            index<questionprovider.Questionsbytitlelist.length-1?
                            Expanded(
                                child: IconButton(
                                  iconSize: 72, icon: Icon(Icons.skip_next,),
                                  onPressed: (){
                                    setState((){
                                      index++;
                                    anscolor1=Colors.black;
                                    anscolor2=Colors.black;
                                    anscolor3=Colors.black;
                                    anscolor4=Colors.black;
                                    });},

                                )
                            ):
                            Expanded(
                                child: IconButton(
                                  iconSize: 72, icon: Icon(Icons.stop,),
                                  onPressed: (){}

                                )
                            )
                          ],
                        ),
                        index==questionprovider.Questionsbytitlelist.length-1?
                        Column(
                          children: [
                            IconButton(
                                iconSize: 52, icon: Icon(Icons.arrow_right_alt_rounded,color: Colors.green),
                                onPressed: (){

                                  setState((){resstatus();});
                                  Navigator.pushNamed(context, ResultShowingPage.routeName);
                                }

                            )
                            ,Text('Go to Result')
                          ],
                        ):
                        IconButton(
                            iconSize: 52, icon: Icon(Icons.circle_outlined,),
                            onPressed: (){}

                        ),
                      ],
                    ),
                  ],

                ),

              ),
            ),
          ),
        ],
      ),
    );

  }
  void optioncheacker( String selected_Op)
  {
    if(selected_Op==questionprovider.Questionsbytitlelist[index].option_one)
    {
      if(questionprovider.Questionsbytitlelist[index].option_one==questionprovider.Questionsbytitlelist[index].rightans)
      {
        oponeclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
        anscolor1=Colors.green;
        anscolor2=Colors.black;
        anscolor3=Colors.black;
        anscolor4=Colors.black;
      }
      else if(questionprovider.Questionsbytitlelist[index].option_one!=questionprovider.Questionsbytitlelist[index].rightans)
      {
        anscolor1=Colors.red;
        if(questionprovider.Questionsbytitlelist[index].option_two==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor2=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_three==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor3=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_four==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor4=Colors.green;
      }
    }
    else if(selected_Op==questionprovider.Questionsbytitlelist[index].option_two)
    {
      if(questionprovider.Questionsbytitlelist[index].option_two==questionprovider.Questionsbytitlelist[index].rightans)
      {
        optwclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
        anscolor1=Colors.black;
        anscolor2=Colors.green;
        anscolor3=Colors.black;
        anscolor4=Colors.black;
      }
      else if(questionprovider.Questionsbytitlelist[index].option_two!=questionprovider.Questionsbytitlelist[index].rightans)
      {
        anscolor2=Colors.red;
        if(questionprovider.Questionsbytitlelist[index].option_one==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor1=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_three==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor3=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_four==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor4=Colors.green;
      }
    }
    else if(selected_Op==questionprovider.Questionsbytitlelist[index].option_three)
    {
      if(questionprovider.Questionsbytitlelist[index].option_three==questionprovider.Questionsbytitlelist[index].rightans)
      {
        opthrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
        anscolor1=Colors.black;
        anscolor2=Colors.black;
        anscolor3=Colors.green;
        anscolor4=Colors.black;
      }
      else if(questionprovider.Questionsbytitlelist[index].option_three!=questionprovider.Questionsbytitlelist[index].rightans)
      {
        anscolor3=Colors.red;
        if(questionprovider.Questionsbytitlelist[index].option_one==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor1=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_two==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor2=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_four==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor4=Colors.green;
      }
    }
    else if(selected_Op==questionprovider.Questionsbytitlelist[index].option_four)
    {
      if(questionprovider.Questionsbytitlelist[index].option_four==questionprovider.Questionsbytitlelist[index].rightans)
      {
        opfrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
        anscolor1=Colors.black;
        anscolor2=Colors.black;
        anscolor3=Colors.black;
        anscolor4=Colors.green;
      }
      else if(questionprovider.Questionsbytitlelist[index].option_four!=questionprovider.Questionsbytitlelist[index].rightans)
      {
        anscolor4=Colors.red;
        if(questionprovider.Questionsbytitlelist[index].option_one==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor1=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_two==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor2=Colors.green;
        if(questionprovider.Questionsbytitlelist[index].option_three==questionprovider.Questionsbytitlelist[index].rightans)
          anscolor3=Colors.green;
      }
    }
  }
  void allopblack(String op)
  {
    if(op==questionprovider.Questionsbytitlelist[index].option_one)
      {
        if(op==questionprovider.Questionsbytitlelist[index].rightans)
    {
    opfrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
    }
        anscolor1=Colors.blue;
        anscolor2=Colors.black;
        anscolor3=Colors.black;
        anscolor4=Colors.black;
      }
   else if(op==questionprovider.Questionsbytitlelist[index].option_two)
    {
    if(questionprovider.Questionsbytitlelist[index].option_two==questionprovider.Questionsbytitlelist[index].rightans)
    {
    opfrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
    }
      anscolor1=Colors.black;
      anscolor2=Colors.blue;
      anscolor3=Colors.black;
      anscolor4=Colors.black;
    }
    else if(op==questionprovider.Questionsbytitlelist[index].option_three)
    {
      if(questionprovider.Questionsbytitlelist[index].option_three==questionprovider.Questionsbytitlelist[index].rightans)
      {
        opfrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
      }
      anscolor1=Colors.black;
      anscolor2=Colors.black;
      anscolor3=Colors.blue;
      anscolor4=Colors.black;
    }
    else if(op==questionprovider.Questionsbytitlelist[index].option_four)
    {
      if(questionprovider.Questionsbytitlelist[index].option_four==questionprovider.Questionsbytitlelist[index].rightans)
      {
        opfrclick==1? finalpoint=finalpoint+1 : finalpoint=finalpoint;
      }
      anscolor1=Colors.black;
      anscolor2=Colors.black;
      anscolor3=Colors.black;
      anscolor4=Colors.blue;
    }
  }
  void resstatus(){
    double perc= finalpoint/ tottalpointofquiz * 100;
    if(perc>=80)
      status='Satisfactory';
    else if(perc>=60)
      status='Good! Study More';
    else if(perc>=40)
      status='Not So Good!';
    else if(perc<40)
      status='Bad Result';
  }
}
