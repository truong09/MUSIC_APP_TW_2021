import 'package:permission_handler/permission_handler.dart';

getPerMision() async {
  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[
        Permission.storage]); // it should print PermissionStatus.granted
  }
}
