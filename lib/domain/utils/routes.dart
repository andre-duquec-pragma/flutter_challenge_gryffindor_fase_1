enum Routes {
  error(value: ""),
  catDetails(value: "cat_detail"),
  catModify(value: "cat_modify");

  final String value;

  static String root = "/";

  const Routes({required this.value});

  factory Routes.init({required String value}) =>
      values.firstWhere(((e) => e.value == value), orElse: () => Routes.error);
}
