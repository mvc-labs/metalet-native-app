/// feeAddress : "bc1qfzkxgcp26k0ntnwvtg546vsfhwgu6kp9q2hj6d"
/// net : "livenet"
/// orderId : "9d18058be44a87dbc5e086478f8687564adea05fe6fd65a9fb84726ba5147d55"
/// rawTx : "01000000000101bc6ceb5c20cd41ad6aa809dd6c6d797f9304b85ef8e4e4dc2db619cfb12458dc0100000000ffffffff02103b00000000000016001428a4605eba5956df20e02e7c33bff810fc030913e1bb03000000000016001448ac64602ad59f35cdcc5a295d3209bb91cd58250247304402201d1d6f769e64158eecd1db7899f2c8543f7c7502a16b951ec1b35b8196538d9402203b76e529f7aa512942906acf7869304d88e32bb867ea386528a8923f59d732a9012102e6ba98f298476490e0f59d7e94900aa638114609f818107aaa84dd95ba35616500000000"
/// version : 0
/// addressType : 1

class Brc20CommitRequestBean {
  Brc20CommitRequestBean({
      this.feeAddress, 
      this.net, 
      this.orderId, 
      this.rawTx, 
      this.version, 
      this.addressType,});

  Brc20CommitRequestBean.fromJson(dynamic json) {
    feeAddress = json['feeAddress'];
    net = json['net'];
    orderId = json['orderId'];
    rawTx = json['rawTx'];
    version = json['version'];
    addressType = json['addressType'];
  }
  String? feeAddress;
  String? net;
  String? orderId;
  String? rawTx;
  num? version;
  num? addressType;
Brc20CommitRequestBean copyWith({  String? feeAddress,
  String? net,
  String? orderId,
  String? rawTx,
  num? version,
  num? addressType,
}) => Brc20CommitRequestBean(  feeAddress: feeAddress ?? this.feeAddress,
  net: net ?? this.net,
  orderId: orderId ?? this.orderId,
  rawTx: rawTx ?? this.rawTx,
  version: version ?? this.version,
  addressType: addressType ?? this.addressType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feeAddress'] = feeAddress;
    map['net'] = net;
    map['orderId'] = orderId;
    map['rawTx'] = rawTx;
    map['version'] = version;
    map['addressType'] = addressType;
    return map;
  }

}