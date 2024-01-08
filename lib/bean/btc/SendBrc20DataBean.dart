/// feeRate : 44
/// files : [{"filename":"{\"p\":\"brc-20\",\"op\":\"transfer\",\"tick\":\"fish\",\"amt\":\"300\"}","dataURL":"eyJwIjoiYnJjLTIwIiwib3AiOiJ0cmFuc2ZlciIsInRpY2siOiJmaXNoIiwiYW10IjoiMzAwIn0="}]
/// net : "livenet"
/// receiveAddress : "bc1qfzkxgcp26k0ntnwvtg546vsfhwgu6kp9q2hj6d"
/// AddressType : 1

class SendBrc20DataBean {
  SendBrc20DataBean({
      this.feeRate, 
      this.files, 
      this.net, 
      this.receiveAddress, 
      this.addressType,});

  SendBrc20DataBean.fromJson(dynamic json) {
    feeRate = json['feeRate'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(Files.fromJson(v));
      });
    }
    net = json['net'];
    receiveAddress = json['receiveAddress'];
    addressType = json['AddressType'];
  }
  num? feeRate;
  List<Files>? files;
  String? net;
  String? receiveAddress;
  num? addressType;
SendBrc20DataBean copyWith({  num? feeRate,
  List<Files>? files,
  String? net,
  String? receiveAddress,
  num? addressType,
}) => SendBrc20DataBean(  feeRate: feeRate ?? this.feeRate,
  files: files ?? this.files,
  net: net ?? this.net,
  receiveAddress: receiveAddress ?? this.receiveAddress,
  addressType: addressType ?? this.addressType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feeRate'] = feeRate;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['net'] = net;
    map['receiveAddress'] = receiveAddress;
    map['AddressType'] = addressType;
    return map;
  }

}

/// filename : "{\"p\":\"brc-20\",\"op\":\"transfer\",\"tick\":\"fish\",\"amt\":\"300\"}"
/// dataURL : "eyJwIjoiYnJjLTIwIiwib3AiOiJ0cmFuc2ZlciIsInRpY2siOiJmaXNoIiwiYW10IjoiMzAwIn0="

class Files {
  Files({
      this.filename, 
      this.dataURL,});

  Files.fromJson(dynamic json) {
    filename = json['filename'];
    dataURL = json['dataURL'];
  }
  String? filename;
  String? dataURL;
Files copyWith({  String? filename,
  String? dataURL,
}) => Files(  filename: filename ?? this.filename,
  dataURL: dataURL ?? this.dataURL,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filename'] = filename;
    map['dataURL'] = dataURL;
    return map;
  }

}