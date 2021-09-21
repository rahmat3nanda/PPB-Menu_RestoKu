const kGAppName = "Menu RestoKu";
const kGPackageName = "id.nesd.menu_restoku";
const kGVersionName = "1.0.0";
const kGVersionCode = 1;

String kGLogTag = "[$kGAppName]";
const kGLogEnable = true;

void printLog(dynamic data) {
  if (kGLogEnable) {
    print("[${DateTime.now().toUtc()}]$kGLogTag$data");
  }
}
