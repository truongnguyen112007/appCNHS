library highlight_text;

import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Defines what occurrence you want to highligh
enum HighlightBinding {
  /// Highlights all occurrences of a word
  all,

  /// Highlights only the first occurrence
  first,

  /// Highlights only the last occurrence
  last,
}

/// It stores the layout data about a word
class HighlightedWord {
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  HighlightedWord({
    this.textStyle,
    this.onTap,
    this.decoration,
    this.padding,
  });
}

/// TextHighlight will provide you a easy way to display highlighted words on your app
class TextHighlight extends StatelessWidget {
  final String text;
  final Map<String, HighlightedWord> words;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final bool matchCase;
  final HighlightBinding binding;

  final Map<String, List<String>> originalWords = <String, List<String>>{};

  TextHighlight({
    required this.text,
    required this.words,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.matchCase = false,
    this.binding = HighlightBinding.all,
  });

  @override
  Widget build(BuildContext context) {
    List<String> _textWords = _bind();

    return RichText(
      text: _buildSpan(_textWords),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
    );
  }

  String _multipleBinding() {
    String boundText = text;
    final Map<int, Match> allMatchesByStartIndex = <int, Match>{};

    for (String word in words.keys) {
      originalWords[word] = <String>[];

      Iterable<Match> wordMatches = matchCase
          ? word.allMatches(text)
          : word.toLowerCase().allMatches(text.toLowerCase())
      ;

      for (Match match in wordMatches) {
        if (match[0] != null) {
          // If a match with the same start as the current match is already
          // known, but the current match is longer, replace the known match.
          // Otherwise do nothing, because otherwise this would
          // attempt to highlight a subword in an already highlighted word,
          // which would break the <highlight> syntax.
          Match? knownMatch = allMatchesByStartIndex[match.start];
          if (knownMatch == null || match[0]!.length > knownMatch[0]!.length) {
            originalWords[word]!.add(text.substring(match.start, match.end));
            allMatchesByStartIndex[match.start] = match;
          }
        }
      }
    }

    final List<String> sourceWords = matchCase
        ? words.keys.toList()
        : words.keys.map((w) => w.toLowerCase()).toList()
    ;

    // sort by start descending to replace from right to left
    final List<Match> allMatches = allMatchesByStartIndex.values.toList();
    allMatches.sort((m1, m2) => m2.start.compareTo(m1.start));

    for (Match match in allMatches) {
      boundText = boundText.replaceRange(
        match.start,
        match.end,
        '<highlight>${sourceWords.indexOf(match[0]!)}<highlight>',
      );
    }

    return boundText;
  }

  String _firstWordBinding() {
    String boundText = text;

    for (String word in words.keys) {
      originalWords.addAll({word: <String>[]});

      if (matchCase) {
        int strIndex = boundText.indexOf(word);
        int strLastIndex = strIndex + word.length;
        boundText = boundText.replaceRange(strIndex, strLastIndex,
            '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
      } else {
        int strIndex = boundText.toLowerCase().indexOf(word.toLowerCase());
        int strLastIndex = strIndex + word.length;
        if (strIndex >= 0) {
          originalWords[word]!
              .add(boundText.substring(strIndex, strIndex + word.length));

          boundText = boundText.replaceRange(strIndex, strLastIndex,
              '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
        }
      }
    }

    return boundText;
  }

  String _lastWordBinding() {
    String boundText = text;

    for (String word in words.keys) {
      originalWords.addAll({word: <String>[]});

      if (matchCase) {
        int strIndex = boundText.lastIndexOf(word);
        int strLastIndex = strIndex + word.length;
        boundText = boundText.replaceRange(strIndex, strLastIndex,
            '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
      } else {
        int strIndex = boundText.toLowerCase().lastIndexOf(word.toLowerCase());
        int strLastIndex = strIndex + word.length;
        if (strIndex >= 0) {
          originalWords[word]!
              .add(boundText.substring(strIndex, strIndex + word.length));

          boundText = boundText.replaceRange(strIndex, strLastIndex,
              '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
        }
      }
    }

    return boundText;
  }

  List<String> _bind() {
    String boundWords;

    switch (binding) {
      case HighlightBinding.first:
        boundWords = _firstWordBinding();
        break;
      case HighlightBinding.last:
        boundWords = _lastWordBinding();
        break;
      case HighlightBinding.all:
      default:
        boundWords = _multipleBinding();
    }

    List<String> splitTexts = boundWords.split("<highlight>");
    splitTexts.removeWhere((s) => s.isEmpty);

    return splitTexts;
  }

  TextSpan _buildSpan(List<String> boundWords) {
    if (boundWords.isEmpty) return TextSpan();

    String nextToDisplay = boundWords.first;
    boundWords.removeAt(0);

    int? index = int.tryParse(nextToDisplay);

    if (index != null) {
      try {
        String currentWord = words.keys.toList()[index];
        String showWord;
        if (matchCase) {
          showWord = currentWord;
        } else {
          showWord = originalWords[currentWord]!.first;
          originalWords[currentWord]!.removeAt(0);
        }

        return TextSpan(
          children: [
            TextSpan(text:  showWord,
              style: words[currentWord]!.textStyle ?? textStyle,),
            _buildSpan(boundWords),
          ],
        );
      } catch (e) {
        if (boundWords.length > 1) throw e;
      }
    }

    return TextSpan(
      text: nextToDisplay,
      style: textStyle,
      children: [
        _buildSpan(boundWords),
      ],
    );
  }
}
