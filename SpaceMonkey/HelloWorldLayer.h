//
//  HelloWorldLayer.h
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/1/11.
//  Copyright YKB 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	CCSprite *m_menuButton;
	CCSprite *m_backgroundImg;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
