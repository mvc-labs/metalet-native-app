/// code : 0
/// message : "success"
/// processingTime : 108
/// data : [{"confirmed":true,"inscriptions":null,"satoshi":425436,"txId":"fab42223fdca49ecbcb2db2b0ebd2025079e135bbd0fad53e108ccea48df860a","vout":1},{"confirmed":true,"inscriptions":null,"satoshi":296221,"txId":"76735be94a60d26dcc0cab97352a08ecc8f1b3cf382ced117e750902dbe488c5","vout":1}]

class BtcUtxoBean {
  BtcUtxoBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcUtxoBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Utxo.fromJson(v));
      });
    }
  }
  num? code;
  String? message;
  num? processingTime;
  List<Utxo>? data;
BtcUtxoBean copyWith({  num? code,
  String? message,
  num? processingTime,
  List<Utxo>? data,
}) => BtcUtxoBean(  code: code ?? this.code,
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
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'BtcUtxoBean{code: $code, message: $message, processingTime: $processingTime, data: $data}';
  }
}

/// confirmed : true
/// inscriptions : null
/// satoshi : 425436
/// txId : "fab42223fdca49ecbcb2db2b0ebd2025079e135bbd0fad53e108ccea48df860a"
/// vout : 1

class Utxo {
  Utxo({
      this.confirmed, 
      this.inscriptions, 
      this.satoshi, 
      this.txId, 
      this.vout,});

  Utxo.fromJson(dynamic json) {
    confirmed = json['confirmed'];
    inscriptions = json['inscriptions'];
    satoshi = json['satoshi'];
    txId = json['txId'];
    vout = json['vout'];
  }
  bool? confirmed;
  dynamic inscriptions;
  num? satoshi;
  String? txId;
  num? vout;
  Utxo copyWith({  bool? confirmed,
  dynamic inscriptions,
  num? satoshi,
  String? txId,
  num? vout,
}) => Utxo(  confirmed: confirmed ?? this.confirmed,
  inscriptions: inscriptions ?? this.inscriptions,
  satoshi: satoshi ?? this.satoshi,
  txId: txId ?? this.txId,
  vout: vout ?? this.vout,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['confirmed'] = confirmed;
    map['inscriptions'] = inscriptions;
    map['satoshi'] = satoshi;
    map['txId'] = txId;
    map['vout'] = vout;
    return map;
  }

  @override
  String toString() {
    return 'Data{confirmed: $confirmed, inscriptions: $inscriptions, satoshi: $satoshi, txId: $txId, vout: $vout}';
  }
}