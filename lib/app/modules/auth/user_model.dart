class AuthData {
  User? user;
  String? accessToken;
  String? tokenType;

  AuthData({this.user, this.accessToken, this.tokenType});

  AuthData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    return data;
  }
}

class User {
  String? admissionNumber;
  String? name;
  String? email;
  dynamic phoneNumber;
  String? nin;
  String? photoUrl;
  Wallet? wallet;
  List<Rental>? rentals;

  User(
      {this.admissionNumber,
      this.name,
      this.email,
      this.phoneNumber,
      this.nin,
      this.photoUrl,
      this.wallet,
      this.rentals});

  User.fromJson(Map<String, dynamic> json) {
    admissionNumber = json['admission_number'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nin = json['nin'];
    photoUrl = json['photo_url'];
    wallet = json['wallet'] != null ? Wallet?.fromJson(json['wallet']) : null;
    if (json['rentals'] != null) {
      rentals = <Rental>[];
      json['rentals'].forEach((v) {
        rentals?.add(Rental.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['admission_number'] = admissionNumber;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['nin'] = nin;
    data['photo_url'] = photoUrl;
    if (wallet != null) {
      data['wallet'] = wallet?.toJson();
    }
    if (rentals != null) {
      data['rentals'] = rentals?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallet {
  String? address;
  int? balance;
  List<Transaction>? transactions;

  Wallet({this.address, this.balance, this.transactions});

  Wallet.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    balance = json['balance'];
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions?.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['balance'] = balance;
    if (transactions != null) {
      data['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rental {
  Rental();
  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental();
  }
  Map<String, dynamic> toJson() {
    return {};
  }
}

class Transaction {
  Transaction();
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction();
  }
  Map<String, dynamic> toJson() {
    return {};
  }
}
