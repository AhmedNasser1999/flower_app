import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../../data/models/about_section_model.dart' as model;
import '../../../../../core/l10n/translation/app_localizations.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Future<model.AboutSectionModel> _loadAbout(BuildContext context) async {
    final jsonString = await rootBundle.loadString('assets/json/Flowery About Section JSON with Expanded Content.json');
    final jsonMap = json.decode(jsonString);
    return model.AboutSectionModel.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)?.localeName ?? 'en';
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.startsWith('ar') ? 'عن تطبيق فلاوري' : 'About Flowery App'),
      ),
      body: FutureBuilder<model.AboutSectionModel>(
        future: _loadAbout(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text(local.noAboutInfoFound));
          }
          final about = snapshot.data!;
          return _AboutContent(about: about, locale: locale);
        },
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final model.AboutSectionModel about;
  final String locale;
  const _AboutContent({required this.about, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: about.aboutSections.length,
      itemBuilder: (context, index) {
        final section = about.aboutSections[index];
        return _buildSection(section, locale);
      },
    );
  }

  Widget _buildSection(model.AboutSection section, String locale) {
    final lang = locale.startsWith('ar') ? 'ar' : 'en';
    final content = section.content != null ? section.content![lang] : null;
    final title = section.title != null ? section.title![lang] : null;
    final style = section.style ?? {};

    TextStyle parseTextStyle(Map<String, dynamic> style, {bool isTitle = false}) {
      final s = isTitle ? (style['title'] ?? style) : (style['content'] ?? style);
      return TextStyle(
        fontSize: (s['fontSize'] is int ? s['fontSize'].toDouble() : s['fontSize']?.toDouble()) ?? (isTitle ? 18 : 16),
        fontWeight: s['fontWeight'] == 'bold' ? FontWeight.bold : FontWeight.normal,
        color: s['color'] != null ? _parseColor(s['color']) : (isTitle ? const Color(0xFFD21E6A) : const Color(0xFF333333)),
      );
    }

    TextAlign parseTextAlign(Map<String, dynamic> style, {bool isTitle = false}) {
      final s = isTitle ? (style['title'] ?? style) : (style['content'] ?? style);
      final align = s['textAlign'];
      if (align is Map) {
        return (align[lang] == 'right')
            ? TextAlign.right
            : (align[lang] == 'center')
                ? TextAlign.center
                : TextAlign.left;
      } else if (align is String) {
        return align == 'right'
            ? TextAlign.right
            : align == 'center'
                ? TextAlign.center
                : TextAlign.left;
      }
      return isTitle ? TextAlign.center : (lang == 'ar' ? TextAlign.right : TextAlign.left);
    }

    Color? parseBackgroundColor(Map<String, dynamic> style, {bool isTitle = false}) {
      final s = isTitle ? (style['title'] ?? style) : (style['content'] ?? style);
      if (s['backgroundColor'] != null) {
        return _parseColor(s['backgroundColor']);
      }
      return null;
    }

    final bgColor = parseBackgroundColor(style) ?? Colors.white;

    return Container(
      color: bgColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                title,
                style: parseTextStyle(style, isTitle: true),
                textAlign: parseTextAlign(style, isTitle: true),
              ),
            ),
          if (content != null)
            content is List
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      content.length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          content[i],
                          textAlign: parseTextAlign(style),
                          style: parseTextStyle(style),
                        ),
                      ),
                    ),
                  )
                : Text(
                    content,
                    textAlign: parseTextAlign(style),
                    style: parseTextStyle(style),
                  ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
