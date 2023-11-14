import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/helpers/helpers_functions.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/strings.dart';
import '../core/utils/text_styles.dart';

class UCPSScaffold extends HookConsumerWidget {
  final Widget child;
  final Widget? titleWidget;
  final String? title;
  final FloatingActionButton? floatingActionButton;
  final TextStyle? titleStyle;
  final bool? centerTitle;
  final EdgeInsets? padding;
  final List<Widget>? actions;
  final bool showSearchBtn;
  final bool showLeadingBtn;
  final bool? showAppBarDivider;

  final GlobalKey<ScaffoldState>? scaffoldKey;

  const UCPSScaffold({super.key,
    this.titleStyle,
    this.titleWidget,
    this.padding,
    this.floatingActionButton,
    this.showAppBarDivider = false,
    required this.child,
    this.showLeadingBtn = true,
    this.title,
    this.showSearchBtn = false,
    this.scaffoldKey,
    this.centerTitle = false,
    this.actions
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: AppBar(
        leading: (){
          if(!showLeadingBtn) return const SizedBox();

          return InkWell(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_back_ios),
              ));
        }(),
        leadingWidth: (){
          if(!showLeadingBtn) {
            return 0.0;
          }
          return 60.0;
        }(),
        title: (){
          if(titleWidget != null) return titleWidget;

          String appTitle = title ?? AppStrings.name;
          TextStyle style = titleStyle ??
              Styles.w600(
                color: UCPSColors.black,
              );

          return Text(
            appTitle,
            style: style,
          );
        }(),
        actions: () {
          List<Widget> mActions = [];

          List<Widget> fixedActions = [
            // if(showSearchBtn)
            //   IconButton(onPressed: () => Navigator.of(context).pushNamed(Routes.search), icon: const Icon(Icons.search)),

          ];

          if (actions != null) {
            mActions.addAll(actions!);
          }


          mActions.addAll(fixedActions);

          return mActions;
        }(),
        centerTitle: centerTitle ?? true,
      ),
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          if(showAppBarDivider != null && showAppBarDivider!)
            Container(height: 1.0, width: Helpers.width(context), color: Colors.grey.shade300,),
          Expanded(
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(Dimensions.big, 0.0, Dimensions.big, 0.0),
              child: child,
            ),
          ),
          Container(height: 1.0, width: Helpers.width(context), color: Colors.grey.shade300,),
        ],
      ),
    );
  }
}