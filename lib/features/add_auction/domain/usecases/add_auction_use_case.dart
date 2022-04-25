import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/usecases/usecase.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

class AddAuctionUseCase implements UseCase<String, AuctionBody> {
  final AddItemRepository addItemRepository;

  AddAuctionUseCase(this.addItemRepository);
  @override
  Future<Either<Failure, String>> call(AuctionBody params) async {
    return await addItemRepository.addAuction(params);
  }
}
