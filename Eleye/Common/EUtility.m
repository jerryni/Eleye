//
//  EUtility.m
//  Eleye
//
//  Created by sheldon on 15/4/22.
//  Copyright (c) 2015年 wheelab. All rights reserved.
//

#import "EUtility.h"
#include <sys/sysctl.h>
#include <sys/utsname.h>

@implementation EUtility

+ (void)addlineOnView:(UIView *)view position:(EViewPosition)position insert:(NSInteger)insert
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.borderColor = RGBCOLOR(217, 217, 217).CGColor;
    lineLayer.borderWidth = .5;
    
    switch (position) {
        case EViewPositionTop: {
            lineLayer.frame = CGRectMake(insert, 0, CGRectGetWidth(view.frame) - insert * 2, 1);
            break;
        } 
        case EViewPositionLeft: {
            lineLayer.frame = CGRectMake(0, 0, 1, CGRectGetHeight(view.frame));
            break;
        }
        case EViewPositionRight: {
            lineLayer.frame = CGRectMake(CGRectGetWidth(view.frame) - 1, 0, 1, CGRectGetHeight(view.frame));
            break;
        }
        case EViewPositionBottom: {
            lineLayer.frame = CGRectMake(insert, CGRectGetHeight(view.frame) - 1, CGRectGetWidth(view.frame) - insert * 2, 1);
            break;
        }
    }
    
    [view.layer addSublayer:lineLayer];
}

+ (void)addlineOnView:(UIView *)view position:(EViewPosition)position
{
    [[self class] addlineOnView:view position:position insert:0];
}

+ (void)saveContentToFileWithContent:(NSString *)content guid:(NSString *)guid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *notePath = [libraryDirectory stringByAppendingPathComponent:@"note"];
    BOOL isPathExist = [[NSFileManager defaultManager] fileExistsAtPath:notePath];
    if (isPathExist) {
        
    } else {
        [[NSFileManager defaultManager] createDirectoryAtPath:notePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [notePath stringByAppendingFormat:@"/note%@.html", guid];
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSAttributedString *)stringFromLocalPathWithGuid:(NSString *)guid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *notePath = [[libraryDirectory stringByAppendingPathComponent:@"note"] stringByAppendingFormat:@"/note%@.html", guid];
    NSString *content = [NSString stringWithContentsOfFile:notePath encoding:NSUTF8StringEncoding error:nil];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return attributedString;
}

+ (NSString *)platformString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

@end