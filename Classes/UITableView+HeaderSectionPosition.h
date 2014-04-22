//
//  UITableView+HeaderSectionPosition.h
//  Category to extend UITableView, which TiUIListView uses
//
//  Created by James Chow on 11/04/2014.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (HeaderSectionPosition)

@property (nonatomic, assign) UIEdgeInsets headerViewInsets;

+ (void) swizzle;

@end
