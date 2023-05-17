/// result : {"rates":[{"symbol":"ME","price":{"CNY":"0.005","USD":"0.00072"},"remark":"1 ME = 0.005 ¥  0.00072 $","updateTime":1683710643156}]}
/// code : 200
/// msg : "success"
/// time : 1683710940340
/// error : "null"

class RateResponse {
  RateResponse({
      this.result, 
      this.code, 
      this.msg, 
      this.time, 
      this.error,});

  RateResponse.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    error = json['error'];
  }
  Result? result;
  num? code;
  String? msg;
  num? time;
  String? error;
RateResponse copyWith({  Result? result,
  num? code,
  String? msg,
  num? time,
  String? error,
}) => RateResponse(  result: result ?? this.result,
  code: code ?? this.code,
  msg: msg ?? this.msg,
  time: time ?? this.time,
  error: error ?? this.error,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['code'] = code;
    map['msg'] = msg;
    map['time'] = time;
    map['error'] = error;
    return map;
  }

}

/// rates : [{"symbol":"ME","price":{"CNY":"0.005","USD":"0.00072"},"remark":"1 ME = 0.005 ¥  0.00072 $","updateTime":1683710643156}]

class Result {
  Result({
      this.rates,});

  Result.fromJson(dynamic json) {
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates?.add(Rates.fromJson(v));
      });
    }
  }
  List<Rates>? rates;
Result copyWith({  List<Rates>? rates,
}) => Result(  rates: rates ?? this.rates,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rates != null) {
      map['rates'] = rates?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// symbol : "ME"
/// price : {"CNY":"0.005","USD":"0.00072"}
/// remark : "1 ME = 0.005 ¥  0.00072 $"
/// updateTime : 1683710643156

class Rates {
  Rates({
      this.symbol, 
      this.price, 
      this.remark, 
      this.updateTime,});

  Rates.fromJson(dynamic json) {
    symbol = json['symbol'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    remark = json['remark'];
    updateTime = json['updateTime'];
  }
  String? symbol;
  Price? price;
  String? remark;
  num? updateTime;
Rates copyWith({  String? symbol,
  Price? price,
  String? remark,
  num? updateTime,
}) => Rates(  symbol: symbol ?? this.symbol,
  price: price ?? this.price,
  remark: remark ?? this.remark,
  updateTime: updateTime ?? this.updateTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    if (price != null) {
      map['price'] = price?.toJson();
    }
    map['remark'] = remark;
    map['updateTime'] = updateTime;
    return map;
  }

}

/// CNY : "0.005"
/// USD : "0.00072"

class Price {
  Price({
      this.cny, 
      this.usd,});

  Price.fromJson(dynamic json) {
    cny = json['CNY'];
    usd = json['USD'];
  }
  String? cny;
  String? usd;
Price copyWith({  String? cny,
  String? usd,
}) => Price(  cny: cny ?? this.cny,
  usd: usd ?? this.usd,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CNY'] = cny;
    map['USD'] = usd;
    return map;
  }

}