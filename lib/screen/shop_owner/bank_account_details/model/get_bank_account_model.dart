class GetBankDetailModel {
  int? status;
  String? message;
  BankDetailData? bankData;

  GetBankDetailModel({
    required this.status,
    required this.message,
    required this.bankData,
  });
  GetBankDetailModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    bankData =
        json['data'] != null ? BankDetailData.fromJson(json['data']) : null;
  }
}

class BankDetailData {
  String? id;
  String? nameOfBank;
  String? accountHolderName;
  String? accountNumber;
  String? typeOfAccount;
  String? ifscCode;
  String? bankBranch;

  BankDetailData({
    required this.id,
    required this.nameOfBank,
    required this.accountHolderName,
    required this.accountNumber,
    required this.typeOfAccount,
    required this.ifscCode,
    required this.bankBranch,
  });
  BankDetailData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nameOfBank = json["name_of_bank"];
    accountHolderName = json["account_holder_name"];
    accountNumber = json["account_number"];
    typeOfAccount = json["type_of_account"];
    ifscCode = json["ifsc_code"];
    bankBranch = json["bank_branch"];
  }
}
