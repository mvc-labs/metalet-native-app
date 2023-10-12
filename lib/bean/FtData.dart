/// code : 0
/// data : {"total":4,"results":{"info":{"version":"1.0.0","responseTime":"130"},"items":[{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"b2d75931958114e48c9927160f80363eae78e2dc","genesisTxId":"93c13d99b017bca82edb78f64e20ef3b77fe7e0ba7809de5baed341c3664e48b","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"8be464361c34edbae59d80a70b7efe773bef204ef678db2ea8bc17b0993dc19300000000","symbol":"MSP","totalSupply":0,"totalSupplyStr":"0","balance":"2.00000000","decimalNum":8,"name":"MVCSWAP Token","desc":"","icon":"","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"","issuer":"","timestamp":0,"issueVersion":""},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"185b4c8fb97a133f1587411b449d30d87ce7d155","genesisTxId":"9227feadb9e5809e1e6ea40e3e0fce63986a6843ec0d04edefe0ab5580c3f5f1","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"f1f5c38055abe0efed040dec43686a9863ce0f3e0ea46e1e9e80e5b9adfe279200000000","symbol":"SHOW","totalSupply":20000000000000000,"totalSupplyStr":"200000000","balance":"0.94813000","decimalNum":8,"name":"ShowCoin","desc":"ShowCoin是由新加坡机构ShowFuture Foundation 发行的为了奖励用户推广和使用Show平台的积分奖励","icon":"metafile://c0a49a45919ab4a2b60f52aaa585afff02b40240ce700ec1157b196ab375da53","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://showfuture.foundation","issuer":"ShowFuture Foundation","timestamp":1688549807620,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"07e4c5a9f866164108de005be81d40ccbd2e964c","genesisTxId":"8f698172f1272083c3ec8f1b37785d2f20cd5e5b493329e57dab16ef921abd85","issueList":[{"issueTxId":"49cc97133beb39921fcdc577534639bd96132b583c31b268846a0a1a22558e2d"}],"sensibleId":"85bd1a92ef16ab7de52933495b5ecd202f5d78371b8fecc3832027f17281698f00000000","symbol":"MC","totalSupply":80000000000000000,"totalSupplyStr":"800000000","balance":"1388.18548330","decimalNum":8,"name":"MetaCoin","desc":"MetaCoin是一个由于OMF发行的，用于激励用户使用MetaID相关应用，创造MetaID交易的通证。发行方：OpenMetanetFoundation （简称OMF），OMF是一家位于新加坡的非营利基金会，致力于推动MetaNet应用的开放和普及。发行总量：8亿枚","icon":"metafile://b8ab60fb3f4bf74facb7020ed0678ef6fdd0423daf07e5ae65a0fa5e8481c03e","iconUrl":"https://filecdn.showpay.top/coin/icon/mc.png","website":"https://omf.foundation","issuer":"OpenMetaNetFoundation","timestamp":1688639603743,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"2cb16123d2473da1972a818af7ed22fafc149f79","genesisTxId":"9185464226d30d7581fa4aa90ce9d60ea20e1b5afcab66f7e141aee4fec1834e","issueList":[{"issueTxId":"6d689929ebc93b29f449a32904cf8db614ea77b7c5a7aecdff3d76eadc50e275"}],"sensibleId":"4e83c1fee4ae41e1f766abfc5a1b0ea20ed6e90ca94afa81750dd3264246859100000000","symbol":"星能","totalSupply":1000000000000000,"totalSupplyStr":"10000000","balance":"153.72695678","decimalNum":8,"name":"星能","desc":"VISION WAR游戏的通用能源， 总量1000万。源于VISION DOME，归于VISION DOME。","icon":"metafile://a1620e6c43636d8c125cfab92c9ab93ea99a871317dceffb32d6c330692b364b","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://www.show3.io/talk/channels/visionbot.metaid","issuer":"visionbot","timestamp":1690124753458,"issueVersion":"1.0.0"}]}}

class FtData {
  FtData({
      this.code,
      this.data,});

  FtData.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  Data? data;
FtData copyWith({  num? code,
  Data? data,
}) => FtData(  code: code ?? this.code,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// total : 4
/// results : {"info":{"version":"1.0.0","responseTime":"130"},"items":[{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"b2d75931958114e48c9927160f80363eae78e2dc","genesisTxId":"93c13d99b017bca82edb78f64e20ef3b77fe7e0ba7809de5baed341c3664e48b","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"8be464361c34edbae59d80a70b7efe773bef204ef678db2ea8bc17b0993dc19300000000","symbol":"MSP","totalSupply":0,"totalSupplyStr":"0","balance":"2.00000000","decimalNum":8,"name":"MVCSWAP Token","desc":"","icon":"","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"","issuer":"","timestamp":0,"issueVersion":""},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"185b4c8fb97a133f1587411b449d30d87ce7d155","genesisTxId":"9227feadb9e5809e1e6ea40e3e0fce63986a6843ec0d04edefe0ab5580c3f5f1","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"f1f5c38055abe0efed040dec43686a9863ce0f3e0ea46e1e9e80e5b9adfe279200000000","symbol":"SHOW","totalSupply":20000000000000000,"totalSupplyStr":"200000000","balance":"0.94813000","decimalNum":8,"name":"ShowCoin","desc":"ShowCoin是由新加坡机构ShowFuture Foundation 发行的为了奖励用户推广和使用Show平台的积分奖励","icon":"metafile://c0a49a45919ab4a2b60f52aaa585afff02b40240ce700ec1157b196ab375da53","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://showfuture.foundation","issuer":"ShowFuture Foundation","timestamp":1688549807620,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"07e4c5a9f866164108de005be81d40ccbd2e964c","genesisTxId":"8f698172f1272083c3ec8f1b37785d2f20cd5e5b493329e57dab16ef921abd85","issueList":[{"issueTxId":"49cc97133beb39921fcdc577534639bd96132b583c31b268846a0a1a22558e2d"}],"sensibleId":"85bd1a92ef16ab7de52933495b5ecd202f5d78371b8fecc3832027f17281698f00000000","symbol":"MC","totalSupply":80000000000000000,"totalSupplyStr":"800000000","balance":"1388.18548330","decimalNum":8,"name":"MetaCoin","desc":"MetaCoin是一个由于OMF发行的，用于激励用户使用MetaID相关应用，创造MetaID交易的通证。发行方：OpenMetanetFoundation （简称OMF），OMF是一家位于新加坡的非营利基金会，致力于推动MetaNet应用的开放和普及。发行总量：8亿枚","icon":"metafile://b8ab60fb3f4bf74facb7020ed0678ef6fdd0423daf07e5ae65a0fa5e8481c03e","iconUrl":"https://filecdn.showpay.top/coin/icon/mc.png","website":"https://omf.foundation","issuer":"OpenMetaNetFoundation","timestamp":1688639603743,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"2cb16123d2473da1972a818af7ed22fafc149f79","genesisTxId":"9185464226d30d7581fa4aa90ce9d60ea20e1b5afcab66f7e141aee4fec1834e","issueList":[{"issueTxId":"6d689929ebc93b29f449a32904cf8db614ea77b7c5a7aecdff3d76eadc50e275"}],"sensibleId":"4e83c1fee4ae41e1f766abfc5a1b0ea20ed6e90ca94afa81750dd3264246859100000000","symbol":"星能","totalSupply":1000000000000000,"totalSupplyStr":"10000000","balance":"153.72695678","decimalNum":8,"name":"星能","desc":"VISION WAR游戏的通用能源， 总量1000万。源于VISION DOME，归于VISION DOME。","icon":"metafile://a1620e6c43636d8c125cfab92c9ab93ea99a871317dceffb32d6c330692b364b","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://www.show3.io/talk/channels/visionbot.metaid","issuer":"visionbot","timestamp":1690124753458,"issueVersion":"1.0.0"}]}

class Data {
  Data({
      this.total,
      this.results,});

  Data.fromJson(dynamic json) {
    total = json['total'];
    results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }
  num? total;
  Results? results;
Data copyWith({  num? total,
  Results? results,
}) => Data(  total: total ?? this.total,
  results: results ?? this.results,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }

}

/// info : {"version":"1.0.0","responseTime":"130"}
/// items : [{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"b2d75931958114e48c9927160f80363eae78e2dc","genesisTxId":"93c13d99b017bca82edb78f64e20ef3b77fe7e0ba7809de5baed341c3664e48b","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"8be464361c34edbae59d80a70b7efe773bef204ef678db2ea8bc17b0993dc19300000000","symbol":"MSP","totalSupply":0,"totalSupplyStr":"0","balance":"2.00000000","decimalNum":8,"name":"MVCSWAP Token","desc":"","icon":"","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"","issuer":"","timestamp":0,"issueVersion":""},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"185b4c8fb97a133f1587411b449d30d87ce7d155","genesisTxId":"9227feadb9e5809e1e6ea40e3e0fce63986a6843ec0d04edefe0ab5580c3f5f1","issueList":[{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}],"sensibleId":"f1f5c38055abe0efed040dec43686a9863ce0f3e0ea46e1e9e80e5b9adfe279200000000","symbol":"SHOW","totalSupply":20000000000000000,"totalSupplyStr":"200000000","balance":"0.94813000","decimalNum":8,"name":"ShowCoin","desc":"ShowCoin是由新加坡机构ShowFuture Foundation 发行的为了奖励用户推广和使用Show平台的积分奖励","icon":"metafile://c0a49a45919ab4a2b60f52aaa585afff02b40240ce700ec1157b196ab375da53","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://showfuture.foundation","issuer":"ShowFuture Foundation","timestamp":1688549807620,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"07e4c5a9f866164108de005be81d40ccbd2e964c","genesisTxId":"8f698172f1272083c3ec8f1b37785d2f20cd5e5b493329e57dab16ef921abd85","issueList":[{"issueTxId":"49cc97133beb39921fcdc577534639bd96132b583c31b268846a0a1a22558e2d"}],"sensibleId":"85bd1a92ef16ab7de52933495b5ecd202f5d78371b8fecc3832027f17281698f00000000","symbol":"MC","totalSupply":80000000000000000,"totalSupplyStr":"800000000","balance":"1388.18548330","decimalNum":8,"name":"MetaCoin","desc":"MetaCoin是一个由于OMF发行的，用于激励用户使用MetaID相关应用，创造MetaID交易的通证。发行方：OpenMetanetFoundation （简称OMF），OMF是一家位于新加坡的非营利基金会，致力于推动MetaNet应用的开放和普及。发行总量：8亿枚","icon":"metafile://b8ab60fb3f4bf74facb7020ed0678ef6fdd0423daf07e5ae65a0fa5e8481c03e","iconUrl":"https://filecdn.showpay.top/coin/icon/mc.png","website":"https://omf.foundation","issuer":"OpenMetaNetFoundation","timestamp":1688639603743,"issueVersion":"1.0.0"},{"codehash":"a2421f1e90c6048c36745edd44fad682e8644693","genesis":"2cb16123d2473da1972a818af7ed22fafc149f79","genesisTxId":"9185464226d30d7581fa4aa90ce9d60ea20e1b5afcab66f7e141aee4fec1834e","issueList":[{"issueTxId":"6d689929ebc93b29f449a32904cf8db614ea77b7c5a7aecdff3d76eadc50e275"}],"sensibleId":"4e83c1fee4ae41e1f766abfc5a1b0ea20ed6e90ca94afa81750dd3264246859100000000","symbol":"星能","totalSupply":1000000000000000,"totalSupplyStr":"10000000","balance":"153.72695678","decimalNum":8,"name":"星能","desc":"VISION WAR游戏的通用能源， 总量1000万。源于VISION DOME，归于VISION DOME。","icon":"metafile://a1620e6c43636d8c125cfab92c9ab93ea99a871317dceffb32d6c330692b364b","iconUrl":"https://filecdn.showpay.top/coin/icon/empty-token.png","website":"https://www.show3.io/talk/channels/visionbot.metaid","issuer":"visionbot","timestamp":1690124753458,"issueVersion":"1.0.0"}]

class Results {
  Results({
      this.info,
      this.items,});

  Results.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  Info? info;
  List<Items>? items;
Results copyWith({  Info? info,
  List<Items>? items,
}) => Results(  info: info ?? this.info,
  items: items ?? this.items,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// codehash : "a2421f1e90c6048c36745edd44fad682e8644693"
/// genesis : "b2d75931958114e48c9927160f80363eae78e2dc"
/// genesisTxId : "93c13d99b017bca82edb78f64e20ef3b77fe7e0ba7809de5baed341c3664e48b"
/// issueList : [{"issueTxId":"6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"}]
/// sensibleId : "8be464361c34edbae59d80a70b7efe773bef204ef678db2ea8bc17b0993dc19300000000"
/// symbol : "MSP"
/// totalSupply : 0
/// totalSupplyStr : "0"
/// balance : "2.00000000"
/// decimalNum : 8
/// name : "MVCSWAP Token"
/// desc : ""
/// icon : ""
/// iconUrl : "https://filecdn.showpay.top/coin/icon/empty-token.png"
/// website : ""
/// issuer : ""
/// timestamp : 0
/// issueVersion : ""

class Items {
  Items({
      this.codehash,
      this.genesis,
      this.genesisTxId,
      this.issueList,
      this.sensibleId,
      this.symbol,
      this.totalSupply,
      this.totalSupplyStr,
      this.balance,
      this.decimalNum,
      this.name,
      this.desc,
      this.icon,
      this.iconUrl,
      this.website,
      this.issuer,
      this.timestamp,
      this.issueVersion,});

  Items.fromJson(dynamic json) {
    codehash = json['codehash'];
    genesis = json['genesis'];
    genesisTxId = json['genesisTxId'];
    if (json['issueList'] != null) {
      issueList = [];
      json['issueList'].forEach((v) {
        issueList?.add(IssueList.fromJson(v));
      });
    }
    sensibleId = json['sensibleId'];
    symbol = json['symbol'];
    totalSupply = json['totalSupply'];
    totalSupplyStr = json['totalSupplyStr'];
    balance = json['balance'];
    decimalNum = json['decimalNum'];
    name = json['name'];
    desc = json['desc'];
    icon = json['icon'];
    iconUrl = json['iconUrl'];
    website = json['website'];
    issuer = json['issuer'];
    timestamp = json['timestamp'];
    issueVersion = json['issueVersion'];
  }
  String? codehash;
  String? genesis;
  String? genesisTxId;
  List<IssueList>? issueList;
  String? sensibleId;
  String? symbol;
  num? totalSupply;
  String? totalSupplyStr;
  String? balance;
  num? decimalNum;
  String? name;
  String? desc;
  String? icon;
  String? iconUrl;
  String? website;
  String? issuer;
  num? timestamp;
  String? issueVersion;
Items copyWith({  String? codehash,
  String? genesis,
  String? genesisTxId,
  List<IssueList>? issueList,
  String? sensibleId,
  String? symbol,
  num? totalSupply,
  String? totalSupplyStr,
  String? balance,
  num? decimalNum,
  String? name,
  String? desc,
  String? icon,
  String? iconUrl,
  String? website,
  String? issuer,
  num? timestamp,
  String? issueVersion,
}) => Items(  codehash: codehash ?? this.codehash,
  genesis: genesis ?? this.genesis,
  genesisTxId: genesisTxId ?? this.genesisTxId,
  issueList: issueList ?? this.issueList,
  sensibleId: sensibleId ?? this.sensibleId,
  symbol: symbol ?? this.symbol,
  totalSupply: totalSupply ?? this.totalSupply,
  totalSupplyStr: totalSupplyStr ?? this.totalSupplyStr,
  balance: balance ?? this.balance,
  decimalNum: decimalNum ?? this.decimalNum,
  name: name ?? this.name,
  desc: desc ?? this.desc,
  icon: icon ?? this.icon,
  iconUrl: iconUrl ?? this.iconUrl,
  website: website ?? this.website,
  issuer: issuer ?? this.issuer,
  timestamp: timestamp ?? this.timestamp,
  issueVersion: issueVersion ?? this.issueVersion,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['codehash'] = codehash;
    map['genesis'] = genesis;
    map['genesisTxId'] = genesisTxId;
    if (issueList != null) {
      map['issueList'] = issueList?.map((v) => v.toJson()).toList();
    }
    map['sensibleId'] = sensibleId;
    map['symbol'] = symbol;
    map['totalSupply'] = totalSupply;
    map['totalSupplyStr'] = totalSupplyStr;
    map['balance'] = balance;
    map['decimalNum'] = decimalNum;
    map['name'] = name;
    map['desc'] = desc;
    map['icon'] = icon;
    map['iconUrl'] = iconUrl;
    map['website'] = website;
    map['issuer'] = issuer;
    map['timestamp'] = timestamp;
    map['issueVersion'] = issueVersion;
    return map;
  }

}

/// issueTxId : "6725951cb5fb968c9a3d0a00549e921a1783ece15458427b78c671df10f48746"

class IssueList {
  IssueList({
      this.issueTxId,});

  IssueList.fromJson(dynamic json) {
    issueTxId = json['issueTxId'];
  }
  String? issueTxId;
IssueList copyWith({  String? issueTxId,
}) => IssueList(  issueTxId: issueTxId ?? this.issueTxId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['issueTxId'] = issueTxId;
    return map;
  }

}

/// version : "1.0.0"
/// responseTime : "130"

class Info {
  Info({
      this.version,
      this.responseTime,});

  Info.fromJson(dynamic json) {
    version = json['version'];
    responseTime = json['responseTime'];
  }
  String? version;
  String? responseTime;
Info copyWith({  String? version,
  String? responseTime,
}) => Info(  version: version ?? this.version,
  responseTime: responseTime ?? this.responseTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['responseTime'] = responseTime;
    return map;
  }

}