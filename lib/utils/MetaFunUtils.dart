import 'package:flutter/cupertino.dart';

class MetaFunUtils {

  // ignore: non_constant_identifier_names
  String SHOW3_SERVICE = "api.show3.space";

  String getShowImageUrl(String url) {
    String resultUrl = "";
    resultUrl = url.replaceAll("metafile://", "");

    if (resultUrl.endsWith(".png")) {
      resultUrl = resultUrl.replaceAll(".png", "");
    }

    if (resultUrl.endsWith(".jpg")) {
      resultUrl = resultUrl.replaceAll(".png", "");
    }

    resultUrl = "https://$SHOW3_SERVICE/metafile/$resultUrl";
    return resultUrl;
  }

  Widget getImageContainer(Widget widget){
    return Container(
      width: 50,
      height: 50,
      child: widget,
    );
  }

  Widget getImageContainerSize(Widget widget,double width,double height){
    return Container(
      width: width,
      height: height,
      child: widget,

    );
  }

  Widget getImageContainerSizeCul(Widget widget,double width,double height){
    return Container(
      width: width,
      height: height,
      // clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: widget,
    );
  }


}
