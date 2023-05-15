import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/meals.dart';
import '../models/sugar_data.dart';
import '../utils/invalid_api_key_exception.dart';

class OpenAiApi {
  final String apiKey;

  OpenAiApi({required this.apiKey}) {
    if (apiKey.isEmpty) {
      throw InvalidApiKeyException('API key is empty');
    }
  }

  Future<String> fetchOpenAIResponse(
      List<SugarData> diabetesdata, List<Meal> meals) async {
    final Uri openAiUrl = Uri(
        scheme: 'https', host: 'api.openai.com', path: '/v1/chat/completions');
    List<Map<String, dynamic>> sugarDataList =
        diabetesdata.map((data) => data.toJson(data)).toList();
    List<Map<String, dynamic>> mealDataList =
        meals.map((data) => data.toJson()).toList();

    // Encode the list of JSON data
    String encodedData = jsonEncode(sugarDataList);
    String encodedMeals = jsonEncode(mealDataList);
    String prompt = '''
Please write a short and witty daily report in markdown for diabetes app users, targeted at users who want to understand their daily blood sugar readings better. Analyze their blood sugar levels and meals to give report. Additionally, include actionable tips for users to make necessary adjustments in their lifestyle and diet to manage their diabetes effectively. Use the following daily blood sugar readings as context: $encodedData $encodedMeals.  your response like this:


## Daily Report: {get date from data i provided you}

### Summary
{summary}

#### Actionable Tips:
* {tip1}
* {tip2}
* {tip3}

Replace {title}, {summary}, {tip1}, {tip2}, and {tip3} with relevant content based on the given context.
''';

    final response = await http.post(
      openAiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['message']['content'];
    } else {
      debugPrint('Error response: ${response.body}');
      throw Exception('Failed to fetch data from OpenAI API');
    }
  }
}
