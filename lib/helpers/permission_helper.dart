import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestLocationPermission() async {
    PermissionStatus locationStatus = await Permission.location.status;

    if (!locationStatus.isGranted) {
      final status = await Permission.location.request();
      return status.isGranted;
    } else if (locationStatus.isDenied) {
      openAppSettings();
    }

    return locationStatus.isGranted;
  }
}
