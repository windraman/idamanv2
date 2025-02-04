class TransaksiModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  TransaksiModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    apiAuthorization = json['api_authorization'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    data['api_authorization'] = this.apiAuthorization;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Null handlerId;
  String? id;
  String? jarak;
  Null keranjangId;
  Null kurirId;
  String? listItemJson;
  String? metodePembayaranId;
  String? ongkir;
  String? pembeliId;
  String? pembeliLat;
  String? pembeliLon;
  Null penjualId;
  String? penjualLat;
  String? penjualLon;
  Null status;
  String? statusTransaksi;
  String? totalHarga;
  String? totalItem;
  String? voucherId;
  List<Keranjang>? keranjang;
  int? keranjangCount;

  Data(
      {this.handlerId,
        this.id,
        this.jarak,
        this.keranjangId,
        this.kurirId,
        this.listItemJson,
        this.metodePembayaranId,
        this.ongkir,
        this.pembeliId,
        this.pembeliLat,
        this.pembeliLon,
        this.penjualId,
        this.penjualLat,
        this.penjualLon,
        this.status,
        this.statusTransaksi,
        this.totalHarga,
        this.totalItem,
        this.voucherId,
        this.keranjang,
        this.keranjangCount});

  Data.fromJson(Map<String, dynamic> json) {
    handlerId = json['handler_id'];
    id = json['id'];
    jarak = json['jarak'];
    keranjangId = json['keranjang_id'];
    kurirId = json['kurir_id'];
    listItemJson = json['list_item_json'];
    metodePembayaranId = json['metode_pembayaran_id'];
    ongkir = json['ongkir'];
    pembeliId = json['pembeli_id'];
    pembeliLat = json['pembeli_lat'];
    pembeliLon = json['pembeli_lon'];
    penjualId = json['penjual_id'];
    penjualLat = json['penjual_lat'];
    penjualLon = json['penjual_lon'];
    status = json['status'];
    statusTransaksi = json['status_transaksi'];
    totalHarga = json['total_harga'];
    totalItem = json['total_item'];
    voucherId = json['voucher_id'];
    if (json['keranjang'] != null) {
      keranjang = <Keranjang>[];
      json['keranjang'].forEach((v) {
        keranjang!.add(new Keranjang.fromJson(v));
      });
    }
    keranjangCount = json['keranjang_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handler_id'] = this.handlerId;
    data['id'] = this.id;
    data['jarak'] = this.jarak;
    data['keranjang_id'] = this.keranjangId;
    data['kurir_id'] = this.kurirId;
    data['list_item_json'] = this.listItemJson;
    data['metode_pembayaran_id'] = this.metodePembayaranId;
    data['ongkir'] = this.ongkir;
    data['pembeli_id'] = this.pembeliId;
    data['pembeli_lat'] = this.pembeliLat;
    data['pembeli_lon'] = this.pembeliLon;
    data['penjual_id'] = this.penjualId;
    data['penjual_lat'] = this.penjualLat;
    data['penjual_lon'] = this.penjualLon;
    data['status'] = this.status;
    data['status_transaksi'] = this.statusTransaksi;
    data['total_harga'] = this.totalHarga;
    data['total_item'] = this.totalItem;
    data['voucher_id'] = this.voucherId;
    if (this.keranjang != null) {
      data['keranjang'] = this.keranjang!.map((v) => v.toJson()).toList();
    }
    data['keranjang_count'] = this.keranjangCount;
    return data;
  }
}

class Keranjang {
  String? id;
  String? cmsUsersId;
  String? produkId;
  String? qty;
  String? catatan;
  String? status;
  String? transaksiId;
  String? createdAt;
  String? updatedAt;

  Keranjang(
      {this.id,
        this.cmsUsersId,
        this.produkId,
        this.qty,
        this.catatan,
        this.status,
        this.transaksiId,
        this.createdAt,
        this.updatedAt});

  Keranjang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cmsUsersId = json['cms_users_id'];
    produkId = json['produk_id'];
    qty = json['qty'];
    catatan = json['catatan'];
    status = json['status'];
    transaksiId = json['transaksi_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cms_users_id'] = this.cmsUsersId;
    data['produk_id'] = this.produkId;
    data['qty'] = this.qty;
    data['catatan'] = this.catatan;
    data['status'] = this.status;
    data['transaksi_id'] = this.transaksiId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
