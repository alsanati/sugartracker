import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigateToNewPage(BuildContext context, String page) {
  GoRouter.of(context).go(page);
}
