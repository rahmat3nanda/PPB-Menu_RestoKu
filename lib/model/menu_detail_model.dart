import 'package:menu_resto_ku/model/kategori_model.dart';

class MenuDetailModel {
  MenuDetailModel({
    this.id,
    this.nama,
    this.foto,
    this.harga,
    this.kategori,
    this.keterangan,
  });

  int? id;
  String? nama;
  String? foto;
  int? harga;
  dynamic kategori;
  String? keterangan;

  factory MenuDetailModel.fromJson(Map<String, dynamic> json) =>
      MenuDetailModel(
        id: json["id"],
        nama: json["nama"],
        foto: json["foto"],
        harga: json["harga"],
        kategori: json["kategori"] is int
            ? json["kategori"]
            : KategoriModel.fromJson(json["kategori"]),
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "foto": foto,
        "harga": harga,
        "kategori": kategori is int ? kategori : kategori?.toJson(),
        "keterangan": keterangan,
      };
}
