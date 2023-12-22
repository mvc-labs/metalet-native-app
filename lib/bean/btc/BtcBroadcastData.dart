/// code : 0
/// message : "success"
/// processingTime : 2
/// data : "f2d64d7ee1733ffbe98a7125c7288dad67e3f6bae1796b30833e7f146e345dff"

class BtcBroadcastData {
  BtcBroadcastData({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BtcBroadcastData.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'];
  }
  num? code;
  String? message;
  num? processingTime;
  String? data;
BtcBroadcastData copyWith({  num? code,
  String? message,
  num? processingTime,
  String? data,
}) => BtcBroadcastData(  code: code ?? this.code,
  message: message ?? this.message,
  processingTime: processingTime ?? this.processingTime,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['processingTime'] = processingTime;
    map['data'] = data;
    return map;
  }

}