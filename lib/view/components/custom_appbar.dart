import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_ikimono_zukan/generated/locale_keys.g.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required bool themeModeProvider,
    required BuildContext context,
    // ignore: avoid_positional_boolean_parameters
    required void Function(bool) toggle,
    super.key,
  }) : super(
          centerTitle: true,
          title: Image.asset(
            'assets/images/ikimono.png',
            height: 50,
            width: 50,
            semanticLabel: 'Ikimono Logo',
          ),
          actions: [
            MenuAnchor(
              alignmentOffset: const Offset(-175, 0),
              style: const MenuStyle(
                elevation: WidgetStatePropertyAll(1),
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              builder: (
                BuildContext context,
                MenuController controller,
                Widget? child,
              ) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(
                    Icons.settings,
                  ),
                );
              },
              menuChildren: <Widget>[
                Column(
                  children: [
                    MenuItemButton(
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(210, 50)),
                      ),
                      trailingIcon: Icon(
                        Icons.translate_outlined,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: AppSettings.openAppSettings,
                      child: Text(
                        LocaleKeys.appLanguage.tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(210, 50)),
                      ),
                      trailingIcon: Switch.adaptive(
                        value: themeModeProvider,
                        onChanged: (val) {
                          toggle(val);
                        },
                      ),
                      child: Text(
                        themeModeProvider
                            ? LocaleKeys.darkMode.tr()
                            : LocaleKeys.lightMode.tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
}
