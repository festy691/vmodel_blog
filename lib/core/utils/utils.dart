import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String link)async{
  Uri url = Uri.parse(link);
  if(await canLaunchUrl(url)) await launchUrl(url);
  else throw 'Could not launch $url';
}

String formatDate(String date, {String? format, Duration? duration}) {
  if (!date.contains("-")){
    return formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(date)).toIso8601String());
  } else if (date.contains("T")){
    var dateTime = DateTime.parse(date);
    if(duration != null) {
      dateTime = dateTime.add(duration);
    }
    return DateFormat(format ?? 'MMM dd, yyyy HH:mm').format(dateTime);
  } else {
    return date;
  }
}

String getMonth(String month) {
  switch (month.toLowerCase()) {
    case "dec": return "12";
    case "nov": return "11";
    case "oct": return "10";
    case "sep": return "9";
    case "aug": return "8";
    case "jul": return "7";
    case "jun": return "6";
    case "may": return "5";
    case "apr": return "4";
    case "mar": return "3";
    case "feb": return "2";
    case "jan": return "1";
    default: return month;
  }
}

int getYear(int year){
  if (year > 23 && year < 1000){
    return year + 1900;
  } else if (year < 23 && year < 1000){
    return year + 2000;
  } else {
    return year;
  }
}

copyText(BuildContext context, String text)async{
  await Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
      msg: "Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
  );
}

String getFirstName(String name){
  if (name.split(" ").isNotEmpty){
    String text = name.split(" ").first;
    print("Last name: $text");
    return text;
  }
  return "";
}

String getLastName(String name){
  if (name.split(" ").skip(1).isNotEmpty){
    String text = name.split(" ").skip(1).first;
    print("First name: $text");
    return text;
  }
  return "";
}

String getMiddleName(String name){
  if (name.split(" ").skip(2).isNotEmpty){
    String text = name.split(" ").skip(2).first;
    print("Middle name: $text");
    return text;
  }
  return "";
}

onShareText(String text) async {
  try{
    await Share.share(text);
  } catch (e,s){
    log("Error: $e");
    log(s.toString());
  }
}
