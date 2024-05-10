import 'dart:async';

import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/constants.dart';
import 'package:after_layout/after_layout.dart';

import '../data/Profile.dart';
import '../data/UserUtils.dart';
import 'package:enhanced_course_feedback_system/pages/AdminDashboard.dart';
import 'package:enhanced_course_feedback_system/pages/TeacherDashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with AfterLayoutMixin<LandingPage> {

  late Future<Profile?> futureProfile;
  late Profile currentUser;
  late StatefulWidget userDashboard;
  bool flag = false;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    futureProfile =  fetchCurrentUser();
    currentUser = (await futureProfile)!;
    if(currentUser.role == 'admin'){
      userDashboard = AdminDashboard();
    }else if(currentUser.role == 'teacher'){
      userDashboard = TeacherDashboard();
    }
    setState(() {
      flag = true;
    });
  }

//   Future<void> fetchCurrentUser() async {
// // Get current user session
//     final currentSession = supabase.auth.currentUser;
//
//     if (currentSession != null) {
//       // Fetch data for the current user
//       final userId = currentSession.id;
//       final info = await supabase
//           .schema('ecfs')
//           .from('user')
//           .select()
//           //.eq('user_id', userId) // not necessary bc of RLS
//           .limit(1);
//       currentUser = Profile.fromMap(info.first);
//     }
//     setState(() {
//       flag = true;
//     });
//   }

    Future<void> signOut() async {
      try {
        await supabase.auth.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/login", (route) => false);
      } catch (error) {
        context.showErrorSnackBar(message: unexpectedErrorMessage);
      }
    }

    @override
    Widget build(BuildContext context) {
      if(flag){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 45,
            title: Row(
              children: [
                Text(currentUser.name),
                const SizedBox(width: 10,height: 0),
                Text(
                  "|${currentUser.role}",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: signOut,
                  icon: const Icon(Icons.logout)
              ),
            ],
          ),
          body: userDashboard,
        );
      }else{
        return const Scaffold(
          body: preloader,
        );
      }
  }
}


