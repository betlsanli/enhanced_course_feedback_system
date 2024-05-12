import 'package:enhanced_course_feedback_system/pages/StudentWriteFeedbackPage.dart';
import 'package:flutter/material.dart';

import 'ChatGPTConfigPage.dart';
import 'EmailServerConfigPage.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatGPTConfigPage(settings: ['Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3'],),
                      ),
                  );
                }, 
                child: const Text('Configure ChatGPT API'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 70),
              ),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailServerConfigPage(),
                      ),
                  );
                },
                child: const Text('Configure E-Mail Server'),
                style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 70),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
