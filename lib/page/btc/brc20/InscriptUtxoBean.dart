/// code : 0
/// message : "success"
/// processingTime : 23
/// data : {"txId":"22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4","outputIndex":0,"satoshis":546,"scriptPk":"001448ac64602ad59f35cdcc5a295d3209bb91cd5825","addressType":1,"inscriptions":[{"id":"22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4i0","num":53528842,"offset":0}]}

class InscriptUtxoBean {
  InscriptUtxoBean({
      this.code,
      this.message,
      this.processingTime,
      this.data,});

  InscriptUtxoBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
InscriptUtxoBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => InscriptUtxoBean(  code: code ?? this.code,
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

/// txId : "22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4"
/// outputIndex : 0
/// satoshis : 546
/// scriptPk : "001448ac64602ad59f35cdcc5a295d3209bb91cd5825"
/// addressType : 1
/// inscriptions : [{"id":"22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4i0","num":53528842,"offset":0}]

class Data {
  Data({
      this.txId,
      this.outputIndex,
      this.satoshis,
      this.scriptPk,
      this.addressType,
      this.inscriptions,});

  Data.fromJson(dynamic json) {
    txId = json['txId'];
    outputIndex = json['outputIndex'];
    satoshis = json['satoshis'];
    scriptPk = json['scriptPk'];
    addressType = json['addressType'];
    if (json['inscriptions'] != null) {
      inscriptions = [];
      json['inscriptions'].forEach((v) {
        inscriptions?.add(Inscriptions.fromJson(v));
      });
    }
  }
  String? txId;
  num? outputIndex;
  num? satoshis;
  String? scriptPk;
  num? addressType;
  List<Inscriptions>? inscriptions;
Data copyWith({  String? txId,
  num? outputIndex,
  num? satoshis,
  String? scriptPk,
  num? addressType,
  List<Inscriptions>? inscriptions,
}) => Data(  txId: txId ?? this.txId,
  outputIndex: outputIndex ?? this.outputIndex,
  satoshis: satoshis ?? this.satoshis,
  scriptPk: scriptPk ?? this.scriptPk,
  addressType: addressType ?? this.addressType,
  inscriptions: inscriptions ?? this.inscriptions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['txId'] = txId;
    map['outputIndex'] = outputIndex;
    map['satoshis'] = satoshis;
    map['scriptPk'] = scriptPk;
    map['addressType'] = addressType;
    if (inscriptions != null) {
      map['inscriptions'] = inscriptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "22e3e693675d07be68cf1ba827cc7cfe10e94a5248561c2ea5093c0641efc8e4i0"
/// num : 53528842
/// offset : 0

class Inscriptions {
  Inscriptions({
      this.id,
      this.numc,
      this.offset,});

  Inscriptions.fromJson(dynamic json) {
    id = json['id'];
    numc = json['num'];
    offset = json['offset'];
  }
  String? id;
  num? numc;
  num? offset;
Inscriptions copyWith({  String? id,
  num? num,
  num? offset,
}) => Inscriptions(  id: id ?? this.id,
  numc: num ?? this.numc,
  offset: offset ?? this.offset,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['num'] = num;
    map['offset'] = offset;
    return map;
  }

}