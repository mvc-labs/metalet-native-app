

import 'package:mvcwallet/utils/Constants.dart';

abstract class  Indo{

  void addWallet(String walletName,String mnemoni,String path);

  void createWallet(String walletName,String path);

  void switchWallet(Wallet? wallet);


}