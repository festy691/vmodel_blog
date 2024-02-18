import 'package:blog/core/extensions/extended_build_context.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/models/new_model.dart';
import 'package:blog/screens/home_screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  NewsModel newsModel;
  NewsCard({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        context.provideOnce<NewsProvider>().setNews(null);
        PageRouter.gotoWidget(NewsDetailScreen(id: newsModel.id), context);
      },
      title: TextView(text: newsModel.title, textStyle: GoogleFonts.poppins(fontSize: 20.sp, color: Pallet.black),),
      subtitle: TextView(text: newsModel.subtitle, textStyle: GoogleFonts.poppins(fontSize: 14.sp, color: Pallet.grey),),
      trailing: TextView(text: timeago.format(DateTime.parse(newsModel.date)), textStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Pallet.grey),),
    );
  }
}
