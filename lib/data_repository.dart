import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String loginName = '';
  static String password = '';
  static String firstName = '';
  static String lastName = '';
  static String phoneNumber = '';
  static String email = '';

  static Future<void> saveData(String key, String value) async {
    final encryptedPrefs = EncryptedSharedPreferences();
    await encryptedPrefs.setString(key, value);
  }

  static Future<String> getData(String key) {
    final encryptedPrefs = EncryptedSharedPreferences();
    return encryptedPrefs.getString(key);
  }

  static Future<void> removeData(String key) async {
    final encryptedPrefs = EncryptedSharedPreferences();
    if (await DataRepository.getData(key) != '') {
      encryptedPrefs.remove(key);
    }
  }

  static Future<void> saveProfileData(
    String firstName,
    String lastName,
    String phoneNumber,
    String email,
  ) async {
    await DataRepository.saveData('firstName', firstName);
    await DataRepository.saveData('lastName', lastName);
    await DataRepository.saveData('phoneNumber', phoneNumber);
    await DataRepository.saveData('email', email);
  }

  static Future<void> loadProfileData() async {
    DataRepository.firstName = await DataRepository.getData('firstName');
    DataRepository.lastName = await DataRepository.getData('lastName');
    DataRepository.phoneNumber = await DataRepository.getData('phoneNumber');
    DataRepository.email = await DataRepository.getData('email');
  }
}
