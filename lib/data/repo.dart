import 'package:menu_resto_ku/common/constans.dart';
import 'package:menu_resto_ku/data/json.dart';

class Repo {
  late Json _loader;

  Repo() {
    _loader = Json();
  }

  Future kategori() async {
    return await _loader.load(path: kDJKategori);
  }

  Future menu() async {
    return await _loader.load(path: kDJMenu);
  }
}
