import 'package:flutter/material.dart';
import 'package:spot_holder/style/styling.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Styling.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrivacyPolicySection(
              title: '1. Introduction:',
              content: const [
                'Welcome to Spot-Holder!',
                'This Privacy Policy outlines how we collect, use, and protect your personal information when you use our mobile application.',
              ],
            ),
            PrivacyPolicySection(
              title: '2. Information We Collect:',
              content: const [
                'User Profile Information: We may collect and store information you provide when creating a user or seller profile. This may include your name, email address, contact information, and profile picture.',
                'Location Data: We may access your device\'s GPS or other location services to provide location-based features, such as finding nearby NGO or Donars.',
                'Usage Data: We may collect information about how you interact with our app, including the features you use and the actions you take.',
              ],
            ),
            PrivacyPolicySection(
              title: '3. How We Use Your Information:',
              content: const [
                'Providing Services: We use your information to provide the services you request, such as connecting donation and sending it to NGOs.',
                'Communication: We may send you service-related notifications and updates.',
              ],
            ),
            PrivacyPolicySection(
              title: '4. Data Security:',
              content: const [
                'We take appropriate measures to protect your data, including encryption and access controls.',
              ],
            ),
            PrivacyPolicySection(
              title: '5. Third-Party Services:',
              content: const [
                'We may use third-party services (e.g., Firebase, Google Maps API) that have their own privacy policies.',
              ],
            ),
            PrivacyPolicySection(
              title: '6. Your Choices:',
              content: const [
                'You can update or delete your profile information within the app.',
                'You can opt out of receiving non-essential communications.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  final String title;
  final List<String> content;

  PrivacyPolicySection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content
                  .map((paragraph) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(paragraph),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
