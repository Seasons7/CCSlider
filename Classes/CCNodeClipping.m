//
//  CCNodeClipping.m
//  CCSlider
//
//  Created by Keisuke Hata on 13/01/11.
//


#import "CCNodeClipping.h"


@interface CCNodeClipping (PrivateMethods)

-(void) deviceOrientationChanged:(NSNotification*)notification;

@end

@implementation CCNodeClipping

-(id) init {
	
	if ((self = [super init])) {
	}    
	return self;	
}

-(CGRect) clippingRegion {
	
	return clippingRegionInNodeCoordinates;
}

-(void) setClippingRegion:(CGRect)region {
	
	// keep the original region coordinates in case the user wants them back unchanged    
	clippingRegionInNodeCoordinates = region;
	
	// convert to retina coordinates if needed    
	region = CC_RECT_POINTS_TO_PIXELS(region);
	// respect scaling    
	clippingRegion = CGRectMake(region.origin.x * scaleX_,
								region.origin.y * scaleY_,                             
								region.size.width * scaleX_, 
								region.size.height * scaleY_);
}

-(void) setScale:(float)newScale { 
	[super setScale:newScale];
    // re-adjust the clipping region according to the current scale factor    
	[self setClippingRegion:clippingRegionInNodeCoordinates];
}

-(void) visit {
	
	glPushMatrix();
    glEnable(GL_SCISSOR_TEST);
    glScissor(clippingRegion.origin.x + positionInPixels_.x, 
			  clippingRegion.origin.y + positionInPixels_.y,
			  clippingRegion.size.width, 
			  clippingRegion.size.height);
	[super visit];
	glDisable(GL_SCISSOR_TEST);
    glPopMatrix();
}

@end