class Category {
  final String id;
  final String name;
  final String slug;
  final String image;
  final bool isSuperAdmin;
  final int productsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.isSuperAdmin,
    required this.productsCount,
    required this.createdAt,
    required this.updatedAt,
  });
}