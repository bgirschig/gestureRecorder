#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofNoFill();
    currentGesture = Gesture();
    menu = Menu();
    homegrid = Homegrid(Settings::homeGridMargin, Settings::homeGridColCount);
    homegrid.gestures.push_back(Gesture());
    homegrid.gestures.push_back(Gesture());
    homegrid.gestures.push_back(Gesture());
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(200, 200, 200);
    currentGesture.draw();
    menu.draw();
    if(menu.stage==0) homegrid.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(menu.click(touch.y)==false){
        if(menu.stage==0){
            int selected = homegrid.onClick(touch.x, touch.y);
            if(selected>=0){
                currentGesture = homegrid.gestures[selected];
                menu.gotoStage(3);
            }
        }
        else currentGesture.touchDown(touch);
    }
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
