class KategoriModel {
  KategoriModel({
    this.id,
    this.nama,
    this.keterangan,
  });

  int? id;
  String? nama;
  String? keterangan;

  factory KategoriModel.fromJson(Map<String, dynamic> json) => KategoriModel(
        id: json["id"],
        nama: json["nama"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "keterangan": keterangan,
      };
}
