import 'package:flutter/material.dart';

@immutable
abstract class FetchDataEvent {
  const FetchDataEvent();
}

class GetUserListEvent extends FetchDataEvent {
  const GetUserListEvent();
}

class SearchUserListEvent extends FetchDataEvent {
  const SearchUserListEvent();
}
