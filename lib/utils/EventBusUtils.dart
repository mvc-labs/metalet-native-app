
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


class DeleteWallet{

}
