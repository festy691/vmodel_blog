import 'dart:developer';

import 'package:blog/core/extensions/extended_build_context.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:blog/core/utils/app_assets.dart';
import 'package:blog/core/utils/app_flushbar.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/core/widgets/dialogs.dart';
import 'package:blog/core/widgets/edit_form_widget.dart';
import 'package:blog/core/widgets/empty_screen.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/models/api_response.dart';
import 'package:blog/models/new_model.dart';
import 'package:blog/screens/home_screens/widgets/news_card.dart';
import 'package:blog/screens/modification_screens/add_news_screen.dart';
import 'package:blog/screens/modification_screens/update_news_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsProvider _newsProvider;

  TextEditingController _searchController = TextEditingController();

  APIResponse _response = APIResponse();
  List<NewsModel> _newsSearchList = [];

  bool _searching = false;

  Future<void> _fetchData({bool local = false}) async {
    var result = await _newsProvider.getNews(context: context, isLocal: local);
    _response = result;
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: true,);

  void _onRefresh() async {
    _refreshController.requestRefresh();
    await _fetchData();
    _newsSearchList = _newsProvider.newsSearchList;
    _newsProvider.onSearch(_searchController.text);
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
      leadingWidget: _searching ? IconButton(
        onPressed: (){
          _searching = false;
          _searchController.text = "";
          if (mounted){
            setState(() {});
          }
        },
        icon: const Icon(Icons.close, color: Pallet.black,)) : const SizedBox(),
      titleWidget: _searching ?
          EditFormField(
            prefixIcon: Icons.search,
            iconColor: Pallet.black,
            controller: _searchController,
            hint: "Search title or subtitle...",
            keyboardType: TextInputType.text,
            onChanged: _newsProvider.onSearch,
          ) : TextView(text: appName, textStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Pallet.black, fontWeight: FontWeight.w600),),
      actions: [
        !_searching ? IconButton(
            onPressed: (){
              _searching = true;
              if (mounted){
                setState(() {});
              }
            },
            icon: const Icon(Icons.search, color: Pallet.black,)) : const SizedBox(),
      ],

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextView(text: newsSubtitle, textAlign: TextAlign.start, textStyle: GoogleFonts.poppins(fontSize: 20.sp, color: Pallet.blue, fontWeight: FontWeight.w600),),
          ),

          SizedBox(height: 16.h,),

          Consumer<NewsProvider>(builder: (context, provider, child) {
            _newsSearchList = provider.newsSearchList;
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
                  child: !_response.status ?
                  EmptyScreen(
                    icon: AppAssets.error,
                    title: _response.message,
                    onRefresh: (){
                      _onRefresh();
                    },
                  ) :
                  _newsSearchList.isNotEmpty ?
                  ListView.separated(
                    itemCount: _newsSearchList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Divider(height: index == (_newsSearchList.length - 1) ? 0 : 1),
                      );
                    },
                    itemBuilder: (BuildContext context, int index){
                      NewsModel newsModel = _newsSearchList[index];
                      return Slidable(
                        // Specify a key if the Slidable is dismissible.
                        key: ValueKey(newsModel.id),

                        // The end action pane is the one at the right or the bottom side.
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (itemContext){
                                provider.addBookMark(newsModel);
                              },
                              backgroundColor: Pallet.green,
                              foregroundColor: Pallet.white,
                              icon: Icons.bookmark,
                              label: 'Bookmark',
                            ),
                            SlidableAction(
                              onPressed: (itemContext){
                                PageRouter.gotoWidget(UpdateNewsScreen(newsModel: newsModel,), context);
                              },
                              backgroundColor: Pallet.blue,
                              foregroundColor: Pallet.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (itemContext){
                                AppDialog.showConfirmationDialog(context, title: "Delete post", message: "Are you sure you want to delete this post?", onContinue: () async {
                                  PageRouter.goBack(context);
                                  provider.deleteNews(context: context, id: newsModel.id);
                                  provider.newsList.removeWhere((element)=> element.id == newsModel.id);
                                  provider.setNewsList(provider.newsList);
                                  AppFlushBar.showSuccess(context: context, message: "Item deleted");
                                });
                              },
                              backgroundColor: Pallet.red,
                              foregroundColor: Pallet.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: NewsCard(newsModel: newsModel),
                      );
                    },
                  )
                      :
                  EmptyScreen(
                    title: 'Sorry, we can’t find any news at this time.',
                    onRefresh: (){
                      _onRefresh();
                    },
                  ),
                ),
              );
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          PageRouter.gotoWidget(AddNewsScreen(), context);
        },
        tooltip: 'Add news',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
