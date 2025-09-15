
class TermsAndConditions {
  final List<TermsSection> termsAndConditions;

  TermsAndConditions({required this.termsAndConditions});

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      termsAndConditions: (json['terms_and_conditions'] as List)
          .map((e) => TermsSection.fromJson(e))
          .toList(),
    );
  }
}

class TermsSection {
  final String section;
  final Map<String, dynamic>? content;
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? style;

  TermsSection({
    required this.section,
    this.content,
    this.title,
    this.style,
  });

  factory TermsSection.fromJson(Map<String, dynamic> json) {
    return TermsSection(
      section: json['section'] ?? '',
      content: json['content'] != null ? Map<String, dynamic>.from(json['content']) : null,
      title: json['title'] != null ? Map<String, dynamic>.from(json['title']) : null,
      style: json['style'] != null ? Map<String, dynamic>.from(json['style']) : null,
    );
  }
}
