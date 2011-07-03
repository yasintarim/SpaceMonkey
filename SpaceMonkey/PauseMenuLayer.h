//
//  PauseMenuLayer.h
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/3/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "cocos2d.h"


@interface PauseMenuLayer : CCLayerColor
{
	CCDirector *dir;
}
-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;
-(id)init;
@end
