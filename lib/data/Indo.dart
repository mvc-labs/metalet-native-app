

import 'package:mvcwallet/utils/Constants.dart';

abstract class  Indo{

  void addWallet(String walletName,String mnemoni,String path);

  void createWallet();

  void switchWallet(Wallet? wallet);


}