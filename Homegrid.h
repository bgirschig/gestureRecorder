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

class Homegrid{
    public:
    Homegrid();
    Homegrid(int _margin, int _colCount);
    void AddGesture(Gesture gesture);
    
    int onClick(int x, int y);
    void draw();
    
    int windowW;
    int margin;
    int colCount;
    int elementW;
    vector<Gesture> gestures;
};

#endif
