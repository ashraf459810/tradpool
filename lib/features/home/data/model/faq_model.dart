// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) => List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
    FaqModel({
        this.answer,
        this.goTo,
        this.question,
    });

    String answer;
    String goTo;
    String question;

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        answer: json["answer"],
        goTo: json["goTo"] == null ? null : json["goTo"],
        question: json["question"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "goTo": goTo == null ? null : goTo,
        "question": question,
    };
}
