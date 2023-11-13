
import 'package:clearance_processing_system/core/helpers/extensions.dart';

/// A collection of common validators that can be reused
class Validators {
  static final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?)+$",
  );

  static Validator notEmpty() {
    return (String? value) {
      return (value?.isEmpty ?? true) ? "This field can not be empty." : null;
    };
  }

  static Validator confirmPass(String val1, String val2) {
    return (String? value) {
      if (val1 != val2) {
        return "Passwords do not match";
      } else {
        return null;
      }
    };
  }

  static Validator phone() {
    return (String? value) {
      return (value!.length < 10 || value.length > 11)
          ? "Invalid phone."
          : null;
    };
  }

  static Validator date() {
    return (String? value) {
      if (value!.isEmpty) {
        return null;
      }
      if (value.length < 10) {
        return "Invalid date.";
      }
      return null;
    };
  }

  static Validator name() {
    return (String? value) {
      if (value!.isEmpty) {
        return "Field cannot be empty.";
      }
      if (!value.contains(" ")) {
        return "Seperate names with spaces";
      }
      return null;
    };
  }

  static Validator accountNumber() {
    return (String? value) {
      return (value!.length < 10) ? "Invalid account number." : null;
    };
  }

  static Validator minLength(int minLength) {
    return (String? value) {
      if ((value?.length ?? 0) < minLength) {
        return "Must contain a minimum of $minLength characters.";
      }
      return null;
    };
  }

  static bool isValid(String pin, String pin2) =>
      (pin.isNotEmpty && pin2.isNotEmpty && pin == pin2);
  static Validator matchPattern(Pattern pattern, [String? patternName]) {
    return (String? value) {
      if (value == null || (pattern.allMatches(value).isEmpty)) {
        return "Please enter a valid ${patternName ?? "value"}.";
      }
      return null;
    };
  }

  static Validator email() {
    return matchPattern(emailPattern, "email");
  }

  static Validator password([int minimumLength = 8]) => multiple(
        [
          containsUpper("Password"),
          containsLower("Password"),
          containsNumber("Password"),
          containsSpecialChar("Password"),
          minLength(minimumLength),
        ],
        shouldTrim: false,
      );

  static Validator containsUpper([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsUpper()) return null;
      return "${fieldName ?? 'Field'} must contain at least one uppercase character.";
    };
  }

  static Validator containsLower([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsLower()) return null;
      return "${fieldName ?? 'Field'} must contain at least one lowercase character.";
    };
  }

  static Validator containsNumber([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsNumber()) return null;
      return "${fieldName ?? 'Field'} must contain at least one number.";
    };
  }

  static Validator containsSpecialChar([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsSpecialChar()) return null;
      return "${fieldName ?? 'Field'} must contain at least one special character.";
    };
  }

  /// Creates a validator that if the combination of multiple validators.
  ///
  /// The provided validators are applied in the order in which
  /// they're specified in the list.
  static Validator multiple(
    List<Validator> validators, {
    bool shouldTrim = true,
  }) {
    return (String? value) {
      value = shouldTrim ? value?.trim() : value;
      for (Validator validator in validators) {
        if (validator(value) != null) {
          return validator(value);
        }
      }
      return null;
    };
  }
}

typedef Validator = String? Function(String? value);
