/// flag : "17200_22"
/// address : "1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9"
/// time : 1684119075000
/// height : 17200
/// income : 0
/// outcome : 1000
/// txid : "9f64ada1aa26423fcb07e5a547c65162d7dba94ab5a27dfd13474f432f9849b3"

class TransRecordResponse {
  TransRecordResponse({
      this.flag, 
      this.address, 
      this.time, 
      this.height, 
      this.income, 
      this.outcome, 
      this.txid,});

  TransRecordResponse.fromJson(dynamic json) {
    flag = json['flag'];
    address = json['address'];
    time = json['time'];
    height = json['height'];
    income = json['income'];
    outcome = json['outcome'];
    txid = json['txid'];
  }
  String? flag;
  String? address;
  num? time;
  num? height;
  num? income;
  num? outcome;
  String? txid;
TransRecordResponse copyWith({  String? flag,
  String? address,
  num? time,
  num? height,
  num? income,
  num? outcome,
  String? txid,
}) => TransRecordResponse(  flag: flag ?? this.flag,
  address: address ?? this.address,
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
    map['time'] = time;
    map['height'] = height;
    map['income'] = income;
    map['outcome'] = outcome;
    map['txid'] = txid;
    return map;
  }

}