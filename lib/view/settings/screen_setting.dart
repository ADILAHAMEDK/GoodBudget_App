import 'dart:io';
import 'package:flutter/material.dart';
import 'package:money_manager/view/settings/about_page.dart';
import 'package:money_manager/view/settings/privicy_policy.dart';
import 'package:money_manager/view/settings/reset_page.dart';
import 'package:money_manager/view/settings/term_and_condition.dart';
import '../homeScreen/home_screen.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: const Text(
                'About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: const Icon(
                Icons.info,
                size: 35,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
                title: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                leading: const Icon(
                  Icons.refresh,
                  size: 35,
                  color: Colors.blue,
                ),
                onTap: () {
                  resetDB(context);
                }),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: const Icon(
                Icons.privacy_tip_sharp,
                size: 35,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: const Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: const Icon(
                Icons.sticky_note_2_outlined,
                color: Colors.blue,
                size: 35,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsAndConditions()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: const Text(
                'Exit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: const Icon(
                Icons.exit_to_app_rounded,
                size: 35,
                color: Colors.blue,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
                        title: const Text(
                          'Conirm Exit',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          'Are you sure you want to exit the app?',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).popUntil(exit(0));
                            },
                            child: const Text(
                              'Exit',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
