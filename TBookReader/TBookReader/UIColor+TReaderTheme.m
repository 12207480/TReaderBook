//
//  UIColor+TReaderTheme.m
//  Examda
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "UIColor+TReaderTheme.h"
#import "TReaderManager.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kNightLightBgColor  RGB(47, 51, 61, 1)
#define kEyeshieldLightBgColor RGB(202, 227, 216, 1)
#define kNightDarkTextColor  RGB(205, 208, 211, 1)
#define kDarkTextColor      RGB(51, 51, 51, 1)

@implementation UIColor (TReaderTheme)

+ (UIColor *)whiteBgReaderThemeColor
{
    switch ([TReaderManager readerTheme]) {
        case TReaderThemeNight:
            return kNightLightBgColor;
        case TReaderThemeEyeshield:
            return kEyeshieldLightBgColor;
        default:
            return [UIColor whiteColor];
    }
}

+ (UIColor *)darkTextReaderThemeColor
{
    if ([TReaderManager readerTheme] == TReaderThemeNight) {
        return kNightDarkTextColor;
    }
    return kDarkTextColor;
}

@end
