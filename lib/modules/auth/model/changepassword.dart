class ChangePassword {
  String? msg;
  String? status;
  Data? data;

  ChangePassword({this.msg, this.status, this.data});

  ChangePassword.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  bool? isEmailVerified;
  String? loginToken;
  String? name;

  Data(
      {this.sId, this.email, this.isEmailVerified, this.loginToken, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    loginToken = json['loginToken'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    data['loginToken'] = loginToken;
    data['name'] = name;
    return data;
  }
}
