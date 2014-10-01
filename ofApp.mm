#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    font.loadFont("futura.ttf", 12);
    ofNoFill();
    
    currentGesture = Gesture();
    
    menu = new Menu();
    homegrid = Homegrid(Settings::homeGridMargin, Settings::homeGridColCount);
    
    ofAddListener(MenuEvent::events, this, &ofApp::menuEvent);
    loadExisting();
}
void ofApp::loadExisting(){
    string action_url = "http://bastiengirschig.fr/GestureRecorder/gestureLoader.php?loadData";
	ofAddListener(httpUtils.newResponseEvent,this,&ofApp::newResponse);
	httpUtils.start();

    ofxHttpForm form;
	form.action = action_url;
	httpUtils.addForm(form);
}
void ofApp::newResponse(ofxHttpResponse & response){
    if (response.status == 200){
        vector<string> gestureStrings = ofSplitString(response.responseBody, "\r");
        for (int i=0; i<gestureStrings.size()-1; i++) {
            homegrid.AddGesture(Gesture(gestureStrings[i]));
        }
    }
    else{
        ofRemoveListener(httpUtils.newResponseEvent,this,&ofApp::newResponse);
        httpUtils.stop();
    }
    currentGesture.gestureGroup = homegrid.gestures.size();
}

void ofApp::menuEvent(MenuEvent &e) {
    if(e.message == "save"){
        // add to homeGrid
        homegrid.AddGesture(currentGesture);
        
        // save to server
        ofxHttpForm form;
        form.action = "http://bastiengirschig.fr/GestureRecorder/gestureLoader.php?saveData&&dataString="+currentGesture.toString(false);
        httpUtils.addForm(form);
        
        //reset "current gesture"
        currentGesture = Gesture();
        currentGesture.gestureGroup = homegrid.gestures.size();
    }
    else if(e.message=="backToHome"){
        currentGesture = Gesture();
    }
    else if(e.message == "displayResult"){
        currentGesture.normalizePoints();
        currentGesture.setScaleParams(10, 10, ofGetWindowWidth()-10, ofGetWindowHeight()-(2*Settings::menuBtnHeight)-10, false);
    }
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(200, 200, 200);
    if(menu->stage==0) homegrid.draw();
    else if(menu->stage==2||menu->stage==3) currentGesture.draw();
    ofFill();
    menu->draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(menu->click(touch.y)==false){
        if(menu->stage==0){
            int selected = homegrid.onClick(touch.x, touch.y);
            if(selected>=0){
                currentGesture = homegrid.gestures[selected];
                currentGesture.setScaleParams(0, 0, ofGetWindowWidth(), ofGetWindowHeight(), false);
                currentGesture.lineWidth = Settings::lineWidth;
                menu->gotoStage(3);
            }
        }
        else currentGesture.touchDown(touch);
    }
}
//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(!menu->hasTouch && (menu->stage==1 || menu->stage==5)) currentGesture.touchMove(touch);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    if(!menu->hasTouch && (menu->stage==1 || menu->stage==5)) currentGesture.touchUp(touch);
    menu->hasTouch = false;
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
