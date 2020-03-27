//
//  SGHNSURLSessionViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 * 来自：
 1、[iOS NSURLConnection使用详解](https://www.cnblogs.com/sunfuyou/p/6838593.html)
 [iOS网络1——NSURLConnection使用详解](https://www.cnblogs.com/mddblog/p/5134783.html)
 2、[iOS网络之NSURLSession使用详解](https://www.cnblogs.com/lxlx1798/articles/9774404.html)
 */
typedef enum {
    SGHRequestMethodGET,
    SGHRequestMethodPOST
}SGHRequestMethod;

#import "SGHNSURLSessionViewController.h"

@interface SGHNSURLSessionViewController ()

@end

//本例子来自：http://www.jianshu.com/p/2bd9cb569fc2?utm_campaign=haruki&utm_content=note&utm_medium=reader_share&utm_source=qq
@implementation SGHNSURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 一般数据请求
    [self NSURLSessionTest];
    
    // 文件下载
    //    [self NSURLSessionDownloadTaskTest];
    
    // 文件上传，表单形式
    //    [self NSURLSessionUploadTaskTest];
    
    // 文件上传，二进制流
    //    [self NSURLSessionBinaryUploadTaskTest];
    
    
    
#if 1
    //----------------------------
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // delegateQueue：请求完成回调函数和代理函数的运行线程，如果为nil则系统自动创建一个串行队列，不影响sessionTask的运行线程
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //设置一些网络属性:------
    config.HTTPAdditionalHeaders = @{
                                     @"Accept": @"application/json",
                                     @"Accept-Language": @"en",
                                     @"Authorization": @"authString",
                                     @"User-Agent": @"userAgentString"
                                     };
    config.networkServiceType = NSURLNetworkServiceTypeVoice;//设置网络服务类型
    config.allowsCellularAccess = YES;  //允许蜂窝访问
    config.timeoutIntervalForRequest = 5;   //请求的超时时长
    config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad; //缓存策略
//    config.HTTPCookieAcceptPolicy
//    config.HTTPCookieStorage
//    config.HTTPShouldSetCookies
//    config.protocolClasses
#endif
    
}


/// config1
- (void)sessionConfiguration {
    //    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // delegateQueue：请求完成回调函数和代理函数的运行线程，如果为nil则系统自动创建一个串行队列
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
}
#pragma mark - 文件上传
/// 文件上传
- (void)NSURLSessionUploadTaskTest {
    // 1.创建url  采用Apache本地服务器
    NSString *urlString = @"http://localhost/upload.php";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"boundary"];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    // 3.拼接表单，大小受MAX_FILE_SIZE限制(2MB)  FilePath:要上传的本地文件路径  formName:表单控件名称，应于服务器一致
    NSData* data = [self getHttpBodyWithFilePath:@"/Users/huangaengoln/Desktop/1785352-6f528bf3cb726543.png" formName:@"file" reName:@"newName.png"];
    request.HTTPBody = data;
    // 根据需要是否提供，非必须,如果不提供，session会自动计算
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    
    // 4.1 使用dataTask
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
        
    }] resume];
#if 0
    // 4.2 开始上传 使用uploadTask   fromData:可有可无，会被忽略
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:nil     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
#endif
}

/// filePath:要上传的文件路径   formName：表单控件名称  reName：上传后文件名
- (NSData *)getHttpBodyWithFilePath:(NSString *)filePath formName:(NSString *)formName reName:(NSString *)reName
{
    NSMutableData *data = [NSMutableData data];
    NSURLResponse *response = [self getLocalFileResponse:filePath];
    // 文件类型：MIMEType  文件的大小：expectedContentLength  文件名字：suggestedFilename
    NSString *fileType = response.MIMEType;
    
    if (reName == nil) {
        reName = response.suggestedFilename;
    }
    
    // 表单拼接
    NSMutableString *headerStrM =[NSMutableString string];
    [headerStrM appendFormat:@"--%@\r\n",@"boundary"];
    // name：表单控件名称  filename：上传文件名
    [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",formName,reName];
    [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n",fileType];
    [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 文件内容
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [data appendData:fileData];
    
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",@"boundary"];
    [data appendData:[footerStrM  dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"dataStr=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    return data;
}
/// 获取响应，主要是文件类型和文件名
- (NSURLResponse *)getLocalFileResponse:(NSString *)urlString
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    // 本地文件请求
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSURLResponse *localResponse = nil;
    // 使用信号量实现NSURLSession同步请求
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        localResponse = response;
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return  localResponse;
}
/// 以流的方式上传，大小理论上不受限制，但应注意时间
- (void) NSURLSessionBinaryUploadTaskTest {
    // 1.创建url  采用Apache本地服务器
    NSString *urlString = @"http://localhost/upload.php";
    //    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    // 3.开始上传   request的body data将被忽略，而由fromData提供
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:[NSData dataWithContentsOfFile:@"/Users/huangaengoln/Desktop/1785352-6f528bf3cb726543.jpg"]     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
}
#pragma mark - 文件下载
/// 文件下载
- (void)NSURLSessionDownloadTaskTest {
    // 1.创建url
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/git命令图.jpg"];  //"
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 3.创建会话，采用苹果提供全局的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.创建任务
    NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下!
            // 只会临时保存，因此需要将其另存
            NSLog(@"location:%@",location.path);
            
            // 采用模拟器测试，为了方便将其下载到Mac桌面
            //            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *filePath = @"/Users/huangaengoln/Desktop/git命令图.jpg";
            NSError *fileError;
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError];
            if (fileError == nil) {
                NSLog(@"file save success");
            } else {
                NSLog(@"file save error: %@",fileError);
            }
        } else {
            NSLog(@"download error:%@",error);
        }
    }];
    
    // 5.开启任务
    [downloadTask resume];
}
#pragma mark - 网络请求数据
/// 向网络请求数据
- (void)NSURLSessionTest {
    // 1.创建url
    // 请求一个网页
    //===============验证请求超时时间的准确性 hsj-16-04-25
    NSLog(@"下载开始");
    NSString *urlString = @"http://map.onegreen.net/%E4%B8%AD%E5%9B%BD%E6%94%BF%E5%8C%BA2500.jpg";//@"http://www.cnblogs.com/mddblog/p/5215453.html";
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSLog(@"data = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            // 网络访问失败
            NSLog(@"error = %@",error);
        }
        NSLog(@"下载完成");
    }];
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)connectionRequestWithMethod:(SGHRequestMethod)method   URLString:(NSString *)URLString parameters:(NSDictionary *)dict success:(void (^)(id JSON))success fail:(void (^)(NSError *error))fail {
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 请求方式，默认为GET
    if (method == SGHRequestMethodPOST) {
        request.HTTPMethod = @"POST";
    }
    // 根据需要设置
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    // 2.设置请求头 Content-Type  返回格式
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3.设置请求体 NSDictionary --> NSData
    if (dict != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = data;
    }
    // 4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ((data != nil) && (connectionError == nil)) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (success) {
                success(jsonDict);
            }
        } else {
            if (fail) {
                fail(connectionError);
            }
        }
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
