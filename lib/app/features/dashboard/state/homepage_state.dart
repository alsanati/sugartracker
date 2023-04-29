import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/homepage.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/sugar_data.dart';
import '../../../modules/supabase_modules.dart';

final supabaseHelper = SupabaseHelpers();

Future<String> fetchOpenAIResponse(diabetesdata) async {
  final Uri apiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');
  String prompt =
      "Please write a short daily report for a diabetes app users, targeted at users who want to understand their daily blood sugar readings better. Additionally, include actionable tips for users to make necessary adjustments in their lifestyle and diet to manage their diabetes effectively. Use the following daily blood sugar readings as context: ${jsonEncode(diabetesdata)}";

  final response = await http.post(
    apiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer <nope>',
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
    'Authorization': 'Bearer ${dotenv.env['OPEN_AI_KEY']}',
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

final diabetesDataProvider = FutureProvider<List<dynamic>>((ref) async {
  return await supabaseHelper.fetchDiabetesData();
});

final reportProvider = FutureProvider<String>((ref) async {
  final diabetesData = await ref.watch(diabetesDataProvider.future);
  final report = await fetchOpenAIResponse(diabetesData);
  return report;
});

final homePageProvider = FutureProvider<HomepageState>((ref) async {
  var currentUser = await supabaseHelper.getCurrentUser();
  final sugarData = await getSugarStats();
  return HomepageState(user: currentUser, sugarData: sugarData);
});

Future<List<SugarData>> getSugarStats() async {
  // Here you would fetch the sugar data from your data source
  // and return a List<SugarData>.
  final response = await supabase
      .from('diabetes_sugar')
      .select()
      .eq('personId', supabase.auth.currentUser!.id)
      .order('created_at', ascending: false);

  List<SugarData> sugarLevels = SugarData.getListMap(response);
  return sugarLevels;
}

final getCurrentSugarDataStats = FutureProvider<List<SugarData>>((ref) async {
  final response = await supabase
      .from('diabetes_sugar')
      .select()
      .eq('personId', supabase.auth.currentUser!.id)
      .order('created_at', ascending: true);

  List<SugarData> sugarLevels = SugarData.getListMap(response);
  List<SugarData> currentEntries =
      SugarData.getEntriesForCurrentDay(sugarLevels);
  return currentEntries;
});
