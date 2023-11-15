import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/thirdparty_services/formatter.dart';

extension CharacterValidation on String {
  bool containsUpper() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 65 && code <= 90) return true;
    }
    return false;
  }

  bool containsLower() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 97 && code <= 122) return true;
    }
    return false;
  }

  bool containsSpecialChar() {
    for (var i = 0; i < length; i++) {
      var char = this[i];
      if ("#?!@\$ %^&*-".contains(char)) return true;
    }
    return false;
  }

  bool containsNumber() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 48 && code <= 57) return true;
    }
    return false;
  }
}

extension RemoveCommas on String {
  removeCommas() {
    if (contains(",")) {
      return replaceAll(",", "");
    } else {
      return this;
    }
  }
}

extension DocIDFormat on String {
  String docVendorFormat({required String uid, String? inventoryId}) {
    if (inventoryId != null) {
      return '$this-$uid-$inventoryId';
    }

    return '$this-$uid';
  }

  String docFormat({String? id}) {
    if (id != null) {
      return '$this-$id';
    }

    return this;
  }
}

extension Initials on String {
  String getInitials() {
    final String text = this;

    if (text.isEmpty) return '';

    String first = '';
    String last = '';

    if (text.contains(' ')) {
      try {
        first = text.split(' ').first[0];
        last = text.split(' ').last[0];
      } catch (e) {}
    } else {
      first = text[0];
    }

    first = first.capitalizeFirst();

    if (last.isNotEmpty) {
      last = last.capitalizeFirst();
    }

    return '$first$last';
  }
}

extension FormatNumber on String {
  String addComma() {
    final String text = this;

    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    String formattedText = text.replaceAllMapped(reg, mathFunc);

    return formattedText;
  }

  String removeComma() {
    final String text = this;

    return text.replaceAll(',', '');
  }
}

extension CapitalizeFirst on String {
  String capitalizeFirst() {
    return this[0].toUpperCase() + substring(1);
  }

  String obscuredMail() {
    var newString = '';
    final List<String> emailList = split("");
    for (var i = 0; i < emailList.length; i++) {
      if (i != 0 && emailList[i] != '@' && i < indexOf('.')) {
        emailList[i] = '*';
        newString = emailList.join();
      }
    }
    return newString;
  }
}

extension DateTimeExtension on DateTime {
  String get convertDateHeaderToString => day == DateTime.now().day
      ? "Today"
      : day == (DateTime.now().add(const Duration(days: -1)).day)
          ? "Yesterday"
          : Dateformatter.formatEEyMMMd(this);

  String splitDateOnly([String? pattern]) {
    return toString().split(pattern ?? ' ')[0];
  }
}

extension DateTimeExt on DateTime {
  String formatDateForMessage(BuildContext context) {
    final dateTime = this;

    // Today
    if (dateTime.day == DateTime.now().day) {
      return TimeOfDay.fromDateTime(dateTime).format(context).toString();
    }

    // Yesterday
    if (dateTime.day == (DateTime.now().add(const Duration(days: -1)).day)) {
      String time = TimeOfDay.fromDateTime(dateTime).format(context).toString();
      return 'Yesterday at $time';
    }

    return Dateformatter.formatEEyMMMd(dateTime).toString();
  }
}

extension DateTimeFormat on DateTime {
  String formatYMMMd() {
    return DateFormat.yMMMd().format(this).toString();
  }
}

extension Group<T> on Iterable<T> {
  Groups<K, T> groupBy<K>(Function(T) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final keyValue = key(element);
      if (!map.containsKey(keyValue)) {
        map[keyValue] = [];
      }
      map[keyValue]?.add(element);
    }
    return Groups(keys: map.keys.toList(), children: map.values.toList());
  }
}

class Groups<K, T> {
  List<K> keys;
  List<List<T>> children;

  Groups({
    required this.keys,
    required this.children,
  });

  @override
  String toString() {
    return 'Groups{keys: $keys, children: $children}';
  }
}
