/// code : 0
/// message : "success"
/// processingTime : 99
/// data : {"page":"1","limit":"50","totalPage":"1","totalTransaction":"1","inscriptionsList":[{"txId":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f","blockHeight":"814767","state":"success","tokenType":"BRC20","actionType":"transfer","fromAddress":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","toAddress":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9","amount":"150","token":"ORXC","inscriptionId":"0dc24b6de14b01bcadd60372eb9023a399c1720b2846ed30d9fb185cb193a310i0","inscriptionNumber":"35335707","index":"0","location":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f:0:0","msg":"","time":"1698808462000"}]}

class BtcFtDetailBean {
  BtcFtDetailBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcFtDetailBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BtcFtDetailBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BtcFtDetailBean(  code: code ?? this.code,
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
/// totalTransaction : "1"
/// inscriptionsList : [{"txId":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f","blockHeight":"814767","state":"success","tokenType":"BRC20","actionType":"transfer","fromAddress":"bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn","toAddress":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9","amount":"150","token":"ORXC","inscriptionId":"0dc24b6de14b01bcadd60372eb9023a399c1720b2846ed30d9fb185cb193a310i0","inscriptionNumber":"35335707","index":"0","location":"8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f:0:0","msg":"","time":"1698808462000"}]

class Data {
  Data({
      this.page, 
      this.limit, 
      this.totalPage, 
      this.totalTransaction, 
      this.inscriptionsList,});

  Data.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
    totalTransaction = json['totalTransaction'];
    if (json['inscriptionsList'] != null) {
      inscriptionsList = [];
      json['inscriptionsList'].forEach((v) {
        inscriptionsList?.add(InscriptionsList.fromJson(v));
      });
    }
  }
  String? page;
  String? limit;
  String? totalPage;
  String? totalTransaction;
  List<InscriptionsList>? inscriptionsList;
Data copyWith({  String? page,
  String? limit,
  String? totalPage,
  String? totalTransaction,
  List<InscriptionsList>? inscriptionsList,
}) => Data(  page: page ?? this.page,
  limit: limit ?? this.limit,
  totalPage: totalPage ?? this.totalPage,
  totalTransaction: totalTransaction ?? this.totalTransaction,
  inscriptionsList: inscriptionsList ?? this.inscriptionsList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['totalPage'] = totalPage;
    map['totalTransaction'] = totalTransaction;
    if (inscriptionsList != null) {
      map['inscriptionsList'] = inscriptionsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// txId : "8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f"
/// blockHeight : "814767"
/// state : "success"
/// tokenType : "BRC20"
/// actionType : "transfer"
/// fromAddress : "bc1qpau0rfvstjf8qzj3rgtcp34swlyukrchk9ddkn"
/// toAddress : "1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9"
/// amount : "150"
/// token : "ORXC"
/// inscriptionId : "0dc24b6de14b01bcadd60372eb9023a399c1720b2846ed30d9fb185cb193a310i0"
/// inscriptionNumber : "35335707"
/// index : "0"
/// location : "8675745b946561f0dbac6aac02ae4c96c269a7258b6a95521c4d7f5b92883e9f:0:0"
/// msg : ""
/// time : "1698808462000"

class InscriptionsList {
  InscriptionsList({
      this.txId, 
      this.blockHeight, 
      this.state, 
      this.tokenType, 
      this.actionType, 
      this.fromAddress, 
      this.toAddress, 
      this.amount, 
      this.token, 
      this.inscriptionId, 
      this.inscriptionNumber, 
      this.index, 
      this.location, 
      this.msg, 
      this.time,});

  InscriptionsList.fromJson(dynamic json) {
    txId = json['txId'];
    blockHeight = json['blockHeight'];
    state = json['state'];
    tokenType = json['tokenType'];
    actionType = json['actionType'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    amount = json['amount'];
    token = json['token'];
    inscriptionId = json['inscriptionId'];
    inscriptionNumber = json['inscriptionNumber'];
    index = json['index'];
    location = json['location'];
    msg = json['msg'];
    time = json['time'];
  }
  String? txId;
  String? blockHeight;
  String? state;
  String? tokenType;
  String? actionType;
  String? fromAddress;
  String? toAddress;
  String? amount;
  String? token;
  String? inscriptionId;
  String? inscriptionNumber;
  String? index;
  String? location;
  String? msg;
  String? time;
InscriptionsList copyWith({  String? txId,
  String? blockHeight,
  String? state,
  String? tokenType,
  String? actionType,
  String? fromAddress,
  String? toAddress,
  String? amount,
  String? token,
  String? inscriptionId,
  String? inscriptionNumber,
  String? index,
  String? location,
  String? msg,
  String? time,
}) => InscriptionsList(  txId: txId ?? this.txId,
  blockHeight: blockHeight ?? this.blockHeight,
  state: state ?? this.state,
  tokenType: tokenType ?? this.tokenType,
  actionType: actionType ?? this.actionType,
  fromAddress: fromAddress ?? this.fromAddress,
  toAddress: toAddress ?? this.toAddress,
  amount: amount ?? this.amount,
  token: token ?? this.token,
  inscriptionId: inscriptionId ?? this.inscriptionId,
  inscriptionNumber: inscriptionNumber ?? this.inscriptionNumber,
  index: index ?? this.index,
  location: location ?? this.location,
  msg: msg ?? this.msg,
  time: time ?? this.time,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['txId'] = txId;
    map['blockHeight'] = blockHeight;
    map['state'] = state;
    map['tokenType'] = tokenType;
    map['actionType'] = actionType;
    map['fromAddress'] = fromAddress;
    map['toAddress'] = toAddress;
    map['amount'] = amount;
    map['token'] = token;
    map['inscriptionId'] = inscriptionId;
    map['inscriptionNumber'] = inscriptionNumber;
    map['index'] = index;
    map['location'] = location;
    map['msg'] = msg;
    map['time'] = time;
    return map;
  }

}