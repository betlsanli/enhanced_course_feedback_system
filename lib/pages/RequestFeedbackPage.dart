import 'package:enhanced_course_feedback_system/data/RequestFormUtils.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

import '../constants.dart';

class RequestFeedbackPage extends StatefulWidget {

  const RequestFeedbackPage(this.courseList, {super.key});

  final List<String> courseList;

  @override
  State<RequestFeedbackPage> createState() => _RequestFeedbackPageState();
}

class _RequestFeedbackPageState extends State<RequestFeedbackPage>  with AfterLayoutMixin<RequestFeedbackPage> {

  bool flag = false;
  late String dropdownValue;
  late String courseName;
  DateTime selectedDate = DateTime.now();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final topicController = TextEditingController();

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    dropdownValue = widget.courseList!.first;
    courseName = await fetchCourseName(dropdownValue);
    setState(() {
      flag = true;
    });
  }

  Future<void> requestFeedback() async{

    final isValid = formKey1.currentState!.validate() && formKey2.currentState!.validate();
    if (!isValid) {
      return;
    }
    try{
      await supabase
          .schema('ecfs')
          .from("request_form")
          .insert({'course_code': dropdownValue, 'date' : "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}", 'topic': topicController.text});
      Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
    }catch(error){
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!flag){
      return preloader;
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            expandedHeight: 45,
            title: FittedBox(
              child: Text(
                "Request Feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
                [
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: formKey1,
                    child: Container(
                      padding: EdgeInsets.only(top:20, left:14,right: 14, bottom: 7),
                      child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height:45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.indigo.shade50,
                                ),
                                child: Center(

                                  child: DropdownButtonFormField<String>(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 28,
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black54,
                                    style: TextStyle(
                                      color: Colors.indigo.shade900,
                                      fontSize: 18,
                                    ),
                                    // underline: Container(
                                    //   height: 0,
                                    //   color: Colors.indigo,
                                    // ),
                                    decoration: const InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                    ),
                                    validator: (val){
                                      if(val == null || val == "NONE"){
                                        return "Required";
                                      }
                                      return null;
                                    },
                                    onChanged: (String? value) async {
                                      courseName = await fetchCourseName(value!);
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: widget.courseList?.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(child: Text(value, style: TextStyle(fontSize: 18),)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                            Expanded(
                              child: Container(
                                height:45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.indigo.shade50,
                                ),
                                child: Expanded(

                                    child: Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(
                                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(5.0)),
                                          IconButton(
                                            onPressed: () async {
                                              final DateTime? dateTime = await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(selectedDate.year),
                                                  lastDate: DateTime(3000)
                                              );
                                              if(dateTime != null){
                                                setState(() {
                                                  selectedDate = dateTime;
                                                });
                                              }
                                            },
                                            icon: Icon(Icons.calendar_month)
                                          )
                                      ]
                                      ),
                                    ),
                                ),
                              ),
                            ),
                          ]
                      ),

                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top:7, left:14,right: 14, bottom: 7),
                    child: Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          //border: Border.all(width: 1, color: Colors.indigo.shade900),
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                courseName ,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: formKey2,
                    child: Padding(
                      padding: EdgeInsets.only(top:7, left:14,right: 14, bottom: 7),
                      child: Column(
                        children: [
                          TextFormField(
                            maxLines: 15,
                            controller: topicController,
                            decoration: const InputDecoration(
                                label: Text(
                                  "T O P I C",
                                  textAlign: TextAlign.center,
                                )
                            ),
                            validator: (val){
                              if(val!.isEmpty || val == null){
                                return "Required";
                              }
                              return null;
                            },
                          ),
                          formSpacer,
                          formSpacer,
                          ElevatedButton(
                            onPressed: requestFeedback,
                            child: Text("REQUEST FEEDBACK")
                          )
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
