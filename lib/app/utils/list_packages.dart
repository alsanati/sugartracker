import 'package:flutter/material.dart';

class PackageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final packages = {
      'supabase_flutter': '^1.2.2',
      'auto_route': '^7.1.0',
      'fpdart': '^0.6.0',
      'json_annotation': '^4.7.0',
      'cupertino_icons': '^1.0.5',
      'image_picker': '^0.8.6',
      'flutter_dotenv': '^5.0.2',
      'syncfusion_flutter_charts': '^21.2.4',
      'go_router': '^7.0.1',
      'email_validator': '^2.1.17',
      'provider': '^6.0.5',
      'flutter_riverpod': '^2.2.0',
      'freezed_annotation': '^2.0.3',
      'google_fonts': '^4.0.3',
      'intl': '^0.18.0',
      'font_awesome_flutter': '^10.4.0',
      'flutter_local_notifications': '^14.0.0+2',
      'timezone': '^0.9.2',
      'rxdart': '^0.27.7',
      'path_provider': '^2.0.14',
      'http': '^0.13.5',
      'loading_animation_widget': '^1.2.0+4',
      'flutter_markdown': '^0.6.14',
      'animated_text_kit': '^4.2.2',
      'freezed': '^2.3.3',
      'shared_preferences': '^2.1.1',
      'pdf': '^3.10.3',
      'printing': '^5.10.4',
      'syncfusion_flutter_pdf': '^21.2.5',
      'csv': '^5.0.2',
      'permission_handler': '^10.2.0',
      'smooth_page_indicator': '^1.1.0',
      'collection': '^1.17.1',
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Package List'),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final packageName = packages.keys.elementAt(index);
          final packageVersion = packages.values.elementAt(index);
          return Card(
            child: ListTile(
              title: Text(packageName),
              subtitle: Text('Version: $packageVersion'),
            ),
          );
        },
      ),
    );
  }
}
