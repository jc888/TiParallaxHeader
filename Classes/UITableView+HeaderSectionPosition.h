//
//  UITableView+HeaderSectionPosition.h
//  SpotifyListView
//
//  Created by James Chow on 11/04/2014.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (HeaderSectionPosition)

@property (nonatomic, assign) UIEdgeInsets headerViewInsets;

+ (void) swizzle;

@end
