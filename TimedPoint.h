//
//  TimedPoint.h
//  gestureRecorder
//
//  Created by bastien girschig on 26/09/2014.
//
//

#ifndef gestureRecorder_TimedPoint_h
#define gestureRecorder_TimedPoint_h
#include "ofMain.h"

class TimedPoint: public ofPoint{
public:
    TimedPoint(int _x, int y, float t);
    float t;
};

#endif
