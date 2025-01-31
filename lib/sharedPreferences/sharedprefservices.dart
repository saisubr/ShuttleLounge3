import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static SharedPreferences? prefs;

  static void clearUserFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString('phonenumber', "");
    prefs!.setString('firstname', "");
    prefs!.setString('lastname', "");
    prefs!.setString('rememberme', "");

    prefs!.setBool('islogged', false);
    prefs!.setString('profileimage', '');
    prefs!.setString('email', '');
    prefs!.setString('customerId', '');
    prefs!.setString('roleCode', '');
    prefs!.setString('qualified', '');
    prefs!.setString('documentId', '');
    prefs!.setString('password', '');
  }

  static void saveLogoutUserInfo(
      String userFirstName, String userProfileImage) async {
    prefs = await SharedPreferences.getInstance();

    await prefs!.setString(_keyfirstname, userFirstName);
    await prefs!.setString(_keyprofileimage, userProfileImage);
  }

  static const _keyphonenumber = 'phonenumber';
  static const _keyfirstname = 'firstname';
  static const _keylastname = 'lastname';
  static const _keyprofileimage = 'profileimage';
  static const _keyislogged = 'islogged';
  static const _keyrememberme = 'rememberme';
  static const _keyemail = 'email';
  static const _keycustomerId = 'customerId';
  static const _keyexpertId = 'expertId';
  static const _keyroleCode = 'roleCode';
  static const _keyqualified = 'qualified';
  static const _keydocumentId = 'documentId';
  static const _keypassword = 'password';

  static Future init() async => prefs = await SharedPreferences.getInstance();

  static Future setroleCode(String roleCode) async =>
      await prefs!.setString(_keyroleCode, roleCode);

  static Future setphonenumber(String phonenumber) async =>
      await prefs!.setString(_keyphonenumber, phonenumber);

  static Future setfirstname(String firstname) async =>
      await prefs!.setString(_keyfirstname, firstname);

  static Future setlastname(String lastname) async =>
      await prefs!.setString(_keylastname, lastname);

  static Future setprofileimage(String profileimage) async =>
      await prefs!.setString(_keyprofileimage, profileimage);
  static Future setemail(String email) async =>
      await prefs!.setString(_keyemail, email);
  static Future setcustomerId(String customerId) async =>
      await prefs!.setString(_keycustomerId, customerId);

  static Future setexpertId(String expertId) async =>
      await prefs!.setString(_keyexpertId, expertId);

  static Future setqualified(String qualified) async =>
      await prefs!.setString(_keyqualified, qualified);
  static Future setrememberme(String rememberme) async =>
      await prefs!.setString(_keyrememberme, rememberme);

  static Future setislogged(bool islogged) async =>
      await prefs!.setBool(_keyislogged, islogged);

  static Future setdocumentId(String documentId) async =>
      await prefs!.setString(_keydocumentId, documentId);

  static Future setpassword(String password) async =>
      await prefs!.setString(_keypassword, password);

// getters

  static String? getphonenumber() => prefs!.getString(_keyphonenumber);

  static String? getfirstname() => prefs!.getString(_keyfirstname);

  static String? getlastname() => prefs!.getString(_keylastname);
  static String? getprofileimage() => prefs!.getString(_keyprofileimage);
  static String? getemail() => prefs!.getString(_keyemail);
  static String? getcustomerId() => prefs!.getString(_keycustomerId);
  static String? getrememberme() => prefs!.getString(_keyrememberme);
  static bool? getislogged() => prefs!.getBool(_keyislogged);
  static String? getroleCode() => prefs!.getString(_keyroleCode);
  static String? getqualified() => prefs!.getString(_keyqualified);
  static String? getexpertId() => prefs!.getString(_keyexpertId);
  static String? getdocumentId() => prefs!.getString(_keydocumentId);
  static String? getpassword() => prefs!.getString(_keypassword);
}
