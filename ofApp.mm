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
    cout<<"load\n";
//    string action_url = "http://localhost:8888/GestureRecorderServer/gestureLoader.php";
    string action_url = "http://bastiengirschig.fr/GestureRecorder/gestureLoader.php";
	ofAddListener(httpUtils.newResponseEvent,this,&ofApp::newResponse);
	httpUtils.start();
    
    ofxHttpForm form;
	form.action = action_url;
	form.method = OFX_HTTP_POST;
	form.addFormField("loadData", "");
	form.addFile("file","ofw-logo.gif");
	httpUtils.addForm(form);
    
//
}
void ofApp::newResponse(ofxHttpResponse & response){
//    cout << ofToString(response.status) + ": " + (string)response.responseBody;
    vector<string> gestureStrings = ofSplitString(response.responseBody, "\r");
    for (int i=0; i<gestureStrings.size()-1; i++) {
        homegrid.gestures.push_back(Gesture(gestureStrings[i]));
        cout << "====================" << endl;
        cout << gestureStrings[i] << endl;
        cout << homegrid.gestures[homegrid.gestures.size()-1].toString(true)<<endl;
    }
}

void ofApp::menuEvent(MenuEvent &e) {
//    ofstream ofs("/Applications/of_v0.8.4_ios_release/apps/myApps/GestureRecorder/bin/data/fifthgrade.ros", ios::binary);
//	ofs.write((char *)&currentGesture, sizeof(currentGesture));
    if(e.message == "save"){
        homegrid.gestures.push_back(currentGesture);
        currentGesture = Gesture();
    }
    else if(e.message=="backToHome"){
        currentGesture = Gesture();
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
