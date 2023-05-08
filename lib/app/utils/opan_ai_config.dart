import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAiConfig {
  final String? apiKey;

  // Default constructor
  OpenAiConfig({this.apiKey});

  // Named constructor with apiKey parameter
  OpenAiConfig.withApiKey() : apiKey = dotenv.env['OPEN_AI_KEY'];
}
