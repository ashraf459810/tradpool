import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';


import '../../data/model/user_preferences_model.dart';

abstract class FetchUserpreferencesRepository {
  Future<Either<Failure,List<UserPreferencesModel>>> fetchUserPreferences(String userId);
}


