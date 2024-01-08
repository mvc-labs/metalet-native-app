/// code : 0
/// message : "success"
/// processingTime : 34
/// data : {"list":[{"title":"Slow","desc":"About 1 hours","feeRate":69},{"title":"Avg","desc":"About 30 minutes","feeRate":81},{"title":"Fast","desc":"About 10 minutes","feeRate":92}]}

class BtcFeeRateBean {
  BtcFeeRateBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcFeeRateBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BtcFeeRateBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BtcFeeRateBean(  code: code ?? this.code,
  message: message ?? this.message,
  processingTime: processingTime ?? this.processingTime,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['processingTime'] = processingTime;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// list : [{"title":"Slow","desc":"About 1 hours","feeRate":69},{"title":"Avg","desc":"About 30 minutes","feeRate":81},{"title":"Fast","desc":"About 10 minutes","feeRate":92}]

class Data {
  Data({
      this.list,});

  Data.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(FeeRateBean.fromJson(v));
      });
    }
  }
  List<FeeRateBean>? list;
Data copyWith({  List<FeeRateBean>? list,
}) => Data(  list: list ?? this.list,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "Slow"
/// desc : "About 1 hours"
/// feeRate : 69

class FeeRateBean {
  FeeRateBean({
      this.title, 
      this.desc, 
      this.feeRate,});

  FeeRateBean.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    feeRate = json['feeRate'];
  }
  String? title;
  String? desc;
  num? feeRate;
  FeeRateBean copyWith({  String? title,
  String? desc,
  num? feeRate,
}) => FeeRateBean(  title: title ?? this.title,
  desc: desc ?? this.desc,
  feeRate: feeRate ?? this.feeRate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['desc'] = desc;
    map['feeRate'] = feeRate;
    return map;
  }

}