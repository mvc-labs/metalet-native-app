/// code : 0
/// message : "success"
/// processingTime : 31
/// data : {"tokenBalance":{"ticker":"OXBT","availableBalance":"0","transferableBalance":"25000","overallBalance":"25000","availableBalanceSafe":"0","availableBalanceUnSafe":"0"},"historyList":[],"transferableList":[{"inscriptionId":"574d79594ef10a281ba285fce236ec3de4ec874631090336aec87408b34ddefbi0","inscriptionNumber":52718419,"amount":"25000","ticker":"OXBT"}],"tokenInfo":{"totalSupply":"200000000","totalMinted":"200000000"}}

class Brc20Able {
  Brc20Able({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  Brc20Able.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
Brc20Able copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => Brc20Able(  code: code ?? this.code,
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

/// tokenBalance : {"ticker":"OXBT","availableBalance":"0","transferableBalance":"25000","overallBalance":"25000","availableBalanceSafe":"0","availableBalanceUnSafe":"0"}
/// historyList : []
/// transferableList : [{"inscriptionId":"574d79594ef10a281ba285fce236ec3de4ec874631090336aec87408b34ddefbi0","inscriptionNumber":52718419,"amount":"25000","ticker":"OXBT"}]
/// tokenInfo : {"totalSupply":"200000000","totalMinted":"200000000"}

class Data {
  Data({
      this.tokenBalance, 
      this.historyList, 
      this.transferableList, 
      this.tokenInfo,});

  Data.fromJson(dynamic json) {
    tokenBalance = json['tokenBalance'] != null ? TokenBalance.fromJson(json['tokenBalance']) : null;
    if (json['historyList'] != null) {
      historyList = [];
      json['historyList'].forEach((v) {
        //未知数据结构
        // historyList?.add(Dynamic.fromJson(v));
      });
    }
    if (json['transferableList'] != null) {
      transferableList = [];
      json['transferableList'].forEach((v) {
        transferableList?.add(TransferableList.fromJson(v));
      });
    }
    tokenInfo = json['tokenInfo'] != null ? TokenInfo.fromJson(json['tokenInfo']) : null;
  }
  TokenBalance? tokenBalance;
  List<dynamic>? historyList;
  List<TransferableList>? transferableList;
  TokenInfo? tokenInfo;
Data copyWith({  TokenBalance? tokenBalance,
  List<dynamic>? historyList,
  List<TransferableList>? transferableList,
  TokenInfo? tokenInfo,
}) => Data(  tokenBalance: tokenBalance ?? this.tokenBalance,
  historyList: historyList ?? this.historyList,
  transferableList: transferableList ?? this.transferableList,
  tokenInfo: tokenInfo ?? this.tokenInfo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tokenBalance != null) {
      map['tokenBalance'] = tokenBalance?.toJson();
    }
    if (historyList != null) {
      map['historyList'] = historyList?.map((v) => v.toJson()).toList();
    }
    if (transferableList != null) {
      map['transferableList'] = transferableList?.map((v) => v.toJson()).toList();
    }
    if (tokenInfo != null) {
      map['tokenInfo'] = tokenInfo?.toJson();
    }
    return map;
  }

}

/// totalSupply : "200000000"
/// totalMinted : "200000000"

class TokenInfo {
  TokenInfo({
      this.totalSupply, 
      this.totalMinted,});

  TokenInfo.fromJson(dynamic json) {
    totalSupply = json['totalSupply'];
    totalMinted = json['totalMinted'];
  }
  String? totalSupply;
  String? totalMinted;
TokenInfo copyWith({  String? totalSupply,
  String? totalMinted,
}) => TokenInfo(  totalSupply: totalSupply ?? this.totalSupply,
  totalMinted: totalMinted ?? this.totalMinted,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalSupply'] = totalSupply;
    map['totalMinted'] = totalMinted;
    return map;
  }

}

/// inscriptionId : "574d79594ef10a281ba285fce236ec3de4ec874631090336aec87408b34ddefbi0"
/// inscriptionNumber : 52718419
/// amount : "25000"
/// ticker : "OXBT"

class TransferableList {
  TransferableList({
      this.inscriptionId, 
      this.inscriptionNumber, 
      this.amount, 
      this.ticker,});

  TransferableList.fromJson(dynamic json) {
    inscriptionId = json['inscriptionId'];
    inscriptionNumber = json['inscriptionNumber'];
    amount = json['amount'];
    ticker = json['ticker'];
  }
  String? inscriptionId;
  num? inscriptionNumber;
  String? amount;
  String? ticker;
TransferableList copyWith({  String? inscriptionId,
  num? inscriptionNumber,
  String? amount,
  String? ticker,
}) => TransferableList(  inscriptionId: inscriptionId ?? this.inscriptionId,
  inscriptionNumber: inscriptionNumber ?? this.inscriptionNumber,
  amount: amount ?? this.amount,
  ticker: ticker ?? this.ticker,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inscriptionId'] = inscriptionId;
    map['inscriptionNumber'] = inscriptionNumber;
    map['amount'] = amount;
    map['ticker'] = ticker;
    return map;
  }

}

/// ticker : "OXBT"
/// availableBalance : "0"
/// transferableBalance : "25000"
/// overallBalance : "25000"
/// availableBalanceSafe : "0"
/// availableBalanceUnSafe : "0"

class TokenBalance {
  TokenBalance({
      this.ticker, 
      this.availableBalance, 
      this.transferableBalance, 
      this.overallBalance, 
      this.availableBalanceSafe, 
      this.availableBalanceUnSafe,});

  TokenBalance.fromJson(dynamic json) {
    ticker = json['ticker'];
    availableBalance = json['availableBalance'];
    transferableBalance = json['transferableBalance'];
    overallBalance = json['overallBalance'];
    availableBalanceSafe = json['availableBalanceSafe'];
    availableBalanceUnSafe = json['availableBalanceUnSafe'];
  }
  String? ticker;
  String? availableBalance;
  String? transferableBalance;
  String? overallBalance;
  String? availableBalanceSafe;
  String? availableBalanceUnSafe;
TokenBalance copyWith({  String? ticker,
  String? availableBalance,
  String? transferableBalance,
  String? overallBalance,
  String? availableBalanceSafe,
  String? availableBalanceUnSafe,
}) => TokenBalance(  ticker: ticker ?? this.ticker,
  availableBalance: availableBalance ?? this.availableBalance,
  transferableBalance: transferableBalance ?? this.transferableBalance,
  overallBalance: overallBalance ?? this.overallBalance,
  availableBalanceSafe: availableBalanceSafe ?? this.availableBalanceSafe,
  availableBalanceUnSafe: availableBalanceUnSafe ?? this.availableBalanceUnSafe,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticker'] = ticker;
    map['availableBalance'] = availableBalance;
    map['transferableBalance'] = transferableBalance;
    map['overallBalance'] = overallBalance;
    map['availableBalanceSafe'] = availableBalanceSafe;
    map['availableBalanceUnSafe'] = availableBalanceUnSafe;
    return map;
  }

}