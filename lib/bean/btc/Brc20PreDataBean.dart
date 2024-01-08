/// code : 0
/// message : "success"
/// processingTime : 974
/// data : {"payAddress":"bc1pwfrdnqwnfyflxwj76cvnxqnxrxq8m4jz25qamqd46h8xmeyhmzvspxsljq","fee":24570,"orderId":"d879a9d7ed21f64ea7971f8066c73a9d850ee0513c5c6822601ec4590a4a1778","inscriptionState":1,"receiveAddress":"bc1qfzkxgcp26k0ntnwvtg546vsfhwgu6kp9q2hj6d","networkFeeRate":65,"needAmount":24570,"payAmount":0,"minerFee":24570,"serviceFee":0,"count":1}

class Brc20PreDataBean {
  Brc20PreDataBean({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  Brc20PreDataBean.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
Brc20PreDataBean copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => Brc20PreDataBean(  code: code ?? this.code,
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

/// payAddress : "bc1pwfrdnqwnfyflxwj76cvnxqnxrxq8m4jz25qamqd46h8xmeyhmzvspxsljq"
/// fee : 24570
/// orderId : "d879a9d7ed21f64ea7971f8066c73a9d850ee0513c5c6822601ec4590a4a1778"
/// inscriptionState : 1
/// receiveAddress : "bc1qfzkxgcp26k0ntnwvtg546vsfhwgu6kp9q2hj6d"
/// networkFeeRate : 65
/// needAmount : 24570
/// payAmount : 0
/// minerFee : 24570
/// serviceFee : 0
/// count : 1

class Data {
  Data({
      this.payAddress, 
      this.fee, 
      this.orderId, 
      this.inscriptionState, 
      this.receiveAddress, 
      this.networkFeeRate, 
      this.needAmount, 
      this.payAmount, 
      this.minerFee, 
      this.serviceFee, 
      this.count,});

  Data.fromJson(dynamic json) {
    payAddress = json['payAddress'];
    fee = json['fee'];
    orderId = json['orderId'];
    inscriptionState = json['inscriptionState'];
    receiveAddress = json['receiveAddress'];
    networkFeeRate = json['networkFeeRate'];
    needAmount = json['needAmount'];
    payAmount = json['payAmount'];
    minerFee = json['minerFee'];
    serviceFee = json['serviceFee'];
    count = json['count'];
  }
  String? payAddress;
  num? fee;
  String? orderId;
  num? inscriptionState;
  String? receiveAddress;
  num? networkFeeRate;
  num? needAmount;
  num? payAmount;
  num? minerFee;
  num? serviceFee;
  num? count;
Data copyWith({  String? payAddress,
  num? fee,
  String? orderId,
  num? inscriptionState,
  String? receiveAddress,
  num? networkFeeRate,
  num? needAmount,
  num? payAmount,
  num? minerFee,
  num? serviceFee,
  num? count,
}) => Data(  payAddress: payAddress ?? this.payAddress,
  fee: fee ?? this.fee,
  orderId: orderId ?? this.orderId,
  inscriptionState: inscriptionState ?? this.inscriptionState,
  receiveAddress: receiveAddress ?? this.receiveAddress,
  networkFeeRate: networkFeeRate ?? this.networkFeeRate,
  needAmount: needAmount ?? this.needAmount,
  payAmount: payAmount ?? this.payAmount,
  minerFee: minerFee ?? this.minerFee,
  serviceFee: serviceFee ?? this.serviceFee,
  count: count ?? this.count,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payAddress'] = payAddress;
    map['fee'] = fee;
    map['orderId'] = orderId;
    map['inscriptionState'] = inscriptionState;
    map['receiveAddress'] = receiveAddress;
    map['networkFeeRate'] = networkFeeRate;
    map['needAmount'] = needAmount;
    map['payAmount'] = payAmount;
    map['minerFee'] = minerFee;
    map['serviceFee'] = serviceFee;
    map['count'] = count;
    return map;
  }

}