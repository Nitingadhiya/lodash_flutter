import 'lodash_flutter_platform_interface.dart';
import "dart:convert";

class LodashFlutter {
  /// getPlatformVersion
  Future<String?> getPlatformVersion() {
    return LodashFlutterPlatform.instance.getPlatformVersion();
  }

  static platformVersion() {
    return LodashFlutterPlatform.instance.getPlatformVersion();
  }

  /// isNullOrBlank
  static bool isNullOrBlank(dynamic val) {
    if (val is List) {
      if (val.isEmpty) return true;
      return false;
    } else {
      if (val == null || val == '' || val.toString().isEmpty) return true;
      return false;
    }
  }

  /// getJsonValue
  static Future<dynamic> getJsonValue(json, String path, defaultValue) {
    try {
      List pathSplitter = path.split(".");

      /// <String,dynamic> || String
      dynamic returnValue;

      json.forEach((key, value) {
        var currentPatten = pathSplitter[0];
        int index = 0;

        if (currentPatten.contains('[') && currentPatten.contains(']')) {
          int index1 = currentPatten.indexOf('[');
          int index2 = currentPatten.indexOf(']');

          index = int.parse(currentPatten.substring(index1 + 1, index2));
          currentPatten = currentPatten.substring(0, index1);
        }

        if (key == currentPatten) {
          if (pathSplitter.length == 1) {
            returnValue = value;
            return;
          }

          pathSplitter.remove(pathSplitter[0]);

          if (value == null) {
            returnValue = defaultValue;
            return;
          }
          try {
            try {
              value = value.toJson();
            } catch (error) {
              // handle error
            }

            try {
              if (value is List) {
                value = value[index];
              }
            } catch (error) {
              // handle error
            }

            returnValue = getJsonValue(value, pathSplitter.join("."), defaultValue);
          } catch (error) {
            returnValue = defaultValue;
          }
          return;
        }
      });

      return returnValue ?? defaultValue;
    } on Exception {
      // TODO
      return defaultValue;
    }

    //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range", null);
    //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range.from", '');
    //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range.from.amount_gross", 0);
    //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range[0].from.amount_gross", 'null');
    //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range[0].from[1].amount_gross", null);
  }

  /// chunk
  static chunk(array, [size = 1]) {
    var chunks = [];
    int chunkSize = 2;
    for (var i = 0; i < array.length; i += chunkSize) {
      chunks.add(array.sublist(i, i + chunkSize > array.length ? array.length : i + chunkSize));
    }
    return chunks;
  }

  /// isInteger
  static bool isInteger(value) => int.tryParse(value.toString()) != null ? true : false;

  /// isNumeric
  static bool isNumeric(s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  /// toNumber
  static toNumber(value) {
    final type = value.runtimeType;
    if (type is String) {
      return double.tryParse(value);
    }
    return value;
  }

  /// compact
  static List compact(array) {
    // final myList = [10, '', '', null, 20, 0, 40, 50, false];

    // remove falsy values from the list
    array.removeWhere((item) => ["", null, false, 0].contains(item));
    return array;
  }

  /// concat
  static concat(array1, array2) {
    if (array2 is List) {
      array1.addAll(array2);
    } else {
      array1.add(array2);
    }
    return array1;
  }

  /// differenceFromFirst
  static differenceFromFirst(first, second) {
    List<dynamic> difference = first.toSet().difference(second.toSet()).toList();
    return difference;
  }

  /// difference
  static difference(l1, l2) {
    List<T> listDiff<T>(List<T> l1, List<T> l2) => (l1.toSet()..addAll(l2)).where((i) => !l1.contains(i) || !l2.contains(i)).toList();
    return listDiff(l1, l2);
  }

  /// removeAt
  static removeAt(array, index) {
    array.removeAt(index);
    return array;
  }

  /// findIndex
  static findIndex(array, val) {
    final index;
    // if (val is String || val is int || val is Uri || val is DateTime) {
    //   index = array.indexWhere((element) => element == val);
    // } else {
      // convert each item to a string by using JSON encoding
      final jsonList = array.map((item) => jsonEncode(item)).toList();
      index = jsonList.indexWhere((element) => element == jsonEncode(val));
      // bool match = false;
      // List keys = val.keys.toList();
      // index = array.indexWhere((element) {
      //   for (var i = 0; i < keys.length; i++) {
      //     if (i != 0 && !match) {
      //       match = false;
      //       break;
      //     }
      //     element[keys[i]] == val[keys[i]] ? match = true : match = false;
      //   }
      //   return match;
      // });
    // }
    return index;
  }

  /// findLastIndex
  static findLastIndex(array, val) {
    final index;
    // if (val is String || val is int || val is Uri || val is DateTime) {
    //   index = array.lastIndexWhere((element) => element == val);
    // } else {
    //
    //   // convert each item to a string by using JSON encoding
      final jsonList = array.map((item) => jsonEncode(item)).toList();
      index = jsonList.lastIndexWhere((element) => element == jsonEncode(val));
    // }
    return index;
  }

  /// contains
  static contains(array, val) {
    if (!isNullOrBlank(array)) return array.contains(val);
    return false;
  }

  ///containsfromList
  static containsfromList(array, val) {
    if (!isNullOrBlank(array)) return array.values.contains(val);
    return null;
  }

  ///fold
  static fold(array, {initialValue = 0}) {
    if (!isNullOrBlank(array)) return array.fold<dynamic>(initialValue, (previousValue, element) => previousValue + element);
    return array;
  }

  ///skip
  static skip(array, skipVal) {
    if (!isNullOrBlank(array)) return array.skip(skipVal);
    return array;
  }

  ///take
  static take(array, takeVal) {
    if (!isNullOrBlank(array)) return array.take(takeVal);
    return array;
  }

  ///join
  static join(array, takeVal) {
    if (!isNullOrBlank(array)) return array.join(takeVal);
    return array;
  }

  ///last
  static last(array) {
    if (!isNullOrBlank(array)) return array.last;
    return array;
  }

  ///first
  static first(array) {
    if (!isNullOrBlank(array)) return array.first;
  }

  ///isEqual
  static isEqual(obj1, obj2) {
    // return expect(obj1 == obj2, false);
  }

  ///remove
  static remove(List array, val) {
    if (val is List) {
      for (var obj in val) {
        array.remove(obj);
      }
      return array;
    } else {
      array.removeAt(findIndex(array, val));
      return array;
    }
  }

  /// reverse
  static reverse(List array) {
    return array.reversed;
  }

  ///slice
  static slice(List array, index) {
    return array.sublist(index);
  }

  ///subList
  static subList(List array, start, end) {
    if (end > array.length) {
      end = array.length;
    }
    return array.sublist(start, end);
  }

  ///sort
  static sort(List array) {
    final sortArray = array.sort();
    return array;
  }

  ///uniq
  static uniq(List array) {
    // convert each item to a string by using JSON encoding
    final jsonList = array.map((item) => jsonEncode(item)).toList();
    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();
    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    return result;
  }

  ///uniqBy
  static uniqBy(List array, key) {
    dynamic uniqArray = [];
    for(var std in array){
      var index = uniqArray.indexWhere((item)=>item[key] == std[key]);
      if(std[key] == null) index = -1; //if key not found
      if(index < 0) uniqArray.add(std);
    }
    return uniqArray;
  }

  ///filter
  static filter(List array, key) {
    final jsonList = array.map((item) => jsonEncode(item)).toList();
    return jsonList.where((item)=> item == jsonEncode(key)).toList();
  }

  ///find
  static find(array, function){
    return function;
  }

  ///groupBy
  static groupBy(array, String key) {
    List<Map<String, dynamic>> result = [];
    List<String> keys = [];

    array.forEach((f) => keys.add(f[key]));

    [...keys.toSet()].forEach((k) {
      List data = [...array.where((e) => e[key] == k)];
      result.add({k: data});
    });
    return result;
  }

  ///size
  static size(array) {
    return array.length;
  }

  static sortedBy(List array, key) {
    array.sort((a,b)=> a[key].compareTo(b[key]));
    return array;
  }

}
