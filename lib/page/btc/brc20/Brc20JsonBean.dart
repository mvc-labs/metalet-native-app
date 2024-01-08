/// p : "brc-20"
/// op : "transfer"
/// tick : "fish"
/// amt : "100"

class Brc20JsonBean {
  Brc20JsonBean({
     required this.p,
     required this.op,
     required this.tick,
      required this.amt,});

  Brc20JsonBean.fromJson(dynamic json) {
    p = json['p'];
    op = json['op'];
    tick = json['tick'];
    amt = json['amt'];
  }
  String? p;
  String? op;
  String? tick;
  String? amt;
Brc20JsonBean copyWith({  String? p,
  String? op,
  String? tick,
  String? amt,
}) => Brc20JsonBean(  p: p ?? this.p,
  op: op ?? this.op,
  tick: tick ?? this.tick,
  amt: amt ?? this.amt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p'] = p;
    map['op'] = op;
    map['tick'] = tick;
    map['amt'] = amt;
    return map;
  }

  @override
  String toString() {
    return 'Brc20JsonBean{p: $p, op: $op, tick: $tick, amt: $amt}';
  }
}