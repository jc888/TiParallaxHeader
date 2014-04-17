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

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}

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
    
    TiViewProxy *headerView = nil;
    ENSURE_ARG_AT_INDEX(headerView,args,0,TiViewProxy);
    NSNumber *height = nil;
    
    ENSURE_ARG_AT_INDEX(height,args,1,NSNumber);
    
    TiUIListView *convert = (TiUIListView*) self.view;
    [convert addParallaxWithView:headerView withHeight:[height floatValue]];
}

-(void)addParallaxWithImage:(id)args
{
    NSString * url = nil;
    ENSURE_ARG_AT_INDEX(url,args,0,NSString);
    NSNumber * height = nil;
    ENSURE_ARG_AT_INDEX(height,args,1,NSNumber);
    KrollCallback * callback = nil;
    ENSURE_ARG_OR_NIL_AT_INDEX(callback, args, 2, KrollCallback)
    
    [TiUIListViewProxy loadFromURL:[NSURL URLWithString:url] callback:^(UIImage *image) {
        
        self.currentImage = image;
        
        TiUIListView *convert = (TiUIListView*) self.view;
        [convert addParallaxWithImage:self.currentImage forHeight:[height floatValue]];
        
        if (callback != nil){
            [callback call:@[@"complete"] thisObject:self];
        }
    }];
}

-(void)addParallaxWithLocalImage:(id)args
{
    TiBlob * blob = nil;
    ENSURE_ARG_AT_INDEX(blob,args,0,TiBlob);
    NSNumber * height = nil;
    ENSURE_ARG_AT_INDEX(height,args,1,NSNumber);
    KrollCallback * callback = nil;
    ENSURE_ARG_OR_NIL_AT_INDEX(callback, args, 2, KrollCallback)
    TiUIListView *convert = (TiUIListView*) self.view;
    
    self.currentImage = [UIImage imageNamed:@"expand.jpg"];
    
    [convert addParallaxWithImage:self.currentImage forHeight:[height floatValue]];
    
    if (callback != nil){
        [callback call:@[@"complete"] thisObject:self];
    }
}

-(void)setSectionHeaderInset:(id)args
{
    ENSURE_SINGLE_ARG(args, NSNumber);
    
    CGFloat height = [(NSNumber*)args floatValue];
    
    TiUIListView *convert = (TiUIListView*) self.view;
    [convert setSectionHeaderInset:height];
}

@end
