class FaqModel {
  int? status;
  String? message;
  List<FaqData>? faqdata;

  FaqModel({
    required this.status,
    required this.message,
    required this.faqdata,
  });
  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      faqdata = <FaqData>[];
      json["data"].forEach((v) {
        faqdata!.add(FaqData.fromJson(v));
      });
    }
  }
}

class FaqData {
  int? id;
  String? question;
  String? answer;

  FaqData({
    required this.id,
    required this.question,
    required this.answer,
  });
  FaqData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    answer = json["answer"];
  }
}
