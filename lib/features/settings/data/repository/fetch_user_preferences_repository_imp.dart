import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/settings/data/remote_data/fetch_user_preferences_remote_data.dart';
import 'package:tradpool/features/settings/data/model/user_preferences_model.dart';
import 'package:tradpool/features/settings/domain/repository/fetch_user_preferences_repository.dart';

class FetchUserPreferencesRepositoryImp implements FetchUserpreferencesRepository {
  final NetworkInf networkInf;
  final FetchUserPreferencesRemoeData fetchUserPreferencesRemoeData;

  FetchUserPreferencesRepositoryImp(this.networkInf, this.fetchUserPreferencesRemoeData);

  @override
  Future<Either<Failure, List<UserPreferencesModel>>> fetchUserPreferences(String userId) async {

           if (await networkInf.isConnected) {
      try {
        final response = await fetchUserPreferencesRemoeData.fetchUserPreferences(userId, );


        // ignore: void_checks
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
    
  }
}