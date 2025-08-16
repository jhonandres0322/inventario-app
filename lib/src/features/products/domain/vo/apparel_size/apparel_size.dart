sealed class ApparelSize {
  const ApparelSize();
  String get label;
}

enum TopAlphaCode { xs, s, m, l, xl, xxl }

final class TopAlphaSize extends ApparelSize {
  final TopAlphaCode code;
  const TopAlphaSize(this.code);

  @override
  String get label => code.name.toUpperCase();
}

final class BottomNumericSize extends ApparelSize {
  final int waist;
  const BottomNumericSize(this.waist);

  @override
  String get label => waist.toString();
}

final class OneSize extends ApparelSize {
  const OneSize();

  @override
  String get label => 'única';
}
