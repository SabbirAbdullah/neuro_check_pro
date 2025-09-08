// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/splash_controller.dart';
//
// class SplashView extends StatefulWidget {
//   SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   final SplashController controller = Get.put(SplashController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Obx(() {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               CircleAvatar(
//                 radius: 80,
//                 backgroundColor: Colors.white,
//                 child: Text(
//                   "N",
//                   style: TextStyle(
//                     fontSize: 100,
//                     color: Color(0xFF114854),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   text: 'Welcome to',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: ' NeuroCheckPro',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               // Show loader only when API call is running
//               if (controller.isLoading.value)
//                 const CircularProgressIndicator(),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
