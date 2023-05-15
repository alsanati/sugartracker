import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/features/feed/state/feed_page_state.dart';
import 'package:sugar_tracker/app/models/homepage.dart';
import 'package:sugar_tracker/app/modules/meal_module.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import '../../../models/sugar_data.dart';
import '../../../modules/open_ai_module.dart';
import '../../../modules/supabase_modules.dart';
import '../../../utils/opan_ai_config.dart';

final supabaseHelper = SupabaseHelpers(supabase);

final openAiConfig = OpenAiConfig.withApiKey();
final openAI = OpenAiApi(apiKey: openAiConfig.apiKey ?? '');

final diabetesDataProvider = FutureProvider<List<SugarData>>((ref) async {
  return await supabaseHelper.fetchDiabetesData();
});

final reportProvider = FutureProvider<String>((ref) async {
  MealRepository meal = MealRepository(supabase);
  final diabetesData = await ref.watch(diabetesDataProvider.future);
  final mealData = await meal.getMeals();
  final report = await openAI.fetchOpenAIResponse(diabetesData, mealData);
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
