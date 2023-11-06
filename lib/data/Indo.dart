import 'package:mvcwallet/utils/Constants.dart';

//wallet
abstract class Indo {
  void addWallet(String walletName, String mnemoni, String path);

  void createWallet(String walletName, String path);

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
// btc change1111111  333
// btc change1111111
// 我是没问题的代码 最终将提交
}
