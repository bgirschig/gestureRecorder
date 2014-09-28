#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofNoFill();
    currentGesture = Gesture();
    menu = Menu();
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(200, 200, 200);
    currentGesture.draw();
    menu.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(menu.click(touch.y)==false) currentGesture.touchDown(touch);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(!menu.hasTouch) currentGesture.touchMove(touch);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    if(!menu.hasTouch) currentGesture.touchUp(touch);
    menu.hasTouch = false;
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
