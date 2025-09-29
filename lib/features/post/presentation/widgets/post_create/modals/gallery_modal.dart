import 'package:flutter/material.dart';

class GalleryModal extends StatefulWidget {
  const GalleryModal({super.key});

  @override
  State<GalleryModal> createState() => _GalleryModalState();
}

class _GalleryModalState extends State<GalleryModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(child: Column(children: [Text('Gallery')])),
    );
  }
}