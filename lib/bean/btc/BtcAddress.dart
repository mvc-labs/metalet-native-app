


class BtcAddress{


  //0-44  1-84 2-mvc
  int addressType=0;
  String? addressName;
  String? addressP2;
  bool isChoose=false;

  @override
  String toString() {
    return 'BtcAddress{addressType: $addressType, addressName: $addressName, addressP2: $addressP2, isChoose: $isChoose}';
  }
}