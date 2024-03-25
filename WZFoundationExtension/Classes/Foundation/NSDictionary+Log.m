//
//  NSDictionary+Log.m
//  Created by ___ORGANIZATIONNAME___ on 2024/3/25
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    
     NSMutableString *string = [NSMutableString string];

     // 开头有个{
     [string appendString:@"{\n"];

     // 遍历所有的键值对
     [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
         [string appendFormat:@"\t%@", key];
         [string appendString:@" : "];
         [string appendFormat:@"%@,\n", obj];
     }];

     // 结尾有个}
     [string appendString:@"}"];

     // 查找最后一个逗号
     NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
     if (range.location != NSNotFound)
     [string deleteCharactersInRange:range];
    
    @try {
        string = [[NSMutableString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        string = (NSMutableString *)[string stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"]; // 处理\/转义字符
        } @catch (NSException *exception) {
        } @finally {
        }

     return string;
}

- (void)debugLog{
    WZLog(@"%@", self)
}

@end
