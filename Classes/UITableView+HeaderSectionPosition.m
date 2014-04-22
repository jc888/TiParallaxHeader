//
//  UITableView+HeaderSectionPosition.m
//  Category to extend UITableView, which TiUIListView uses
//
//  Created by James Chow on 11/04/2014.
// http://b2cloud.com.au/tutorial/uitableview-section-header-positions/
//

#import "UITableView+HeaderSectionPosition.h"
#import "NSObject+JRSwizzle.h"
#import <objc/runtime.h>

@implementation UITableView (HeaderSectionPosition)

BOOL shouldManuallyLayoutHeaderViews;

+ (void) swizzle
{
    NSError *error = nil;
	[UITableView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:&error];
    
    if (error != nil) {
        NSLog(@"[ERROR] %@", [error localizedDescription]);
    }
}

#pragma mark -
#pragma mark Self

- (void) layoutSubviews_swizzle
{
    [UITableView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:nil];
    
	[self layoutSubviews];
    
    [UITableView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:nil];
    
	if(shouldManuallyLayoutHeaderViews)
		[self layoutHeaderViews];
}

- (void) setHeaderViewInsets:(UIEdgeInsets )_headerViewInsets
{
    NSNumber * topValue = [NSNumber numberWithFloat: _headerViewInsets.top];
    
    objc_setAssociatedObject(self, @selector(headerViewInsets), topValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
	shouldManuallyLayoutHeaderViews = !UIEdgeInsetsEqualToEdgeInsets(_headerViewInsets, UIEdgeInsetsZero);
	
    [self setNeedsLayout];
}

-(UIEdgeInsets ) headerViewInsets
{
    NSNumber *topValue = objc_getAssociatedObject(self, @selector(headerViewInsets));
    UIEdgeInsets convert = UIEdgeInsetsMake([topValue floatValue], 0, 0, 0);
    return convert;
}

#pragma mark Private

- (void) layoutHeaderViews
{
	const NSUInteger numberOfSections = self.numberOfSections;
	const UIEdgeInsets contentInset = self.contentInset;
	const CGPoint contentOffset = self.contentOffset;
	
	const CGFloat sectionViewMinimumOriginY = contentOffset.y + contentInset.top + self.headerViewInsets.top;
	
	//	Layout each header view
	for(NSUInteger section = 0; section < numberOfSections; section++)
	{
        
        //headerViewForSection:section won't work due to titanium using plain uiviews
        
		UIView* sectionHeView = [self viewWithTag:100 + section];
		
		if(sectionHeView == nil)
			continue;
        
		const CGRect sectionFrame = [self rectForSection:section];
		
		CGRect sectionHeViewFrame = sectionHeView.frame;
        
		sectionHeViewFrame.origin.y = ((sectionFrame.origin.y < sectionViewMinimumOriginY) ? sectionViewMinimumOriginY : sectionFrame.origin.y);
		
		//	If it's not last section, manually 'stick' it to the below section if needed
		if(section < numberOfSections - 1)
		{
			const CGRect nextSectionFrame = [self rectForSection:section + 1];
			
			if(CGRectGetMaxY(sectionHeViewFrame) > CGRectGetMinY(nextSectionFrame))
				sectionHeViewFrame.origin.y = nextSectionFrame.origin.y - sectionHeViewFrame.size.height;
		}
        
		[sectionHeView setFrame:sectionHeViewFrame];
	}
}
@end
