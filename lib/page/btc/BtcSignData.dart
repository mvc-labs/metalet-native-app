import '../../bean/btc/BtcUtxoBean.dart';


class BtcSignData{


  List<Utxo> utxoNeedList = [];
  String? sendtoAddress;
  int? sendAmount;
  int? netWorkFee;
  int? netWorkFeeRate;
  String? rawTx;

  @override
  String toString() {
    return 'BtcSignData{utxoNeedList: $utxoNeedList, sendtoAddress: $sendtoAddress, sendAmount: $sendAmount, netWorkFee: $netWorkFee, netWorkFeeRate: $netWorkFeeRate}';
  }
}