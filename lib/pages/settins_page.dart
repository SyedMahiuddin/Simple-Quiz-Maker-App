import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/quizlistpage.dart';

import '../quiz_provider.dart';
import 'cheakarsclass.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settingspage';

int? min;
int? sec;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
int minutenum=0;
int secnum=0;
int finalseconds=minutenum*60+secnum;
Cheacker? chkpass;
 bool prevbuten=true;
class _SettingsPageState extends State<SettingsPage> {
  late QuizProvider settingsprovider;
 int index=1;
  late bool prechk;
  late bool anschk;
  late bool timechk;
  int calltimer=0;
  @override
  void didChangeDependencies() {
    settingsprovider = Provider.of<QuizProvider>(context);
    settingsprovider.getallSettings();
    if(calltimer==0)
      {
        prechk=settingsprovider.settingslist[index-1].prevswitch==0? false:true;
        anschk=settingsprovider.settingslist[index-1].showansswitch==0?false:true;
        timechk=settingsprovider.settingslist[index-1].timelimitedswitch==0?false:true;
        calltimer++;
      }
    chkpass=new Cheacker(prechk, anschk, timechk);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text('Quiz Settings'),
      ),
      body: Consumer<QuizProvider>(
        builder:(context,provider,_)=> Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 IconButton(onPressed: (){
                   setState((){
                     bool prechk=provider.settingslist[2].prevswitch==0?false:true;
                     bool anschk=provider.settingslist[2].showansswitch==0?false:true;;
                     bool timechk=provider.settingslist[2].timelimitedswitch==0?false:true;
                   });
                 }, icon:Icon(Icons.downloading)),
                  Container(
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
                    child: Row(
                      children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Set Previous Ans View Enable',style: TextStyle(fontSize: 20),),
                        )),
                        SizedBox(width: 20,),
                        FlutterSwitch(
                          width: 70.0,
                          height: 30.0,
                          valueFontSize: 12.0,
                          toggleSize: 20.0,
                          value:prechk ,
                          borderRadius: 35.0,
                          padding: 8.0,
                          activeColor: Colors.black,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              prechk=val;
                              val==false? provider.updatePrevEn(index,0): provider.updatePrevEn(index,1);
                              print(val.toString());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
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
                    child: Row(
                      children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Show Right Answer',style: TextStyle(fontSize: 20),),
                        )),
                        SizedBox(width: 20,),
                        FlutterSwitch(
                          width: 70.0,
                          height: 30.0,
                          valueFontSize: 12.0,
                          toggleSize: 20.0,
                          value:anschk ,
                          borderRadius: 35.0,
                          padding: 8.0,
                          activeColor: Colors.black,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              anschk=val;
                              val==false? provider.updateShowNasEn(index,0): provider.updateShowNasEn(index,1);
                              print(val.toString());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
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
                    child: Row(
                      children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Quiz Time Limited',style: TextStyle(fontSize: 20),),
                        )),
                        SizedBox(width: 20,),
                        FlutterSwitch(
                          width: 70.0,
                          height: 30.0,
                          valueFontSize: 12.0,
                          toggleSize: 20.0,
                          value:timechk ,
                          borderRadius: 35.0,
                          padding: 8.0,
                          activeColor: Colors.black,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              timechk=val;
                              val==false? provider.updateTimeLimEn(index,0): provider.updateTimeLimEn(index,1);
                              print(val.toString());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: NumberPicker(
                            value: minutenum,
                            textStyle: TextStyle(color: Colors.black45),
                            selectedTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            minValue: 0,
                            maxValue: 100,
                            onChanged: (value) => setState((){minutenum=value; })
                          ),
                        ),
                        Expanded(
                          child: NumberPicker(
                            value: secnum,
                            textStyle: TextStyle(color: Colors.black45),
                            selectedTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            minValue: 0,
                            maxValue: 100,
                            onChanged: (value) => setState(() => secnum = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Quiz Time: $minutenum Min $secnum Seconds',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
