class ValidationIssue {
  final String code; // machine-readable, e.g. "INVALID_BOARD_SIZE"
  final String message; // human-readable description

  const ValidationIssue({required this.code, required this.message});

  @override
  String toString() => '[$code] $message';
}

class LevelValidationResult {
  final bool isValid;
  final List<ValidationIssue> issues;

  const LevelValidationResult({required this.isValid, this.issues = const []});

  factory LevelValidationResult.valid() =>
      const LevelValidationResult(isValid: true);

  factory LevelValidationResult.invalid(List<ValidationIssue> issues) =>
      LevelValidationResult(isValid: false, issues: issues);

  @override
  String toString() => isValid
      ? 'LevelValidationResult(valid)'
      : 'LevelValidationResult(invalid, ${issues.length} issues: ${issues.map((e) => e.code).join(', ')})';
}
