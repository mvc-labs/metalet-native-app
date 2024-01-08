/// status : "1"
/// message : "OK"
/// result : {"list":[{"title":"Slow","desc":"About 1 hours","feeRate":48},{"title":"Avg","desc":"About 30 minutes","feeRate":52},{"title":"Fast","desc":"About 10 minutes","feeRate":58}]}

class BtcFeeBean {
  BtcFeeBean({
      this.status, 
      this.message, 
      this.result,});

  BtcFeeBean.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? status;
  String? message;
  Result? result;
BtcFeeBean copyWith({  String? status,
  String? message,
  Result? result,
}) => BtcFeeBean( status: status ?? this.status,
  message: message ?? this.message,
  result: result ?? this.result,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

/// list : [{"title":"Slow","desc":"About 1 hours","feeRate":48},{"title":"Avg","desc":"About 30 minutes","feeRate":52},{"title":"Fast","desc":"About 10 minutes","feeRate":58}]

class Result {
  Result({
      this.list,});

  Result.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(FeeBean.fromJson(v));
      });
    }
  }
  List<FeeBean>? list;



Result copyWith({  List<FeeBean>? list,
}) => Result(  list: list ?? this.list,
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
/// feeRate : 48

class FeeBean {
  FeeBean({
      this.title, 
      this.desc, 
      this.feeRate,});

  FeeBean.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    feeRate = json['feeRate'];
  }
  String? title;
  String? desc;
  num? feeRate;
  FeeBean copyWith({  String? title,
  String? desc,
  num? feeRate,
}) => FeeBean(  title: title ?? this.title,
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



/*
class BtcFeeBean {
  BtcFeeBean({
    this.status,
    this.message,
    this.result,});

  BtcFeeBean.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? status;
  String? message;
  Result? result;
  BtcFeeBean copyWith({  String? status,
    String? message,
    Result? result,
  }) => BtcFeeBean( status: status ?? this.status,
    message: message ?? this.message,
    result: result ?? this.result,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

/// list : [{"title":"Slow","desc":"About 1 hours","feeRate":48},{"title":"Avg","desc":"About 30 minutes","feeRate":52},{"title":"Fast","desc":"About 10 minutes","feeRate":58}]

class Result {
  Result({
    this.list,});

  Result.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(FeeBean.fromJson(v));
      });
    }
  }
  List<FeeBean>? list;



  Result copyWith({  List<FeeBean>? list,
  }) => Result(  list: list ?? this.list,
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
/// feeRate : 48

class FeeBean {
  FeeBean({
    this.title,
    this.desc,
    this.feeRate,});

  FeeBean.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    feeRate = json['feeRate'];
  }
  String? title;
  String? desc;
  num? feeRate;
  FeeBean copyWith({  String? title,
    String? desc,
    num? feeRate,
  }) => FeeBean(  title: title ?? this.title,
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

}*/
