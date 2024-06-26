class Pair<T, U>{
  final T first;
  final U second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return 'Pair{first: $first, second: $second}';
  }
}