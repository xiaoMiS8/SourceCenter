//
//  CSNetAccessor.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CSNetAccessor.h"
#import "AFNetworking.h"
#import "ResultAnalyzer.h"
@implementation CSNetAccessor
//发送一个post异步请求
+ (void)sendPostAsyncObjectFormUrl:(NSString *)urlStr
                    parameters:(id)parameters
                   connectFlag:(NSString *)flag
                      finished:(FinishedBlock)finished {
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager POST:URLString
       parameters:parameters
          success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers |
                                                                        NSJSONReadingMutableLeaves |
                                                                        NSJSONReadingAllowFragments
                                                                  error:nil];
          DLog(@"returnStr----%@",jsonString);
        ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                        connecteFlag:flag];
        finished(Enum_SUCCESS, returnObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(Enum_FAIL, error);
        DLog(@"error---%@",error);
    }];

    
}

+ (void)sendGetAsyncObjectFormUrl:(NSString *)urlStr
                       parameters:(id)parameters
                      connectFlag:(NSString *)flag
                         finished:(FinishedBlock)finished {
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers |
                                 NSJSONReadingMutableLeaves |
                                 NSJSONReadingAllowFragments
                                                                  error:nil];
        DLog(@"returnStr----%@",jsonString);
        ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                        connecteFlag:flag];
        finished(Enum_SUCCESS, returnObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(Enum_FAIL, error);
        DLog(@"error---%@",error);
    }];
    
}

    //发送一个post异步请求
+ (void)sendPostAsyncObjectFormUrl:(NSString *)urlStr
                        parameters:(id)parameters
                       connectClass:(Class)Class
                          finished:(FinishedBlock)finished {
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager POST:URLString
       parameters:parameters
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
              NSString *jsonString = [[NSString alloc] initWithData:data
                                                           encoding:NSUTF8StringEncoding];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers |
                                       NSJSONReadingMutableLeaves |
                                       NSJSONReadingAllowFragments
                                                                        error:nil];
              DLog(@"returnStr----%@",jsonString);
              ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                              connecteClass:Class];
              finished(Enum_SUCCESS, returnObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              finished(Enum_FAIL, error);
              DLog(@"error---%@",error);
          }];
    
    
}

+ (void)sendGetAsyncObjectFormUrl:(NSString *)urlStr
                       parameters:(id)parameters
                      connectClass:(Class)Class
                         finished:(FinishedBlock)finished {
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers |
                                 NSJSONReadingMutableLeaves |
                                 NSJSONReadingAllowFragments
                                                                  error:nil];
        DLog(@"returnStr----%@",jsonString);
        ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                        connecteClass:Class];
        finished(Enum_SUCCESS, returnObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(Enum_FAIL, error);
        DLog(@"error---%@",error);
    }];
    
}

+ (void)sendPostAsyncObjectFormExtraUrl:(NSString *)urlStr
                             parameters:(id)parameters
                            connectFlag:(NSString *)flag
                               finished:(FinishedBlock)finished{
    NSString *URLString = urlStr;
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager POST:URLString
       parameters:parameters
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
              NSString *jsonString = [[NSString alloc] initWithData:data
                                                           encoding:NSUTF8StringEncoding];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers |
                                       NSJSONReadingMutableLeaves |
                                       NSJSONReadingAllowFragments
                                                                        error:nil];
              DLog(@"returnStr----%@",jsonString);
              ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                              connecteFlag:flag];
              finished(Enum_SUCCESS, returnObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              finished(Enum_FAIL, error);
              DLog(@"error---%@",error);
          }];
}

+(void)httpRequestUploadFormUrl:(NSString *)urlStr
                      formDatas:(NSData *)formDatas
                     parameters:(NSDictionary *)parameters
                    connectFlag:(NSString *)flag
                       finished:(FinishedBlock)finished{
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    DLog(@"url:---%@,参数:----%@",URLString,parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *name=[NSString stringWithFormat:@"%@.png",[Tool getNowTime]];
        [formData appendPartWithFileData:formDatas name:@"UploadFile" fileName:name mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data
                                                     encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers |
                                 NSJSONReadingMutableLeaves |
                                 NSJSONReadingAllowFragments
                                                                  error:nil];
        DLog(@"returnStr----%@",jsonString);
        ResponseObject *returnObject = [ResultAnalyzer analyseResult:jsonDic
                                                        connecteFlag:flag];
        finished(Enum_SUCCESS, returnObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        finished(Enum_FAIL, error);
        DLog(@"error---%@",error);
    }];
}
@end
