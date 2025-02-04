import 'package:flutter/material.dart';
import 'package:idaman/models/Photos.dart';

class Product {
  final int id, isFavourite, kategori_produk_id, satuan_berat_id, umkm_usaha_id, status_produk;
  final String title, description, satuan_berat, lokasi, usaha, longDesc;
  final List<PhotoModel> images;
  final List<Color> colors;
  final double rating, price, berat, jarak;
  final bool  isPopular;
  final String nik;
  final String verified;

  Product( {
    required this.id,
    required this.images,
    required this.umkm_usaha_id,
    required this.colors,
    this.rating = 0.0,
    required this.isFavourite,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.berat,
    required this.satuan_berat,
    required this.description,
    required this.longDesc,
    required this.lokasi,
    required this.jarak,
    required this.usaha,
    required this.nik,
    required this.kategori_produk_id,
    required this.satuan_berat_id,
    required this.status_produk,
    required this.verified
  });

  Map<String, dynamic> toJson() => {
    "id":id,
  };

}

// Our demo Products
