import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sugar_tracker/constants.dart';

class PostSugarLevels extends StatefulWidget {
  const PostSugarLevels({Key? key}) : super(key: key);

  @override
  PostSugarLevelsState createState() {
    return PostSugarLevelsState();
  }
}

class PostSugarLevelsState extends State<PostSugarLevels> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _sugarLevelController = TextEditingController();

  Future<void> upload() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userId = supabase.auth.currentUser!.id;
        final sugarLevels = _sugarLevelController.text;
        await supabase
            .from('diabetes_sugar')
            .insert({'personId': userId, 'sugar_level': sugarLevels});
        if (mounted) {
          context.showSnackBar(
              message: 'Successfully posted your sugar levels!');
        }
        _sugarLevelController.clear();
      } on AuthException catch (error) {
        context.showErrorSnackBar(message: error.message);
      } catch (error) {
        context.showErrorSnackBar(message: 'Unexpected error occurred');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _sugarLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.onTertiaryContainer;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodySmall,
              controller: _sugarLevelController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a sugar level';
                }
                return null;
              },
              maxLines: 1,
              maxLength: 3,
              decoration: InputDecoration(
                  hintText: 'Enter your sugar level',
                  prefixIcon: const Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodySmall,
              controller: _sugarLevelController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a sugar level';
                }
                return null;
              },
              maxLines: 1,
              maxLength: 3,
              decoration: InputDecoration(
                  hintText: 'Enter your sugar level',
                  prefixIcon: const Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodySmall,
              controller: _sugarLevelController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a sugar level';
                }
                return null;
              },
              maxLines: 1,
              maxLength: 3,
              decoration: InputDecoration(
                  hintText: 'Enter your sugar level',
                  prefixIcon: const Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                splashFactory: InkSparkle.splashFactory),
            onPressed: upload,
            child: Text(
              _isLoading ? 'Loading...' : 'Add',
              style: TextStyle(color: buttonColor),
            ),
          ),
        ],
      ),
    );
  }
}
