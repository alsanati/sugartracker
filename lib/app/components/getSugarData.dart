import 'dart:async';

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
  bool _redirecting = false;
  final _sugarLevelController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

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
          .insert({'personId': userId, 'sugarLevel': sugarLevels});
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
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ), // add elevated button here

        ElevatedButton(
          onPressed: upload,
          child: Text(_isLoading ? "Loading.. " : "Send"),
        ),
      ],
    );
  }
}
