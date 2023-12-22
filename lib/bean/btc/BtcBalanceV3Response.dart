/// code : 0
/// message : "success"
/// processingTime : 49
/// data : {"balance":0.0006451,"block":{"incomeFee":0.6412436,"spendFee":0.6405985},"mempool":{"incomeFee":0,"spendFee":0}}

class BtcBalanceV3Response {
  BtcBalanceV3Response({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcBalanceV3Response.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BtcBalanceV3Response copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BtcBalanceV3Response(  code: code ?? this.code,
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

/// balance : 0.0006451
/// block : {"incomeFee":0.6412436,"spendFee":0.6405985}
/// mempool : {"incomeFee":0,"spendFee":0}

class Data {
  Data({
      this.balance, 
      this.block, 
      this.mempool,});

  Data.fromJson(dynamic json) {
    balance = json['balance'];
    block = json['block'] != null ? Block.fromJson(json['block']) : null;
    mempool = json['mempool'] != null ? Mempool.fromJson(json['mempool']) : null;
  }
  num? balance;
  Block? block;
  Mempool? mempool;
Data copyWith({  num? balance,
  Block? block,
  Mempool? mempool,
}) => Data(  balance: balance ?? this.balance,
  block: block ?? this.block,
  mempool: mempool ?? this.mempool,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    if (block != null) {
      map['block'] = block?.toJson();
    }
    if (mempool != null) {
      map['mempool'] = mempool?.toJson();
    }
    return map;
  }

}

/// incomeFee : 0
/// spendFee : 0

class Mempool {
  Mempool({
      this.incomeFee, 
      this.spendFee,});

  Mempool.fromJson(dynamic json) {
    incomeFee = json['incomeFee'];
    spendFee = json['spendFee'];
  }
  num? incomeFee;
  num? spendFee;
Mempool copyWith({  num? incomeFee,
  num? spendFee,
}) => Mempool(  incomeFee: incomeFee ?? this.incomeFee,
  spendFee: spendFee ?? this.spendFee,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['incomeFee'] = incomeFee;
    map['spendFee'] = spendFee;
    return map;
  }

}

/// incomeFee : 0.6412436
/// spendFee : 0.6405985

class Block {
  Block({
      this.incomeFee, 
      this.spendFee,});

  Block.fromJson(dynamic json) {
    incomeFee = json['incomeFee'];
    spendFee = json['spendFee'];
  }
  num? incomeFee;
  num? spendFee;
Block copyWith({  num? incomeFee,
  num? spendFee,
}) => Block(  incomeFee: incomeFee ?? this.incomeFee,
  spendFee: spendFee ?? this.spendFee,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['incomeFee'] = incomeFee;
    map['spendFee'] = spendFee;
    return map;
  }

}