import '../data/Profile.dart';
import 'package:enhanced_course_feedback_system/constants.dart';

Future< List<Map<String, dynamic>>? > fetchSummariesList() async {
// Get current user session
  final summaryList;

  if (supabase.auth.currentUser != null) {
    // Fetch data
    
    summaryList = await supabase
        .schema('ecfs')
        .from('request_form')
        .select('*')
        .not('feedback_summary', 'is' ,null)
    ;
    return summaryList;
  }
  return null;
}