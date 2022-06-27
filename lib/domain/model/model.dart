class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class CustomerModel {
  final int? id;
  final String? name;
  final int? numOfNofication;

  const CustomerModel({
    this.id,
    this.name,
    this.numOfNofication,
  });
}

class ContactModel {
  final String? email;
  final String? phone;
  final String? link;

  ContactModel({
    this.email,
    this.phone,
    this.link,
  });
}

class AuthenticationModel {
  final CustomerModel? customerModel;
  final ContactModel? contactModel;
  AuthenticationModel({
    required this.customerModel,
    required this.contactModel,
  });
}

class DeviceInfo {
  final String name;
  final String id;
  final String version;
  DeviceInfo({
    required this.name,
    required this.id,
    required this.version,
  });
}
