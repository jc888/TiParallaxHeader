//
//  TiUIListViewProxy+ProxyParallaxHeader.h
//  TiParallaxHeader
//
//  Created by James Chow on 17/04/2014.
//
//

#import "TiUIListViewProxy.h"
#import "TiUIViewProxy.h"
#import "TiProxy.h"
#import <objc/runtime.h>

@interface TiUIListViewProxy (ProxyParallaxHeader)

@property (nonatomic, retain) UIImage * currentImage;

-(void)addParallaxWithView:(id)args;
-(void)addParallaxWithImage:(id)args;
-(void)setSectionHeaderInset:(id)args;

@end
