import 'dart:async';

import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/data/RequestFormUtils.dart';
import 'package:after_layout/after_layout.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> with AfterLayoutMixin<TeacherDashboard>{

  late List<Map<String, dynamic>>? list;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    list = await fetchSummariesList();
  }

  Future<void> refresh()async {
    list = await fetchSummariesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: refresh,
        edgeOffset: 75,

        child: CustomScrollView(
          slivers: <Widget>[

            SliverAppBar(
              expandedHeight: 75.0,
              backgroundColor: Colors.indigo.shade100,
              flexibleSpace: FlexibleSpaceBar(

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
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(

                      title: Center(child: Text('course code and name')),
                      subtitle: Center(child: Text("date")),
                      tileColor: Colors.black12,
                      onTap: (){},
                    ),
                  );
                },
                childCount: 20,
              ),
            ),

          ],


        ),
      ),
    );
  }


}
