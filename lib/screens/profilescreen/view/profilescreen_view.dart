import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://example.com/your-profile-image-url.jpg',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Jhon Abraham',
                style: appTypography.regular
                    .copyWith(fontSize: (17), color: Colors.black),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.help),
                  title: Text(
                    'Help',
                    style: appTypography.regular
                        .copyWith(fontSize: (17), color: Colors.black),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.support),
                  title: Text(
                    'Support',
                    style: appTypography.regular
                        .copyWith(fontSize: (17), color: Colors.black),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
