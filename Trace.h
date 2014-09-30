//
//  Trace.h
//  gestureRecorder
//
//  Created by bastien girschig on 26/09/2014.
//
//

#ifndef gestureRecorder_Trace_h
#define gestureRecorder_Trace_h
#include "ofMain.h"
#include "Settings.h"
#include "TimedPoint.h"

class Trace{
    public:
    Trace(int _touchId, ofColor _color);
    Trace(int _touchId);
    void setup();
    void update();
    void draw(int animTime);
    void addPoint(int x, int y, int time);
    
    ofPolyline line;
    vector<TimedPoint> points;
    ofColor color;

    int touchId;
    int id;
};

#endif
