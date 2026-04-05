import 'dart:convert';
import 'dart:io';
import 'dart:vmservice_io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

void main() async {
  final router = Router();
  router.get('/', (Request request) {
    return Response.ok('API LoPlus en ligne');
  });
  router.get('/api/images', (Request request) {
    final baseUrl =
        Platform.environment['RENDER_EXTERNAL_URL'] ?? 'http://localhost:8080';
    final images = [
      {'id': 1, 'url': '$baseUrl/images/lop1.jpg'},
      {'id': 2, 'url': '$baseUrl/images/lop2.jpg'},
      {'id': 3, 'url': '$baseUrl/images/lop3.jpg'},
      {'id': 4, 'url': '$baseUrl/images/lop4.jpg'},
      {'id': 5, 'url': '$baseUrl/images/lop5.jpg'},
      {'id': 6, 'url': '$baseUrl/images/lop6.jpg'},
      {'id': 7, 'url': '$baseUrl/images/lop7.jpg'},
      {'id': 8, 'url': '$baseUrl/images/lop8.jpg'},
      {'id': 9, 'url': '$baseUrl/images/lop9.jpg'},
      {'id': 10, 'url': '$baseUrl/images/lop10.jpg'},
      {'id': 11, 'url': '$baseUrl/images/lop11.jpg'},
      {'id': 12, 'url': '$baseUrl/images/lop12.jpg'},
      {'id': 13, 'url': '$baseUrl/images/lop13.jpg'},
      {'id': 14, 'url': '$baseUrl/images/lop14.jpg'},
    ];
    return Response.ok(
      jsonEncode(images),
      headers: {'Content-Type': 'appliaction/json'},
    );
  });
  final imageHandler = createStaticHandler('images');
  final cascade = Cascade().add((Request request) {
    if (request.url.path.startsWith('images/')) {
      final newRequest = request.change(
        path: request.url.path.replaceFirst('images', ''),
      );
      return imageHandler(newRequest);
    }
    return router(request);
  });

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await io.serve(cascade.handler, InternetAddress.anyIPv4, port);
  print('Serveur démarré sur le port ${server.port}');
}
