String formatHHMM(String? time) {
  if (time == null || time.length < 4) return '정보 없음';
  final hour = time.substring(0, 2);
  final minute = time.substring(2, 4);
  return '$hour:$minute';
}
