enum CommonRoutes {
  error(value: ""),
  favoriteCatsPackages(value: "favorite_cats_package"),
  catDetailsPackage(value: "cat_details_package"),
  catModifyPackage(value: "cat_modify_package");

  final String value;

  static String root = "/";

  const CommonRoutes({required this.value});

  factory CommonRoutes.init({required String value}) =>
      values.firstWhere(((e) => e.value == value), orElse: () => CommonRoutes.error);
}
