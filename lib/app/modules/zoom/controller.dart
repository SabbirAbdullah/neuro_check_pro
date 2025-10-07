// import 'package:flutter_zoom_sdk/zoom_options.dart';
//
// import 'package:get/get.dart';
//
//
// class ZoomController extends GetxController {
//   final meetingId = ''.obs;
//   final meetingPassword = ''.obs;
//
//   final ZoomOptions zoomOptions = ZoomOptions(
//     domain: "zoom.us", // Zoom domain
//     appKey: "YOUR_ZOOM_SDK_KEY", // from Zoom marketplace
//     appSecret: "YOUR_ZOOM_SDK_SECRET",
//   );
//
//   final ZoomMeetingOptions meetingOptions = ZoomMeetingOptions(
//     meetingId: "",
//     meetingPassword: "",
//     disableDialIn: "true",
//     disableDrive: "true",
//     disableInvite: "true",
//     disableShare: "true",
//     disableTitlebar: "false",
//     viewOptions: "true",
//   );
//
//   Future<void> joinMeeting() async {
//     final zoom = ZoomView();
//     var options = meetingOptions.copyWith(
//       meetingId: meetingId.value,
//       meetingPassword: meetingPassword.value,
//       displayName: "Flutter User",
//     );
//
//     zoom.initZoom(zoomOptions).then((results) {
//       if (results[0] == 0) {
//         zoom.joinMeeting(options).then((joinMeetingResult) {
//           print("Meeting Status: $joinMeetingResult");
//         });
//       }
//     });
//   }
// }
