//
//  GestureGroup.h
//  GestureRecorder
//
//  Created by bastien girschig on 01/10/2014.
//
//

#ifndef GestureRecorder_GestureGroup_h
#define GestureRecorder_GestureGroup_h
#include "ofMain.h"
#include "Gesture.h"

class GestureGroup{
    public:
    GestureGroup();
    GestureGroup(int _groupId, Gesture firstGesture);
    void draw();
    void addVersion(Gesture gesture);
    Gesture& getCurrent();
    void gotoNext();
    void gotoPrev();
    
    vector<Gesture> versions;
    int currentVesrion;
    int groupId;
};


#endif
