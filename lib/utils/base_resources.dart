enum BaseResources {
  splash(name: "splash.png"),
  favoritesCatsPackageImage(name: "favorites_cats_package.png");

  final String value;

  const BaseResources({required String name}) : value = "assets/images/$name";
}
