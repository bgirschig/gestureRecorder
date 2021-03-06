#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "Gesture.h"
#include "GestureGroup.h"
#include "Menu.h"
#include "Homegrid.h"
#include "MenuEvent.h"
#include "ofxHttpUtils/ofxHttpUtils.h"

#include "Poco/RegularExpression.h"
using Poco::RegularExpression;

class ofApp : public ofxiOSApp {
    public:
    void setup();
    void update();
    void draw();
    void drawArrows();
    void exit();

    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);

    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    void menuEvent(MenuEvent &e);
    void loadExisting();
    void newResponse(ofxHttpResponse & response);
    GestureGroup currentGroup;
    Menu* menu;
    Homegrid homegrid;
    ofTrueTypeFont font;
    int test = 34;
    
    ofxHttpUtils httpUtils;
};