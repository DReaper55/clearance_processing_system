import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefsDataSource {
  Future<bool> saveString(String key, String value);
  Future<bool> saveBool(String key, bool value);
  Future<bool> saveInt(String key, int value);
  Future<String> getString(String key);
  Future<bool> getBool(String key);
  Future<int> getInt(String key);
  Future<bool> clear();
}

class SharedPrefsDataSourceImpl implements SharedPrefsDataSource {
  final SharedPreferences sharedPreference;

  SharedPrefsDataSourceImpl({required this.sharedPreference});

  @override
  Future<bool> getBool(String key) async {
    try {
    final value = sharedPreference.getBool(key);

    // Return the boolean value if it exists
    if (value != null) {
      return value;
    }

    // Handle the case when the value doesn't exist
    throw Exception('Value not found for key: $key');
  } catch(e){
      // Handle any errors that occur during the retrieval
      throw Exception('Failed to retrieve boolean value');
    }
  }

  @override
  Future<int> getInt(String key) async {
    try {
      final value = sharedPreference.getInt(key);

      // Return the integer value if it exists
      if (value != null) {
        return value;
      }

      // Handle the case when the value doesn't exist
      throw Exception('Value not found for key: $key');
    } catch(e){
      // Handle any errors that occur during the retrieval
      throw Exception('Failed to retrieve integer value');
    }
  }

  @override
  Future<String> getString(String key) async {
    try {
      final value = sharedPreference.getString(key);

      // Return the string value if it exists
      if (value != null) {
        return value;
      }

      // Handle the case when the value doesn't exist
      throw Exception('Value not found for key: $key');
    } catch(e){
      // Handle any errors that occur during the retrieval
      throw Exception('Failed to retrieve string value');
    }
  }

  @override
  Future<bool> saveBool(String key, bool value) async {
    try {
      await sharedPreference.setBool(key, value);
      return true; // Return true to indicate successful saving
    } catch (error) {
      // Handle any errors that occur during the saving process
      throw Exception('Failed to save boolean value');
    }
  }

  @override
  Future<bool> saveInt(String key, int value) async {
    try {
      await sharedPreference.setInt(key, value);
      return true; // Return true to indicate successful saving
    } catch (error) {
      // Handle any errors that occur during the saving process
      throw Exception('Failed to save boolean value');
    }
  }

  @override
  Future<bool> saveString(String key, String value) async {
    try {
      await sharedPreference.setString(key, value);
      return true; // Return true to indicate successful saving
    } catch (error) {
      // Handle any errors that occur during the saving process
      throw Exception('Failed to save boolean value');
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await sharedPreference.clear();
      return true; // Return true to indicate successful clear
    } catch (error) {
      // Handle any errors that occur during the deletion process
      throw Exception('Failed to save boolean value');
    }
  }
}
