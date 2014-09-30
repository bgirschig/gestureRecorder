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
    
    string toString(Boolean prettyPrint);
    
    int startTime;
    int duration;
    int gestureGroup;
    
    Boolean drawing;
    
    vector<Trace> traces;
    vector<Trace> currentTraces;
};

#endif
