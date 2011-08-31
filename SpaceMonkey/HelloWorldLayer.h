//
//  HelloWorldLayer.h
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/1/11.
//  Copyright YKB 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "PauseMenuButtonLayer.h"
#import "GLES-Render.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	CCSprite* m_menuButton;
	CCSprite* m_backgroundImg;
	CCSprite* m_ball;
	b2World* m_world;
	b2Body* m_body;
	GLESDebugDraw* debugDraw;
    b2MouseJoint *m_mouseJoint;

}

-(void)createWorld;
-(void)setupDebugDraw;
-(void)createGround;
-(void)createBoxAtLocation:(CGPoint)location withSize:(CGSize)size;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
