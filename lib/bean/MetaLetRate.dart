/// code : 0
/// message : "success"
/// processingTime : 119
/// data : {"priceInfo":{"btc":36306.37,"space":16.98}}

class MetaLetRate {

  MetaLetRate({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  MetaLetRate.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
MetaLetRate copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => MetaLetRate( code: code ?? this.code,
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

/// priceInfo : {"btc":36306.37,"space":16.98}

class Data {
  Data({
      this.priceInfo,});

  Data.fromJson(dynamic json) {
    priceInfo = json['priceInfo'] != null ? PriceInfo.fromJson(json['priceInfo']) : null;
  }
  PriceInfo? priceInfo;
Data copyWith({  PriceInfo? priceInfo,
}) => Data(  priceInfo: priceInfo ?? this.priceInfo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (priceInfo != null) {
      map['priceInfo'] = priceInfo?.toJson();
    }
    return map;
  }

}

/// btc : 36306.37
/// space : 16.98

class PriceInfo {
  PriceInfo({
      this.btc, 
      this.space,});

  PriceInfo.fromJson(dynamic json) {
    btc = json['btc'];
    space = json['space'];
  }
  num? btc;
  num? space;
PriceInfo copyWith({  num? btc,
  num? space,
}) => PriceInfo(  btc: btc ?? this.btc,
  space: space ?? this.space,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['btc'] = btc;
    map['space'] = space;
    return map;
  }

}