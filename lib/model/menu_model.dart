import 'package:menu_resto_ku/model/kategori_model.dart';

class MenuModel {
  MenuModel({
    this.id,
    this.nama,
    this.foto,
    this.harga,
    this.kategori,
  });

  int? id;
  String? nama;
  String? foto;
  int? harga;
  dynamic kategori;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        nama: json["nama"],
        foto: json["foto"],
        harga: json["harga"],
        kategori: json["kategori"] is int
            ? json["kategori"]
            : KategoriModel.fromJson(json["kategori"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "foto": foto,
        "harga": harga,
        "kategori": kategori is int ? kategori : kategori?.toJson(),
      };
}
