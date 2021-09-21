import 'package:flutter/material.dart';
import 'package:menu_resto_ku/common/styles.dart';
import 'package:menu_resto_ku/data/request.dart';
import 'package:menu_resto_ku/model/app/singleton_model.dart';
import 'package:menu_resto_ku/model/menu_detail_model.dart';
import 'package:menu_resto_ku/tool/helper.dart';
import 'package:menu_resto_ku/tool/image_network_widget.dart';
import 'package:menu_resto_ku/tool/multi_vertical_drag_gesture_recognizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:menu_resto_ku/widget/reload_data_widget.dart';

class MenuDetailPage extends StatefulWidget {
  final int id;

  const MenuDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MenuDetailPageState createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  late Helper _helper;
  late Request _request;

  late Future _future;
  late MenuDetailModel? _data;
  late bool _collapsed;
  dynamic _backColor;

  @override
  void initState() {
    super.initState();
    SingletonModel.withContext(context);
    _helper = Helper();
    _request = Request();
    _collapsed = false;
    _backColor = Colors.white;
    _future = _request.detailMenu(idMenu: widget.id);
  }

  Map<Type, GestureRecognizerFactory> _gestures() {
    return {
      MultiVerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          MultiVerticalDragGestureRecognizer>(
        () => MultiVerticalDragGestureRecognizer(),
        _initializer,
      ),
    };
  }

  void _initializer(MultiVerticalDragGestureRecognizer instance) {
    instance.onUpdate = _onDrag;
    instance.onStart = _onDrag;
    instance.onDown = _onDrag;
    instance.onEnd = _onDrag;
  }

  void _onDrag(details) {
    setState(() {
      _backColor = _collapsed ? primaryColor : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: _gestures(),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return SpinKitPulse(
              color: primaryColor,
              size: 64.0,
            );
          case ConnectionState.done:
            if (snapshot.hasData) {
              _data = snapshot.data as MenuDetailModel;

              return _data == null
                  ? const Center(child: Text("Tidak Ada Data"))
                  : _mainView();
            } else if (snapshot.hasError) {
              return Center(
                child: ReloadDataWidget(
                  error: "${snapshot.error}",
                  onReload: () => setState(() {
                    _future = _request.detailMenu(idMenu: widget.id);
                  }),
                ),
              );
            }
        }
        return Container();
      },
    );
  }

  Widget _mainView() {
    MediaQueryData q = MediaQuery.of(context);
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 350.0,
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: _backColor,
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    _collapsed = constraints.biggest.height ==
                        MediaQuery.of(context).padding.top + kToolbarHeight;

                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1.0,
                        child: Text(
                          _data!.nama!,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: _collapsed ? primaryColor : Colors.white,
                          ),
                        ),
                      ),
                      background: Stack(
                        children: [
                          Positioned.fill(
                            child: ImageNetworkWidget(
                              url: _data!.foto!,
                            ),
                          ),
                          IgnorePointer(
                            ignoring: true,
                            child: Container(
                              color: Colors.black.withOpacity(0.2),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            elevation: 4.0,
                            child: Container(
                              width: q.size.width,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _colBuilder(
                                          text: ["Nama", "Kategori", "Harga"]),
                                      const SizedBox(width: 4.0),
                                      _colBuilder(text: [":", ":", ":"]),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: _colBuilder(
                                          text: [
                                            _data!.nama!,
                                            _data!.kategori!.nama!,
                                            _helper.formatRupiah(
                                                "${_data?.harga ?? 0}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(_data!.keterangan!),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          q.size.height - q.padding.top - (kToolbarHeight * 4.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: q.size.width,
          height: kToolbarHeight,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      color: primaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: const Text("Tambah Ke Keranjang"),
                  color: Colors.white,
                  textColor: primaryColor,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16.0),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    color: primaryColor,
                    width: 2.0,
                  ),
                ),
                child: const Text("Beli"),
                color: primaryColor,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _colBuilder({required List<String> text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        text.length,
        (i) => Text(
          text[i],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
