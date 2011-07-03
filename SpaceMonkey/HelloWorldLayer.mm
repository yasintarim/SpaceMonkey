//
//  HelloWorldLayer.mm
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/1/11.
//  Copyright YKB 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		m_backgroundImg = [CCSprite spriteWithFile:@"cembg.png"];
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		m_backgroundImg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:m_backgroundImg];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
