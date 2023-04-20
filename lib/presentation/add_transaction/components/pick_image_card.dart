import 'dart:io' show File;

import '../../core_package/core_widget.dart';

import '../add_transaction_provider.dart';
import '../../../utils/base_extensions.dart';
import '../../../utils/type_def_utils.dart';
import 'package:flutter/material.dart' hide CloseButton;
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/theme.dart';

const _duration = Duration(milliseconds: 300);

class PickImageCard extends ConsumerWidget {
  const PickImageCard({Key? key}) : super(key: key);

  File? getFile(String? path) {
    try {
      if (path == null) return null;
      return File(path);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = getFile(ref.watch(AddTransactionProvider.imagePathProvider));
    final editable = ref.watch(AddTransactionProvider.editableProvider);
    if (!editable && image == null) return const SizedBox.shrink();
    return AddEditInfoCard(
      title: 'Image',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
        child: Column(
          children: [
            AnimatedCrossFade(
              duration: _duration,
              firstChild: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: image != null
                        ? GestureDetector(
                            onTap: () => showImage(context, image),
                            child: Hero(
                              tag: 'image-expin',
                              child: Image.file(
                                image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              secondChild: const SizedBox.shrink(),
              crossFadeState: image != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            if (image != null && editable)
              _Type(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                title: 'Remove',
                color: Colors.red,
                onTap: () => ref
                    .read(AddTransactionProvider.imagePathProvider.notifier)
                    .update((state) => null),
              ),
            if (editable)
              Row(
                children: [
                  Expanded(
                    child: _Type(
                      margin: const EdgeInsets.all(8),
                      title: 'Camera',
                      color: Colors.blue,
                      onTap: () => takePhoto(ImageSource.camera, ref.read),
                    ),
                  ),
                  Expanded(
                    child: _Type(
                      margin: const EdgeInsets.all(8),
                      title: 'Gallery',
                      color: Colors.orange,
                      onTap: () => takePhoto(ImageSource.gallery, ref.read),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> takePhoto(ImageSource source, Reader read) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
    pickedFile?.let(
      (value) => read(AddTransactionProvider.imagePathProvider.notifier)
          .update((state) => value.path),
    );
  }

  void showImage(BuildContext context, File? image) => image == null
      ? null
      : Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, a, b) => _ShowImage(file: image),
            transitionsBuilder: (_, anim, b, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
          ),
        );
}

class _Type extends StatelessWidget {
  final EdgeInsets margin;
  final String title;
  final Color? color;
  final VoidCallback onTap;
  const _Type({
    required this.margin,
    required this.title,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color?.withOpacity(0.15),
      elevation: 0,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowImage extends StatefulWidget {
  final File file;
  const _ShowImage({Key? key, required this.file}) : super(key: key);

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<_ShowImage> {
  bool _show = false;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _show = !_show;
        if (_show) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
        }
        // setState(() => _show = !_show);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Hero(
            tag: 'image-expin',
            child: Image.file(widget.file, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
