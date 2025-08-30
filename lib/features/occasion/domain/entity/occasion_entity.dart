class OccasionEntity {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String createdAt;
  final String updatedAt;
  final bool isSuperAdmin;
  final int productsCount;

  OccasionEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount,
  });
}