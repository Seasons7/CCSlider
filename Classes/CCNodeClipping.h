//
//  CCNodeClipping.h
//  CCSlider
//
//  Created by Keisuke Hata on 13/01/11.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCNodeClipping : CCNode {
	
	CGRect clippingRegionInNodeCoordinates;
	CGRect clippingRegion;
}

@property (nonatomic) CGRect clippingRegion;

@end