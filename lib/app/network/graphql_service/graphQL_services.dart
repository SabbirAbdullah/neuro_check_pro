//
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../../../flavors/build_config.dart'; // adjust path as needed
//
// class GraphQLService {
//   static Dio? _dio;
//
//   /// Access the base URL from BuildConfig
//   static String get baseUrl => BuildConfig.instance.config.baseUrl ;
//
//   static const int _timeoutSeconds = 60;
//   static const int _maxLogWidth = 90;
//
//   static final _prettyLogger = PrettyDioLogger(
//     requestHeader: true,
//     requestBody: true,
//     responseBody: true,
//     responseHeader: false,
//     error: true,
//     compact: true,
//     maxWidth: _maxLogWidth,
//   );
//
//   static Dio get dio {
//     if (_dio == null) {
//       _dio = Dio(
//         BaseOptions(
//           baseUrl: baseUrl,
//           connectTimeout: const Duration(seconds: _timeoutSeconds),
//           receiveTimeout: const Duration(seconds: _timeoutSeconds),
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );
//       _dio!.interceptors.add(_prettyLogger);
//     }
//     return _dio!;
//   }
//
//   /// Executes a raw GraphQL query or mutation with variables
//   static Future<Map<String, dynamic>> rawQuery({
//     required String query,
//     Map<String, dynamic> variables = const {},
//     String? token,
//   }) async {
//     try {
//       final response = await dio.post(
//         '',
//         data: {
//           'query': query,
//           'variables': variables,
//         },
//         options: Options(
//           headers: {
//             if (token != null) 'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         if (response.data['errors'] != null) {
//           throw Exception(response.data['errors'].toString());
//         }
//         return response.data['data'];
//       } else {
//         throw Exception('GraphQL HTTP ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('GraphQL error: $e');
//     }
//   }
// }
//
