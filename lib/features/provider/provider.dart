import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/date_converter.dart';

final todateSelectedProv = StateProvider(
  (ref) => dateFormattertoStr(
    DateTime.now(),
  ),
);
final fromdateSelectedProv = StateProvider(
  (ref) => dateFormattertoStr(
    DateTime.now(),
  ),
);

final designationProv = StateProvider(
  (ref) => '',
);

final employeeCurListProv = StateProvider(
  (ref) => [],
);
final employeePreListProv = StateProvider(
  (ref) => [],
);
