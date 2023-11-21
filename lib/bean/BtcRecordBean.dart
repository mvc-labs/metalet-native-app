/// code : 0
/// message : "success"
/// processingTime : 185
/// data : {"page":"1","limit":"50","totalPage":"1","transactionList":[{"txId":"9b7ad460e375e52581f5ec8cadacf04726829d2c519f9d22c9ea802f5eacb72b","methodId":"","blockHash":"000000000000000000022c7821bda2f848ee0a00858d875bae2843e83916cbf1","height":"814767","transactionTime":"1698808462000","from":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","to":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","amount":"0.00001","transactionSymbol":"BTC","txFee":"0.00002606"},{"txId":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f","methodId":"","blockHash":"000000000000000000022c7821bda2f848ee0a00858d875bae2843e83916cbf1","height":"814767","transactionTime":"1698808462000","from":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","to":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","amount":"0.00000546","transactionSymbol":"BTC","txFee":"0.00003825"}]}

class BtcRecordBean {
  BtcRecordBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcRecordBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BtcRecordBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BtcRecordBean(  code: code ?? this.code,
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
/// transactionList : [{"txId":"9b7ad460e375e52581f5ec8cadacf04726829d2c519f9d22c9ea802f5eacb72b","methodId":"","blockHash":"000000000000000000022c7821bda2f848ee0a00858d875bae2843e83916cbf1","height":"814767","transactionTime":"1698808462000","from":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","to":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","amount":"0.00001","transactionSymbol":"BTC","txFee":"0.00002606"},{"txId":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f","methodId":"","blockHash":"000000000000000000022c7821bda2f848ee0a00858d875bae2843e83916cbf1","height":"814767","transactionTime":"1698808462000","from":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","to":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","amount":"0.00000546","transactionSymbol":"BTC","txFee":"0.00003825"}]

class Data {
  Data({
      this.page, 
      this.limit, 
      this.totalPage, 
      this.transactionList,});

  Data.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
    if (json['transactionList'] != null) {
      transactionList = [];
      json['transactionList'].forEach((v) {
        transactionList?.add(TransactionList.fromJson(v));
      });
    }
  }
  String? page;
  String? limit;
  String? totalPage;
  List<TransactionList>? transactionList;
Data copyWith({  String? page,
  String? limit,
  String? totalPage,
  List<TransactionList>? transactionList,
}) => Data(  page: page ?? this.page,
  limit: limit ?? this.limit,
  totalPage: totalPage ?? this.totalPage,
  transactionList: transactionList ?? this.transactionList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['totalPage'] = totalPage;
    if (transactionList != null) {
      map['transactionList'] = transactionList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// txId : "9b7ad460e375e52581f5ec8cadacf04726829d2c519f9d22c9ea802f5eacb72b"
/// methodId : ""
/// blockHash : "000000000000000000022c7821bda2f848ee0a00858d875bae2843e83916cbf1"
/// height : "814767"
/// transactionTime : "1698808462000"
/// from : "bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn"
/// to : "1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9,bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn"
/// amount : "0.00001"
/// transactionSymbol : "BTC"
/// txFee : "0.00002606"

class TransactionList {
  TransactionList({
      this.txId, 
      this.methodId, 
      this.blockHash, 
      this.height, 
      this.transactionTime, 
      this.from, 
      this.to, 
      this.amount, 
      this.transactionSymbol, 
      this.txFee,});

  TransactionList.fromJson(dynamic json) {
    txId = json['txId'];
    methodId = json['methodId'];
    blockHash = json['blockHash'];
    height = json['height'];
    transactionTime = json['transactionTime'];
    from = json['from'];
    to = json['to'];
    amount = json['amount'];
    transactionSymbol = json['transactionSymbol'];
    txFee = json['txFee'];
  }
  String? txId;
  String? methodId;
  String? blockHash;
  String? height;
  String? transactionTime;
  String? from;
  String? to;
  String? amount;
  String? transactionSymbol;
  String? txFee;
TransactionList copyWith({  String? txId,
  String? methodId,
  String? blockHash,
  String? height,
  String? transactionTime,
  String? from,
  String? to,
  String? amount,
  String? transactionSymbol,
  String? txFee,
}) => TransactionList(  txId: txId ?? this.txId,
  methodId: methodId ?? this.methodId,
  blockHash: blockHash ?? this.blockHash,
  height: height ?? this.height,
  transactionTime: transactionTime ?? this.transactionTime,
  from: from ?? this.from,
  to: to ?? this.to,
  amount: amount ?? this.amount,
  transactionSymbol: transactionSymbol ?? this.transactionSymbol,
  txFee: txFee ?? this.txFee,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['txId'] = txId;
    map['methodId'] = methodId;
    map['blockHash'] = blockHash;
    map['height'] = height;
    map['transactionTime'] = transactionTime;
    map['from'] = from;
    map['to'] = to;
    map['amount'] = amount;
    map['transactionSymbol'] = transactionSymbol;
    map['txFee'] = txFee;
    return map;
  }

}