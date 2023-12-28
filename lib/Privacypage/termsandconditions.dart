import 'package:flutter/material.dart';

class TermsandConditions extends StatelessWidget {
  const TermsandConditions({super.key});

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
                    "Terms and Conditions",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ),
              const Text('''
Terms and Conditions - MET Application
Welcome to the MET app
Our! These terms and conditions govern
(“Agreement”) Your access to and use of the Recipes App, including any Content
Features and services provided through the application. from
By accessing or using the Application, you
You agree to be bound by this Agreement. Please
Read these terms and conditions carefully before
Application Usage.
Accept the terms
By accessing and using our Recipes App, you acknowledge
That you have read and understood these terms and conditions
I agreed to abide by it. If you do not agree
on any part of this Agreement, you must
Do not use the application.
User eligibility
You must be at least 18 years old to be able to
Of using your own e-commerce application
coffee beans. By using the Application, you represent and warrant
You are of legal age and have legal capacity
To conclude this agreement.

Register an account
To access certain of our features
Recipes app, may
You need to create an account. do you agree
To provide accurate and up-to-date information
And complete during the registration process. You
You are solely responsible for preservation
On the confidentiality of your account credentials and
All activities that occur under your account.
You must notify us immediately
Any unauthorized use of your account.
Application Usage
a. You agree to use the Recipes Application only for lawful purposes and in accordance with
to this agreement. You will not use the application
To engage in any prohibited activities, including
For example but not limited to:
Upload, transmit or distribute any content
Illegal, harmful or defamatory
Or obscene or objectionable
In any other way.
Impersonate any person or
entity or falsely represent your affiliation with any entity
A person or entity.
Engage in any fraudulent activities
Or deceptive.

Interfering with the operation of the application, including introducing
Viruses, malware, or other
Malicious code.
Violate any applicable laws or
Systems.
B. We reserve the right to comment
or terminate your access to the Application, without
Advance notice of any violation of these
Convention.
intellectual property
a. All intellectual property rights, incl
Copyrights, trademarks and secrets
Commercial, in the application of MET
Our and its content are owned by us or
To our licensors. You are granted a limited, non-exclusive license
It is not transferable to use the application
For personal, non-commercial purposes only.
B. You may not copy, modify, distribute or
Sell or rent any part of the application or its content
Without obtaining our prior written consent.
Product listings and sales
We do not endorse or guarantee the accuracy, quality or safety
Or the legality of any products listed on the application.
You agree that any purchase or transaction

Third party links and services may
The application contains special MET
We provide links to websites, services or
Third-party resources that we do not own or control
In which. We are not responsible for the content or
Privacy policies or practices
Any third-party sites or services. You
You acknowledge and agree that we will not be liable
For any loss or damage arising from your use
To third party websites or services.
Limitation of liability
a. Application and food labels are provided
OUR AND THE CONTENT ARE ON AN “AS IS” AND “AS IS” BASIS
is available.” We make no guarantees
or representations, express or implied,
In connection with the Application or its content
Or its availability.
B. To the maximum extent permitted by law
applicable, we will not be responsible for that
'''),
            ],
          ),
        ),
      ),
    );
  }
}
