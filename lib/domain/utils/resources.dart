enum Resources {
  cat1(name: "cat1.png"),
  cat2(name: "cat2.png"),
  cat3(name: "cat3.png"),
  cat4(name: "cat4.png"),
  cat5(name: "cat5.png"),
  cat6(name: "cat6.png"),
  cat7(name: "cat7.png"),
  error(name: "error_illustration.png"),
  empty(name: "empty_illustration.png"),
  favoritesCatsPackageImage(name: "favorites_cats_package.png");

  final String value;
  final String name;

  const Resources({required this.name}) : value = "assets/images/$name";

  factory Resources.init({required String name}) =>
      values.firstWhere(((e) => e.name == name), orElse: () => Resources.cat1);
}
