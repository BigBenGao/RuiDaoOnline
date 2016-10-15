//
//  MYAFNetWork.m
//  AF
//
//  Created by gao on 16/9/28.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "MYAFNetWork.h"

@implementation MYAFNetWork

+(void)GET:(NSString *)URLString parameters:(id)parameters progress:(RequestProgress)downloadProgress success:(RequestSuccess)success failure:(RequestFail)failure
{
    [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+(void)POST:(NSString *)URLString parameters:(id)parameters progress:(RequestProgress)uploadProgress success:(RequestSuccess)success failure:(RequestFail)failure
{
    [[AFHTTPSessionManager manager] POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

@end
