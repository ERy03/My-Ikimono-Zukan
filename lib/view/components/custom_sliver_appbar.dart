import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({required this.ikimonoUrl, super.key});

  final String ikimonoUrl;

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    return SliverAppBar(
      expandedHeight: 275,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      elevation: 0,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: ikimonoUrl,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
      ),
      leadingWidth: 80,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        iconSize: 16,
        padding: const EdgeInsets.all(12),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Colors.white.withOpacity(0.2),
          ),
        ),
        icon: isAndroid
            ? const Icon(Icons.arrow_back)
            : const Icon(
                Icons.arrow_back_ios_new,
              ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
