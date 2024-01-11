/// code : 0
/// message : "success"
/// processingTime : 19
/// data : {"Brc20List":[{"ticker":"fish","overallBalance":"2500","transferableBalance":"0","availableBalance":"2500","availableBalanceSafe":"2200","availableBalanceUnSafe":"300","decimal":18},{"ticker":"OXBT","overallBalance":"0","transferableBalance":"0","availableBalance":"0","availableBalanceSafe":"0","availableBalanceUnSafe":"0","decimal":18},{"ticker":"RDEX","overallBalance":"0","transferableBalance":"0","availableBalance":"0","availableBalanceSafe":"0","availableBalanceUnSafe":"0","decimal":18}],"total":3}

class Brc20ListV2Bean {
  Brc20ListV2Bean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  Brc20ListV2Bean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
Brc20ListV2Bean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => Brc20ListV2Bean(  code: code ?? this.code,
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

/// Brc20List : [{"ticker":"fish","overallBalance":"2500","transferableBalance":"0","availableBalance":"2500","availableBalanceSafe":"2200","availableBalanceUnSafe":"300","decimal":18},{"ticker":"OXBT","overallBalance":"0","transferableBalance":"0","availableBalance":"0","availableBalanceSafe":"0","availableBalanceUnSafe":"0","decimal":18},{"ticker":"RDEX","overallBalance":"0","transferableBalance":"0","availableBalance":"0","availableBalanceSafe":"0","availableBalanceUnSafe":"0","decimal":18}]
/// total : 3

class Data {
  Data({
      this.brc20List, 
      this.total,});

  Data.fromJson(dynamic json) {
    if (json['list'] != null) {
      brc20List = [];
      json['list'].forEach((v) {
        brc20List?.add(Brc20List.fromJson(v));
      });
    }
    total = json['total'];
  }
  List<Brc20List>? brc20List;
  num? total;
Data copyWith({  List<Brc20List>? brc20List,
  num? total,
}) => Data(  brc20List: brc20List ?? this.brc20List,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (brc20List != null) {
      map['list'] = brc20List?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }

}

/// ticker : "fish"
/// overallBalance : "2500"
/// transferableBalance : "0"
/// availableBalance : "2500"
/// availableBalanceSafe : "2200"
/// availableBalanceUnSafe : "300"
/// decimal : 18

class Brc20List {
  Brc20List({
      this.ticker, 
      this.overallBalance, 
      this.transferableBalance, 
      this.availableBalance, 
      this.availableBalanceSafe, 
      this.availableBalanceUnSafe, 
      this.decimal,});

  Brc20List.fromJson(dynamic json) {
    ticker = json['ticker'];
    overallBalance = json['overallBalance'];
    transferableBalance = json['transferableBalance'];
    availableBalance = json['availableBalance'];
    availableBalanceSafe = json['availableBalanceSafe'];
    availableBalanceUnSafe = json['availableBalanceUnSafe'];
    decimal = json['decimal'];
  }
  String? ticker;
  String? overallBalance;
  String? transferableBalance;
  String? availableBalance;
  String? availableBalanceSafe;
  String? availableBalanceUnSafe;
  num? decimal;
Brc20List copyWith({  String? ticker,
  String? overallBalance,
  String? transferableBalance,
  String? availableBalance,
  String? availableBalanceSafe,
  String? availableBalanceUnSafe,
  num? decimal,
}) => Brc20List(  ticker: ticker ?? this.ticker,
  overallBalance: overallBalance ?? this.overallBalance,
  transferableBalance: transferableBalance ?? this.transferableBalance,
  availableBalance: availableBalance ?? this.availableBalance,
  availableBalanceSafe: availableBalanceSafe ?? this.availableBalanceSafe,
  availableBalanceUnSafe: availableBalanceUnSafe ?? this.availableBalanceUnSafe,
  decimal: decimal ?? this.decimal,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticker'] = ticker;
    map['overallBalance'] = overallBalance;
    map['transferableBalance'] = transferableBalance;
    map['availableBalance'] = availableBalance;
    map['availableBalanceSafe'] = availableBalanceSafe;
    map['availableBalanceUnSafe'] = availableBalanceUnSafe;
    map['decimal'] = decimal;
    return map;
  }

}