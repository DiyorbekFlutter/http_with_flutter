import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../models/taxi_model.dart';

void connectionWithTaxiDriver(BuildContext context, TaxiModel taxiModel) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    content: SizedBox(
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(taxiModel.taxiDriverName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 15),
          ZoomTapAnimation(
            onTap: () => _openPhone(context, taxiModel.phoneNumber),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/connection_window_icons/call.svg',
                  width: 20,
                  height: 20,
                  // ignore: deprecated_member_use
                  color: Colors.green
                ),
                const SizedBox(width: 10),
                const Expanded(child: Text("Qo'ng'iroq qilish"))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => _openSMS(context, taxiModel.phoneNumber),
            child: const Row(
              children: [
                Icon(Icons.sms, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(child: Text("SMS yozish"))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () {
              if(taxiModel.telegramUsername != null){
                _openTelegram(context, taxiModel.telegramUsername!);
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ushbu foydalanuvchi telegram uchun username qo'shmagan"),
                    behavior: SnackBarBehavior.floating,
                  )
                );
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/connection_window_icons/telegram.svg',
                  width: 20,
                  height: 20,
                  // ignore: deprecated_member_use
                  color: Colors.blue
                ),
                const SizedBox(width: 10),
                const Expanded(child: Text("Telegrmdan yozish")),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: (){},
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/connection_window_icons/marker.svg',
                  width: 20,
                  height: 20,
                  // ignore: deprecated_member_use
                  color: const Color(0xffEA4234)
                ),
                const SizedBox(width: 10),
                const Expanded(child: Text("Locatsiya yuborish"))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => Clipboard.setData(ClipboardData(text: '+${phoneNumberFormat(taxiModel.phoneNumber)}')),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/connection_window_icons/copy.svg', width: 20, height: 20),
                const SizedBox(width: 10),
                const Expanded(child: Text("Raqamni nusxalash"))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          Row(
            children: [
              const Icon(Icons.numbers, color: Colors.blue),
              const SizedBox(width: 10),
              Text(taxiModel.phoneNumber)
            ],
          ),
          const Spacer(),
          ZoomTapAnimation(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8)
              ),
              child: const Text("Yopish"),
            ),
          )
        ],
      ),
    ),
  ),
);


String phoneNumberFormat(String phoneNumber) => phoneNumber.split('').where((element) => RegExp(r'\d').hasMatch(element)).join();

void _openPhone(BuildContext context, String phoneNumber) async {
  // String url = 'tel:${phoneNumberFormat(phoneNumber)}';
  // // ignore: deprecated_member_use
  // if (await canLaunch(url)){
  //   // ignore: deprecated_member_use
  //   await launch(url);
  // } else {
  //   if(!context.mounted) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Telefon raqamini chaqirish uchun URL ochilmadi: $url")
  //     )
  //   );
  // }
}

void _openSMS(BuildContext context, String phoneNumber) async {
  // String url = 'sms:${phoneNumberFormat(phoneNumber)}';
  // // ignore: deprecated_member_use
  // if (await canLaunch(url)) {
  //   // ignore: deprecated_member_use
  //   await launch(url);
  // } else {
  //   if (!context.mounted) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("SMS ochish uchun URL ochilmadi: $url")
  //     )
  //   );
  // }
}

void _openTelegram(BuildContext context, String telegramUrl) async {
  // try{
  //   // ignore: deprecated_member_use
  //   await launch(telegramUrl);
  // } catch(e){
  //   if (!context.mounted) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Telegramni ochish uchun URL ochilmadi: $telegramUrl")
  //     )
  //   );
  // }
}

