// lib/app/data/model/faq_model.dart
class FAQModel {
  final int id;
  final String question;
  final String answer;

  FAQModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
