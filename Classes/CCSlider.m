//
//  Slider.m
//  Trundle
//
//  Created by Robert Blackwood on 11/13/09.
//  Modified by Keisuke Hata on 13/01/11.
//  Copyright 2009 Mobile Bros. All rights reserved.
//

#import "CCSlider.h"

static const int _max = 200;

@implementation CCSliderThumb

-(id) init
{
	return [self initWithTarget:nil selector:nil];
}

-(id) initWithTarget:(id)t selector:(SEL)sel
{
	[super initFromNormalImage:@"sliderthumb.png" 
				 selectedImage:@"sliderthumbsel.png" 
				 disabledImage:nil target:t selector:sel];
	
	
	return self;
}

-(float) value
{
	return (position_.x+(_max/2))/_max;
}

-(void) setValue:(float)val
{
	position_ = ccp(val*_max-(_max/2), position_.y);
}

@end

@interface CCSliderTouchLogic : CCMenu
{
	CCSliderThumb* _thumb;
	BOOL _liveDragging;
}

@property (readonly) CCSliderThumb* thumb;
@property (readwrite, assign) BOOL liveDragging;

-(id) initWithTarget:(id)t selector:(SEL)sel;

@end


@implementation CCSliderTouchLogic

@synthesize liveDragging = _liveDragging;

-(id) init
{
	return [self initWithTarget:nil selector:nil];
}

-(id) initWithTarget:(id)t selector:(SEL)sel
{
	if( (self = [super initWithItems:nil vaList:nil]) ) {
		
		self.position = ccp(0,0);
		
		_liveDragging = NO;
		_thumb = [[[CCSliderThumb alloc] initWithTarget:t selector:sel] autorelease];
		if( _thumb ) {
			[self addChild:_thumb];
		}
	}
	return self;
}

-(CCSliderThumb*) thumb
{
	return _thumb;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ([super ccTouchBegan:touch withEvent:event])
	{
		[self ccTouchMoved:touch withEvent:event];
		return YES;
	}
	else
		return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super ccTouchEnded:touch withEvent:event];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint pt = [self convertTouchToNodeSpace:touch];
	
	float x = pt.x;
	
	if (x < -_max/2)
		_thumb.position = ccp(-_max/2, 0);
	else if (x > _max/2)
		_thumb.position = ccp(_max/2, 0);
	else
		_thumb.position = ccp(x, 0);
	
	if (_liveDragging)
		[_thumb activate];
}

@end

@interface CCSlider()

-(id) initWithTarget:(id)t selector:(SEL)sel;

@end

@implementation CCSlider

@synthesize barImage = barImage_;

+ (id) sliderWithTarget:(id)t selector:(SEL)sel {

	return [[[self alloc] initWithTarget:t selector:sel] autorelease];
}

-(id) init
{
	return [self initWithTarget:nil selector:nil];
}

-(id) initWithTarget:(id)t selector:(SEL)sel
{
	if( (self = [super init]) ) {
	
		_touchLogic = [[[CCSliderTouchLogic alloc] 
						initWithTarget:t 
						selector:sel] autorelease];
		if( _touchLogic ) {
			barImage_ = [CCSprite spriteWithFile:@"slidergroove.png"];
			[self addChild:barImage_ z:1];
			[self addChild:_touchLogic z:2];
		}
	}
	return self;
}

- (void) setBarImage:(CCSprite *)image {

	if( image != barImage_ ) {
		
		[self removeChild:barImage_ cleanup:YES];
		[self addChild:image z:1];
		
		barImage_ = image;
	}
}

-(CCSliderThumb*) thumb
{
	return _touchLogic.thumb;
}

-(float) value
{
	return self.thumb.value;
}

-(void) setValue:(float)val
{
	[self.thumb setValue:val];
}

-(BOOL) liveDragging
{
	return _touchLogic.liveDragging;
}

-(void) setLiveDragging:(BOOL)live
{
	_touchLogic.liveDragging = live;
}

@end
