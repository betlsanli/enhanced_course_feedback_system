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


  Future<RequestForm?> fetchRequestForm() async {
    final response = await supabase
        .schema('ecfs')
        .from('request_form')
        .select()
        .eq('form_id', '48955783-260f-4851-b71e-9955641578f2')
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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: TextFormField(
                //controller: _serverAddressController,
                decoration: InputDecoration(labelText: 'Server Adress'),
              ),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: TextFormField(
                  //controller: _portController,
                  decoration: InputDecoration(labelText: 'Port'),
                  keyboardType: TextInputType.number,
                ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: (){
                    _configureEmailServer();
                  },
                  child: Text('Configure Email Server'),
              ),
            ),
            if(_isConfigured)
              Text('Email Server Configured Successfully',
              style: TextStyle(color: Colors.green),
              ),

            
            //FOR TESTING
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
                minimumSize: Size(200, 60),
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            
            
            SizedBox(height: 300.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 98),
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

  void _configureEmailServer(){
    //yaz

    setState((){
      _isConfigured=true;
    });

  }

}


