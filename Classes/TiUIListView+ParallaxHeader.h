//
//  TiUIListView+ParallaxHeader.h
//  TiParallaxHeader
//
//  Created by James Chow on 17/04/2014.
//
//

#import "TiUIView.h"
#import "TiUIListViewProxy.h"
#import "TiUIListView.h"
#import "TiViewProxy.h"

@interface TiUIListView (ParallaxHeader)

@property (nonatomic, retain) UIImage * currentImage;
@property (nonatomic, retain) TiViewProxy * currentHeaderView;

+ (void) swizzle;

-(void)addParallaxWithView:(TiViewProxy *)headerview withHeight: (CGFloat) height;
-(void)addParallaxWithImage:(UIImage *)image forHeight: (CGFloat) height;
-(void)setSectionHeaderInset:(CGFloat) height;

@end
