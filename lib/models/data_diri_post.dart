

class DataDiriPostModel {
  String id;
  String nama_lgkp;
  String jk;
  String tmpt_lhr;
  String tgl_lhr;
  String pddk_akhir_id;
  String pekerjaan_id;
  String alamat2;
  String rt;
  String rw;
  String nama_prop;
  String nama_kab;
  String nama_kec;
  String nama_kel;
  String no_kk;
  String updated_by;


  DataDiriPostModel({
    required this.id,
    required this.nama_lgkp,
    required this.jk,
    required this.tmpt_lhr,
    required this.tgl_lhr,
    required this.pddk_akhir_id,
    required this.pekerjaan_id,
    required this.alamat2,
    required this.rt,
    required this.rw,
    required this.nama_prop,
    required this.nama_kab,
    required this.nama_kec,
    required this.nama_kel,
    required this.no_kk,
    required this.updated_by

  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'nama_lgkp': nama_lgkp,
      'jk': jk,
      'tmpt_lhr': tmpt_lhr,
      'tgl_lhr': tgl_lhr,
      'pddk_akhir_id': pddk_akhir_id,
      'pekerjaan_id': pekerjaan_id,
      'alamat2': alamat2,
      'rt': rt,
      'rw': rw,
      'nama_prop': nama_prop,
      'nama_kab': nama_kab,
      'nama_kec': nama_kec,
      'nama_kel': nama_kel,
      'no_kk': no_kk,
      'updated_by': updated_by
    };

    return map;
  }
}