#import "Box2D.h"

class SimpleQueryCallback : public b2QueryCallback {
    b2Vec2 m_pointToTest;
    b2Fixture *m_fixtureFound;
public:
    SimpleQueryCallback(const b2Vec2& point)
    {
        m_pointToTest = point;
        m_fixtureFound = NULL;
    }
    b2Fixture* GetFixtureFound()
    {
        return m_fixtureFound;
    }
    
    bool ReportFixture(b2Fixture* fixture)
    {
        b2Body *body = fixture->GetBody();
        if (body->GetType() == b2_dynamicBody && fixture->TestPoint(m_pointToTest)) {
            m_fixtureFound = fixture;
            return  false;
        }
        return true;
    }
    
};

