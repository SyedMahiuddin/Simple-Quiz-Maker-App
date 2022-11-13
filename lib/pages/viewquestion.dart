
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/instantquiz_page.dart';
import 'package:quizz_app/quiz_provider.dart';


class ViewQuestionPage extends StatefulWidget {
  static const String routeName = '/viewquestionpage';
  const ViewQuestionPage({Key? key}) : super(key: key);

  @override
  State<ViewQuestionPage> createState() => _ViewQuestionPageState();
}

class _ViewQuestionPageState extends State<ViewQuestionPage> {
  late QuizProvider questionprovider;


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
        title: Text('${questionprovider.Questionsbytitlelist[0].quiztitle}'),
      ),
      body: Column(
        children: [

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
                    itemCount: provider.Questionsbytitlelist.length,
                    itemBuilder: (context, index) {
                      final questions = provider.Questionsbytitlelist[index];
                      return Dismissible(
                        key: ValueKey(questions.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: ListTile(
                            onTap: () {},
                            leading: Text('Q${index+1}'),
                            title:Align(
                              alignment: Alignment.topLeft,
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
                                      Text("Question: ${questions.question_name}"),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_box_outline_blank,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${questions.option_one}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_box_outline_blank,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${questions.option_two}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_box_outline_blank,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${questions.option_three}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_box_outline_blank,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${questions.option_four}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_box_outlined,
                                            color: Colors.black45,
                                            size: 24.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("Right Answer: ${questions.rightans}"),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                    ],

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
          ElevatedButton(onPressed: (){
            questionprovider.getallQuestionsBytitle(questionprovider.Questionsbytitlelist[0].quiztitle);
            Navigator.pushNamed(context, InstantQuizPage.routeName);
          },
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all(Colors.black45),),
              child: Text('Take Quiz Now')),
        ],
      ),
    );
  }
}
