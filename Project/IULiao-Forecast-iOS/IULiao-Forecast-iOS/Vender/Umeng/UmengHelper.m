//
//  UmengHelper.m
//  HuaXia
//
//  Created by tianshui on 16/1/14.
//  Copyright © 2016年 fenlanmed. All rights reserved.
//

#import "UmengHelper.h"

@implementation UmengHelper
+(void)printOpenUDID;
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    //复制全部代码
    
    Class cls = NSClassFromString(@"UMANUtil");

    SEL deviceIDSelector = NSSelectorFromString(@"openUDIDString");
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
#pragma clang diagnostic pop
}
@end
