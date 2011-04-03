//
//  HelloWorldLayer.m
//  CCSlider
//
//  Created by 畑圭輔 on 11/01/13.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "CCSlider.h"

#define kTagSlider 0x1

#define __CLIPPING_SLIDERBAR   // Use clipping sliderbar
#define __TOUCH_END_SLIDERBAR  // Use touch end callback sliderbar

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) sliderMessage : (id)sender {
	
	CCSliderThumb *thumb = (CCSliderThumb *)sender;
	CCLOG(@"%f" , thumb.value );
    
    CCNode *node = [self getChildByTag:kTagSlider];
    CCSlider *slider = (CCSlider *)node;
    
#if defined (__CLIPPING_SLIDERBAR)
    [slider clippingBar:CGSizeMake(thumb.value * slider.barImage.contentSize.width,
                                   slider.barImage.contentSize.height)];
#endif
}

- (void) sliderTouchEnd {
    
    CCLOG(@"sliderTouchEnd");
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		CCSlider *slider = [CCSlider sliderWithTarget:self selector:@selector(sliderMessage:)];
		slider.position = ccp( size.width/2 , size.height/2 );
		slider.liveDragging = YES;
		
		// You can use custom image
		/* --- This is sample code --- */
		slider.thumb.selectedImage = [CCSprite spriteWithFile:@"thumb.png"];
		slider.thumb.normalImage   = [CCSprite spriteWithFile:@"thumb.png"];
        slider.thumb.contentSize   = slider.thumb.selectedImage.contentSize;
        slider.thumb.contentSizeInPixels = slider.thumb.selectedImage.contentSizeInPixels;
		slider.barImage = [CCSprite spriteWithFile:@"bar.png"];
		/* --- This is sample code --- */
        
		[self addChild:slider];
        slider.tag = kTagSlider;
        
        // If you use setTouchEndSelector method, 
        // you can call specific selector when 
        // you release your finger from the slider.
#if defined (__TOUCH_END_SLIDERBAR)        
        [slider setTouchEndSelector:@selector(sliderTouchEnd)];
#endif
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
