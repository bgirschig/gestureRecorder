#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    loadExisting();
    
    font.loadFont("futura.ttf", 12);
    ofNoFill();
    
    
    currentGroup = GestureGroup(homegrid.gestures.size(), Gesture());
    
    menu = new Menu();
    homegrid = Homegrid(Settings::homeGridMargin, Settings::homeGridColCount);
    
    ofAddListener(MenuEvent::events, this, &ofApp::menuEvent);
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
    currentGroup = GestureGroup(homegrid.gestures.size(), Gesture());
}

void ofApp::menuEvent(MenuEvent &e) {
    if(e.message == "save"){
        // add to homeGrid
        homegrid.AddGroup(currentGroup);
        
        // save to server
        ofxHttpForm form;
        form.action = "http://bastiengirschig.fr/GestureRecorder/gestureLoader.php?saveData&&dataString="+currentGroup.getCurrent().toString(false);
        httpUtils.addForm(form);
        
        //reset "current gesture"
        currentGroup = GestureGroup(homegrid.gestures.size(), Gesture());
    }
    else if(e.message=="backToHome"){
        currentGroup = GestureGroup(homegrid.gestures.size(), Gesture());
    }
    else if(e.message == "displayResult"){
        currentGroup.getCurrent().normalizePoints();
        currentGroup.getCurrent().setScaleParams(10, 10, ofGetWindowWidth()-10, ofGetWindowHeight()-(2*Settings::menuBtnHeight)-10, false);
    }
    else if(e.message == "newGesture"){
        currentGroup = GestureGroup(homegrid.gestures.size(), Gesture());
    }
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(200, 200, 200);
    if(menu->stage==0) homegrid.draw();
    else if(menu->stage==2||menu->stage==3) currentGroup.draw();
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
                currentGroup = homegrid.gestures[selected];
                currentGroup.getCurrent().setScaleParams(0, 0, ofGetWindowWidth(), ofGetWindowHeight()-(2*Settings::menuBtnHeight), false);
                currentGroup.getCurrent().lineWidth = Settings::lineWidth;
                menu->gotoStage(3);
            }
        }
        else if(menu->stage==3){
            if(touch.x<100) currentGroup.gotoPrev();
            else if(touch.x>ofGetWindowWidth()-100) currentGroup.gotoNext();
            currentGroup.getCurrent().lineWidth = Settings::lineWidth;
            currentGroup.getCurrent().setScaleParams(0, 0, ofGetWindowWidth(), ofGetWindowHeight()-(2*Settings::menuBtnHeight), false);
        }
        else currentGroup.getCurrent().touchDown(touch);
    }
}
//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(!menu->hasTouch && (menu->stage==1 || menu->stage==5)) currentGroup.getCurrent().touchMove(touch);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    if(!menu->hasTouch && (menu->stage==1 || menu->stage==5)) currentGroup.getCurrent().touchUp(touch);
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
