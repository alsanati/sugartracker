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
"Please generate a concise and engaging daily report in markdown format for users of our diabetes app. The report should help users better understand their daily blood sugar readings and meal intake. Use the following daily blood sugar readings and meal data as context: $encodedData $encodedMeals.

The report should include:

A brief analysis of the user's blood sugar levels throughout the day, highlighting any significant fluctuations or patterns.
An overview of the user's meals, focusing on their nutritional content and how they might have affected the user's blood sugar levels.
Practical and personalized tips to help the user manage their diabetes more effectively. This could include suggestions for dietary changes, lifestyle modifications, or strategies for maintaining stable blood sugar levels.

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
