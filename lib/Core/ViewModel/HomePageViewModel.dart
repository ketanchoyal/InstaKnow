import 'package:instaknown/Core/Services/Api.dart';
import 'package:instaknown/Core/ViewModel/BaseModel.dart';
import 'package:instaknown/Core/models/Result.dart';
import 'package:instaknown/locator.dart';

class HomePageViewModel extends BaseModel {
  Api _api = locator<Api>();

  Future<Result> getSentimentsPublic({String user}) async {
    setState(ViewState.Busy);
    var result = await _api.getSentimentsPublic(user);
    setState(ViewState.Idle);
    return result;
  }

  Future<Result> getSentimentsPrivate(
      {String username, String password, String user}) async {
    setState(ViewState.Busy);
    var result = await _api.getSentimentsPrivate(username, password, user);
    setState(ViewState.Idle);
    return result;
  }
}
