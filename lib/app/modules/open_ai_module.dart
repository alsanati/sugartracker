import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchOpenAIResponse(diabetesdata) async {
  final Uri apiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');
  String prompt =
      "Please write a short and witty daily report in markdown for a diabetes app users, targeted at users who want to understand their daily blood sugar readings better. Additionally, include actionable tips for users to make necessary adjustments in their lifestyle and diet to manage their diabetes effectively. Use the following daily blood sugar readings as context: ${jsonEncode(diabetesdata)}";

  final response = await http.post(
    apiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
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
    throw Exception('Failed to fetch data from OpenAI API');
  }
}

Future<String> getReport(diabetesData) async {
  // Define API URL and headers
  String apiUrl = 'https://api.openai.com/v1/chat/completions';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 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',
  };

  // Define the prompt and request body
  String prompt =
      'Act as a diabetes expert and write a short report about the following data: \${json.encode(diabetesData)}';
  Map<String, dynamic> requestBody = {
    'prompt': prompt,
    'max_tokens': 100,
    'n': 1,
  };

  // Make the API request
  http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: json.encode(requestBody),
  );

  // Check the response status and extract the report
  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    String report = responseBody['choices'][0]['text'];
    return report;
  } else {
    throw Exception('Failed to get report from OpenAI API');
  }
}
