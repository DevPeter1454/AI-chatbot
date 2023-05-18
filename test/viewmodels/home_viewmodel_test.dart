import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ask_ai/app/app.bottomsheets.dart';
import 'package:ask_ai/app/app.locator.dart';
import 'package:ask_ai/ui/common/app_strings.dart';
import 'package:ask_ai/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel _getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
