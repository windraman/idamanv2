

class Umkm {
  final String warga_bjb_id,nama_usaha, bidang_usaha, sub_bidang_usaha, jenis_produk, brand,
                alamat_usaha, province_id, regency_id,district_id,village_id,lat,lon,photo,peta_icon,
                provinsi,kabupaten,kecamatan, kelurahan, verified,nik;
  final String lokasi_id, perizinan, keterangan;
  final double jarak_km, aset_tetap, omset;
  final String update_omset;
  final int numOfProduk, j_kary_l, j_kary_p;
  final int id;

  Umkm( {
    required this.id,
    required this.warga_bjb_id,
    required this.nama_usaha,
    required this.bidang_usaha,
    required this.sub_bidang_usaha,
    required this.jenis_produk,
    required this.brand,
    required this.alamat_usaha,
    required this.province_id,
    required this.regency_id,
    required this.district_id,
    required this.village_id,
    required this.lat,
    required this.lon,
    required this.photo,
    required this.peta_icon,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.jarak_km,
    required this.verified,
    required this.numOfProduk,
    required this.nik,
    required this.lokasi_id,
    required this.perizinan,
    required this.aset_tetap,
    required this.omset,
    required this.update_omset,
    required this.keterangan,
    required this.j_kary_l,
    required this.j_kary_p
  });

  Map<String, dynamic> toJson() => {
    "id":id,
    "nama_usaha": nama_usaha,
    "keterangan": keterangan
  };

}

// Our demo Products
