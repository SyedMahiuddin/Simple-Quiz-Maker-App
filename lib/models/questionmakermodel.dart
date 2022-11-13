const String tablequestion='tbl_questions';
const String tablequestionid='id';
const String tablequestionname='question_name';
const String tablequestionopone='optionone';
const String tablequestionoptwo='optiontwo';
const String tablequestionopthree='optionthree';
const String tablequestionopfour='optionfour';
const String tablequestionrightans='rightans';
const String tablequestiongivenans='givenans';
const String tablequestionquiztitle='quiztitle';

class AddQuestionsModel{
  int? id;
  String question_name;
  String option_one;
  String option_two;
  String option_three;
  String option_four;
  String rightans;
  String? givenans;
  String quiztitle;

  AddQuestionsModel({
      this.id,
      required this.question_name,
      required this.option_one,
      required this.option_two,
      required this.option_three,
      required this.option_four,
      required this.rightans,
      this.givenans,
      required this.quiztitle});

  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      tablequestionname:question_name,
      tablequestionopone:option_one,
      tablequestionoptwo:option_two,
      tablequestionopthree:option_three,
      tablequestionopfour:option_four,
      tablequestionrightans:rightans,
      tablequestiongivenans:givenans,
      tablequestionquiztitle:quiztitle,
    };
    if(id!=null){
      map[tablequestionid]=id;
    }
    return map;
}
  factory AddQuestionsModel.fromMap(Map<String, dynamic> map) => AddQuestionsModel(
      id: map[tablequestionid],
      question_name: map[tablequestionname],
      option_one: map[tablequestionopone],
      option_two: map[tablequestionoptwo],
      option_three: map[tablequestionopthree],
      option_four: map[tablequestionopfour],
      rightans: map[tablequestionrightans],
      givenans: map[tablequestiongivenans],
      quiztitle: map[tablequestionquiztitle]
  );
}