import 'package:flutter/material.dart';
import 'package:menu_resto_ku/tool/image_network_widget.dart';

class ImageViewerPage extends StatefulWidget {
  final String url;

  const ImageViewerPage({Key? key, required this.url}) : super(key: key);

  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    var q = MediaQuery.of(context);
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 4.0,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            transformationController: _controller,
            child: ImageNetworkWidget(
              url: widget.url,
              clickable: false,
              fit: BoxFit.none,
            ),
            onInteractionEnd: (d) => _controller.value = Matrix4.identity(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: q.padding.top),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
