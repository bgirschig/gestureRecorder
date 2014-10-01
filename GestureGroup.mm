//
//  GestureGroup.mm
//  GestureRecorder
//
//  Created by bastien girschig on 01/10/2014.
//
//

#include "GestureGroup.h"

GestureGroup::GestureGroup(){
    
}
GestureGroup::GestureGroup(int _groupId, Gesture firstGesture){
    groupId = _groupId;
    currentVesrion = 0;
    addVersion(firstGesture);
}
void GestureGroup::draw(){
    versions[currentVesrion].draw();
}
void GestureGroup::addVersion(Gesture gesture){
    versions.push_back(gesture);
}
Gesture& GestureGroup::getCurrent(){
    return versions[currentVesrion];
}
void GestureGroup::gotoNext(){
    currentVesrion = (currentVesrion+1);
    if(currentVesrion > versions.size()-1) currentVesrion = versions.size()-1;
    cout << currentVesrion;
}
void GestureGroup::gotoPrev(){
    currentVesrion = (currentVesrion-1);
    if(currentVesrion < 0) currentVesrion = 0;
}