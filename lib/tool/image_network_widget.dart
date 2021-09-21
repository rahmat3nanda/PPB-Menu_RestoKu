import 'package:flutter/material.dart';
import 'package:menu_resto_ku/common/constans.dart';
import 'package:menu_resto_ku/page/image_viewer_page.dart';
import 'package:menu_resto_ku/tool/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageNetworkWidget extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadius? radius;
  final bool clickable;
  final BoxFit fit;
  final BoxShape shape;
  final Color? color;

  const ImageNetworkWidget({Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.clickable = true,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.color,
  }) : super(key: key);

  @override
  _ImageNetworkWidgetState createState() => _ImageNetworkWidgetState();
}

class _ImageNetworkWidgetState extends State<ImageNetworkWidget> {
  void _onTap() {
    if (widget.clickable) {
      Helper().jumpToPage(
        context,
        page: ImageViewerPage(url: widget.url),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: CachedNetworkImage(
        imageUrl: widget.url,
        imageBuilder: (c, image) => _imageView(image),
        placeholder: (c, url) => _imageView(const AssetImage(kImgNotAvail)),
        errorWidget: (c, url, e) => _imageView(const AssetImage(kImgNotAvail)),
      ),
    );
  }

  Widget _imageView(ImageProvider<Object> image) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.radius,
        shape: widget.shape,
        color: widget.color,
        image: DecorationImage(
          image: image,
          fit: widget.fit,
        ),
      ),
    );
  }
}
