// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  int? status;
  String? message;
}

@JsonSerializable()
class CustomerResponce {
  int? id;
  String? name;
  int? numOfNotification;
}

@JsonSerializable()
class ContactResponce {
  String? email;
  String? phone;
  String? link;
}

@JsonSerializable()
class AuthenticationResponce {
  CustomerResponce? customerResponce;
  ContactResponce? contactResponce;
}
