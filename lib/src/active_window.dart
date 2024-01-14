import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'active_window_error.dart';
import 'active_window_info.dart';

class _WindowsResult {
  String? exe;
  String? name;
  String? title;
  _WindowsResult({
    this.exe,
    this.name,
    this.title,
  });

  _WindowsResult copyWith({
    String? exe,
    String? name,
    String? title,
  }) {
    return _WindowsResult(
      exe: exe ?? this.exe,
      name: name ?? this.name,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exe': exe,
      'name': name,
      'title': title,
    };
  }

  factory _WindowsResult.fromMap(Map<String, dynamic> map) {
    return _WindowsResult(
      exe: map['exe'],
      name: map['name'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory _WindowsResult.fromJson(String source) => _WindowsResult.fromMap(json.decode(source));

  @override
  String toString() => '_WindowsResult(exe: $exe, name: $name, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _WindowsResult && other.exe == exe && other.name == name && other.title == title;
  }

  @override
  int get hashCode => exe.hashCode ^ name.hashCode ^ title.hashCode;
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class ActiveWindow {
  static const MethodChannel _channel = MethodChannel('desktop_active_window');

  static Future<ActiveWindowInfo?> get getActiveWindowInfo async {
    final rawResult = await _channel.invokeMethod('getActiveWindowInfo');
    ActiveWindowInfo? info;
    if (Platform.isWindows) {
      info = fromWindows(rawResult);
    } else {
      info = fromString(rawResult as String?);
    }
    if (info == null || info.title.isEmpty == true) {
      return null;
    } else {
      info.hostName = Platform.localHostname;
      return info;
    }
  }

  static ActiveWindowInfo? fromString(String? windowInfo) {
    if (windowInfo == null || windowInfo.isEmpty) {
      return null;
    }
    ActiveWindowInfo result;
    if (Platform.isMacOS) {
      result = ActiveWindowInfo.fromJson(windowInfo);
      result.userName = Platform.environment['LOGNAME'];
    } else if (Platform.isWindows) {
      throw ActiveWindowError(number: 0, message: 'This could not happen!');
    } else {
      result = fromLinuxString(windowInfo);
    }
    result.rawResult = windowInfo;
    return result;
  }

  static ActiveWindowInfo fromLinuxString(String map) {
    final values = map.split('\n');
    final wmClass = _getValue(values, 'WM_CLASS', split: ',');
    return ActiveWindowInfo(
      title: _getValue(values, 'WM_NAME(')!,
      bundleId: _getValue(values, '_GTK_APPLICATION_ID(UTF8_STRING)') ?? wmClass,
      appName: wmClass,
      userName: Platform.environment['USER'],
    );
  }

  static ActiveWindowInfo fromWindows(dynamic rawResult) {
    final result = _WindowsResult.fromJson(json.encode(rawResult));
    return ActiveWindowInfo(
      title: result.title ?? 'ERROR',
      bundleId: result.exe,
      appName: result.name,
      userName: Platform.environment['USERNAME'],
    );
  }

  static String? _getValue(List<String> values, String key, {String? split}) {
    final line = values.firstWhereOrNull((element) => element.startsWith(key));
    final lineValues = line?.split('=');
    String? result;
    if (lineValues != null && lineValues.length > 1) {
      result = lineValues[1].replaceAll('"', '');

      if (split != null) {
        final parts = result.split(split);
        result = parts.length > 1 ? parts[1] : parts[0];
      }
    }
    return result?.trim();
  }
}
