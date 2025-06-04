String capitalizeAndTrim(String text) {
  return text
      .trim()
      .split(RegExp(r'\s+')) // Split by one or more spaces
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join(' ');
}

String addPrefixToPhoneNumber(String phoneNumber) {
  // Sanitize: Remove all non-digit characters
  final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  // Validate basic structure
  if (cleaned.isEmpty || cleaned.length < 10) {
    throw const FormatException("Invalid phone number");
  }

  // Handle Nigerian numbers specifically
  if (cleaned.startsWith('234') && cleaned.length == 13) {
    return '+$cleaned'; // Already in intl format
  } else if (cleaned.startsWith('0') && cleaned.length == 11) {
    return '+234${cleaned.substring(1)}'; // Trim leading '0'
  } else if (cleaned.length == 10) {
    return '+234$cleaned'; // Add prefix
  } else {
    throw const FormatException("Unrecognized phone number format");
  }
}
