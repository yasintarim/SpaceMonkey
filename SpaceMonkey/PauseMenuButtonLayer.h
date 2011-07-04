//
//  PauseMenuButtonLayer.h
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/4/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "cocos2d.h"
#import "PauseMenuLayer.h"

@interface PauseMenuButtonLayer : CCLayer
{
	PauseMenuLayer *m_pauseMenu;

}

-(id)init;
-(void)dealloc;
@end
