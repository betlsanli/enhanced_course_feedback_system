import 'package:enhanced_course_feedback_system/pages/EmailServerConfigPage.dart';
import 'package:enhanced_course_feedback_system/pages/LandingPage.dart';
import 'package:flutter/material.dart';


class ChatGPTConfigPage extends StatefulWidget  {
  final List<String> settings;
  const ChatGPTConfigPage({Key? key, required this.settings}) : super(key: key);

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
          Expanded(
              child: Scrollbar(
                thickness: 7.0,
                controller: ScrollController(),
                child: ListView.builder(
                  itemCount: widget.settings.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 7.0),
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ListTile(
                          title: Text(
                            widget.settings[index],
                            style: TextStyle(
                              //fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward, color: Colors.indigo.shade200),
                          onTap: (){
                            //yaz
                          },
                        ),
                      ),
                    );

                  },
                ),
              )

          ),
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