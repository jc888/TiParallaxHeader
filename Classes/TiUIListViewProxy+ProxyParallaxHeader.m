//
//  TiUIListViewProxy+ProxyParallaxHeader.m
//  TiParallaxHeader
//
//  Created by James Chow on 17/04/2014.
//
//

#import "TiUIListViewProxy+ProxyParallaxHeader.h"
#import "TiUIListView+ParallaxHeader.h"
#import "TiUIListViewProxy.h"
#import "TiProxy.h"
#import <objc/runtime.h>

@implementation TiUIListViewProxy (ProxyParallaxHeader)


-(void)setCurrentImage:(UIImage *)_currentImage
{
    objc_setAssociatedObject(self, @selector(currentImage), _currentImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};

-(UIImage*)currentImage
{
    return objc_getAssociatedObject(self, @selector(currentImage));
}

-(void)addParallaxWithView:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    
    TiViewProxy *headerView = nil;
    ENSURE_ARG_AT_INDEX(headerView,args,0,TiViewProxy);
    NSNumber *height = nil;
    
    ENSURE_ARG_AT_INDEX(height,args,1,NSNumber);
    
    TiUIListView *convert = (TiUIListView*) self.view;
    [convert addParallaxWithView:headerView withHeight:[height floatValue]];
}

-(void)addParallaxWithImage:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    
    NSString * url = nil;
    ENSURE_ARG_AT_INDEX(url,args,0,NSString);
    NSNumber * height = nil;
    ENSURE_ARG_AT_INDEX(height,args,1,NSNumber);
    
    TiUIListView *convert = (TiUIListView*) self.view;
    
    [convert addParallaxWithImage:url forHeight:[height floatValue]];
}

-(void)setSectionHeaderInset:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSNumber);
    
    CGFloat height = [(NSNumber*)args floatValue];
    
    TiUIListView *convert = (TiUIListView*) self.view;
    [convert setSectionHeaderInset:height];
}

-(void)setFadeoutOverHeight:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    
    ENSURE_SINGLE_ARG(args, NSNumber);

    TiUIListView *convert = (TiUIListView*) self.view;
    
    [convert setFadeoutOverHeight:(NSNumber*)args];
}

@end
