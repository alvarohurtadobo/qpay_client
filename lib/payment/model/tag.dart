class Tag {
  String id;
  DateTime dateAdd;
  String tagId;
  String code;
  bool disabled;
  String state;
  String balance;
  double balanceDouble;
  List<dynamic> trxApps;

  Tag(
      {required this.id,
      required this.dateAdd,
      required this.tagId,
      required this.code,
      required this.disabled,
      required this.state,
      required this.balance,
      required this.trxApps})
      : balanceDouble = double.tryParse(balance) ?? 0;

  Tag.empty()
      : id = '',
        dateAdd = DateTime.now(),
        tagId = '',
        code = '',
        disabled = false,
        state = '',
        balance = '0.00',
        balanceDouble = 0,
        trxApps = [];

  Tag.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? '',
        dateAdd = DateTime.parse(data['dateAdd'] ?? DateTime.now().toIso8601String()),
        tagId = data['tagId'] ?? '',
        code = data['code'] ?? '',
        disabled = data['disabled'] ?? false,
        state = data['state'] ?? '',
        balance = data['balance'] ?? '0.00',
        balanceDouble = double.tryParse(data['balance']) ?? 0,
        trxApps = data['trxApps'] ?? [];

  @override
  String toString() {
    return '[TAG:$id] $code $state';
  }
}

List<Tag> myTags = [];