# 52、MVVM架构演示2：使用Observable样例


[免费开放接口API](https://www.jianshu.com/p/e6f072839282)

## 三、一个使用 Observable 的 MVVM 样例
### 1，效果图

（1）当我们在表格上方的搜索框中输入文字时，会实时地去请求 `GitHub` 接口查询相匹配的资源库。

（2）数据返回后，将查询结果数量显示在导航栏标题上，同时把匹配度最高的资源条目显示显示在表格中（这个是 `GitHub` 接口限制，由于数据太多，可能不会一次全部都返回）。

（3）点击某个单元格，会弹出显示该资源的详细信息（全名和描述）

（4）删除搜索框的文字后，表格内容同步清空，导航栏标题变成显示“hangge.com”

### 2，准备工作
（1）首先我们在项目中配置好 `RxSwift`、`Alamofire`、`Moya`、`Result` 这几个库，具体步骤可以参考这篇文章：

* [Swift - RxSwift的使用详解49（结合Moya使用1：数据请求）](https://www.jianshu.com/p/510ad3b8d6d7)

（2）为了方便将结果映射成自定义对象，我们还需要引入 `ObjectMapper`、`Moya-ObjectMapper` 这两个第三方库。具体步骤可以参考我之前写的这篇文章：

* [Swift - RxSwift的使用详解50（结合Moya使用2：结果处理、模型转换）](https://www.jianshu.com/p/173915b943af)

### 3，样例代码

（1）我们先创建一个 `GitHubAPI.swift` 文件作为网络请求层，里面的内容如下：

1. 首先定义一个 `provider`，即请求发起对象。往后我们如果要发起网络请求就使用这个 `provider`。
2. 接着声明一个 `enum` 来对请求进行明确分类，这里我们只有一个枚举值表示查询资源。
3. 最后让这个 `enum` 实现 `TargetType` 协议，在这里面定义我们各个请求的 `url`、参数、`header` 等信息。
```swift
import Foundation
import Moya
import RxSwift
import RxCocoa

//初始化GitHub请求的provider
let GitHubProvider = MoyaProvider<GitHubAPI>()

/** 下面定义GitHub请求的endpoints（供provider使用）**/
//请求分类
public enum GitHubAPI {
    case repositories(String)  //查询资源库
}
//请求配置
extension GitHubAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    //请求任务事件（这里附带上参数）
    public var task: Task {
        print("发起请求")
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
}
```
（2）接着定义好相关模型：`GitHubModel.swift`（需要实现 `ObjectMapper` 的 `Mappable` 协议，并设置好成员对象与 `JSON` 属性的相互映射关系。）

```swift
import Foundation

import ObjectMapper
//包含查询返回的所有库模型
struct GitHubRepositories: Mappable {
    init?(map: Map) { }
    
    init() {
        print("init()")
        totalCount = 0
        incompleteResults = false
        items = []
    }
    
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }
    
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [GitHubRepository]!       //本次查询返回的所有仓库集合
    
}
//单个仓库模型
struct GitHubRepository: Mappable {
    var id: Int!
    var name: String!
    var fullName: String!
    var htmlUrl: String!
    var description: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        htmlUrl <- map["html_url"]
        description <- map["description"]
    }
}
```

（3）下面就是本文的重头戏了。我们创建一个 `ViewModel`，它的作用就是将用户各种输入行为，转换成输出状态。本样例中，不管输入还是输出都是 `Observable` 类型。
```swift
import Foundation

import RxSwift
import Result

class GitHubViewModel {
    /**** 输入部分 ***/
    //查询行为
    fileprivate let searchAction: Observable<String>
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Observable<GitHubRepositories>
    //查询结果里的资源列表
    let repositories: Observable<[GitHubRepository]>
    //清空结果动作
    let cleanResult: Observable<Void>
    //导航栏标题
    let navigationTitle: Observable<String>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction: Observable<String>) {
        self.searchAction = searchAction
        //生成查询结果序列
        self.searchResult = searchAction
            .filter { $0.isEmpty }   //如果输入为空则不发送请求了
            .flatMapLatest {
                GitHubProvider.rx.request(.repositories($0))
                .filterSuccessfulStatusCodes()
                .mapObject(GitHubRepositories.self)
                .asObservable()
                    .catchError({ (error) in
                        print("发生错误：",error.localizedDescription)
                        return Observable<GitHubRepositories>.empty()
                    })
            }.share(replay: 1)//让HTTP请求是被共享的
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter { $0.isEmpty }.map{ _ in Void() }
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        self.repositories = Observable.of(searchResult.map{ $0.items! }, cleanResult.map{ [] }).merge()
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Observable.of(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" })
            .merge()
        
    }
}
```
（4）最后我们视图控制器（`ViewController`）只需要调用 `ViewModel` 进行数据绑定就可以了。可以看到由于网络请求、数据处理等逻辑已经被剥离到 `ViewModel` 中，`VC` 这边的负担大大减轻了。




