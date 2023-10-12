
import 'package:event_bus/event_bus.dart';

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

