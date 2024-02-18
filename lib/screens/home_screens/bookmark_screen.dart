import 'package:blog/core/extensions/extended_build_context.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/core/widgets/empty_screen.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/models/new_model.dart';
import 'package:blog/screens/home_screens/widgets/news_card.dart';
import 'package:blog/screens/modification_screens/add_news_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late NewsProvider _newsProvider;

  List<NewsModel> _newsList = [];

  Future<void> _fetchData() async {
    await _newsProvider.loadBookmarks();
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: true,);

  void _onRefresh() async {
    _refreshController.requestRefresh();
    await _fetchData();
    _newsList = _newsProvider.newsList;
    _refreshController.refreshToIdle();
  }

  @override
  void initState() {
    // TODO: implement initState
    _newsProvider = context.provideOnce<NewsProvider>();
    super.initState();
    globalContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      hasAppBar: true,
      leadingWidget: const SizedBox(),
      titleWidget: TextView(text: appName, textStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Pallet.black, fontWeight: FontWeight.w600),),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextView(text: bookmarkedNews, textAlign: TextAlign.start, textStyle: GoogleFonts.poppins(fontSize: 20.sp, color: Pallet.blue, fontWeight: FontWeight.w600),),
          ),

          SizedBox(height: 16.h,),

          Consumer<NewsProvider>(builder: (context, provider, child) {
            _newsList = provider.newsBookmarkList;

            return Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropHeader(),
                footer: CustomFooter(
                  builder: (context, mode){
                    Widget body ;
                    if(mode==LoadStatus.idle){
                      body = TextView(text: "pull up load");
                    } else if(mode==LoadStatus.loading){
                      body = const CupertinoActivityIndicator();
                    }
                    else if(mode == LoadStatus.failed){
                      body = TextView(text: "Load Failed!Click retry!");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = TextView(text: "release to load more");
                    } else{
                      body = TextView(text: "No more Data");
                    }
                    return SizedBox(
                      height: 55.0.h,
                      child: Center(child:body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: _newsList.isNotEmpty ?
                ListView.separated(
                  itemCount: _newsList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Divider(height: index == (_newsList.length - 1) ? 0 : 1),
                    );
                  },
                  itemBuilder: (BuildContext context, int index){
                    NewsModel newsModel = _newsList[index];
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(newsModel.id),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              provider.removeBookMark(newsModel);
                            },
                            backgroundColor: Pallet.red,
                            foregroundColor: Pallet.white,
                            icon: Icons.bookmark_remove_outlined,
                            label: 'Remove Bookmark',
                          ),
                        ],
                      ),
                      child: NewsCard(newsModel: newsModel),
                    );
                  },
                )
                    :
                EmptyScreen(
                  title: 'Sorry, we can’t find any bookmarks for you.',
                  onRefresh: (){
                    _onRefresh();
                  },
                ),
              ),
            );
          }
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
