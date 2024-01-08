import 'package:mvcwallet/utils/Constants.dart';

import '../page/btc/BtcSignData.dart';

//wallet
abstract class Indo {
  void addWallet(String walletName, String mnemoni, String path,String btcPath);

  void createWallet(String walletName, String path,String btcPath);

  void switchWallet(Wallet? wallet);
}

//send NFT
abstract class SendNftIndo {
  void sendCancel();

  void sendConfirm(String sendAddress);
}

abstract class SendFtIndo {
  void sendCancel();

  void sendConfirm(String sendAddress, String sendAmount);
}



abstract class SendBtcTransIndo{

  void sendBtcTransResult(BtcSignData btcSignData);


}