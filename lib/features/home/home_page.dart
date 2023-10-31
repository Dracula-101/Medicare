import 'package:medicare/core/keys/app_keys.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(WidgetKeys.homeScaffoldKey),
      appBar: AppBar(
        title: Text(
          'Medicare App',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text(
                'Go to Login Page',
              ),
              onPressed: () {},
            ),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
              child: Text('Go to Register Page'),
              onPressed: () {},
            ),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
              child: Text('Go to Forgot Password Page'),
              onPressed: () {},
            ),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
              child: Text('Go to Images From DB Page'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
