import '../data/Profile.dart';
import 'package:enhanced_course_feedback_system/constants.dart';

Future<Profile?> fetchCurrentUser() async {
// Get current user session
  final currentSession = supabase.auth.currentUser;

  if (currentSession != null) {
    // Fetch data for the current user
    //final userId = currentSession.id;
    final info = await supabase
        .schema('ecfs')
        .from('user')
        .select()
    //.eq('user_id', userId) // not necessary bc of RLS
        .limit(1);
    return Profile.fromMap(info.first);
  }
  return null;
}

Future<List<String>> fetchCourseList() async {
  Profile? currentUser = await fetchCurrentUser();

  if(currentUser == null){
    return [];
  }
  final courseList = <String>[];

  final response = await supabase
                          .schema('ecfs')
                          .from('course')
                          .select()
                          .eq('teacher_id', currentUser.user_id);
  for(final courseData in response){
    courseList.add(courseData['course_code']);
  }
  return courseList;
}