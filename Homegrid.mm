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
void Homegrid::AddVersion(Gesture gesture){
    gesture.lineWidth = 2;
    gesture.setScaleParams((gesture.gestureGroup%colCount)*elementW+margin, floor(gesture.gestureGroup/colCount)*elementW+margin, elementW, elementW, true);
    Boolean createNewGroup = true;
    for (int i=0; i<gestures.size(); i++) {
        if(gestures[i].groupId == gesture.gestureGroup){
            gestures[i].addVersion(gesture);
            createNewGroup = false;
        }
    }
    if(createNewGroup) AddGroup(GestureGroup(gesture.gestureGroup, gesture));
}
void Homegrid::AddGroup(GestureGroup group){
    group.getCurrent().lineWidth = 2;
    group.getCurrent().setScaleParams((gestures.size()%colCount)*elementW+margin, floor(gestures.size()/colCount)*elementW+margin, elementW, elementW, true);
    gestures.push_back(group);
}

void Homegrid::draw(){
    for(int i=0; i < gestures.size(); i++) {
        ofFill();
        ofSetColor(255, 200); //fill color
        ofRect((i%colCount)*elementW+margin, floor(i/colCount)*elementW+margin, elementW, elementW);
        ofNoFill();
        ofSetColor(255);//stroke color
        ofRect((i%colCount)*elementW+margin, floor(i/colCount)*elementW+margin, elementW, elementW);
        
        gestures[i].draw();
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