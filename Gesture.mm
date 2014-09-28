//
//  Gesture.mm
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#include "Gesture.h"

Gesture::Gesture(){
    startTime = 0;
    traces = vector<Trace>();
    currentTraces = vector<Trace>();
}

void Gesture::addTrace(Trace _trace){
    traces.push_back(_trace);
    if(_trace.duration>duration) duration = _trace.duration;
}
void Gesture::draw(){
    for(int i=0; i<currentTraces.size();i++) currentTraces[i].draw(INFINITY);
    if(duration>1) for(int i=0; i<traces.size();i++) traces[i].draw(ofGetElapsedTimeMillis()%duration);
    
}
void Gesture::touchDown(ofTouchEventArgs & touch){
    if(traces.size() == 0){
        startTime = ofGetElapsedTimeMillis();
        cout << startTime <<endl;
    }
    currentTraces.push_back(Trace(touch.id));
}
void Gesture::touchMove(ofTouchEventArgs & touch){
    for(int i=0; i<currentTraces.size();i++){
        if(currentTraces[i].touchId == touch.id){
            currentTraces[i].addPoint(touch.x, touch.y, ofGetElapsedTimeMillis()-startTime);
            break;
        }
    }
}
void Gesture::touchUp(ofTouchEventArgs & touch){
    for(int i=0; i<currentTraces.size(); i++){
        if(currentTraces[i].touchId == touch.id){
            currentTraces[i].color = ofColor(200,150,100);
            currentTraces[i].duration = ofGetElapsedTimeMillis()-currentTraces[i].startTime;
            traces.push_back(currentTraces[i]);
            currentTraces.erase(currentTraces.begin()+i);
            break;
        }
    }
    duration = ofGetElapsedTimeMillis() - startTime;
    cout << duration<<endl;
}