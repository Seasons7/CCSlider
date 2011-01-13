//
//  Slider.h
//  Trundle
//
//  Created by Robert Blackwood on 11/13/09.
//  Modified by Keisuke Hata on 13/01/11.
//  Copyright 2009 Mobile Bros. All rights reserved.
//

#import "cocos2d.h"

@interface CCSliderThumb : CCMenuItemImage
{
	
}
@property (readwrite, assign) float value;

-(id) initWithTarget:(id)t selector:(SEL)sel;

@end

/* Internal class only */
@class CCSliderTouchLogic;

@interface CCSlider : CCLayer
{
	CCSliderTouchLogic* _touchLogic;
	CCSprite *barImage_;
}

@property (readonly) CCSliderThumb* thumb;
@property (readwrite, assign) CCSprite *barImage;
@property (readwrite, assign) float value;
@property (readwrite, assign) BOOL liveDragging;

- (id) initWithTarget:(id)t selector:(SEL)sel;
+ (id) sliderWithTarget:(id)t selector:(SEL)sel;

@end


