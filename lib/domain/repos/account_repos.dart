import '../../presentation/res/mess_data.dart';
import '../../source/network/apisubdomain.dart';
import '../../source/network/restclient.dart';
import '../entity/login_model.dart';
import '../entity/sign_up_model.dart';

class AccountRespos with RestClient {
  Future<SignUpModel> signUp(String email, String password) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "firstName": "Tester",
        "lastName": "Mr"
      };
      final result = await postAsync(
        API.signUp,
        body: body,
      );
      // Account registed return 403 error
      if (result.message == MessData.errorInternet) {
        return SignUpModel();
      } else {
        SignUpModel signUpModel = SignUpModel.fromJson(result.body);
        return signUpModel;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> login(String email, String password) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
      };
      final result = await postAsync(
        API.signin,
        body: body,
      );
      LoginModel loginModel = LoginModel.fromJson(result.body);
      return loginModel;
    } catch (e) {
      rethrow;
    }
  }
}
