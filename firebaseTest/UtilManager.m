//
//  UtilManager.m
//  GoSkinCare
//
//  Created by Luokey on 10/9/15.
//  Copyright © 2015 Luokey. All rights reserved.
//

#import "UtilManager.h"

#define SecondsInAMin                       60
#define MinsInAnHour                        60
#define HoursInADay                         24
#define DaysInAMonth                        30
#define MonthsInAYear                       12

@implementation UtilManager

+ (UtilManager*)sharedManager {
    
    static UtilManager* _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

+ (BOOL)validateEmail:(NSString*)email {
    
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (NSString*)validateString:(NSString*)string {
    
    if (string == nil || [string isKindOfClass:[NSNull class]])
        return @"";
    
    return string;
}

+ (NSDate*)convertToGMT:(NSDate*)sourceDate {
    
    NSTimeZone* currentTimeZone = [NSTimeZone localTimeZone];
    
    NSTimeInterval gmtInterval = [currentTimeZone secondsFromGMTForDate:sourceDate];
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:sourceDate];
    
    return destinationDate;
}

+ (NSDate*)dateFromString:(NSString*)strDate inFormat:(NSString*)format {
    
    if (!strDate || strDate.length < 1)
        return nil;
    
    if ([strDate isEqualToString:@"0000-00-00"])
        return nil;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:format];
    
    NSDate* date = [formatter dateFromString:strDate];
    
    return date;
}

+ (NSString*)dateStringFromDate:(NSDate*)date inFormat:(NSString*)format {
    
    if (!date)
        return @"";
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSString* strDate = [dateFormatter stringFromDate:date];
    if (!strDate)
        strDate = @"";
    
    return strDate;
}

+ (NSString*)dateStringFromDate:(NSDate*)date inMediumFormat:(NSString*)format {
    
    if (!date)
        return @"";
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSString* strDate = [dateFormatter stringFromDate:date];
    if (!strDate)
        strDate = @"";
    
    return strDate;
}

+ (NSString*)dateStringForChatListFromDate:(NSDate*)date {
    
    NSString* strDate = @"";
    
    if (!date)
        return @"";
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeInterval duration = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
    if (duration < 60 * 60 * 24) {
        [dateFormatter setDateFormat:@"hh:mm a"];
        strDate = [dateFormatter stringFromDate:date];
    }
    else {
        [dateFormatter setDateFormat:@"MMM dd"];
        strDate = [dateFormatter stringFromDate:date];
    }
    
    return strDate;
}

+ (NSString*)dateStringForChatListFromDateString:(NSString*)strDate {
    
    if (!strDate)
        return @"";
    strDate = [strDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [dateFormatter dateFromString:strDate];
    if (date)
        return [[self class] dateStringForChatListFromDate:date];
    
    return @"";
}

+ (NSString*)dateStringForChatListFromTimeInterval:(NSNumber*)timeInterval {
    
    NSTimeInterval interval = [timeInterval doubleValue] / 1000.f;
    
    //    NSLog(@"\n%.0f\n%.0f", [[NSDate date] timeIntervalSince1970], [[NSDate date] timeIntervalSinceNow]);
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    if (date)
        return [[self class] dateStringForChatListFromDate:date];
    
    return @"";
}

+ (NSString*)dateStringForChatMessageFromDate:(NSDate*)date {
    
    NSString* strDate = @"";
    
    if (!date)
        return @"";
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeInterval duration = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
    if (duration < 60 * 60 * 24 * 7) {
        [dateFormatter setDateFormat:@"EEEE"];
        NSString* weekday = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSString* time = [dateFormatter stringFromDate:date];
        
        strDate = [NSString stringWithFormat:@"%@ %@", weekday, time];
    }
    else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
        strDate = [dateFormatter stringFromDate:date];
    }
    
    return strDate;
}

+ (NSString*)dateStringForChatMessageFromDateString:(NSString*)strDate inFormat:(NSString*)format {
    
    if (!strDate)
        return @"";
    strDate = [strDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate* date = [dateFormatter dateFromString:strDate];
    if (date)
        return [[self class] dateStringForChatMessageFromDate:date];
    
    return @"";
}

+ (NSDate*)dateForChatMessageFromGMTDateString:(NSString*)strDate inFormat:(NSString*)format {
    
    if (!strDate)
        return nil;
    
    strDate = [strDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate* date = [dateFormatter dateFromString:strDate];
    date = [[self class] convertToGMT:date];
    
    return date;
}

+ (NSString*)dateStringForChatMessageFromTimeInterval:(NSNumber*)timeInterval {
    
    NSTimeInterval interval = [timeInterval doubleValue] / 1000.f;
    
    //    NSLog(@"\n%.0f\n%.0f", [[NSDate date] timeIntervalSince1970], [[NSDate date] timeIntervalSinceNow]);
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    if (date)
        return [[self class] dateStringForChatMessageFromDate:date];
    
    return @"";
}

+ (NSString*)getDurationFromDateTime:(NSString*)strDateTime {
    if (!strDateTime || strDateTime.length < 1)
        return @"";
    
    NSDate* startDateTime = [[self class] dateFromString:strDateTime inFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (!startDateTime)
        return @"";
    
    NSTimeInterval timeIntervalOfStartDate = [startDateTime timeIntervalSince1970];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] - timeIntervalOfStartDate;
    
    int mins = timeInterval / SecondsInAMin;
    if (mins < 1)
        return [NSString stringWithFormat:@"%.0f seconds", timeInterval];
    
    int hours = mins / MinsInAnHour;
    if (hours < 1) {
        if (mins == 1)
            return [NSString stringWithFormat:@"1 min"];
        else
            return [NSString stringWithFormat:@"%d mins", mins];
    }
    
    int days = hours / HoursInADay;
    if (days < 1) {
        if (hours == 1)
            return [NSString stringWithFormat:@"1 hour"];
        else
            return [NSString stringWithFormat:@"%d hours", hours];
    }
    
    int months = days / DaysInAMonth;
    if (months < 1) {
        if (days == 1)
            return [NSString stringWithFormat:@"1 day"];
        else
            return [NSString stringWithFormat:@"%d days", days];
    }
    
    int years = months / MonthsInAYear;
    if (years < 1) {
        if (months == 1)
            return [NSString stringWithFormat:@"1 day"];
        else
            return [NSString stringWithFormat:@"%d days", months];
    }
    
    if (years == 1)
        return [NSString stringWithFormat:@"1 year"];
    else
        return [NSString stringWithFormat:@"%d years", years];
    
    return @"";
}

+ (void)trackingEvents:(NSDictionary*)eventsDict {
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker send:eventsDict];
    
    //    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"       // Event category (required)
    //                                                          action:@"button_press"    // Event action (required)
    //                                                           label:@"play"            // Event label
    //                                                           value:nil] build]];      // Event value
}


+ (void)trackingScreenView:(NSString*)screenName {
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker set:kGAIScreenName value:screenName];
//    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"page visit"          // Event category (required)
//                                                          action:@"visit"               // Event action (required)
//                                                           label:screenName             // Event label
//                                                           value:nil] build]];          // Event value
}


@end
