class GetUrlReqModel{
String ? appKey;
GetUrlReqModel({
  this.appKey,
});
Map<String,dynamic> toJson(){
  Map<String,dynamic> data={};
  data["app_key"]=appKey;
  return data;
}
}
class GetUrlResModel{
  int ? status;
  String ? message;
  UrlData ? data;
  GetUrlResModel({
    this.status,
    this.message,
    this.data,
});
  GetUrlResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data = json['data'] != null ? UrlData.fromJson(json['data']) : null;
  }
}

class UrlData{
  String ? appUrl;
  UrlData({
    this.appUrl,
});
  UrlData.fromJson(Map<String,dynamic> json){
    appUrl=json["app_main_url"];
  }
}