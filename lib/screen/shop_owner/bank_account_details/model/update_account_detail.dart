class BankAccountUpadateRequestModel {
  String? nameOfBank;
  String? accountHolderName;
  String? accountNumber;
  String? typeOfAccount;
  String? ifscCode;
  String? bankBranch;

  BankAccountUpadateRequestModel({
    required this.nameOfBank,
    required this.accountHolderName,
    required this.accountNumber,
    required this.typeOfAccount,
    required this.ifscCode,
    required this.bankBranch,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["name_of_bank"] = nameOfBank;
    data["account_holder_name"] = accountHolderName;
    data["account_number"] = accountNumber;
    data["type_of_account"] = typeOfAccount;
    data["ifsc_code"] = ifscCode;
    data["bank_branch"] = bankBranch;

    return data;
  }
}

//////////////////////////RESPONSE MODEL/////////////////////
class BankAccountUpadateResModel {
  int? status;
  String? message;

  BankAccountUpadateResModel({
    required this.status,
    required this.message,
  });
  BankAccountUpadateResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
