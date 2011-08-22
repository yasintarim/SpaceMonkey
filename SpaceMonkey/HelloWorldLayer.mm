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
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		m_backgroundImg = [CCSprite spriteWithFile:@"cembg.png"];
		[m_backgroundImg setOpacity:210];
		m_backgroundImg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:m_backgroundImg z:0];
		
		PauseMenuButtonLayer *menuButton = [[[PauseMenuButtonLayer alloc] init] autorelease];
		[self addChild:menuButton z:92];
		self.isAccelerometerEnabled = YES;
		[self createWorld];
		[self setupDebugDraw];
		[self scheduleUpdate];
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
	}
	return self;
}
- (void)update:(ccTime) dt {
	
    m_world->Step(dt, 3, 3);
    b2Vec2 point;


	for (b2Body* b = m_world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}	
}

-(void)draw {
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    m_world->DrawDebugData();
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}

-(void)setupDebugDraw {
    debugDraw = new GLESDebugDraw(PTM_RATIO *[[CCDirector sharedDirector]
											  contentScaleFactor]);
    m_world->SetDebugDraw(debugDraw);
    debugDraw->SetFlags(b2DebugDraw::e_shapeBit);
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
    // Landscape left values
    b2Vec2 gravity(-acceleration.y * 15, acceleration.x *15);
    m_world->SetGravity(gravity);
}



-(void)createBoxAtLocation:(CGPoint)location withSize:(CGSize)size
{
	CCSprite *c1 = c1 = [CCSprite spriteWithFile:@"c1.png"];
	[self addChild:c1];
	c1.position = ccp(location.x, location.y);
	
	b2Vec2 positon = b2Vec2(location.x / PTM_RATIO, location.y / PTM_RATIO);
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position = positon;
	bodyDef.userData = c1;
	
	b2Body* body= m_world->CreateBody(&bodyDef);
	
	b2PolygonShape shape;
	shape.SetAsBox(size.width / 2.0 /PTM_RATIO, size.height / 2.0 /PTM_RATIO);
	
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;
	fixtureDef.density = 1000;
	fixtureDef.restitution = 0.5;
	body->CreateFixture(&fixtureDef);
	//body->SetUserData(sprite);
	
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector]
					 convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    b2Vec2 locationWorld =
	b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO);
    [self createBoxAtLocation:touchLocation
					 withSize:CGSizeMake(30, 30)];
    return TRUE;
}
-(void)createWorld
{	
	b2Vec2 gravity = b2Vec2(0.0f,-30.0f);
	
	bool doSleep = false;
	m_world = new b2World(gravity, doSleep);
	[self createGround];
}

-(void)createGround
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];

	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0);
	
	b2Body* groundBody = m_world->CreateBody(&groundBodyDef);
	
	b2PolygonShape groundBox;
	b2FixtureDef boxShapeDef;
	boxShapeDef.shape = &groundBox;
	
	float margin = 10;
	float marginRatio = margin / PTM_RATIO;
	float heightRatio = (winSize.height - margin) / PTM_RATIO;
	float widthRatio = (winSize.width - margin) / PTM_RATIO;

	
	b2Vec2 lowerLeft = b2Vec2(marginRatio, marginRatio);
	b2Vec2 lowerRight = b2Vec2(widthRatio, marginRatio);
	b2Vec2 upperLeft = b2Vec2(marginRatio, heightRatio);
	b2Vec2 upperRight = b2Vec2(widthRatio, heightRatio);
		
	
	groundBox.SetAsEdge(lowerLeft, lowerRight);
	groundBody->CreateFixture(&boxShapeDef);
	
	groundBox.SetAsEdge(lowerRight, upperRight);
	groundBody->CreateFixture(&boxShapeDef);
	
	groundBox.SetAsEdge(upperRight, upperLeft);
	groundBody->CreateFixture(&boxShapeDef);
	
	groundBox.SetAsEdge(upperLeft, lowerLeft);
	groundBody->CreateFixture(&boxShapeDef);
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	if (debugDraw) {
		delete debugDraw;
		debugDraw = nil;
	}
	
	if (m_world) {
		delete m_world;
	}
	
    m_body = NULL;
    m_world = NULL;
	
	[super dealloc];
}
@end
