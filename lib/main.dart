import 'dart:async';

import 'package:interactive_story/src/core/utils/refined_logger.dart';
import 'package:interactive_story/src/feature/app/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );
