import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: Colors.black,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                child: const Center(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ),
              const Text(
                  '''privacy policy\nThis privacy policy explains how we collect your information\nPersonal information, use, disclosure and protection upon access\nTo our MET and use it.By using the Application, you agree to the practicesdescribed in this Privacy Policy.
Information we collect
Connection. B. Usage Information: We may collect information
About your use of the application, including your IP address
Your device information, browser type and system
Employment.
C. Cookies and tracking technologies:
We use cookies and technologies
Similar tracking to improve your experience
Your application collects information about your preferences and behavior
Browsing.
Use of information
a. We may use your personal information to:
Providing, operating and improving the MET application and its services.
Processing and executing your requests and transactions.
Communicate with you regarding your account and requests
and application updates.
Respond to your inquiries and provide customer service

Personalize your app and viewing experience
Related content and offers
Relevance. Send promotional materials and communications
Marketing to you if you subscribe to
Receive it.
B. We may aggregate and anonymize data
For statistical and analytical purposes, which is not
Personally identifies you.
Exchange and disclosure of information
a. We may share your personal information with: .
Business partners or affiliates in connection with
Promotions, contests or joint marketing initiatives.
Law enforcement authorities or government officials
Or other third parties when we are requested to do so
This is done by law or in response to a request
Valid legal. B. We may also disclose
About your information in connection with a merger or acquisition
or sell all or a portion of our assets, subject to approval
The acquirer is responsible for protecting your personal information.
Data security
a. We implement reasonable security measures to protect
Your personal information is not accessible
authorized, disclosed, changed or
Destroy it. However, no method is completely safe
For online transmission or storage
Email, we cannot guarantee this

Absolute security.
B. You are responsible for maintaining confidentiality
Your account credentials and any actions
It is taken under your account. Please notify us at
immediately of any unauthorized access to
Your account or its use.
  may be
Our application contains recipes
Contains links to third-party websites or services
We own or control them. This Privacy Policy does not apply
On third party websites or services
External. We encourage you to review our privacy policies
own before submitting any
personal information.
Children's privacy\n
Our application is not
Intended for children under 18 years of age.
We do not knowingly collect personal information from children.
If you think we may have collected information
From a child without parental consent, please contact
We will delete this information immediately.
Changes to this Privacy Policy
We may update this Privacy Policy from time to time
time. The revised policy will be effective when
Post it on the app. If you continue to use
Application after publication of the revised policy constitutes
Your consent to the changes.

call us
If you have any questions or concerns about our Privacy Policy
These or our data practices, please contact us
on
muslimdeveloper106@gmail.com'''),
            ],
          ),
        ),
      ),
    );
  }
}
