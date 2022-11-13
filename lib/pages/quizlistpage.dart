import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/viewquestion.dart';

import '../quiz_provider.dart';

class QuizListPage extends StatefulWidget {
  static const String routeName = '/quizlistpage';
  const QuizListPage({Key? key}) : super(key: key);

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}
late QuizProvider questionprovider;
class _QuizListPageState extends State<QuizListPage> {
  @override
  void didChangeDependencies() {
    questionprovider = Provider.of(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
   backgroundColor: Colors.black45,
   centerTitle: true,
   title: Text('All Previous Quizes'),
 ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text('${questionprovider.TitleList.length} Quiz Question',style: TextStyle(fontSize: 20),),
          Expanded(
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
                child: Consumer<QuizProvider>(
                  builder: (context, provider, _) => ListView.builder(
                    itemCount: provider.TitleList.length,
                    itemBuilder: (context, index) {
                      final Quizes = provider.TitleList[index];
                      return Dismissible(
                        key: ValueKey(Quizes.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                        },
                        child: ListTile(
                          onTap: () {
                          },
                          title:Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: (){
                                  questionprovider.getallQuestionsBytitle(Quizes.quiztitle);
                                  Navigator.pushNamed(context, ViewQuestionPage.routeName);
                                  print(Quizes.quiztitle);
                                  print(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment(0.8, 1),
                                    colors: <Color>[
                                      Color(0x6FF6F1F1),
                                      Color(0xFFFCFCFC),
                                    ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                    tileMode: TileMode.mirror,
                                  ),

                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                  border: Border.all(
                                      color: Colors.black, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.question_answer_rounded,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("  ${Quizes.quiztitle}"),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                    ],

                                  ),
                                ),
                              ),
                            ),
                          ) ,

                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
