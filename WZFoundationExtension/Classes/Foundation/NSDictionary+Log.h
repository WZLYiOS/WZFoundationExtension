//
//  NSDictionary+Log.h
//  Created by ___ORGANIZATIONNAME___ on 2024/3/25
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

#import <Foundation/Foundation.h>

// 打印输出
#ifdef RELEASE
#define WZLog(format, ...)
#else
#define WZLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];\
[dateFormatter setTimeZone:timeZone];\
[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];\
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"【TIME:%s】【FILE:%s-- LINE:%d】FUNCTION:%s\n%s\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__PRETTY_FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#endif
NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Log)
// 打印数据
- (void)debugLog;

@end

NS_ASSUME_NONNULL_END
