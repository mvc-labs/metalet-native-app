class Brc20CommitRequest{


  //brc20
  String brc_ticker="";
  String? brc_amount="";
  String? orderID="";
  String? brc20_json="";


  @override
  String toString() {
    return 'Brc20CommitRequest{brc_ticker: $brc_ticker, brc_amount: $brc_amount, orderID: $orderID}';
  }

  Brc20CommitRequest(this.brc_ticker, this.brc_amount, this.orderID,this.brc20_json);
}