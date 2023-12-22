
import 'package:event_bus/event_bus.dart';

import '../bean/BtcFeeBean.dart';
import '../bean/btc/BtcUtxoBean.dart';

class EventBusUtils {
  static final EventBus instance=EventBus();

}


class StringContentEvent{
  String str;
  StringContentEvent(this.str);
}



class WalletHomeData{
  String spaceBalance="0.0";
  String walletBalance="\$0.0";

  WalletHomeData(this.spaceBalance, this.walletBalance);
}

class  ShowLoadingDialog{
  bool isShow;
  ShowLoadingDialog(this.isShow);
}

//删除钱包通知
class DeleteWallet{

}


class SendNftSuccess{



}

class SendFtSuccess{



}


class SendNftDialogData{


  String? nftName;
  String? nftIconUrl;
  String? nftTokenIndex;
  String? receiveAddress;
  String? transactionID;




}


class SendFtDialogData{

  String? nftName;
  String? receiveAddress;
  String? transactionID;
  String? ftAmount;




}


class WalletBTCData{
  String btcBalance="0.0";
  String btcWalletBalance="\$0.0";

  WalletBTCData(this.btcBalance, this.btcWalletBalance);
}




class WalletBTCRate{
  BtcFeeBean? btcFeeBean;

  WalletBTCRate(this.btcFeeBean);
}


class WalletBTCUtxo{
  BtcUtxoBean? btcUtxoBean;

  WalletBTCUtxo(this.btcUtxoBean);
}

