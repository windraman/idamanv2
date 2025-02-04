

class UsahaPostModel {
  String id;
  //String warga_bjb_id;
  String nama_usaha;
  String bidang_usaha;
  String sub_bidang_usaha;
  String alamat_usaha;
  String province_id;
  String regency_id;
  String district_id;
  String village_id;
  String lat;
  String lon;
  String keterangan;
  String photo;
  String peta_icon;
  String updated_by;
  String perizinan;
  String j_kary_l;
  String j_kary_p;
  String aset_tetap;
  String omset;
  String update_omset;
  String lokasi_id;



  UsahaPostModel({
    required this.id,
    //required this.warga_bjb_id,
    required this.nama_usaha,
    required this.bidang_usaha,
    required this.sub_bidang_usaha,
    required this.alamat_usaha,
    required this.province_id,
    required this.regency_id,
    required this.district_id,
    required this.village_id,
    required this.lat,
    required this.lon,
    required this.keterangan,
    required this.photo,
    required this.peta_icon,
    required this.updated_by,
    required this.perizinan,
    required this.j_kary_l,
    required this.j_kary_p,
    required this.aset_tetap,
    required this.omset,
    required this.update_omset,
    required this.lokasi_id,

  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      //'warga_bjb_id': warga_bjb_id,
      'nama_usaha': nama_usaha,
      'bidang_usaha': bidang_usaha,
      'sub_bidang_usaha': sub_bidang_usaha,
      'alamat_usaha': alamat_usaha,
      'province_id': province_id,
      'regency_id': regency_id,
      'district_id': district_id,
      'village_id': village_id,
      'lat': lat,
      'lon': lon,
      'keterangan': keterangan,
      'photo': photo,
      'peta_icon': peta_icon,
      'updated_by': updated_by,
      'perizinan':perizinan,
      'j_kary_l':j_kary_l,
      'j_kary_p':j_kary_p,
      'aset_tetap':aset_tetap,
      'omset':omset,
      'update_omset':update_omset,
      'lokasi_id':lokasi_id
    };

    return map;
  }
}