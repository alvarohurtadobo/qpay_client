class User {
  String id = '';
  String email = '';
  String name = '';
  String phone = '';
  String avatar = '';
  String balance = '0.00';
  double balanceDouble = 0;

  User(this.id, this.email, this.name, this.phone, this.avatar, this.balance) {
    balanceDouble = double.tryParse(balance) ?? 0;
  }
  User.empty();

  User.fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? "";
    email = data['email'] ?? "";
    name = data['name'] ?? "";
    phone = data['phone'] ?? "";
    avatar = data['avatar'] ?? "";
    balance = data['balance'] ?? "";
    balanceDouble = double.tryParse(balance) ?? 0;
  }

  @override
  String toString() {
    return '[USER:$id] $name $email';
  }
}

User currentUser = User.empty();
