//
//  PauseMenuButtonLayer.m
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/4/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "PauseMenuButtonLayer.h"
#define PAUSEMENUTAG	9999
@implementation PauseMenuButtonLayer

- (id)init
{
    self = [super init];
    if (self) {
		
		CCMenuItem *resume = [CCMenuItemImage itemFromNormalImage:@"ButtonPlus.png" selectedImage:@"ButtonPlusSel.png"];
		CCMenuItem *pause = [CCMenuItemImage itemFromNormalImage:@"ButtonMinus.png" selectedImage:@"ButtonMinusSel.png"];
		CGSize winSize = [[CCDirector sharedDirector] winSize];
	__block BOOL m_menuVisible = NO;
		m_pauseMenu = [[PauseMenuLayer alloc] initWithColor:ccc4(155, 155, 65, 125) width:winSize.width * 0.4 height:winSize.height * 0.4];
		m_pauseMenu.tag = PAUSEMENUTAG;
		
		CCMenuItemToggle *itemToggle = [CCMenuItemToggle itemWithBlock:^(id arg) {
			
			m_menuVisible = !m_menuVisible;
			
			if (m_menuVisible) {
				[[self parent] addChild:m_pauseMenu z:PAUSEMENUTAG];
			}
			else
			{
				[[self parent] removeChildByTag:PAUSEMENUTAG cleanup:YES];
			}			
		} items:resume,pause, nil];
		
		CCMenu *menu = [CCMenu menuWithItems:itemToggle, nil];

		//menu.position = ccp(winSize.width - 100, winSize.height  - 100);
		[self addChild:menu z:1];

    }
    
    return self;
}
-(void)dealloc
{
	[m_pauseMenu release];
	[super dealloc];
}

@end
