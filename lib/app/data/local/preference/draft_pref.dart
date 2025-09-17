import 'dart:convert';

import 'package:neuro_check_pro/app/data/local/preference/preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DraftPrefRepository {
  final SharedPreferences _prefs;
  DraftPrefRepository(this._prefs);

  Future<void> saveDraft(int assessmentId, Map<int, dynamic> answers, int currentIndex) async {
    final draftData = {
      "answers": answers,
      "currentIndex": currentIndex,
    };
    await _prefs.setString("draft_$assessmentId", jsonEncode(draftData));
  }

  Map<String, dynamic>? getDraft(int assessmentId) {
    final jsonString = _prefs.getString("draft_$assessmentId");
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  Future<void> removeDraft(int assessmentId) async {
    await _prefs.remove("draft_$assessmentId");
  }

  List<int> getAllDraftIds() {
    return _prefs.getKeys()
        .where((key) => key.startsWith("draft_"))
        .map((key) => int.parse(key.split("_")[1]))
        .toList();
  }
}
