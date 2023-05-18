// lib/env/env.dart
import 'package:envied/envied.dart';
part 'env.g.dart';

// .env

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static const apiKey = _Env.apiKey;
}

// const String organizationId = 'org-nPIRDxZ4O181oVBFcuhh2sWL';
