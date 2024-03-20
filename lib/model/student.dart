abstract class Staff {
  String _manv;
  String _ten;
  double _luongCB;

  Staff(this._manv, this._ten, this._luongCB);

  String get manv => _manv;
  set manv(String value) => _manv = value;

  String get ten => _ten;
  set ten(String value) => _ten = value;

  double get luongCB => _luongCB;
  set luongCB(double value) => _luongCB = value;

  double tinhLuong();
}

// Define the OfficeStaff class extending Staff
class OfficeStaff extends Staff {
  double _tienTC = 0;

  OfficeStaff(String manv, String ten, double luongCB)
      : super(manv, ten, luongCB);

  double get tienTC => _tienTC;
  set tienTC(double value) => _tienTC = value;

  @override
  double tinhLuong() {
    return luongCB + tienTC;
  }
}

// Define the AccountingStaff class extending Staff
class AccountingStaff extends Staff {
  double _hesoLuong = 1.0;

  AccountingStaff(String manv, String ten, double luongCB)
      : super(manv, ten, luongCB);

  double get hesoLuong => _hesoLuong;
  set hesoLuong(double value) => _hesoLuong = value;

  @override
  double tinhLuong() {
    return luongCB * hesoLuong;
  }
}
