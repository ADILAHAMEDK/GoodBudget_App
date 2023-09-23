import 'package:flutter/material.dart';
import 'package:money_manager/helpers/colors.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms And Conditions'),
        backgroundColor: AppColors.allBlue,
        // leading:  IconButton(onPressed: (){
        //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ScreenSettings()));
        // }, icon:const Icon(Icons.arrow_back))
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
              """[Your Company Name] Money Manager Service Terms and Conditions

Effective Date: [Date]

These Money Manager Service Terms and Conditions (the "Terms") are a legal agreement between [Your Company Name] ("we," "us," or "our") and the client ("you" or "your") for the provision of money management services (the "Services"). By using our Services, you agree to be bound by these Terms.

1. Services

1.1 Scope of Services: We will provide money management services to you, which may include but are not limited to investment advisory, financial planning, and asset management. The specific services provided will be outlined in a separate agreement or engagement letter.

1.2 No Guarantees: We do not guarantee any specific financial results or returns on investments. The value of investments can go up or down, and past performance is not indicative of future results.

2. Client Responsibilities

2.1 Information Accuracy: You are responsible for providing accurate and complete information about your financial situation, goals, and risk tolerance to enable us to provide suitable advice and services.

2.2 Investment Decisions: You have the ultimate authority and responsibility for making investment decisions, and we will act on your instructions and preferences as outlined in our agreement.

2.3 Review and Communication: You are responsible for regularly reviewing your account statements and promptly notifying us of any discrepancies or concerns.

3. Fees and Payment

3.1 Fee Structure: The fees for our Services will be outlined in a separate fee schedule or engagement letter. You agree to pay all applicable fees and charges in accordance with the terms set forth in that document.

3.2 Billing and Payment: Fees are typically billed in advance or as specified in the agreement. You agree to make payments promptly in accordance with the agreed-upon schedule.

4. Termination

4.1 Termination by Client: You may terminate our Services at any time by providing written notice. Termination may be subject to the terms outlined in the agreement, including any applicable fees.

4.2 Termination by Us: We may terminate our Services with written notice if, in our sole discretion, we believe it is in your best interest to do so. Termination may also occur for non-payment of fees or other breaches of these Terms.

5. Confidentiality and Privacy

5.1 Confidentiality: We will maintain the confidentiality of your personal and financial information in accordance with applicable laws and regulations. We may disclose your information to third parties as necessary to provide the Services or as required by law.

5.2 Privacy: We may collect, use, and disclose your personal information as described in our Privacy Policy.

6. Risk Disclosure

6.1 Investment Risks: You acknowledge that investing in financial markets carries inherent risks, and the value of investments can fluctuate. We do not guarantee the safety or performance of any investment.

7. Miscellaneous

7.1 Governing Law: These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction].

7.2 Entire Agreement: These Terms constitute the entire agreement between you and us regarding the Services and supersede all prior agreements and understandings.

By using our Services, you acknowledge that you have read, understood, and agreed to these Terms. If you have any questions or concerns, please contact us at [Your Contact Information]."""),
        ),
      ),
    );
  }
}
