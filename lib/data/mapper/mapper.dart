import 'package:tut_app/data/responses/response.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
        id: this?.id?.orZero() ?? 0,
        name: this?.name?.orEmpty() ?? "",
        numOfNofication: this?.numOfNotification.orZero() ?? 0);
  }
}

extension ContactResponseMapper on ContactResponse? {
  ContactModel toDomain() {
    return ContactModel(
        email: this?.email?.orEmpty() ?? "",
        phone: this?.phone?.orEmpty() ?? "",
        link: this?.link?.orEmpty());
  }
}

extension AuthenticationMapper on AuthenticationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
        customerModel: this?.customerResponse?.toDomain(),
        contactModel: this?.contactResponse?.toDomain());
  }
}
