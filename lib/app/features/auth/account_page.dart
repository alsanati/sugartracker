import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sugar_tracker/app/utils/constants.dart';

import '../components/avatar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  String? _avatarUrl;
  var _loading = false;

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single() as Map;
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred');
    }

    setState(() {
      _loading = false;
    });
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text;
    final website = _websiteController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: 'Successfully updated profile!');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpeted error occurred');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
    if (mounted) {
      context.go('/login');
    }
  }

  /// Called when image has been uploaded to Supabase storage from within Avatar widget
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      if (mounted) {
        context.showSnackBar(message: 'Updated your profile image!');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error has occurred');
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
        useMaterial3:
            true); // Opt-in to Material 3 [docs.flutter.dev](https://docs.flutter.dev/ui/material)

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Avatar(
            imageUrl: _avatarUrl,
            onUpload: _onUpload,
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'User Name',
              labelStyle: theme.textTheme
                  .subtitle1, // Apply Material 3 typography [docs.flutter.dev](https://docs.flutter.dev/ui/material)
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _websiteController,
            decoration: InputDecoration(
              labelText: 'Website',
              labelStyle: theme.textTheme
                  .subtitle1, // Apply Material 3 typography [docs.flutter.dev](https://docs.flutter.dev/ui/material)
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text(_loading ? 'Saving...' : 'Update'),
            style: ElevatedButton.styleFrom(
              primary: theme.colorScheme
                  .primary, // Apply Material 3 color system [docs.flutter.dev](https://docs.flutter.dev/ui/material)
              onPrimary: theme.colorScheme
                  .onPrimary, // Apply Material 3 color system [docs.flutter.dev](https://docs.flutter.dev/ui/material)
              elevation:
                  4, // Apply Material 3 elevation support [docs.flutter.dev](https://docs.flutter.dev/ui/material)
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: _signOut,
            child: const Text('Sign Out'),
            style: TextButton.styleFrom(
              primary: theme.colorScheme
                  .primary, // Apply Material 3 color system [docs.flutter.dev](https://docs.flutter.dev/ui/material)
              onSurface: theme.colorScheme
                  .onSurface, // Apply Material 3 color system [docs.flutter.dev](https://docs.flutter.dev/ui/material)
            ),
          ),
        ],
      ),
    );
  }
}
