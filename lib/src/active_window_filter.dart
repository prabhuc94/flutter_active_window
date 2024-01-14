import 'dart:convert';

import 'package:dotup_dart_utils/dotup_dart_utils.dart';

enum ActiveWindowFilterType {
  contains,
  startsWith,
}

enum ActiveWindowProperty {
  title,
  appName,
  path,
  bundleId,
  rawResult,
  userName,
  hostName,
  deviceId,
}

class ActiveWindowFilter {
  bool hide;

  ActiveWindowProperty field;

  ActiveWindowFilterType type;

  String value;

  ActiveWindowFilter({
    this.hide = true,
    this.type = ActiveWindowFilterType.contains,
    required this.value,
    required this.field,
  });

  ActiveWindowFilter copyWith({
    bool? hide,
    String? value,
    ActiveWindowFilterType? type,
    ActiveWindowProperty? field,
  }) {
    return ActiveWindowFilter(
      hide: hide ?? this.hide,
      field: field ?? this.field,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hide': hide,
      'field': EnumUtils.getName(field),
      'type': EnumUtils.getName(type),
      'value': value,
    };
  }

  factory ActiveWindowFilter.fromMap(Map<String, dynamic> map) {
    return ActiveWindowFilter(
      hide: map['hide'],
      field: EnumUtils.getEnumFromName(ActiveWindowProperty.values, map['field']),
      type: EnumUtils.getEnumFromName(ActiveWindowFilterType.values, map['type']),
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveWindowFilter.fromJson(String source) => ActiveWindowFilter.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActiveWindowFilter(field: ${EnumUtils.getName(field)}, type: ${EnumUtils.getName(type)}, value: $value, hide: $hide)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActiveWindowFilter && other.hide == hide && other.field == field && other.value == value && other.type == type;
  }

  @override
  int get hashCode => hide.hashCode ^ field.hashCode ^ value.hashCode ^ type.hashCode;
}
