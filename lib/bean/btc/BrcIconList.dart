/// code : 0
/// message : "success"
/// processingTime : 0
/// data : {"brc20_coin":{"bili":"/v3/coin/brc20/icon/bili.jpg","btcs":"/v3/coin/brc20/icon/btcs.jpg","cats":"/v3/coin/brc20/icon/cats.jpg","fish":"/v3/coin/brc20/icon/fish.jpg","grum":"/v3/coin/brc20/icon/grum.png","ibtc":"/v3/coin/brc20/icon/ibtc.jpg","lger":"/v3/coin/brc20/icon/lger.jpg","ordi":"/v3/coin/brc20/icon/ordi.svg","orxc":"/v3/coin/brc20/icon/orxc.png","oxbt":"/v3/coin/brc20/icon/oxbt.png","rats":"/v3/coin/brc20/icon/rats.jpg","rdex":"/v3/coin/brc20/icon/rdex.png","sats":"/v3/coin/brc20/icon/sats.jpg","sayc":"/v3/coin/brc20/icon/sayc.jpg","trac":"/v3/coin/brc20/icon/trac.png","vmpx":"/v3/coin/brc20/icon/vmpx.jpg"},"ft_coin":{"BTC":"/v3/coin/ft/icon/btc-logo.svg","MC":"/v3/coin/ft/icon/mc-logo.svg","MSP":"/v3/coin/ft/icon/msp-logo.png","MVC":"/v3/coin/ft/icon/mvc-logo.svg","ORDI":"/v3/coin/ft/icon/ordi-logo.svg","SHOW":"/v3/coin/ft/icon/sc-logo.svg","SPACE":"/v3/coin/ft/icon/space-logo.svg","USDT":"/v3/coin/ft/icon/usdt-logo.jpg","VEMSP":"/v3/coin/ft/icon/vemsp-logo.png","xingneng":"/v3/coin/ft/icon/xingneng-logo.png"}}

class BrcIconList {
  BrcIconList({
      this.code, 
      this.message, 
      this.processingTime, 
      this.data,});

  BrcIconList.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    processingTime = json['processingTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  num? processingTime;
  Data? data;
BrcIconList copyWith({  num? code,
  String? message,
  num? processingTime,
  Data? data,
}) => BrcIconList(  code: code ?? this.code,
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

/// brc20_coin : {"bili":"/v3/coin/brc20/icon/bili.jpg","btcs":"/v3/coin/brc20/icon/btcs.jpg","cats":"/v3/coin/brc20/icon/cats.jpg","fish":"/v3/coin/brc20/icon/fish.jpg","grum":"/v3/coin/brc20/icon/grum.png","ibtc":"/v3/coin/brc20/icon/ibtc.jpg","lger":"/v3/coin/brc20/icon/lger.jpg","ordi":"/v3/coin/brc20/icon/ordi.svg","orxc":"/v3/coin/brc20/icon/orxc.png","oxbt":"/v3/coin/brc20/icon/oxbt.png","rats":"/v3/coin/brc20/icon/rats.jpg","rdex":"/v3/coin/brc20/icon/rdex.png","sats":"/v3/coin/brc20/icon/sats.jpg","sayc":"/v3/coin/brc20/icon/sayc.jpg","trac":"/v3/coin/brc20/icon/trac.png","vmpx":"/v3/coin/brc20/icon/vmpx.jpg"}
/// ft_coin : {"BTC":"/v3/coin/ft/icon/btc-logo.svg","MC":"/v3/coin/ft/icon/mc-logo.svg","MSP":"/v3/coin/ft/icon/msp-logo.png","MVC":"/v3/coin/ft/icon/mvc-logo.svg","ORDI":"/v3/coin/ft/icon/ordi-logo.svg","SHOW":"/v3/coin/ft/icon/sc-logo.svg","SPACE":"/v3/coin/ft/icon/space-logo.svg","USDT":"/v3/coin/ft/icon/usdt-logo.jpg","VEMSP":"/v3/coin/ft/icon/vemsp-logo.png","xingneng":"/v3/coin/ft/icon/xingneng-logo.png"}

class Data {
  Data({
      this.brc20Coin, 
      this.ftCoin,});

  Data.fromJson(dynamic json) {
    brc20Coin = json['brc20_coin'] != null ? Brc20Coin.fromJson(json['brc20_coin']) : null;
    ftCoin = json['ft_coin'] != null ? FtCoin.fromJson(json['ft_coin']) : null;
  }
  Brc20Coin? brc20Coin;
  FtCoin? ftCoin;
Data copyWith({  Brc20Coin? brc20Coin,
  FtCoin? ftCoin,
}) => Data(  brc20Coin: brc20Coin ?? this.brc20Coin,
  ftCoin: ftCoin ?? this.ftCoin,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (brc20Coin != null) {
      map['brc20_coin'] = brc20Coin?.toJson();
    }
    if (ftCoin != null) {
      map['ft_coin'] = ftCoin?.toJson();
    }
    return map;
  }

}

/// BTC : "/v3/coin/ft/icon/btc-logo.svg"
/// MC : "/v3/coin/ft/icon/mc-logo.svg"
/// MSP : "/v3/coin/ft/icon/msp-logo.png"
/// MVC : "/v3/coin/ft/icon/mvc-logo.svg"
/// ORDI : "/v3/coin/ft/icon/ordi-logo.svg"
/// SHOW : "/v3/coin/ft/icon/sc-logo.svg"
/// SPACE : "/v3/coin/ft/icon/space-logo.svg"
/// USDT : "/v3/coin/ft/icon/usdt-logo.jpg"
/// VEMSP : "/v3/coin/ft/icon/vemsp-logo.png"
/// xingneng : "/v3/coin/ft/icon/xingneng-logo.png"

class FtCoin {
  FtCoin({
      this.btc, 
      this.mc, 
      this.msp, 
      this.mvc, 
      this.ordi, 
      this.show, 
      this.space, 
      this.usdt, 
      this.vemsp, 
      this.xingneng,});

  FtCoin.fromJson(dynamic json) {
    btc = json['BTC'];
    mc = json['MC'];
    msp = json['MSP'];
    mvc = json['MVC'];
    ordi = json['ORDI'];
    show = json['SHOW'];
    space = json['SPACE'];
    usdt = json['USDT'];
    vemsp = json['VEMSP'];
    xingneng = json['xingneng'];
  }
  String? btc;
  String? mc;
  String? msp;
  String? mvc;
  String? ordi;
  String? show;
  String? space;
  String? usdt;
  String? vemsp;
  String? xingneng;
FtCoin copyWith({  String? btc,
  String? mc,
  String? msp,
  String? mvc,
  String? ordi,
  String? show,
  String? space,
  String? usdt,
  String? vemsp,
  String? xingneng,
}) => FtCoin(  btc: btc ?? this.btc,
  mc: mc ?? this.mc,
  msp: msp ?? this.msp,
  mvc: mvc ?? this.mvc,
  ordi: ordi ?? this.ordi,
  show: show ?? this.show,
  space: space ?? this.space,
  usdt: usdt ?? this.usdt,
  vemsp: vemsp ?? this.vemsp,
  xingneng: xingneng ?? this.xingneng,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BTC'] = btc;
    map['MC'] = mc;
    map['MSP'] = msp;
    map['MVC'] = mvc;
    map['ORDI'] = ordi;
    map['SHOW'] = show;
    map['SPACE'] = space;
    map['USDT'] = usdt;
    map['VEMSP'] = vemsp;
    map['xingneng'] = xingneng;
    return map;
  }

}

/// bili : "/v3/coin/brc20/icon/bili.jpg"
/// btcs : "/v3/coin/brc20/icon/btcs.jpg"
/// cats : "/v3/coin/brc20/icon/cats.jpg"
/// fish : "/v3/coin/brc20/icon/fish.jpg"
/// grum : "/v3/coin/brc20/icon/grum.png"
/// ibtc : "/v3/coin/brc20/icon/ibtc.jpg"
/// lger : "/v3/coin/brc20/icon/lger.jpg"
/// ordi : "/v3/coin/brc20/icon/ordi.svg"
/// orxc : "/v3/coin/brc20/icon/orxc.png"
/// oxbt : "/v3/coin/brc20/icon/oxbt.png"
/// rats : "/v3/coin/brc20/icon/rats.jpg"
/// rdex : "/v3/coin/brc20/icon/rdex.png"
/// sats : "/v3/coin/brc20/icon/sats.jpg"
/// sayc : "/v3/coin/brc20/icon/sayc.jpg"
/// trac : "/v3/coin/brc20/icon/trac.png"
/// vmpx : "/v3/coin/brc20/icon/vmpx.jpg"

class Brc20Coin {
  Brc20Coin({
      this.bili, 
      this.btcs, 
      this.cats, 
      this.fish, 
      this.grum, 
      this.ibtc, 
      this.lger, 
      this.ordi, 
      this.orxc, 
      this.oxbt, 
      this.rats, 
      this.rdex, 
      this.sats, 
      this.sayc, 
      this.trac, 
      this.vmpx,});

  Brc20Coin.fromJson(dynamic json) {
    bili = json['bili'];
    btcs = json['btcs'];
    cats = json['cats'];
    fish = json['fish'];
    grum = json['grum'];
    ibtc = json['ibtc'];
    lger = json['lger'];
    ordi = json['ordi'];
    orxc = json['orxc'];
    oxbt = json['oxbt'];
    rats = json['rats'];
    rdex = json['rdex'];
    sats = json['sats'];
    sayc = json['sayc'];
    trac = json['trac'];
    vmpx = json['vmpx'];
  }
  String? bili;
  String? btcs;
  String? cats;
  String? fish;
  String? grum;
  String? ibtc;
  String? lger;
  String? ordi;
  String? orxc;
  String? oxbt;
  String? rats;
  String? rdex;
  String? sats;
  String? sayc;
  String? trac;
  String? vmpx;
Brc20Coin copyWith({  String? bili,
  String? btcs,
  String? cats,
  String? fish,
  String? grum,
  String? ibtc,
  String? lger,
  String? ordi,
  String? orxc,
  String? oxbt,
  String? rats,
  String? rdex,
  String? sats,
  String? sayc,
  String? trac,
  String? vmpx,
}) => Brc20Coin(  bili: bili ?? this.bili,
  btcs: btcs ?? this.btcs,
  cats: cats ?? this.cats,
  fish: fish ?? this.fish,
  grum: grum ?? this.grum,
  ibtc: ibtc ?? this.ibtc,
  lger: lger ?? this.lger,
  ordi: ordi ?? this.ordi,
  orxc: orxc ?? this.orxc,
  oxbt: oxbt ?? this.oxbt,
  rats: rats ?? this.rats,
  rdex: rdex ?? this.rdex,
  sats: sats ?? this.sats,
  sayc: sayc ?? this.sayc,
  trac: trac ?? this.trac,
  vmpx: vmpx ?? this.vmpx,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bili'] = bili;
    map['btcs'] = btcs;
    map['cats'] = cats;
    map['fish'] = fish;
    map['grum'] = grum;
    map['ibtc'] = ibtc;
    map['lger'] = lger;
    map['ordi'] = ordi;
    map['orxc'] = orxc;
    map['oxbt'] = oxbt;
    map['rats'] = rats;
    map['rdex'] = rdex;
    map['sats'] = sats;
    map['sayc'] = sayc;
    map['trac'] = trac;
    map['vmpx'] = vmpx;
    return map;
  }

}