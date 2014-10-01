//
//  Homegrid.h
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#ifndef GestureRecorder_Homegrid_h
#define GestureRecorder_Homegrid_h
#include "ofMain.h"
#include "Gesture.h"
#include "GestureGroup.h"

class Homegrid{
    public:
    Homegrid();
    Homegrid(int _margin, int _colCount);
    void AddVersion(Gesture gesture);
    void AddGroup(GestureGroup group);
    
    int onClick(int x, int y);
    void draw();
    
    int windowW;
    int margin;
    int colCount;
    int elementW;
    vector<GestureGroup> gestures;
};

#endif
