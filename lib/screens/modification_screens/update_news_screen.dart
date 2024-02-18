import 'package:blog/core/state_managers/news_provider.dart';
import 'package:blog/core/utils/app_flushbar.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/core/widgets/custom_button.dart';
import 'package:blog/core/widgets/edit_form_widget.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/models/new_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateNewsScreen extends StatefulWidget {
  NewsModel newsModel;
  UpdateNewsScreen({super.key, required this.newsModel});

  @override
  State<UpdateNewsScreen> createState() => _UpdateNewsScreenState();
}

class _UpdateNewsScreenState extends State<UpdateNewsScreen> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _subtitleController = TextEditingController();

  TextEditingController _bodyController = TextEditingController();

  bool _hasEdited (){
    return _titleController.text != widget.newsModel.title ||
        _subtitleController.text != widget.newsModel.subtitle ||
      _bodyController.text != widget.newsModel.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.newsModel.title;
    _subtitleController.text = widget.newsModel.subtitle;
    _bodyController.text = widget.newsModel.body;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      hasAppBar: true,
      hasPadding: true,
      titleWidget: TextView(text: appName, textStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Pallet.black, fontWeight: FontWeight.w600),),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [

                SizedBox(height: 24.h,),

                TextView(text: updateNews, textAlign: TextAlign.start, textStyle: GoogleFonts.poppins(fontSize: 20.sp, color: Pallet.blue, fontWeight: FontWeight.w600),),

                SizedBox(height: 24.h,),

                EditFormField(
                  label: "Title",
                  hint: "Enter title here",
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  onChanged: (text) {
                    if (mounted) setState(() {});
                  },
                ),

                SizedBox(height: 24.h,),

                EditFormField(
                  label: "Subtitle",
                  hint: "Enter subtitle here",
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 3,
                  controller: _subtitleController,
                  onChanged: (text) {
                    if (mounted) setState(() {});
                  },
                ),

                SizedBox(height: 24.h,),

                EditFormField(
                  label: "Body",
                  hint: "Enter body here",
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 6,
                  controller: _bodyController,
                  onChanged: (text) {
                    if (mounted) setState(() {});
                  },
                ),

                SizedBox(height: 24.h,),

              ],
            ),
          ),

          Consumer<NewsProvider>(
              builder: (context, provider, child) {
                return CustomButtonWidget(
                  buttonText: 'Update post',
                  height: 56.h,
                  width: 1.sw,
                  disabled: provider.isUpdatingNews || !_hasEdited(),
                  loading: provider.isUpdatingNews,
                  onTap: () async {
                    if(_titleController.text.isEmpty) AppFlushBar.showError(context: context, message: "Title is required");
                    if(_subtitleController.text.isEmpty) AppFlushBar.showError(context: context, message: "Subtitle is required");
                    if(_bodyController.text.isEmpty) AppFlushBar.showError(context: context, message: "Body is required");

                    var result = await provider.updateNews(context: context, id: widget.newsModel.id, newsModel: NewsModel(title: _titleController.text, subtitle: _subtitleController.text, body: _bodyController.text));
                    if(!result.status) return;

                    PageRouter.goBack(context);
                  },
                );
              }
          ),

          SizedBox(height: 24.h,),

        ],
      ),
    );
  }
}
