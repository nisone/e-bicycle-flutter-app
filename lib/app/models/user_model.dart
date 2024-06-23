import 'package:bike_rental/app/models/notification_model.dart';
import 'package:bike_rental/app/models/rental_model.dart';
import 'package:bike_rental/app/models/wallet_model.dart';
import 'package:bike_rental/global.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.admissionNumber,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.nin,
    required this.photoUrl,
    required this.documentUrl,
    required this.documentType,
    required this.wallet,
    required this.rentals,
    required this.notifications,
  });

  final int id;
  final String admissionNumber;
  final String name;
  final String email;
  final String phoneNumber;
  final String nin;
  final String photoUrl;
  final String documentUrl;
  final String documentType;
  WalletModel wallet;
  List<RentalModel> rentals;
  List<NotificationModel> notifications;

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      admissionNumber: data['admission_number'],
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phone_number'],
      nin: data['nin'],
      photoUrl: Global.baseUrl + data['photo_url'],
      documentUrl: Global.baseUrl + data['document_url'],
      documentType: data['document_type'],
      wallet: WalletModel.fromMap(data['wallet']),
      rentals: (data['rentals'] as List)
          .map((rental) => RentalModel.fromMap(rental))
          .toList(),
      notifications: (data['notifications'] as List)
          .map((notification) => NotificationModel.fromMap(notification))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admission_number': admissionNumber,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'nin': nin,
      'photo_url': photoUrl,
      'document_url': documentUrl,
      'document_type': documentType,
      'wallet': wallet,
      'rentals': rentals.map((rent) => rent.toJson()),
      'notifications': notifications
    };
  }
}

final me = {'data': user};

final UserModel user = UserModel.fromMap({
  'admission_number': 'p23pscs8001',
  'name': 'Nuhu',
  'email': 'nuhu94@gmail.com',
  'phone_number': '08029429723',
  'nin': '01234567890',
  'photo_url':
      'http://192.168.0.131:9199/v0/b/safara-e-bike.appspot.com/o/profileImages%2F1718037994790.png?alt=media&token=a8e1d726-0ab5-422f-a818-3f93b7a23eb8',
  'document_url':
      'http://192.168.0.131:9199/v0/b/safara-e-bike.appspot.com/o/documentImages%2F1718037994790.png?alt=media&token=2182799e-098f-4315-9c66-fc9d7c4b4c2e',
  'document_type': 'id_card',
  'wallet': wallet,
  'rentals': [],
  'notifications': []
});

final wallet = {
  'address': 'acbb7680addd4b30a38f6638fe2f1a23',
  'balance': 5000,
  'transactions': [],
  'links': {},
  'meta': meta,
};

final meta = {
  'current_page': 1,
  'total_pages': 1,
  'per_page': 10,
  'total': 0,
  'sort_by': 'created_at',
  'sort_dir': 'desc'
};

final dataModel = {
  'wallet': {
    'address': '32c1ca6b4c4a401393ff2fa67e73db71',
    'balance': 15300,
    'transactions': [
      {
        'transaction_id': 497,
        'transaction_wallet_id': 8,
        'transaction_reference': 'OZsS9tD013ZiYplj',
        'transaction_amount': 176,
        'transaction_narration': ' Ride payment',
        'transaction_channel': 'wallet',
        'transaction_type': 'debit',
        'transaction_is_successful': false,
        'transaction_status': 'success',
        'transaction_created_at': '2024-06-09T17:31:41.000000Z',
        'transaction_updated_at': '1 day ago'
      },
    ],
  },
  'renals': [
    {
      'rental_user_id': 1,
      'rental_bike_id': 14,
      'rental_started': null,
      'rental_ended': '2024-06-09 17:31:14',
      'rental_pickup_station': 8,
      'rental_returned_station': 3,
      'rental_paid_amount': 176,
      'rental_is_paid': 0
    }
  ],
  'access_token':
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4wLjEzMTo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzE4MDQ0MDcwLCJleHAiOjE3MTgwNDc2NzAsIm5iZiI6MTcxODA0NDA3MCwianRpIjoiQk5jME1rQ0hjbW14VEp5UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.rL8bGl1M_Fq2C3IA4Qz_h6nn8OZzKt1aRgnjz22Uz8Y',
  'token_type': 'bearer'
};
