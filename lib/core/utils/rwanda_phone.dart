enum Carrier { mtn, airtel, unknown }

class ParsedPhone {
  final bool valid;
  final String e164;
  final Carrier carrier;

  const ParsedPhone({
    required this.valid,
    required this.e164,
    required this.carrier,
  });
}

ParsedPhone parseRwandaPhone(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');

  String local;
  if (digits.startsWith('250') && digits.length == 12) {
    local = digits.substring(3);
  } else if (digits.startsWith('0') && digits.length == 10) {
    local = digits.substring(1);
  } else {
    local = digits;
  }

  if (local.length != 9) {
    return const ParsedPhone(valid: false, e164: '', carrier: Carrier.unknown);
  }

  final prefix = local.substring(0, 2);
  final carrier = switch (prefix) {
    '78' || '79' => Carrier.mtn,
    '72' || '73' => Carrier.airtel,
    _ => Carrier.unknown,
  };

  if (carrier == Carrier.unknown) {
    return const ParsedPhone(valid: false, e164: '', carrier: Carrier.unknown);
  }

  return ParsedPhone(
    valid: true,
    e164: '+250$local',
    carrier: carrier,
  );
}
