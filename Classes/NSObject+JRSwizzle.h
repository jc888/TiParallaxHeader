//
//  NSObject+JRSwizzle.h
//  SpotifyListView
//
//  Created by James Chow on 11/04/2014.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JRSwizzle)

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;

@end
