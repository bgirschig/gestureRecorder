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
Gesture::Gesture(string loadData){
    Gesture();
    load(loadData);
}
void Gesture::draw(){
    for(int i=0; i<currentTraces.size();i++) currentTraces[i].draw(INFINITY);
    if(duration>1) for(int i=0; i<traces.size();i++) traces[i].draw(ofGetElapsedTimeMillis()%duration);    
}
void Gesture::touchDown(ofTouchEventArgs & touch){
    if(traces.size() == 0){
        startTime = ofGetElapsedTimeMillis();
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
            addTrace(currentTraces[i]);
            currentTraces.erase(currentTraces.begin()+i);
            break;
        }
    }
    duration = ofGetElapsedTimeMillis() - startTime;
}
void Gesture::addTrace(Trace trace){
    trace.color.setHue(20*traces.size()%255);
    traces.push_back(trace);
}
void Gesture::load(string str){
    vector<string> lines = ofSplitString(str, "||");
    gestureGroup = ofToInt(ofSplitString(lines[0], "_")[0]);
    duration = ofToInt(ofSplitString(lines[0], "_")[1]);
    
    for(int i=1;i<lines.size();i++){
        addTrace(Trace(0));
        vector<string> points = ofSplitString(lines[i], "|");
        
        for (int j=1; j<points.size(); j++) {
            vector<string> parts = ofSplitString(points[j], ",");
            traces[traces.size()-1].addPoint(ofToInt(parts[0]), ofToInt(parts[1]), ofToInt(parts[2]));
        }
    }
}
string Gesture::toString(Boolean prettyPrint){
    std::ostringstream result;
    if(prettyPrint){
        result << endl << "==== print gesture" << endl;
        result << "gestureId: " << gestureGroup << endl;
        result << "gestureDuration: " << duration << endl;
        result << "traces (" << traces.size() << "):" << endl;
        for (int i=0; i<traces.size(); i++) {
            result << "\ttrace"<<endl;
            for (int j=0; j<traces[i].points.size(); j++) {
                result << "\t\tpoint:" << endl << "\t\t\tx:" << traces[i].points[j].x << endl << "\t\t\ty:" << traces[i].points[j].x << endl<< "\t\t\tt:" << traces[i].points[j].t << endl;
            }
        }
    }
    else{
        result << gestureGroup << "_"<< duration << "|";
        for (int i=0; i<traces.size(); i++) {
            for (int j=0;j<traces[i].points.size(); j++) {
                result << "|" << traces[i].points[j].x << "," << traces[i].points[j].y<< "," << traces[i].points[j].t;
            }
            result << "||";
        }
    }
    return result.str();
}
