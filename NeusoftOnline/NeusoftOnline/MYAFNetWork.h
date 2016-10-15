//
//  MYAFNetWork.h
//  AF
//
//  Created by gao on 16/9/28.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

/**请求成功的block*/
typedef void(^RequestSuccess)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject);

/**请求进度的block*/
typedef void(^RequestProgress)(NSProgress * _Nonnull progress);
 
/**请求失败的block*/
typedef void(^RequestFail)(NSURLSessionDataTask * _Nullable resk, NSError * _Nonnull error);


@interface MYAFNetWork : NSObject

+ (void)GET:(NSString * _Nonnull)URLString parameters:(nullable id)parameters
                                    progress:(nullable RequestProgress)downloadProgress
                                     success:(nullable RequestSuccess)success
                                     failure:(nullable RequestFail)failure;

+ (void)POST:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable RequestProgress)uploadProgress
                                success:(nullable RequestSuccess)success
                                failure:(nullable RequestFail)failure;

@end
