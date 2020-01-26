int StringToInt(String str) {
  return int.tryParse(str) ?? 0;
}

double StringToDouble(String str) {
  return double.tryParse(str) ?? 0.0;
}