import 'dart:math';


class Collection {
  late List<dynamic>? list = [];
  final List<dynamic> _result = [];

  Collection({this.list});

  int randomIndex(List list) => Random().nextInt(list.length);

  dynamic randomItem({List? data}) {
    list = _data(data);

    return list!.isNotEmpty ? list![Random().nextInt(list!.length)] : null;
  }

  Collection whereNotIn(List notInList,
      {List<dynamic>? data, String key = "id"}) {
    list = _data(data);
    final id = [];
    for (int i = 0; i < notInList.length; i++) {
      id.add(notInList[i][key]);
    }

    for (int a = 0; a < id.length; a++) {
      for (int i = 0; i < list!.length; i++) {
        if (list?[i][key] == notInList[a][key]) {
          remove(i);
        }
      }
    }
    return this;
  }

  Collection whereItem(String key, dynamic search, {List<dynamic>? data}) {
    list = _data(data);
    for (int i = 0; i < list!.length; i++) {
      if (list?[i][key] == search) _result.addAll([i, list?[i]]);
    }

    return this;
  }

  Collection getIndex(String key, dynamic search, {List<dynamic>? data}) {
    list = _data(data);
    for (int i = 0; i < list!.length; i++) {
      if (list?[i][key] == search) _result.add(i);
    }

    return this;
  }

  Collection whereMap(key, dynamic search, {List<dynamic>? data}) {
    list = _data(data);
    for (int i = 0; i < list!.length; i++) {
      if (list?[i][key] == search) _result.add(list?[i]);
    }

    return this;
  }

  dynamic remove(int index) => list?.removeAt(index);

  dynamic removeAll(List<int> items) =>
      items.forEach((int item) => list?.removeAt(item));

  int get length => _result.length;
  List<dynamic> _data(data) => data != null ? list = data : list;
  List<dynamic> get() => _result.isEmpty ? list! : _result;
}
