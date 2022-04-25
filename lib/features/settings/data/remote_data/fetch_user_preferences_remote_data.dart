import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';
import 'package:tradpool/features/settings/data/model/user_preferences_model.dart';

abstract class FetchUserPreferencesRemoeData {
  Future<dynamic> fetchUserPreferences (String userId);
}


class FetchUserPreferencesRemoteDataImp implements FetchUserPreferencesRemoeData{
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  FetchUserPreferencesRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future fetchUserPreferences(String userId) async {
    var response= await networkFunctions.getMethod(baseurl: networkInf.baseUrl,url: "/tradepool/client/get-preferences?client=$userId");
    return userPreferencesModelFromJson(response);
  }
  
}