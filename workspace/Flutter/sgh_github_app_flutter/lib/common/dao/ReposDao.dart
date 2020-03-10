import 'package:sgh_github_app_flutter/common/dao/DaoResult.dart';
import 'package:sgh_github_app_flutter/common/net/Address.dart';
import 'package:sgh_github_app_flutter/common/net/trending/GithubTrending.dart';
import 'package:sgh_github_app_flutter/widget/ReposItem.dart';

/**
 * Created by sengoln huang
 * Date: 2020-03-10
 */

class ReposDao {
  /**
   * 趋势数据
   * @param page 分页，趋势数据其实没有分页
   * @param since 数据时长，    本日，本周，本月
   * @param languageType 语言
   */
  static getTrendDao({since = 'daily', languageType, page = 0}) async {
    String localLanguage = (languageType != null) ? languageType : "*";
    String url = Address.trending(since, localLanguage);
    var res = await new GitHubTrending().fetchTrending(url);
    if (res != null && res.result && res.data.length > 0) {
      List<ReposViewModel> list = new List();
      var data = res.data;
      if (data == null || data .length == 0) {
        return new DataResult(null, false);
      }
      for (var i = 0; i < data.length; i++) {
        TrendingRepoMode model = data[i];
        ReposViewModel reposViewModel = new ReposViewModel();
        reposViewModel.ownerName = model.name;
        reposViewModel.ownerPic = model.contributors[0];
        reposViewModel.repositoryName = model.reposName;
        reposViewModel.repositoryStar = model.starCount;
        reposViewModel.repositoryFork = model.forkCount;
        reposViewModel.repositoryWatch = model.meta;
        reposViewModel.repositoryType = model.language;
        reposViewModel.repositoryDes = model.description;
      }
      return new DataResult(list, true);
    } else {
      return new DataResult(null, false);
    }
  }
}