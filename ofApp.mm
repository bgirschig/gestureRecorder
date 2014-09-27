#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofNoFill();
    traces = vector<Trace>();
    
    colorPalette.loadImage("colorPalette.jpg");
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(200, 200, 200);
    for(int i=0; i<currentTraces.size();i++) currentTraces[i].draw();
    for(int i=0; i<traces.size();i++) traces[i].draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    currentTraces.push_back(Trace(touch.id));
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    for(int i=0; i<currentTraces.size();i++){
        if(currentTraces[i].touchId == touch.id){
            currentTraces[i].addPoint(touch.x, touch.y, ofGetElapsedTimeMillis());
            break;
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    for(int i=0; i<currentTraces.size(); i++){
        if(currentTraces[i].touchId == touch.id){
            currentTraces[i].color = colorPalette.getColor((traces.size()%(colorPalette.width-1))+1, 0);
            currentTraces[i].duration = ofGetElapsedTimeMillis()-currentTraces[i].startTime;
            traces.push_back(currentTraces[i]);
            currentTraces.erase(currentTraces.begin()+i);
            break;
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
