enum CommonResources {
  cat1(name: "cat1.png"),
  cat2(name: "cat2.png"),
  cat3(name: "cat3.png"),
  cat4(name: "cat4.png"),
  cat5(name: "cat5.png"),
  cat6(name: "cat6.png"),
  cat7(name: "cat7.png"),
  error(name: "error_illustration.png"),
  empty(name: "empty_illustration.png");

  final String value;
  final String name;

  const CommonResources({required this.name}) : value = "packages/commons_ui/assets/images/$name";

  factory CommonResources.init({required String name}) =>
      values.firstWhere(((e) => e.name == name), orElse: () => CommonResources.cat1);
}
