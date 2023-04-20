String? validateAmount(String? value) {
  if (value == null) return 'Amount required !';
  if (value.isEmpty) return 'Amount required !';
  if (double.tryParse(value) == null) return 'Enter a valid amount !';
  if (double.parse(value) <= 0) return 'Enter a valid amount !';
  if (double.parse(value) >= 100000000) {
    return 'Amount must be less than 100000000';
  }
  return null;
}
