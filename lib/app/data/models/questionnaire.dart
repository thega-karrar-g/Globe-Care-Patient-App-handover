class Questionnaire {
  Questionnaire(
      {this.id = 0,
      this.question = '',
      this.questionAr = '',
      this.answer,
      this.answerText = 'Yes'});

  int id;
  String question = '', questionAr = '', answerText = 'Yes';
  bool? answer;

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        id: json['id'] ?? 0,
        question: json['question'] ?? '',
        questionAr: json['question_ar'] ?? '',
        answer: json['answer'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "question_ar": questionAr,
        "answer": answer,
      };
}
