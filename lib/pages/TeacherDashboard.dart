import 'dart:async';

import 'package:enhanced_course_feedback_system/data/UserUtils.dart';
import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/data/RequestFormUtils.dart';
import 'package:after_layout/after_layout.dart';

import '../constants.dart';
import '../data/RequestForm.dart';
import 'FeedbackSummaryPage.dart';
import 'RequestFeedbackPage.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> with AfterLayoutMixin<TeacherDashboard>{

  late List<RequestForm>? summaryList;
  late List<String>? courseList;
  bool flag = false;
  late String dropdownValue;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    summaryList = await fetchSummariesList();
    courseList = await fetchCourseList();
    courseList?.insert(0, "ALL");
    dropdownValue = courseList!.first;
    setState(() {
      flag = true;
    });
  }

  Future<void> refresh()async {
    summaryList = await fetchSummariesList();
    courseList = await fetchCourseList();
    courseList?.insert(0, "ALL");
    setState((){
      dropdownValue = courseList!.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(flag){
      
      return Scaffold(

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo.shade200,
          focusColor: Colors.indigo.shade300,
          onPressed: () {
            if(courseList!.isNotEmpty || courseList != null){
              var selectCourseList = courseList!.toList();
              selectCourseList.remove("ALL");
              selectCourseList.insert(0, "NONE");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestFeedbackPage(selectCourseList),
                ),
              );
            }
          },
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          edgeOffset: 75,

          child: CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                expandedHeight: 70.0,
                backgroundColor: Colors.indigo.shade100,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        padding: EdgeInsets.only(right: 40),
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 24,
                        iconEnabledColor: Colors.black54,
                        style: TextStyle(
                          color: Colors.indigo.shade900,
                          fontSize: 15,
                        ),
                        underline: Container(
                          height: 3,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? value) async {
                          summaryList = await fetchSummariesList();
                          if(value != "ALL"){
                            summaryList = summaryList?.where((form) => form.code == value).toList();
                          }
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: courseList?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      Text(
                        "Sort by Date:",
                        style: TextStyle(
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        iconSize: 24,
                        color: Colors.black54,
                        onPressed: (){
                          setState(() {
                            summaryList?.sort((a, b) => a.date.compareTo(b.date));
                          });
                        },
                        icon: const Icon(Icons.arrow_upward_rounded),
                      ),
                      IconButton(
                        iconSize: 24,
                        color: Colors.black54,
                        onPressed: (){
                          setState(() {
                            summaryList?.sort((a, b) => b.date.compareTo(a.date));
                          });
                        },
                        icon: const Icon(Icons.arrow_downward_rounded),
                      ),

                    ],
                  ),
                ),
              ),

              // SliverPadding(
              //   padding: EdgeInsets.all(8.0),
              // ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                    return Container(
                      //color: index.isOdd ? Colors.white : Colors.black12,
                      padding: formPadding,
                      child: ListTile(

                        title: Center(
                            child: Text("${summaryList?[index].code} - ${summaryList?[index].name}",)
                        ),
                        subtitle: Center(
                            child: Text(summaryList![index].date)
                        ),
                        tileColor: Colors.black12,
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackSummaryPage(feedbackSummary: summaryList![index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: summaryList?.length,
                ),
              ),

            ],
          ),
        ),
      );
    }
    else{
      return const Scaffold(
        body: preloader,
      );
    }
  }


}
