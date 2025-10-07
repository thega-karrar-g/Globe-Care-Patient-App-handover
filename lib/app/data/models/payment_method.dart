
import '../../core/assets_helper/app_images.dart';

class PaymentMethod {
  PaymentMethod(
      {this.id = 0, this.name = '', this.description = '', this.logo = ''});

  int id;
  String name = '', description = '', logo;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };

  static List<PaymentMethod> methods = [
    PaymentMethod(id: 1, name: 'Credit Card', logo: AppImages.payoneer),
    PaymentMethod(
        id: 1,
        name: 'Paypal',
        logo: AppImages.paypal,
        description: AppImages.paypalLogo),
    PaymentMethod(id: 1, name: 'Visa Card', logo: AppImages.visa),
    PaymentMethod(id: 1, name: 'Google Pay', logo: AppImages.google),
    PaymentMethod(id: 1, name: 'Mada', logo: AppImages.mada),
  ];
}
