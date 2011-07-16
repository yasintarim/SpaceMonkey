//
//  HelloWorldLayer.mm
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/1/11.
//  Copyright YKB 2011. All rights reserved.
//

#define PTM_RATIO 32.0
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
		PauseMenuButtonLayer *menuButton = [[[PauseMenuButtonLayer alloc] init] autorelease];
		//menuButton.position = [menuButton]
		[self addChild:menuButton z:2];
		m_backgroundImg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:m_backgroundImg z:1];
		
		
		m_ball = [CCSprite spriteWithFile:@"Ball.jpg" rect:CGRectMake(0, 0, 52, 52)];
		m_ball.position = ccp(100, 100);
		[self addChild:m_ball z:2];
		
		//create a world
	
		b2Vec2 gravity = b2Vec2(0.0f,-30.0f);
		bool doSleep = true;
		m_world = new b2World(gravity, doSleep);
		
		//create edges around the screen
		
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0);
		
		b2Body* groundBody = m_world->CreateBody(&groundBodyDef);
		
		b2PolygonShape groundBox;
		b2FixtureDef boxShapeDef;
		boxShapeDef.shape = &groundBox;
		
		float heightRatio = winSize.height / PTM_RATIO;
		float widthRatio = winSize.width / PTM_RATIO;
		
		
		groundBox.SetAsEdge(b2Vec2(0, 0), b2Vec2(widthRatio, 0));
		groundBody->CreateFixture(&boxShapeDef);
		
		groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(0, heightRatio));
		groundBody->CreateFixture(&boxShapeDef);
		
		groundBox.SetAsEdge(b2Vec2(0, heightRatio), b2Vec2(widthRatio, heightRatio));
		groundBody->CreateFixture(&boxShapeDef);
		
		groundBox.SetAsEdge(b2Vec2(widthRatio, heightRatio), b2Vec2(widthRatio, 0));
		groundBody->CreateFixture(&boxShapeDef);
		
		
		b2BodyDef ballBodyDef;
		ballBodyDef.type = b2_dynamicBody;
		ballBodyDef.position.Set(100/PTM_RATIO, 100/PTM_RATIO);
		ballBodyDef.userData = m_ball;
		m_body = m_world->CreateBody(&ballBodyDef);
		
		b2CircleShape circle;
		circle.m_radius = 26.0 / PTM_RATIO;
		
		b2FixtureDef ballShapeDef;
		ballShapeDef.shape = &circle;
		ballShapeDef.density = 1.0f;
		ballShapeDef.friction = 0.2f;
		ballShapeDef.restitution = 0.8f;
		
		m_body->CreateFixture(&ballShapeDef);


		[self schedule:@selector(tick:)];
		
	}
	return self;
}
- (void)tick:(ccTime) dt {
	
    m_world->Step(dt, 10, 10);
    for(b2Body *b = m_world->GetBodyList(); b; b=b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }        
    }
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	delete m_world;
    m_body = NULL;
    m_world = NULL;
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
