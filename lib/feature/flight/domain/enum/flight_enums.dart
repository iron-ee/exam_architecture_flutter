enum TerminalId {
  p01('제1 터미널'),
  p02('탑승동'),
  p03('제2 터미널'),
  c01('화물터미널 남측'),
  c02('화물터미널 북측'),
  c03('제2 화물터미널'),
  unknown('정보 없음');

  final String displayName;
  const TerminalId(this.displayName);

  static TerminalId fromString(String? terminalId) {
    switch (terminalId) {
      case 'P01':
        return TerminalId.p01;
      case 'P02':
        return TerminalId.p02;
      case 'P03':
        return TerminalId.p03;
      case 'C01':
        return TerminalId.c01;
      case 'C02':
        return TerminalId.c02;
      case 'C03':
        return TerminalId.c03;
      default:
        return TerminalId.unknown;
    }
  }
}

enum TypeOfFlight {
  international('국제선'),
  domestic('국내선'),
  unknown('정보 없음');

  final String displayName;
  const TypeOfFlight(this.displayName);

  static TypeOfFlight fromString(String? typeOfFlight) {
    switch (typeOfFlight) {
      case 'I':
        return TypeOfFlight.international;
      case 'D':
        return TypeOfFlight.domestic;
      default:
        return TypeOfFlight.unknown;
    }
  }
}
