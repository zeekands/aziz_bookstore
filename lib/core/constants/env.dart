import 'package:flutter_dotenv/flutter_dotenv.dart';

final String geminiKey = dotenv.env['GEMINI_KEY'] ?? "";
final String baseUrl = dotenv.env['BASE_URL'] ?? "";
