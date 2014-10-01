//
//  Gesture.h
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#ifndef GestureRecorder_Gesture_h
#define GestureRecorder_Gesture_h
#import "Trace.h"

class Gesture{
    public:
    Gesture();
    Gesture(string loadData);
    void draw();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMove(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void load(string str);
    void addTrace(Trace trace);
    void setScaleParams(int x, int y, int w, int h, Boolean allowScaleUp);
    void normalizePoints();
    
    string toString(Boolean prettyPrint);
    
    int startTime;
    int duration;
    int gestureGroup;
    
    int lBound = INFINITY, rBound = 0, tBound = INFINITY, bBound = 0;
    int containerX, containerY;
    float ratio;
    float scale;
    int lineWidth;
    
    Boolean drawing;
    
    vector<Trace> traces;
    vector<Trace> currentTraces;
};

#endif
