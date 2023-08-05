class CustomerFaqModel {
  int? status;
  String? message;
  List<CustomerFaqDataList>? customerfaqdataList;

  CustomerFaqModel({
    required this.status,
    required this.message,
    required this.customerfaqdataList,
  });
  CustomerFaqModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      customerfaqdataList = <CustomerFaqDataList>[];
      json["data"].forEach((v) {
        customerfaqdataList!.add(CustomerFaqDataList.fromJson(v));
      });
    }
  }
}

class CustomerFaqDataList {
  int? id;
  String? question;
  String? answer;

  CustomerFaqDataList({
    required this.id,
    required this.question,
    required this.answer,
  });
  CustomerFaqDataList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    answer = json["answer"];
  }
}
