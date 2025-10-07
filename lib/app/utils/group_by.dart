extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  Map<K, List<E>> groupByDate<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension UtilListExtension on List {
  groupBy1(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      for (var f in this) {
        keys.add(f[key]);
      }

      for (var k in [...keys.toSet()]) {
        List data = [...where((e) => e[key] == k)];
        result.add({k: data});
      }

      return result;
    } catch (e) {
      return this;
    }
  }
}
