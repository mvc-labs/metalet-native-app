import '../../bean/btc/BtcUtxoBean.dart';

class BtcSignData {
  List<Utxo> utxoNeedList = [];
  String? sendtoAddress;
  int? sendAmount;
  int? netWorkFee;
  int? netWorkFeeRate;
  String? rawTx;
  String? changeAmount;

  //sim inputs and outputs
  List<String>? inputUtxos = [];
  List<String>? outputUtxos = [];


  //brc20
  String? brc20Amt="";


  @override
  String toString() {
    return 'BtcSignData{utxoNeedList: $utxoNeedList, sendtoAddress: $sendtoAddress, sendAmount: $sendAmount, netWorkFee: $netWorkFee, netWorkFeeRate: $netWorkFeeRate, rawTx: $rawTx, changeAmount: $changeAmount, inputUtxos: $inputUtxos, outputUtxos: $outputUtxos}';
  }
}
