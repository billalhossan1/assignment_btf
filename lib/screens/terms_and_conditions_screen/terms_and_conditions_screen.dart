import 'package:flutter/material.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
        child: AppText(
          height: 1.8,
          data:
              """By using car a rental mobile application, you agree to our terms and conditions. Renters must meet age and license requirements. Vehicles must be returned in their original condition and on time to avoid additional charges. Insurance and deposit policies apply. Any damages, late returns, or violations will incur penalties. We reserve the right to modify terms without prior notice. By booking, you accept these terms. For full details, please review our complete policy before renting. Drive responsibly!
      
       """,
        ),
      ),
    );
  }
}
