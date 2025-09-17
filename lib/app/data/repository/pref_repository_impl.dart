
import 'dart:convert';

import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/pref_repository.dart';
import '../local/preference/preference_manager.dart';

class PrefRepositoryImpl implements PrefRepository{
  final PreferenceManager _prefSource =
  Get.find(tag: (PreferenceManager).toString());
  @override
  Future<bool> clear() {
   return _prefSource.clear();
    throw UnimplementedError();
  }

  @override
  Future<bool> getBool(String key, {bool defaultValue = false}) {
   return _prefSource.getBool(key,defaultValue: false);
    throw UnimplementedError();
  }

  @override
  Future<double> getDouble(String key, {double defaultValue = 0.0}) {
    // TODO: implement getDouble
    throw UnimplementedError();
  }

  @override
  Future<int> getInt(String key, {int defaultValue = 0}) {
    return _prefSource.getInt(key, defaultValue: defaultValue);
    throw UnimplementedError();
  }

  @override
  Future<String> getString(String key, {String defaultValue = ""}) {
    return _prefSource.getString(key,defaultValue:"");
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getStringList(String key, {List<String> defaultValue = const []}) {
    // TODO: implement getStringList
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
   return _prefSource.remove(key);
    throw UnimplementedError();
  }


  @override
  Future<void> setOnboardingShown() async {
    await _prefSource.setBool('onboarding_shown', true);
  }

  @override
  Future<bool> isOnboardingShown() async {
    return await _prefSource.getBool('onboarding_shown', defaultValue: false);
  }

  Future<void> saveDraft(int assessmentId, Map<int, dynamic> answers, int currentIndex) async {
    final draftData = {
      "answers": answers,
      "currentIndex": currentIndex,
    };
    await _prefSource.setString("draft_$assessmentId", jsonEncode(draftData));
  }

  Future<Map<String, dynamic>?> getDraft(int assessmentId) async {
    final jsonString = _prefSource.getString("draft_$assessmentId");
    if (jsonString == null) return null;
    return jsonDecode(await jsonString);
  }

  Future<void> removeDraft(int assessmentId) async {
    await _prefSource.remove("draft_$assessmentId");
  }


  // New method
  Future<Set<String>> getKeys() => _prefSource.getKeys();

  @override
  Future<bool> setBool(String key, bool value) {
    // TODO: implement setBool
    throw UnimplementedError();
  }

  @override
  Future<bool> setDouble(String key, double value) {
    // TODO: implement setDouble
    throw UnimplementedError();
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _prefSource.setInt(key, value);
    throw UnimplementedError();
  }

  @override
  Future<bool> setString(String key, String value) {
return _prefSource.setString(key,value);
    throw UnimplementedError();
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    // TODO: implement setStringList
    throw UnimplementedError();
  }


}


