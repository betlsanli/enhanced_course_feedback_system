import 'package:enhanced_course_feedback_system/data/RequestForm.dart';
import 'package:enhanced_course_feedback_system/pages/ChatGPTConfigPage.dart';
import 'package:enhanced_course_feedback_system/pages/StudentWriteFeedbackPage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../data/RequestFormUtils.dart';
import 'AdminDashboard.dart';
import 'LandingPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EmailServerConfigPage extends StatefulWidget {
  const EmailServerConfigPage({Key? key}) : super(key: key);

  @override
  _EmailServerConfigPageState createState() => _EmailServerConfigPageState();

}

  class _EmailServerConfigPageState extends State<EmailServerConfigPage>{

  bool _isConfigured=false;


  //for testing
  Future<RequestForm?> fetchRequestForm() async {
    final response = await supabase
        .schema('ecfs')
        .from('request_form')
        .select()
        .eq('form_id', '1500c6db-5d33-4bc6-b588-8d865e0e4527')
        .limit(1);
    return RequestForm.fromMap(response.first, await fetchCourseName(response.first['course_code']));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure E-Mail Server'),

        backgroundColor: Colors.indigo.shade300,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Token',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val){
                    if(val!.isEmpty || val == null){
                      return 'Required';
                    }
                    return null;
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: ElevatedButton(
                onPressed: (){
                },
                child: Text('Configure'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                ),

              ),
            ),
            if(_isConfigured)
              Text('Email Server Configured Successfully',
                style: TextStyle(color: Colors.green),
              ),

            ElevatedButton(
              onPressed: () async{
                RequestForm? requestForm= await fetchRequestForm();
                if(requestForm !=null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentWriteFeedbackPage(requestForm: requestForm),
                    ),
                  );
                }

              },
              child: Text('Write Feedback'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(110, 50),
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 430.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                    },
                    child: Text('Email Server \nConfiguration'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                      backgroundColor: Colors.indigo.shade100,

                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatGPTConfigPage(),
                        ),
                      );
                    },

                    child: Text('ChatGPT API \nConfiguration'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  /*
  void _configureEmailServer(){

    setState((){
      _isConfigured=true;
    });

  }
  */
}


