import 'package:flutter/material.dart';

class ReloadDataWidget extends StatefulWidget {
  final String error;
  final Function() onReload;

  const ReloadDataWidget({
    Key? key,
    required this.error,
    required this.onReload,
  }) : super(key: key);

  @override
  _ReloadDataWidgetState createState() => _ReloadDataWidgetState();
}

class _ReloadDataWidgetState extends State<ReloadDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(widget.error),
        const SizedBox(height: 16.0),
        MaterialButton(
          color: Colors.grey[100],
          child: const Text('Reload data'),
          onPressed: widget.onReload,
        ),
      ],
    );
  }
}
