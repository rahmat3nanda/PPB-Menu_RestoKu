import 'dart:convert';

import 'package:menu_resto_ku/data/repo.dart';
import 'package:menu_resto_ku/model/kategori_model.dart';
import 'package:menu_resto_ku/model/menu_detail_model.dart';
import 'package:menu_resto_ku/model/menu_model.dart';

class Request {
  late Repo _repo;

  Request() {
    _repo = Repo();
  }

  Future allMenu() async {
    var encKategori = await _repo.kategori();
    if (encKategori is! String) return encKategori;

    var encMenu = await _repo.menu();
    if (encMenu is! String) return encMenu;

    List<KategoriModel> kategori = List<KategoriModel>.from(
        jsonDecode(encKategori).map((x) => KategoriModel.fromJson(x)));
    List<MenuModel> data = List<MenuModel>.from(
        jsonDecode(encMenu).map((x) => MenuModel.fromJson(x)));

    for (var d in data) {
      KategoriModel k = kategori.firstWhere((kt) => kt.id == d.kategori);
      d.kategori = k;
    }

    return data;
  }

  Future detailMenu({required int idMenu})async{
    var encKategori = await _repo.kategori();
    if (encKategori is! String) return encKategori;

    var encMenu = await _repo.menu();
    if (encMenu is! String) return encMenu;

    List<KategoriModel> kategori = List<KategoriModel>.from(
        jsonDecode(encKategori).map((x) => KategoriModel.fromJson(x)));
    List<MenuDetailModel> data = List<MenuDetailModel>.from(
        jsonDecode(encMenu).map((x) => MenuDetailModel.fromJson(x)));

    for (var d in data) {
      KategoriModel k = kategori.firstWhere((kt) => kt.id == d.kategori);
      d.kategori = k;
    }

    return data.firstWhere((d) => d.id == idMenu);
  }
}
