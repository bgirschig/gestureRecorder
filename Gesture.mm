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
    lineWidth = Settings::lineWidth;
}
Gesture::Gesture(string loadData){
    Gesture();
    load(loadData);
}
void Gesture::draw(){
    if(duration>1) for(int i=0; i<traces.size();i++) traces[i].draw(ofGetElapsedTimeMillis()%(duration+400), scale, containerX, containerY, lineWidth);
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
            if(touch.x<=lBound)lBound = touch.x;
            if(touch.x>=rBound)rBound = touch.x;
            if(touch.y<=tBound)tBound = touch.y;
            if(touch.y>=bBound)bBound = touch.y;
            
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
    ratio = (float)(rBound-lBound)/(bBound-tBound);
}
void Gesture::setScaleParams(int x, int y, int w, int h, Boolean allowScaleUp){
    containerX = x;
    containerY = y;
    if (ratio>float(w)/h) {
        scale = w/(float)(rBound-lBound);
        cout << scale<<endl;
        if(!allowScaleUp && scale>1){
            scale = 1;
            containerY += (h-bBound+tBound)/2;
            containerX += (w-rBound+lBound)/2;
        }
        else containerY += (h - (w/ratio))/2;
    }
    else{
        scale = h/(float)(bBound-tBound);
        if(!allowScaleUp && scale>1){
            scale = 1;
            containerY += (h-bBound+tBound)/2;
            containerX += (w-rBound+lBound)/2;
        }
        else containerX += (w - (h*ratio))/2;
    }
}
void Gesture::normalizePoints(){
    for(int i=0;i<traces.size();i++){
        for (int j=0; j<traces[i].points.size(); j++) {
            traces[i].points[j].x -= lBound;
            traces[i].points[j].y -= tBound;
        }
    }
}

void Gesture::addTrace(Trace trace){
    trace.color.setHue(20*traces.size()%255);
    traces.push_back(trace);
}
void Gesture::load(string str){
    vector<string> lines = ofSplitString(str, "||");
   
    vector<string> gestureInfo = ofSplitString(lines[0], ",");
    gestureGroup = ofToInt(gestureInfo[0]);
    duration = ofToInt(gestureInfo[1]);
    lBound = ofToInt(gestureInfo[2]);
    rBound = ofToInt(gestureInfo[3]);
    tBound = ofToInt(gestureInfo[4]);
    bBound = ofToInt(gestureInfo[5]);
    ratio = ofToFloat(gestureInfo[6]);
    
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
        result << gestureGroup << ","<< duration <<","<< lBound <<","<< rBound <<","<< tBound <<","<< bBound<<","<< ratio << "|";
        for (int i=0; i<traces.size(); i++) {
            for (int j=0;j<traces[i].points.size(); j++) {
                result << "|" << traces[i].points[j].x << "," << traces[i].points[j].y<< "," << traces[i].points[j].t;
            }
            result << "||";
        }
    }
    return result.str();
}
