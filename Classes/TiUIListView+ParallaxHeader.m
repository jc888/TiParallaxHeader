//
//  TiUIListView+ParallaxHeader.m
//  TiParallaxHeader
//
//  Created by James Chow on 17/04/2014.
//
//

#import "TiUIListView+ParallaxHeader.h"
#import "TiUtils.h"
#import "TiUIViewProxy.h"
#import "UIScrollView+APParallaxHeader.h"
#import "UITableView+HeaderSectionPosition.h"
#import "NSObject+JRSwizzle.h"
#import <objc/runtime.h>

@implementation TiUIListView (ParallaxHeader)

+ (void) swizzle
{
    NSError *error = nil;
	[TiUIListView jr_swizzleMethod:@selector(tableView:viewForHeaderInSection:) withMethod:@selector(swizzle_tableView:viewForHeaderInSection:) error:&error];
    
    if (error != nil) {
        NSLog(@"[ERROR] %@", [error localizedDescription]);
    }
}


-(void)addParallaxWithView:(TiViewProxy *)headerview withHeight: (CGFloat) height
{
    self.currentHeaderView = headerview;
    
    [self.tableView addParallaxWithView: headerview.view andHeight:height];
}

-(void)addParallaxWithImage:(UIImage *)image forHeight:(CGFloat)height
{
    [self.tableView addParallaxWithImage:image andHeight:height];
}

-(void)setSectionHeaderInset:(CGFloat) height
{
    [self.tableView setHeaderViewInsets:UIEdgeInsetsMake(height, 0, 0, 0)];
}

-(void)setCurrentImage:(UIImage *)_currentImage
{
    objc_setAssociatedObject(self, @selector(currentImage), _currentImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};

-(UIImage*)currentImage
{
    return objc_getAssociatedObject(self, @selector(currentImage));
}

-(void)setCurrentHeaderView:(TiViewProxy *)_currentHeaderView
{
    objc_setAssociatedObject(self, @selector(currentHeaderView), _currentHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};

-(TiViewProxy*)currentHeaderView
{
    return objc_getAssociatedObject(self, @selector(currentHeaderView));
}

- (UIView *)swizzle_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    [TiUIListView jr_swizzleMethod:@selector(tableView:viewForHeaderInSection:) withMethod:@selector(swizzle_tableView:viewForHeaderInSection:) error:nil];
    
    //using a plain UI view we need to use tags
    //http://stackoverflow.com/questions/20188049/uitableview-headerviewforsection-returns-null
    
    UIView * sectionHeView = [self tableView:tableView viewForHeaderInSection:section];
    [sectionHeView setTag:100+section];
    
    [TiUIListView jr_swizzleMethod:@selector(tableView:viewForHeaderInSection:) withMethod:@selector(swizzle_tableView:viewForHeaderInSection:) error:nil];
    
    return sectionHeView;
}

@end
