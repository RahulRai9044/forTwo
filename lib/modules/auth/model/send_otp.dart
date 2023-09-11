class SendOtp {
  String? msg;
  String? status;
  Otp? otp;

  SendOtp({this.msg, this.status, this.otp});

  SendOtp.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    otp = json['data'] != null ? Otp.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['status'] = status;
    if (otp != null) {
      data['data'] = otp!.toJson();
    }
    return data;
  }
}

class Otp {
  String? email;
  int? otp;
  bool? isEmailVerified;

  Otp({this.email, this.otp, this.isEmailVerified});

  Otp.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    data['isEmailVerified'] = isEmailVerified;
    return data;
  }
}
