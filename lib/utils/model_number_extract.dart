import 'dart:math';

/// Indicates from which source a candidate model number has been extracted.
enum CandidateSource { qr, barcode, ocr }

/// Represents a deduplicated candidate with an associated confidence score.
class ScoredCandidate {
  const ScoredCandidate({
    required this.value,
    required this.score,
    required this.source,
  });

  final String value;
  final double score;
  final CandidateSource source;

  ScoredCandidate copyWith({
    String? value,
    double? score,
    CandidateSource? source,
  }) {
    return ScoredCandidate(
      value: value ?? this.value,
      score: score ?? this.score,
      source: source ?? this.source,
    );
  }
}

/// Normalises a raw model number string for consistent comparison.
String normalizeModelNumber(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return '';
  final withoutWhitespace = trimmed.replaceAll(RegExp(r'\s+'), '');
  final collapsedSeparators = withoutWhitespace.replaceAll(
    RegExp(r'([-_/]){2,}'),
    r'$1',
  );
  return collapsedSeparators.toUpperCase();
}

/// Lightweight validation to quickly discard unlikely model number candidates.
bool isLikelyModelNumber(String raw) {
  final normalized = normalizeModelNumber(raw);
  if (normalized.length < 6 || normalized.length > 30) {
    return false;
  }
  const pattern = r'^[A-Z0-9][A-Z0-9\-_\/]{4,28}[A-Z0-9]$';
  return RegExp(pattern, caseSensitive: false).hasMatch(normalized);
}

bool _hasLetterAndDigit(String value) {
  return RegExp(r'(?=.*[A-Z])(?=.*\d)').hasMatch(value);
}

/// Extracts and ranks model number candidates from OCR text using heuristic scoring.
List<ScoredCandidate> extractAndScore(String fullText) {
  if (fullText.trim().isEmpty) {
    return const [];
  }

  // ignore: valid_regexps
  final regex = RegExp(r'(?i)\b([A-Z0-9][A-Z0-9\-_\/]{4,28}[A-Z0-9])\b');
  final keywordRegex = RegExp(
    r'(model|model\s?no|model\s?number|sku|part\s?no)',
    caseSensitive: false,
  );

  final Map<String, double> scores = {};

  for (final match in regex.allMatches(fullText)) {
    final rawCandidate = match.group(1);
    if (rawCandidate == null) continue;

    final normalized = normalizeModelNumber(rawCandidate);
    if (normalized.isEmpty || !isLikelyModelNumber(normalized)) {
      continue;
    }

    var score = 1.0;

    final contextStart = max(0, match.start - 20);
    final contextEnd = min(fullText.length, match.end + 20);
    final context = fullText.substring(contextStart, contextEnd);
    if (keywordRegex.hasMatch(context)) {
      score += 2;
    }

    if (_hasLetterAndDigit(normalized)) {
      score += 1;
    }

    final length = normalized.length;
    if (length >= 6 && length <= 30) {
      score += 1;
    }

    final specialCount = RegExp(r'[-_/]').allMatches(normalized).length;
    if (specialCount > 3) {
      score -= 0.5;
    }

    final existing = scores[normalized];
    if (existing != null) {
      scores[normalized] = existing + (score * 0.2);
    } else {
      scores[normalized] = score;
    }
  }

  final results = scores.entries
      .map(
        (entry) => ScoredCandidate(
          value: entry.key,
          score: entry.value < 0 ? 0 : entry.value,
          source: CandidateSource.ocr,
        ),
      )
      .toList();

  results.sort((a, b) => b.score.compareTo(a.score));
  return results;
}
