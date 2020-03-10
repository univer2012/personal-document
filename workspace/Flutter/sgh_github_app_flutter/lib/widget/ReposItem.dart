import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';
import 'package:sgh_github_app_flutter/widget/GSYCardItem.dart';
import 'package:sgh_github_app_flutter/widget/GSYIconText.dart';

/**
 * Created by sengoln huang
 * Date: 2020-03-10
 */

class ReposItem extends StatelessWidget {
  final ReposViewModel reposViewModel;
  const ReposItem(this.reposViewModel) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new GSYCardItem(
        child: new FlatButton(
          onPressed: () => {}, 
          child: new Padding(
            padding: new EdgeInsets.only(left: 10.0, top: 10.0,right: 10.0,bottom: 10.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new ClipOval(
                      child: new FadeInImage.assetNetwork(
                        placeholder: 'static/images/logo.png', 
                        //预览图
                        fit: BoxFit.fitWidth,
                        image: reposViewModel.ownerPic,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.all(10.0)),
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(reposViewModel.repositoryName, style: GSYConstant.normalTextBold,),
                          new GSYIconText(
                            GSYIcons.REPOS_ITEM_USER,
                            reposViewModel.ownerName,
                            GSYConstant.subLightSmallText, 
                            Color(GSYColors.subLightTextColor), 
                            10.0, 
                            padding: 3.0
                          ),
                        ],
                      ),
                    ),
                    new Text(reposViewModel.repositoryType, style: GSYConstant.subSmallText),
                  ],
                ),
                new Container(
                  child: new Text(reposViewModel.repositoryDes, style: GSYConstant.subSmallText, maxLines: 3, overflow: TextOverflow.ellipsis),
                  margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                  alignment: Alignment.topLeft,
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Center(
                        child: new GSYIconText(
                          GSYIcons.REPOS_ITEM_STAR,
                          reposViewModel.repositoryStar,
                          GSYConstant.subLightSmallText,
                          Color(GSYColors.subTextColor),
                          15.0,
                          padding: 5.0,
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Center(
                        child: new GSYIconText(
                          GSYIcons.REPOS_ITEM_FORK,
                          reposViewModel.repositoryFork,
                          GSYConstant.subLightSmallText,
                          Color(GSYColors.subTextColor),
                          15.0,
                          padding: 5.0,
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 2,
                      child: new Center(
                        child: new GSYIconText(
                          GSYIcons.REPOS_ITEM_ISSUE,
                          reposViewModel.repositoryWatch,
                          GSYConstant.subLightSmallText,
                          Color(GSYColors.subTextColor),
                          15.0,
                          padding: 5.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReposViewModel {
  String ownerName;
  String ownerPic;
  String repositoryName;
  String repositoryStar;
  String repositoryFork;
  String repositoryWatch;
  String hideWatchIcon;
  String repositoryType = "";
  String repositoryDes;
}