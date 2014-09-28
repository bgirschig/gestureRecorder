//
//  Trace.cpp
//  gestureRecorder
//
//  Created by bastien girschig on 26/09/2014.
//
//

#include "Trace.h"

Trace::Trace(int _touchId, ofColor _color){
    touchId = _touchId;
    color = _color;
    id = 0;
}
Trace::Trace(int _touchId){
    touchId = _touchId;
    color = ofColor(20, 50, 90);
    id = 0;
}

void Trace::addPoint(int x, int y, int time){
    if(points.size()==0) startTime = time;
    points.push_back(TimedPoint(x, y, time-startTime));
}
void Trace::draw(int animTime){
    ofSetLineWidth(Settings::lineWidth);
    ofSetColor(color);
    ofPolyline line = ofPolyline();
    for(int i=0; i<points.size() && points[i].t<animTime-startTime;i++){
        line.addVertex(points[i]);
    }
    line.draw();
}