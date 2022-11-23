import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_quickstart/constants.dart';

class PostSugarLevels extends StatefulWidget {
  const PostSugarLevels({super.key});

  @override
  PostSugarLevelsState createState() {
    return PostSugarLevelsState();
  }
}

class PostSugarLevelsState extends State<PostSugarLevels> {
  bool _isLoading = false;
  final _sugarLevelController = TextEditingController();

  Future<void> upload() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userId = supabase.auth.currentUser!.id;
      final sugarLevels = _sugarLevelController.text;
      if (sugarLevels.isEmpty) {
        context.showErrorSnackBar(message: 'Please enter a sugar level');

        setState(() {
          _isLoading = false;
        });

        return;
      }
      await supabase
          .from('diabetes_sugar')
          .insert({'personId': userId, 'sugar_level': sugarLevels});
      if (mounted) {
        context.showSnackBar(message: 'Successfully posted your sugar levels!');
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _sugarLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _sugarLevelController,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your sugar level',
              isCollapsed: false),
        ), // add elevated button here
        ElevatedButton(
          onPressed: upload,
          child: Text(_isLoading ? "Loading.. " : "Send"),
        ),
      ],
    );
  }
}
