class AboutSectionModel {
  final List<AboutSection> aboutSections;

  AboutSectionModel({required this.aboutSections});

  factory AboutSectionModel.fromJson(Map<String, dynamic> json) {
    return AboutSectionModel(
      aboutSections: (json['about_app'] as List)
          .map((e) => AboutSection.fromJson(e))
          .toList(),
    );
  }
}

class AboutSection {
  final String section;
  final Map<String, dynamic>? content;
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? style;

  AboutSection({
    required this.section,
    this.content,
    this.title,
    this.style,
  });

  factory AboutSection.fromJson(Map<String, dynamic> json) {
    return AboutSection(
      section: json['section'] ?? '',
      content: json['content'] != null ? Map<String, dynamic>.from(json['content']) : null,
      title: json['title'] != null ? Map<String, dynamic>.from(json['title']) : null,
      style: json['style'] != null ? Map<String, dynamic>.from(json['style']) : null,
    );
  }
}
