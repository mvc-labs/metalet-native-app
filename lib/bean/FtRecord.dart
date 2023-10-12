/// flag : "39013_15"
/// address : "1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9"
/// codeHash : "a2421f1e90c6048c36745edd44fad682e8644693"
/// genesis : "07e4c5a9f866164108de005be81d40ccbd2e964c"
/// time : 1697011618000
/// height : 39013
/// income : 136818548320
/// outcome : 137818548320
/// txid : "6df325d6b46ec9a6015c397cfbfab4592bcdaa600f6a5b9197ee305b2e9d5dc5"

class FtRecord {
  FtRecord({
      this.flag, 
      this.address, 
      this.codeHash, 
      this.genesis, 
      this.time, 
      this.height, 
      this.income, 
      this.outcome, 
      this.txid,});

  FtRecord.fromJson(dynamic json) {
    flag = json['flag'];
    address = json['address'];
    codeHash = json['codeHash'];
    genesis = json['genesis'];
    time = json['time'];
    height = json['height'];
    income = json['income'];
    outcome = json['outcome'];
    txid = json['txid'];
  }
  String? flag;
  String? address;
  String? codeHash;
  String? genesis;
  num? time;
  num? height;
  num? income;
  num? outcome;
  String? txid;
FtRecord copyWith({  String? flag,
  String? address,
  String? codeHash,
  String? genesis,
  num? time,
  num? height,
  num? income,
  num? outcome,
  String? txid,
}) => FtRecord(  flag: flag ?? this.flag,
  address: address ?? this.address,
  codeHash: codeHash ?? this.codeHash,
  genesis: genesis ?? this.genesis,
  time: time ?? this.time,
  height: height ?? this.height,
  income: income ?? this.income,
  outcome: outcome ?? this.outcome,
  txid: txid ?? this.txid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flag'] = flag;
    map['address'] = address;
    map['codeHash'] = codeHash;
    map['genesis'] = genesis;
    map['time'] = time;
    map['height'] = height;
    map['income'] = income;
    map['outcome'] = outcome;
    map['txid'] = txid;
    return map;
  }

}