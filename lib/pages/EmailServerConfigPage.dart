import 'package:enhanced_course_feedback_system/data/RequestForm.dart';
import 'package:enhanced_course_feedback_system/pages/ChatGPTConfigPage.dart';
import 'package:enhanced_course_feedback_system/pages/StudentWriteFeedbackPage.dart';
import 'package:flutter/material.dart';

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


  //BURAYA BAK

  /*
  Future<RequestForm?> fetchRequestForm() async {
    try {
      final response=await http.get(
      Uri.parse('https://nzhnrpjexclcxkoyczob.supabase.co/request_form'));

      headers: {
        ' ', //API-KEY ekle??

        //public and anon
        // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56aG5ycGpleGNsY3hrb3ljem9iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3MDQwODMsImV4cCI6MjAyOTI4MDA4M30.nIpNVrDuIAcYo5ixk_G3_VmzlDplvv7VbM5Q268QsNY
      },



      if (response.statusCode == 200) {
        final jsonData=json.decode(response.body);
        return RequestForm.fromJson(jsonData);

      } else {
        throw Exception('Failed to load request form');
      }

    } catch (e) {
      print('Error fetching request form: $e');
      return null;
    }
  }
  */

  Future<RequestForm?> fetchRequestForm() async {
    //FOR TESTING
    return RequestForm(
      code: 'SENG384',
      name: 'Project IV',
      topic: 'testttt',
      date: '12/05/2024',
      summary: '',
    );
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
                          builder: (context) => ChatGPTConfigPage(settings: ['Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3','Setting 1', 'Setting 2', 'Setting 3'],),
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


