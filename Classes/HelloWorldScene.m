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
	
	CCSliderThumb *slider = (CCSliderThumb *)sender;
	CCLOG(@"%f" , slider.value );
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
		/* sample code */
		/*
		slider.thumb.selectedImage = [CCSprite spriteWithFile:@"slider_thumb.png"];
		slider.thumb.normalImage   = [CCSprite spriteWithFile:@"slider_thumb.png"];
		slider.barImage = [CCSprite spriteWithFile:@"slider_bar.png"];
		 */
		[self addChild:slider];
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
