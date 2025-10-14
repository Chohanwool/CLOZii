import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/auth/core/enum/agreement_type.dart';
import 'package:flutter/material.dart';

class AgreementDetail extends StatelessWidget {
  const AgreementDetail({super.key, required this.type});

  final AgreementType type;

  /// 약관 타입별 제목
  String getTitle() {
    switch (type) {
      case AgreementType.terms:
        return 'Terms of Service';
      case AgreementType.privacy:
        return 'Privacy Policy';
      case AgreementType.location:
        return 'Location Information Agreement';
      case AgreementType.marketing:
        return 'Marketing Consent';
      default:
        return 'Agreement';
    }
  }

  /// 약관 타입별 내용 (실무에서는 이 부분을 서버나 로컬 파일에서 불러올 수도 있음)
  String getContent() {
    switch (type) {
      case AgreementType.terms:
        return '''
Welcome to CLOZii!  
By using our services, you agree to the following terms:

1. You must be at least 18 years old to create an account.  
2. You are responsible for maintaining the confidentiality of your account.  
3. CLOZii reserves the right to modify these terms at any time.  
4. Violation of these terms may result in account suspension or termination.
        ''';

      case AgreementType.privacy:
        return '''
We take your privacy seriously.

- We collect minimal personal data necessary to provide our services.  
- Your data will never be sold to third parties.  
- You may request data deletion at any time via account settings.
        ''';

      case AgreementType.location:
        return '''
We use your location to show nearby listings.

- Location data is used only while the app is active.  
- You may disable location access anytime from device settings.  
- Location information helps improve search relevance.
        ''';

      case AgreementType.marketing:
        return '''
We may send marketing communications about new offers or features.

- You can opt-out anytime in your notification settings.  
- We never share your contact information with advertisers.  
- Your consent helps us improve personalized experiences.
        ''';

      default:
        return 'No agreement content available.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = getTitle();
    final content = getContent();

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
