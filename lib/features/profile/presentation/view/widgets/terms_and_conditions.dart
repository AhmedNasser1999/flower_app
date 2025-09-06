import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../../data/models/terms_and_conditions_model.dart' as model;
import '../../../../../core/l10n/translation/app_localizations.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  Future<model.TermsAndConditions> _loadTerms(BuildContext context) async {
    final jsonString = await rootBundle.loadString('assets/json/Flowery Terms and Conditions JSON with Arabic and English.json');
    final jsonMap = json.decode(jsonString);
    return model.TermsAndConditions.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)?.localeName ?? 'en';
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(AppLocalizations.of(context)?.termsConditions ?? 'Terms and Conditions'),
      ),
      body: FutureBuilder<model.TermsAndConditions>(
        future: _loadTerms(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading terms'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No terms found'));
          }
          final terms = snapshot.data!;
          return _TermsContent(terms: terms, locale: locale);
        },
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  final model.TermsAndConditions terms;
  final String locale;
  const _TermsContent({required this.terms, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: terms.termsAndConditions.length,
      itemBuilder: (context, index) {
        final section = terms.termsAndConditions[index];
        return _buildSection(section, locale);
      },
    );
  }

  Widget _buildSection(model.TermsSection section, String locale) {
    final lang = locale.startsWith('ar') ? 'ar' : 'en';
    final content = section.content != null ? section.content![lang] : null;
    final title = section.title != null ? section.title![lang] : null;
    final style = section.style ?? {};

    // Helper to parse style
    TextStyle parseTextStyle(Map<String, dynamic> style, {bool isTitle = false}) {
      final s = isTitle ? (style['title'] ?? style) : (style['content'] ?? style);
      return TextStyle(
        fontSize: (s['fontSize'] is int ? s['fontSize'].toDouble() : s['fontSize']?.toDouble()) ?? (isTitle ? 18 : 16),
        fontWeight: s['fontWeight'] == 'bold'
            ? FontWeight.bold
            : FontWeight.normal,
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

    // Section background
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
