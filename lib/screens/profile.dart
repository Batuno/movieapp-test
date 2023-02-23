import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie/global_keys.dart';
import 'package:movie/providers/common.dart';
import 'package:movie/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final _bloc = MovieBloc();

  void _onChangeLang() {
    final context = GlobalKeys.navigatorKey.currentContext!;
    if (context.locale.languageCode == 'mn') {
      context.setLocale(const Locale('en', 'US'));
    } else if (context.locale.languageCode == 'en') {
      context.setLocale(const Locale('ko', 'KR'));
    } else {
      context.setLocale(const Locale('mn', 'MN'));
    }
  }

  // void _onChangeLang() {
  //   final context = GlobalKeys.navigatorKey.currentContext!;
  //   if (context.locale.languageCode == Locale("mn", "MN").languageCode) {
  //     context.setLocale(Locale("en", "US"));
  //   }
  //   if (context.locale.languageCode == Locale("en", "Us").languageCode) {
  //     context.setLocale(Locale("ko", "KR"));
  //   } else {
  //     context.setLocale(Locale("mn", "MN"));
  //   }
  // }
  // GlobalKeys.navigatorKey.currentContext!.setLocale(Locale("mn", "MN"));

  void _onImgPick(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
  }

  // void _onHttpReques() async {
  //   _bloc.add(const MovieTest());
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<CommonProvider>(builder: ((context, provider, child) {
      return provider.isLoggedIn
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () => _onHttpReques(),
                //   child: const Text("Хүсэлт илгээх"),
                // ),
                ElevatedButton(
                  onPressed: () => _onImgPick(ImageSource.gallery),
                  child: const Text("Зургийн сан нээх"),
                ),
                ElevatedButton(
                  onPressed: () => _onImgPick(ImageSource.camera),
                  child: const Text("Камер нээх"),
                ),
                ElevatedButton(
                    onPressed: _onChangeLang,
                    child: Text(context.locale.languageCode)),
                ElevatedButton(
                  onPressed: provider.onLogout,
                  child: const Text("Гарах"),
                ),
              ],
            ))
          : LoginPage();
    }));
  }
}
