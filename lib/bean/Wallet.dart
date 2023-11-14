class Wallet {
  String id = "0";
  String name = "Wallet";
  String mnemonic = "";

  // String path = "m/44'/10001'/0'";
  String path = "10001";
  String address = "";
  String balance = "0.0";
  int isChoose = 0;

  //btc
  String btcAddress="";
  String btcPath="";
  String btcBalance="";


  Wallet(this.mnemonic, this.path, this.address, this.balance, this.id,
      this.name, this.isChoose,this.btcAddress,this.btcPath,this.btcBalance);

  // Map toJson() {
  //   Map map = {};
  //   map["mnemonic"] = mnemonic;
  //   map["path"] = path;
  //   map["address"] = address;
  //   map["balance"] = balance;
  //   map["id"] = id;
  //   map["name"] = name;
  //   map["isChoose"] = isChoose;
  //   return map;
  // }

  Map<String, Object?> toJson() {
    Map<String, Object?> map = {};
    map["mnemonic"] = mnemonic;
    map["path"] = path;
    map["address"] = address;
    map["balance"] = balance;
    map["id"] = id;
    map["name"] = name;
    map["isChoose"] = isChoose;
    map["btcAddress"] = btcAddress;
    map["btcPath"] = btcPath;
    map["btcBalance"] = btcBalance;
    return map;
  }

  factory Wallet.fromJson(Map<String, dynamic> parsedJson) {
    Wallet wallet = Wallet(
        parsedJson['mnemonic'],
        parsedJson['path'],
        parsedJson['address'],
        parsedJson['balance'],
        parsedJson['id'],
        parsedJson['name'],
        parsedJson['isChoose'],
        parsedJson['btcAddress'],
        parsedJson['btcPath'],
        parsedJson['btcBalance']);
    return wallet;
  }

  @override
  String toString() {
    return 'Wallet{id: $id, name: $name, mnemonic: $mnemonic, path: $path, address: $address, balance: $balance, isChoose: $isChoose, btcAddress: $btcAddress, btcPath: $btcPath, btcBalance: $btcBalance}';
  }

// @override
// String toString() {
//   return 'Wallet{id: $id, name: $name, mnemonic: $mnemonic, path: $path, address: $address, balance: $balance, isChoose: $isChoose}';
// }
}