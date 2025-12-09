import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:riverpod/riverpod.dart';

final scanner_controller_provider = Provider.autoDispose(
  (ref) => MobileScannerController(facing: CameraFacing.back),
);
