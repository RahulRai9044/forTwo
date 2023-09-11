class Register {
  String? msg;
  String? status;
  Data? data;

  Register({this.msg, this.status, this.data});

  Register.fromJson(Map<String, dynamic> json) {
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
  bool? consultationConsent;
  bool? privacyPolicyConsent;
  String? notificationTime;
  String? fcmToken;
  String? loginToken;
  String? mobile;
  String? name;
  String? state;
  int? zipcode;

  Data(
      {this.sId,
      this.email,
      this.consultationConsent,
      this.privacyPolicyConsent,
      this.notificationTime,
      this.fcmToken,
      this.loginToken,
      this.mobile,
      this.name,
      this.state,
      this.zipcode});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    consultationConsent = json['consultationConsent'];
    privacyPolicyConsent = json['privacyPolicyConsent'];
    notificationTime = json['notificationTime'];
    fcmToken = json['fcmToken'];
    loginToken = json['loginToken'];
    mobile = json['mobile'];
    name = json['name'];
    state = json['state'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['consultationConsent'] = consultationConsent;
    data['privacyPolicyConsent'] = privacyPolicyConsent;
    data['notificationTime'] = notificationTime;
    data['fcmToken'] = fcmToken;
    data['loginToken'] = loginToken;
    data['mobile'] = mobile;
    data['name'] = name;
    data['state'] = state;
    data['zipcode'] = zipcode;
    return data;
  }
}
