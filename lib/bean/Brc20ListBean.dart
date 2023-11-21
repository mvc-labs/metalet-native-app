/// code : 0
/// message : "success"
/// processingTime : 31
/// data : {"page":"1","limit":"50","totalPage":"1","tickList":[{"token":"BTCs","tokenType":"BRC20","balance":"200","availableBalance":"200","transferBalance":"0"},{"token":"ORXC","tokenType":"BRC20","balance":"20","availableBalance":"20","transferBalance":"0"}]}

class Brc20ListBean {
  Brc20ListBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  Brc20ListBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
Brc20ListBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => Brc20ListBean(  code: code ?? this.code,
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

/// page : "1"
/// limit : "50"
/// totalPage : "1"
/// tickList : [{"token":"BTCs","tokenType":"BRC20","balance":"200","availableBalance":"200","transferBalance":"0"},{"token":"ORXC","tokenType":"BRC20","balance":"20","availableBalance":"20","transferBalance":"0"}]

class Data {
  Data({
      this.page, 
      this.limit, 
      this.totalPage, 
      this.tickList,});

  Data.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
    if (json['tickList'] != null) {
      tickList = [];
      json['tickList'].forEach((v) {
        tickList?.add(TickList.fromJson(v));
      });
    }
  }
  String? page;
  String? limit;
  String? totalPage;
  List<TickList>? tickList;
Data copyWith({  String? page,
  String? limit,
  String? totalPage,
  List<TickList>? tickList,
}) => Data(  page: page ?? this.page,
  limit: limit ?? this.limit,
  totalPage: totalPage ?? this.totalPage,
  tickList: tickList ?? this.tickList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['totalPage'] = totalPage;
    if (tickList != null) {
      map['tickList'] = tickList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// token : "BTCs"
/// tokenType : "BRC20"
/// balance : "200"
/// availableBalance : "200"
/// transferBalance : "0"

class TickList {
  TickList({
      this.token, 
      this.tokenType, 
      this.balance, 
      this.availableBalance, 
      this.transferBalance,});

  TickList.fromJson(dynamic json) {
    token = json['token'];
    tokenType = json['tokenType'];
    balance = json['balance'];
    availableBalance = json['availableBalance'];
    transferBalance = json['transferBalance'];
  }
  String? token;
  String? tokenType;
  String? balance;
  String? availableBalance;
  String? transferBalance;
TickList copyWith({  String? token,
  String? tokenType,
  String? balance,
  String? availableBalance,
  String? transferBalance,
}) => TickList(  token: token ?? this.token,
  tokenType: tokenType ?? this.tokenType,
  balance: balance ?? this.balance,
  availableBalance: availableBalance ?? this.availableBalance,
  transferBalance: transferBalance ?? this.transferBalance,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['tokenType'] = tokenType;
    map['balance'] = balance;
    map['availableBalance'] = availableBalance;
    map['transferBalance'] = transferBalance;
    return map;
  }

  @override
  String toString() {
    return 'TickList{token: $token, tokenType: $tokenType, balance: $balance, availableBalance: $availableBalance, transferBalance: $transferBalance}';
  }
}