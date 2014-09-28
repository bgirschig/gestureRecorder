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
    void addTrace(Trace _trace);
    void draw();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMove(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    
    int startTime;
    int duration;
    
    Boolean drawing;
    
    vector<Trace> traces;
    vector<Trace> currentTraces;
};

#endif
