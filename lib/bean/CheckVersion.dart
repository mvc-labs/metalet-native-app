class CheckVersion {
  CheckVersion({
      this.code, 
      this.data,});

  CheckVersion.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  Data? data;
CheckVersion copyWith({  num? code,
  Data? data,
}) => CheckVersion(  code: code ?? this.code,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.appName, 
      this.platform, 
      this.name, 
      this.url, 
      this.version, 
      this.mandatory, 
      this.versionCode, 
      this.mandatoryCode, 
      this.contents,});

  Data.fromJson(dynamic json) {
    appName = json['app_name'];
    platform = json['platform'];
    name = json['name'];
    url = json['url'];
    version = json['version'];
    mandatory = json['mandatory'];
    versionCode = json['version_code'];
    mandatoryCode = json['mandatory_code'];
    contents = json['contents'] != null ? Contents.fromJson(json['contents']) : null;
  }
  String? appName;
  String? platform;
  String? name;
  String? url;
  String? version;
  String? mandatory;
  num? versionCode;
  num? mandatoryCode;
  Contents? contents;
Data copyWith({  String? appName,
  String? platform,
  String? name,
  String? url,
  String? version,
  String? mandatory,
  num? versionCode,
  num? mandatoryCode,
  Contents? contents,
}) => Data(  appName: appName ?? this.appName,
  platform: platform ?? this.platform,
  name: name ?? this.name,
  url: url ?? this.url,
  version: version ?? this.version,
  mandatory: mandatory ?? this.mandatory,
  versionCode: versionCode ?? this.versionCode,
  mandatoryCode: mandatoryCode ?? this.mandatoryCode,
  contents: contents ?? this.contents,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_name'] = appName;
    map['platform'] = platform;
    map['name'] = name;
    map['url'] = url;
    map['version'] = version;
    map['mandatory'] = mandatory;
    map['version_code'] = versionCode;
    map['mandatory_code'] = mandatoryCode;
    if (contents != null) {
      map['contents'] = contents?.toJson();
    }
    return map;
  }

}

class Contents {
  Contents({
      this.en, 
      this.zh,});

  Contents.fromJson(dynamic json) {
    en = json['en'];
    zh = json['zh'];
  }
  String? en;
  String? zh;
Contents copyWith({  String? en,
  String? zh,
}) => Contents(  en: en ?? this.en,
  zh: zh ?? this.zh,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = en;
    map['zh'] = zh;
    return map;
  }

}