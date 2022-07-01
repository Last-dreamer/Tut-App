import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "unknown";
  String id = "unknown";
  String version = "unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = '${build.brand}${build.model}';
      id = build.androidId;
      version = build.version.codename;
    }

    if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = '${build.name}${build.model}';
      id = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    return DeviceInfo(name: name, id: id, version: version);
  }
  return DeviceInfo(name: name, id: id, version: version);
}
