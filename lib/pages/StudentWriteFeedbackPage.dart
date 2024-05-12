import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import '../constants.dart';
import '../data/RequestForm.dart';

class StudentWriteFeedbackPage extends StatefulWidget{
  final RequestForm requestForm;

  const StudentWriteFeedbackPage({Key? key, required this.requestForm}): super(key: key);

  @override
  _StudentWriteFeedbackPageState createState() => _StudentWriteFeedbackPageState();

}

class _StudentWriteFeedbackPageState extends State<StudentWriteFeedbackPage>{
  final TextEditingController feedbackController = TextEditingController();
  //double _textFieldHeight = 100.0; //for resizing


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Feedback'),
        backgroundColor: Colors.indigo.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(  //gives an overflow error without this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16.0),
                width: 400.0,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8.0),

                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Course Code: ${widget.requestForm.code}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Course Name: ${widget.requestForm.name}',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Topic: ${widget.requestForm.topic}'),
                    SizedBox(height: 20),

                    //Text('Teacher: ${widget.requestForm.teacherName}'),
                    //SizedBox(height: 8),

                    Text('Date: ${widget.requestForm.date}'),
                  ],
                ),
              ),

              SizedBox(height: 70),

              Text(
                'Share your feedback:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),


              TextField(
                controller: feedbackController,
                minLines: 5,
                maxLines: 10, //buna bak
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here.',
                  border: OutlineInputBorder(),
                ),
              ),


            /*
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Update the height of the text field based on drag gesture
                  setState(() {
                    _textFieldHeight += details.primaryDelta!;
                  });
                },
                child: AnimatedContainer(
                  height: _textFieldHeight,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: feedbackController,
                    maxLines: null, // Allow unlimited lines
                    decoration: InputDecoration(
                      hintText: 'Enter your feedback here.',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

*/

              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (){
                    submitFeedback();
                  },
                  //final feedbackText= feedbackController.text;

                  child: Text('Submit'),
                ),
              ),
            ],
          ),

        ),

      ),
    );
  }

  Future<void> submitFeedback() async {
    final feedbackText = feedbackController.text;
    final courseCode = widget.requestForm.code;

    if (feedbackText.trim().isEmpty) {
      _showErrorSnackBar('Feedback field cannot be empty.');
      return;
    }

    final response = await supabase
        .from('feedback')
        .upsert({'course_code': courseCode, 'feedback_text': feedbackText});

    if (response.error == null) {

      Navigator.pop(context); // Close the feedback page, successful
    } else {
      _showErrorSnackBar('Error submitting feedback');
    }
  }

  void _showErrorSnackBar(String message) {
    context.showErrorSnackBar(message: message);
  }


}

