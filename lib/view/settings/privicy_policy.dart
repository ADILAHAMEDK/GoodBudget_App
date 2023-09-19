import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        title:const Text('Privacy Policy'),
      // leading: IconButton(onPressed: (){
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenSettings()));
      //   }, icon: const Icon(Icons.arrow_back)),
      ),
      body:const SingleChildScrollView(
        child: Padding(padding:EdgeInsets.all(10),
        child:Text("""Privacy Policy for [Your Money Manager App]

Last Updated: [Date]

1. Introduction

Welcome to [Your Money Manager App] ("we," "our," or "us"). At [Your Money Manager App], we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard your data when you use our money management services.

2. Information We Collect

Personal Information: We may collect personal information, such as your name, email address, and financial information, when you register for or use [Your Money Manager App].

Financial Information: We may collect and store your financial information, including transaction history, account balances, and income details, to provide our money management services effectively.

Device Information: We may collect device information, such as your IP address, browser type, operating system, and device identifiers, to enhance your experience and ensure the security of our services.

Location Information: If you enable location services, we may collect and process your location data for specific features of the app, such as expense tracking.

3. How We Use Your Information

We may use your information for the following purposes:

To provide and maintain our money management services.
To improve our services and develop new features.
To communicate with you regarding updates, news, and promotions.
To personalize your experience and provide tailored content.
To ensure the security and integrity of our services.
To comply with legal obligations and regulations.
4. Sharing Your Information

We may share your information with the following entities:

Third-party service providers: We may share data with trusted third parties that assist us in delivering our services, such as payment processors, cloud hosting providers, and analytics services.

Legal compliance: We may disclose your information when required by law, in response to legal requests, or to protect our rights, privacy, safety, or property.

5. Data Security

We implement security measures to protect your information from unauthorized access, disclosure, alteration, or destruction. However, no data transmission over the internet or storage system is 100% secure, and we cannot guarantee the absolute security of your data.

6. Your Choices

You can control certain aspects of your data, such as updating your personal information or opting out of promotional communications. You may also disable location services or delete your account at any time.

7. Children's Privacy

Our services are not intended for children under the age of 13. We do not knowingly collect or maintain information from anyone under the age of 13.

8. Changes to this Privacy Policy

We may update this Privacy Policy to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any changes by posting the new policy on this page.

9. Contact Us

If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at [contact@email.com].""",
),
        
        ),
      ),
    );
  }
}