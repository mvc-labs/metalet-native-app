/// code : 0
/// message : "success"
/// processingTime : 39
/// data : {"address":"1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9","satoshi":1546,"pendingSatoshi":0,"utxoCount":2,"btcSatoshi":1000,"btcPendingSatoshi":0,"btcUtxoCount":1,"inscriptionSatoshi":546,"inscriptionPendingSatoshi":0,"inscriptionUtxoCount":1}

class BtcBalanceResponse {
  BtcBalanceResponse({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcBalanceResponse.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BtcBalanceResponse copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BtcBalanceResponse(  code: code ?? this.code,
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

/// address : "1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9"
/// satoshi : 1546
/// pendingSatoshi : 0
/// utxoCount : 2
/// btcSatoshi : 1000
/// btcPendingSatoshi : 0
/// btcUtxoCount : 1
/// inscriptionSatoshi : 546
/// inscriptionPendingSatoshi : 0
/// inscriptionUtxoCount : 1

class Data {
  Data({
      this.address, 
      this.satoshi, 
      this.pendingSatoshi, 
      this.utxoCount, 
      this.btcSatoshi, 
      this.btcPendingSatoshi, 
      this.btcUtxoCount, 
      this.inscriptionSatoshi, 
      this.inscriptionPendingSatoshi, 
      this.inscriptionUtxoCount,});

  Data.fromJson(dynamic json) {
    address = json['address'];
    satoshi = json['satoshi'];
    pendingSatoshi = json['pendingSatoshi'];
    utxoCount = json['utxoCount'];
    btcSatoshi = json['btcSatoshi'];
    btcPendingSatoshi = json['btcPendingSatoshi'];
    btcUtxoCount = json['btcUtxoCount'];
    inscriptionSatoshi = json['inscriptionSatoshi'];
    inscriptionPendingSatoshi = json['inscriptionPendingSatoshi'];
    inscriptionUtxoCount = json['inscriptionUtxoCount'];
  }
  String? address;
  num? satoshi;
  num? pendingSatoshi;
  num? utxoCount;
  num? btcSatoshi;
  num? btcPendingSatoshi;
  num? btcUtxoCount;
  num? inscriptionSatoshi;
  num? inscriptionPendingSatoshi;
  num? inscriptionUtxoCount;
Data copyWith({  String? address,
  num? satoshi,
  num? pendingSatoshi,
  num? utxoCount,
  num? btcSatoshi,
  num? btcPendingSatoshi,
  num? btcUtxoCount,
  num? inscriptionSatoshi,
  num? inscriptionPendingSatoshi,
  num? inscriptionUtxoCount,
}) => Data(  address: address ?? this.address,
  satoshi: satoshi ?? this.satoshi,
  pendingSatoshi: pendingSatoshi ?? this.pendingSatoshi,
  utxoCount: utxoCount ?? this.utxoCount,
  btcSatoshi: btcSatoshi ?? this.btcSatoshi,
  btcPendingSatoshi: btcPendingSatoshi ?? this.btcPendingSatoshi,
  btcUtxoCount: btcUtxoCount ?? this.btcUtxoCount,
  inscriptionSatoshi: inscriptionSatoshi ?? this.inscriptionSatoshi,
  inscriptionPendingSatoshi: inscriptionPendingSatoshi ?? this.inscriptionPendingSatoshi,
  inscriptionUtxoCount: inscriptionUtxoCount ?? this.inscriptionUtxoCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['satoshi'] = satoshi;
    map['pendingSatoshi'] = pendingSatoshi;
    map['utxoCount'] = utxoCount;
    map['btcSatoshi'] = btcSatoshi;
    map['btcPendingSatoshi'] = btcPendingSatoshi;
    map['btcUtxoCount'] = btcUtxoCount;
    map['inscriptionSatoshi'] = inscriptionSatoshi;
    map['inscriptionPendingSatoshi'] = inscriptionPendingSatoshi;
    map['inscriptionUtxoCount'] = inscriptionUtxoCount;
    return map;
  }

  @override
  String toString() {
    return 'Data{address: $address, satoshi: $satoshi, pendingSatoshi: $pendingSatoshi, utxoCount: $utxoCount, btcSatoshi: $btcSatoshi, btcPendingSatoshi: $btcPendingSatoshi, btcUtxoCount: $btcUtxoCount, inscriptionSatoshi: $inscriptionSatoshi, inscriptionPendingSatoshi: $inscriptionPendingSatoshi, inscriptionUtxoCount: $inscriptionUtxoCount}';
  }
}