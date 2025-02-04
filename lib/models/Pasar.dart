
class PasarModel {
  final String id, nama, kategori_lokasi_id, lat, lon, alamat, gambar_utama;
  final int numOfProduk;

  PasarModel({
    required this.id,
    required this.nama,
    required this.kategori_lokasi_id,
    required this.lat,
    required this.lon,
    required this.alamat,
    required this.gambar_utama,
    required this.numOfProduk,
  });
}