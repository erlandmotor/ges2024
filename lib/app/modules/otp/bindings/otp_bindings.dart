import 'package:http/http.dart' as http;

Future<http.Response> initializeApp() async {
  return await http.get(
    Uri.parse("https://witek-inspire.net/check.php"),
    headers: {
      "content-type": "application/json",
      "accept": "application/json",
    },
  );
}
