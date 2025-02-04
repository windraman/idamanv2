

class ProdukPostModel {
  String id;
  String nama_produk_jasa;
  String harga;
  String mata_uang_id;
  String umkm_usaha_id;
  String lokasi_id;
  String deskripsi_singkat;
  String deskripsi_produk;
  String berat;
  String satuan_berat;
  String kategori_produk_id;
  String status_produk;
  String diskon;
  String etalase_id;
  String updated_by;


  ProdukPostModel({
    required this.id,
    required this.nama_produk_jasa,
    required this.harga,
    required this.mata_uang_id,
    required this.umkm_usaha_id,
    required this.lokasi_id,
    required this.deskripsi_singkat,
    required this.deskripsi_produk,
    required this.berat,
    required this.satuan_berat,
    required this.kategori_produk_id,
    required this.status_produk,
    required this.diskon,
    required this.etalase_id,
    required this.updated_by

  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'nama_produk_jasa': nama_produk_jasa,
      'harga': harga,
      'mata_uang_id': mata_uang_id,
      'umkm_usaha_id': umkm_usaha_id,
      'lokasi_id': lokasi_id,
      'deskripsi_singkat': deskripsi_singkat,
      'deskripsi_produk': deskripsi_produk,
      'berat': berat,
      'satuan_berat': satuan_berat,
      'kategori_produk_id': kategori_produk_id,
      'status_produk': status_produk,
      'diskon': diskon,
      'etalase_id': etalase_id,
      'updated_by': updated_by
    };

    return map;
  }
}