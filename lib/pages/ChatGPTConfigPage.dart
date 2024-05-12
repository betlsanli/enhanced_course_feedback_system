import 'package:enhanced_course_feedback_system/pages/EmailServerConfigPage.dart';
import 'package:enhanced_course_feedback_system/pages/LandingPage.dart';
import 'package:flutter/material.dart';


class ChatGPTConfigPage extends StatefulWidget  {
  const ChatGPTConfigPage({Key? key}) : super(key: key);

  @override
  _ChatGPTConfigPageState createState() => _ChatGPTConfigPageState();

}

class _ChatGPTConfigPageState extends State<ChatGPTConfigPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure ChatGPT API'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
            child: ElevatedButton(
              onPressed: (){
                //yaz
              },
              child: Text('Save Configuration'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200,60),
              ),

            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailServerConfigPage(),
                          ),
                      );
                    },
                    child: Text('Email Server \nConfiguration'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60),
                  backgroundColor: Colors.grey.shade100,

                ),
                ),
                ElevatedButton(
                    onPressed: (){
                  },
                    child: Text('ChatGPT API \nConfiguration'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60),
                    backgroundColor: Colors.indigo.shade100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
