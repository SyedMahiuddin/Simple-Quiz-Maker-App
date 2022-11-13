import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/models/questionmakermodel.dart';
import 'package:quizz_app/models/settingsmodel.dart';
import 'package:quizz_app/pages/instantquiz_page.dart';
import 'package:quizz_app/pages/quizlistpage.dart';
import 'package:quizz_app/pages/settins_page.dart';
import 'package:quizz_app/pages/viewquestion.dart';
import 'package:quizz_app/quiz_provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

class QuizMakerPage extends StatefulWidget {
  static const String routeName = '/quizmaker';
  const QuizMakerPage({Key? key}) : super(key: key);
  @override
  State<QuizMakerPage> createState() => _QuizMakerPageState();
}
int questionnum=0;
int qcount=1;
class _QuizMakerPageState extends State<QuizMakerPage> {

  late QuizProvider questionprovider;
  final questionnumcontroller = TextEditingController();
  final questionnamecontroller = TextEditingController();
  final oponecontroller = TextEditingController();
  final optwocontroller = TextEditingController();
  final opthreecontroller = TextEditingController();
  final opfourcontroller = TextEditingController();
  final rightanscontroller = TextEditingController();
  final givenanscontroller= TextEditingController();
  final quiztitlecontroller= TextEditingController();
  var titleicon=Icons.search;
  int animatedheight=0;
  int swichmaker=0;
  String rightanstext='';
  final from_key = GlobalKey<FormState>();
  Icon opicon=Icon(Icons.brightness_1_outlined);
 int  opclick1=0;
  int  opclick2=0;
  int  opclick3=0;
  int  opclick4=0;
  @override
@override
  void didChangeDependencies() {
  questionprovider = Provider.of<QuizProvider>(context);
  questionprovider.getallSettings();
  questionprovider.getallSettings();
  if(swichmaker==0)
  {
    swichmaker++;
    _savesettings();
  }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool switchon=false;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text('Quiz Maker'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, QuizListPage.routeName);
          },
          child: Icon(Icons.list),
        ),
        actions: [
      Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () { Navigator.pushNamed(context, SettingsPage.routeName);
          },
        child: Icon(
          Icons.settings,
          size: 26.0,
        ),
      ))
        ],
        ),
      body: Center(
        child: ListView(
            shrinkWrap: true,
          children: [
           Center(
            child:Form(
              key: from_key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
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
                   questionprovider.settingslist[0].timelimitedswitch==1?
                  Text('Quiz Time: '+minutenum.toString()+' Minutes '+ secnum.toString()+' Seconds',style: TextStyle(fontSize: 20),):
                Text('',style: TextStyle(fontSize: 1),),
                        animatedheight==440? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Column(
                              children: [
                                Text('Select the number of questions want to add'),
                                NumberPicker(
                                  value: questionnum,
                                  axis: Axis.horizontal,
                                  textStyle: TextStyle(color: Colors.black45),
                                  selectedTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  minValue: 0,
                                  maxValue: 100,
                                  onChanged: (value) => setState(() => questionnum = value),

                                ),
                              ],
                            ),
                          ),
                        ):Padding(padding: const EdgeInsets.all(8)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: quiztitlecontroller,
                        decoration: InputDecoration(
                            hintText: animatedheight <100? 'Search Quiz By Title': 'Write Your Quiz Title' ,
                            prefixIcon: Icon(titleicon, color: Colors.black45,),
                            focusedBorder: animatedheight<10 ? OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black),
                            ):
                            OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black),
                            )
                          ,
                            border: animatedheight<100? new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide( color: Colors.black),
                          ):
                            new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(6),
                              borderSide: new BorderSide(color: Colors.black45),
                            ),

                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextButton(onPressed: (){
                      setState((){animatedheight==440? animatedheight=0: animatedheight=440;
                        animatedheight<100? titleicon=Icons.search : titleicon=Icons.title ;});
                      }, child:
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(animatedheight==440?'Do Not want to add?, just search previous Quiz ': 'Add New Quiz Questions ', style: TextStyle(color: Colors.black),),
                         Icon(animatedheight==440? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_sharp, color: Colors.black,),
                       ],
                     ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 70),
                        height: animatedheight.toDouble() ,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          border: Border.all(
                              color: Colors.black, width: 1),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Making Question No $qcount',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: questionnamecontroller,
                              decoration: InputDecoration(
                                  labelText: 'Write Your Question',
                                  prefixIcon: Icon(Icons.question_answer_outlined)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: oponecontroller,
                              decoration: InputDecoration(
                                labelText: 'First Option',
                                prefixIcon: Icon(Icons.brightness_1_outlined)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: optwocontroller,
                              decoration: InputDecoration(
                                  labelText: 'Second Option',
                                  prefixIcon: Icon(Icons.brightness_1_outlined)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: opthreecontroller,
                              decoration: InputDecoration(
                                  labelText: 'Third Option',
                                  prefixIcon: Icon(Icons.brightness_1_outlined)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: opfourcontroller,
                              decoration: InputDecoration(
                                  labelText: 'Forth Option',
                                  prefixIcon: Icon(Icons.brightness_1_outlined)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: givenanscontroller,
                              decoration: InputDecoration(
                                  labelText: 'Right Answer',
                                  prefixIcon: Icon(Icons.brightness_1)
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'This field must not be emplty';
                                }
                                else{
                                  return null;
                                }
                              },
                            ),

                           qcount<=questionnum?
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: ElevatedButton(onPressed: (){
                                  setState((){
                                    _savequestion();
                                    qcount++;
                                  });
                             },
                                 style: ButtonStyle(
                                   backgroundColor:  MaterialStateProperty.all(Colors.black45),),
                                 child: Text('Add Question No $qcount')),
                           ) : Text('$questionnum Questions Added Already'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: (){
                              questionprovider.getallQuestionsBytitle(quiztitlecontroller.text);
                              Navigator.pushNamed(context, ViewQuestionPage.routeName);
                            },
                                style: ButtonStyle(
                                  backgroundColor:  MaterialStateProperty.all(Colors.black45),),
                                child: Text('View Question')),),
                          SizedBox(width: 30,),
                          Expanded(
                            child: ElevatedButton(onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Making A Quiz'),
                                    content: Container(
                                      height: 200,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text('Starting A Quiz'),
                                                  Text('Title: ${quiztitlecontroller.text}')
                                                ],
                                              )
                                            ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(onPressed: (){
                                        questionnum=0;
                                        qcount=1;
                                        questionprovider.getallQuestionsBytitle(quiztitlecontroller.text);
                                        Navigator.pushNamed(context, InstantQuizPage.routeName);
                                      },style: ButtonStyle(
                                        backgroundColor:  MaterialStateProperty.all(Colors.black45),), child: Text('Start Quiz'))

                                    ],
                                  ),
                                );
                            },
    style: ButtonStyle(
    backgroundColor:  MaterialStateProperty.all(Colors.black45),),
                                child: Text('Instant Quiz')),)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),)
          ),]
        ),
      ),
    );
  }

  void _savequestion() async {
    final question = AddQuestionsModel(
        question_name:questionnamecontroller.text,
        option_one: oponecontroller.text,
        option_two: optwocontroller.text,
        option_three: opthreecontroller.text,
        option_four: opfourcontroller.text,
        rightans: givenanscontroller.text,
        quiztitle: quiztitlecontroller.text,
        givenans: null
    );
    print(question.toString());
    final status = await Provider
        .of<QuizProvider>(context, listen: false)
        .addQuestion(question);
    if(status){
    print('Succesfuly Added Question No: $qcount');
    }
  }

  void _savesettings() async {
    final settings = SettingsModel(
        prevswitch:0,
        showansswitch:0,
        timelimitedswitch:0,
    );
    print(settings.toString());
    final status = await Provider
        .of<QuizProvider>(context, listen: false)
        .addSettings(settings);
    if(status){
      print('Succesfuly Added Settings');
      print(QuizProvider().settingslist.length);
    }
  }
}
