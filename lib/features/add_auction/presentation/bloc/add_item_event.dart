part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class GetMainCategoriesEvent extends AddItemEvent {}

class GetSubCategoriesEvent extends AddItemEvent {
  final String parent;

  const GetSubCategoriesEvent(this.parent);
}

class GetBrandsForSubCategoriesEvent extends AddItemEvent {
  final String parent;

  const GetBrandsForSubCategoriesEvent(this.parent);
}

class AddAuctionEvent extends AddItemEvent {
  final AuctionBody auctionBody;

  const AddAuctionEvent(this.auctionBody);
}

class UploadFileEvent extends AddItemEvent {
  final String name;
  final List<XFile> image;

  const UploadFileEvent(this.name, this.image);
}


class GetTagsEvent extends AddItemEvent{
  final String categoryId;

  const GetTagsEvent(this.categoryId);
}

