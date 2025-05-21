String capitalizeAndTrim(String text) {

  // Remove leading/trailing spaces
  text = text.trim();

  // Capitalize the first letter of each word and make others lowercase
  return text.split(' ').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
  
}

String addPrefixToPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.trim();  // Trim leading/trailing spaces
  
  // Check if the phone number starts with a '0'
  if (phoneNumber.startsWith("0")) {
    return "+234${phoneNumber.substring(1)}";  // Remove the '0' and add the '+234' prefix
  }

  // If the phone number doesn't start with '0', add the '+234' prefix
  return "+234$phoneNumber";
}
