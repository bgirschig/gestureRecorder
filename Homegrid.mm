//
//  Homegrid.mm
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#include "Homegrid.h"

Homegrid::Homegrid(){
}
Homegrid::Homegrid(int _margin, int _colCount){
    windowW = ofGetWindowWidth();
    margin = _margin;
    colCount = _colCount;
    elementW = (windowW - (2 * margin)) / colCount;
}
void Homegrid::draw(){
    for(int i=0; i < gestures.size(); i++) {
        ofNoFill();
        ofSetLineWidth(1);
        ofSetColor(0);
        ofRect((i%colCount)*elementW+margin, floor(i/colCount)*elementW+margin, elementW, elementW);
    }
}
int Homegrid::onClick(int x, int y){
    if(x > margin && x < windowW-margin && y > margin){
        int index = floor((y-margin)/elementW) * Settings::homeGridColCount + floor((x-margin)/elementW);
        if(index<gestures.size())return index;
        return -1;
    }
    return -1;
}