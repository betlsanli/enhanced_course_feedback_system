
import 'package:enhanced_course_feedback_system/constants.dart';

import 'RequestForm.dart';

Future<List<RequestForm>>fetchSummariesList() async {
// Get current user session
  final requestFormList = <RequestForm>[];;

  if (supabase.auth.currentUser != null) {
    // Fetch data
    
    final response = await supabase
        .schema('ecfs')
        .from('request_form')
        .select('*')
        .not('feedback_summary', 'is' ,null)
    ;

    if (response.isEmpty) {
      return [];
    }
    for(final formData in response){
      final courseData = await supabase
          .schema('ecfs')
          .from('course')
          .select('name')
          .eq('course_code', formData['course_code']);
      String courseName = courseData.first['name'];
      requestFormList.add(RequestForm.fromMap(formData, courseName));
    }
    return requestFormList;
  }
  return [];
}