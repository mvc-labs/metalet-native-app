/// code : 0
/// message : "success"
/// processingTime : 136
/// data : {"orderId":"93b925be104387a7fe48559c089e7d3e59054fa93194775ca0a9246d9494abaf","commitTxHash":"0c1d6cff60eed95e591756e0960adb13c5790486711b056a38dd937a0f23556a","revealTxHashList":["22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4"],"inscriptionIdList":["22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4i0"],"inscriptionState":4,"inscriptionInfos":null}

class Brc20CommitResponseBean {
  Brc20CommitResponseBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  Brc20CommitResponseBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
Brc20CommitResponseBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => Brc20CommitResponseBean(  code: code ?? this.code,
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

/// orderId : "93b925be104387a7fe48559c089e7d3e59054fa93194775ca0a9246d9494abaf"
/// commitTxHash : "0c1d6cff60eed95e591756e0960adb13c5790486711b056a38dd937a0f23556a"
/// revealTxHashList : ["22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4"]
/// inscriptionIdList : ["22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4i0"]
/// inscriptionState : 4
/// inscriptionInfos : null

class Data {
  Data({
      this.orderId, 
      this.commitTxHash, 
      this.revealTxHashList, 
      this.inscriptionIdList, 
      this.inscriptionState, 
      this.inscriptionInfos,});

  Data.fromJson(dynamic json) {
    orderId = json['orderId'];
    commitTxHash = json['commitTxHash'];
    revealTxHashList = json['revealTxHashList'] != null ? json['revealTxHashList'].cast<String>() : [];
    inscriptionIdList = json['inscriptionIdList'] != null ? json['inscriptionIdList'].cast<String>() : [];
    inscriptionState = json['inscriptionState'];
    inscriptionInfos = json['inscriptionInfos'];
  }
  String? orderId;
  String? commitTxHash;
  List<String>? revealTxHashList;
  List<String>? inscriptionIdList;
  num? inscriptionState;
  dynamic inscriptionInfos;
Data copyWith({  String? orderId,
  String? commitTxHash,
  List<String>? revealTxHashList,
  List<String>? inscriptionIdList,
  num? inscriptionState,
  dynamic inscriptionInfos,
}) => Data(  orderId: orderId ?? this.orderId,
  commitTxHash: commitTxHash ?? this.commitTxHash,
  revealTxHashList: revealTxHashList ?? this.revealTxHashList,
  inscriptionIdList: inscriptionIdList ?? this.inscriptionIdList,
  inscriptionState: inscriptionState ?? this.inscriptionState,
  inscriptionInfos: inscriptionInfos ?? this.inscriptionInfos,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['commitTxHash'] = commitTxHash;
    map['revealTxHashList'] = revealTxHashList;
    map['inscriptionIdList'] = inscriptionIdList;
    map['inscriptionState'] = inscriptionState;
    map['inscriptionInfos'] = inscriptionInfos;
    return map;
  }

}