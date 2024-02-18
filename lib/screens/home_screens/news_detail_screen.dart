import 'dart:developer';

import 'package:blog/core/extensions/extended_build_context.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:blog/core/utils/app_assets.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/core/widgets/dialogs.dart';
import 'package:blog/core/widgets/empty_screen.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/models/api_response.dart';
import 'package:blog/models/new_model.dart';
import 'package:blog/screens/modification_screens/update_news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetailScreen extends StatefulWidget {
  final String id;
  const NewsDetailScreen({super.key, required this.id});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late NewsProvider _newsProvider;

  APIResponse _response = APIResponse();

  NewsModel? _news;

  Future<void> _fetchData() async {
    var result = await _newsProvider.getSingleNews(context: context, id: widget.id);
    _response = result;
    log(result.message);
  }

  @override
  void initState() {
    // TODO: implement initState
    _newsProvider = context.provideOnce<NewsProvider>();
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    _news = _newsProvider.news;
    return BackgroundWidget(
      hasAppBar: true,
      hasPadding: true,
      titleWidget: TextView(text: appName, textStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Pallet.black, fontWeight: FontWeight.w600),),
      actions: [
        if(_news != null) IconButton(
          onPressed: () {
            PageRouter.gotoWidget(UpdateNewsScreen(newsModel: _news!,), context).then((value) => _fetchData());
          },
          icon: const Icon(Icons.edit, color: Pallet.black,),
        ),

        if(_news != null) IconButton(
          onPressed: () {
            AppDialog.showConfirmationDialog(context, title: "Delete post", message: "Are you sure you want to delete this post?", onContinue: () async {
              PageRouter.goBack(context);
              _newsProvider.deleteNews(context: context, id: widget.id);
              _newsProvider.newsList.removeWhere((element) => element.id == widget.id);
              _newsProvider.setNewsList(_newsProvider.newsList);
              PageRouter.goBack(context);
            });
          },
          icon: const Icon(Icons.delete, color: Pallet.red,),
        ),
      ],
      body: _newsProvider.isLoadingSingleNews ?
      const Center(
        child: CircularProgressIndicator(color: Pallet.blue,),
      ) :
      !_response.status ?
      EmptyScreen(
        icon: AppAssets.error,
        title: _response.message,
        onRefresh: (){
          _fetchData();
        },
      ) : _news != null ? ListView(
        children: [
          SizedBox(height: 24.h,),

          TextView(text: _news!.title, textAlign: TextAlign.center, textStyle: GoogleFonts.poppins(fontSize: 24.sp, color: Pallet.black, fontWeight: FontWeight.w600),),

          SizedBox(height: 16.h,),

          TextView(text: _news!.subtitle, textAlign: TextAlign.start, textStyle: GoogleFonts.poppins(fontSize: 18.sp, color: Pallet.blue, fontWeight: FontWeight.w400),),

          TextView(text: "Added ${timeago.format(DateTime.parse(_news!.date))}", textStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Pallet.grey),),

          SizedBox(height: 16.h,),

          TextView(text: _news!.body, textAlign: TextAlign.justify, textStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Pallet.grey, fontWeight: FontWeight.w400),),
        ],
      ) : EmptyScreen(
        title: 'Sorry, we can’t find any result for you.',
        onRefresh: (){
          _fetchData();
        },
      ),

      floatingActionButton:_news != null ? FloatingActionButton.extended(
        onPressed: (){
          _newsProvider.addBookMark(_news!);
        },
        label: TextView(text: "Bookmark post", textAlign: TextAlign.justify, textStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Pallet.white, fontWeight: FontWeight.w400),),
        icon: const Icon(Icons.bookmark),
      ) : null, //
    );
  }
}
