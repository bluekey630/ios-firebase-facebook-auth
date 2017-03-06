//
//  UtilManager.h
//  GoSkinCare
//
//  Created by Luokey on 10/9/15.
//  Copyright © 2015 Luokey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilManager : NSObject

+ (UtilManager*)sharedManager;

+ (BOOL)validateEmail:(NSString*)email;

+ (NSString*)validateString:(NSString*)string;

+ (NSDate*)dateFromString:(NSString*)strDate inFormat:(NSString*)format;

+ (NSString*)dateStringFromDate:(NSDate*)date inFormat:(NSString*)format;

+ (NSString*)dateStringFromDate:(NSDate*)date inMediumFormat:(NSString*)format;

+ (NSString*)dateStringForChatListFromDate:(NSDate*)date;

+ (NSString*)dateStringForChatListFromDateString:(NSString*)strDate;

+ (NSString*)dateStringForChatListFromTimeInterval:(NSNumber*)timeInterval;

+ (NSString*)dateStringForChatMessageFromDate:(NSDate*)date;

+ (NSString*)dateStringForChatMessageFromDateString:(NSString*)strDate inFormat:(NSString*)format;

+ (NSDate*)dateForChatMessageFromGMTDateString:(NSString*)strDate inFormat:(NSString*)format;

+ (NSString*)dateStringForChatMessageFromTimeInterval:(NSNumber*)timeInterval;

+ (NSString*)getDurationFromDateTime:(NSString*)strDateTime;

+ (void)trackingEvents:(NSDictionary*)eventsDict;

+ (void)trackingScreenView:(NSString*)screenName;

@end