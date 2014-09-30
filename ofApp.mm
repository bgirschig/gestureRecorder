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
    homegrid.gestures.push_back(Gesture("17261080 3358\n|118,165,47|115,165,65|108,165,82|99,165,98|91,165,116|84,167,132|78,171,149|74,178,167|72,191,185|72,208,202|72,222,219|73,245,237|76,256,254|82,268,271|90,276,288|105,281,305|119,281,323|135,275,340|149,266,357|160,252,375|166,241,393|172,220,410|173,200,428|172,184,444|166,167,461|157,157,478|147,149,495|135,144,512|124,143,529|114,143,547|109,143,564|106,145,581|105,149,598\n|89,183,1249|94,183,1266|97,183,1284|102,183,1300|104,183,1317|105,183,1334\n|121,182,1697|126,182,1715|130,182,1732|135,182,1749|139,182,1766|141,182,1783|142,182,1800|143,182,1817\n|105,197,2235|105,201,2253|105,206,2271|105,211,2288|105,217,2305|105,219,2322\n|88,213,2822|88,215,2839|88,219,2856|88,222,2873|88,225,2891|88,227,2908|89,227,2956|95,228,2973|98,228,2990|103,229,3007|108,229,3025|111,229,3043|115,229,3061|119,228,3078|121,225,3095|122,221,3112|124,214,3128|124,209,3146|124,205,3163|124,202,3180|124,200,3198|124,199,3215"));
}
void ofApp::menuEvent(MenuEvent &e) {
//    ofstream ofs("/Applications/of_v0.8.4_ios_release/apps/myApps/GestureRecorder/bin/data/fifthgrade.ros", ios::binary);
//	ofs.write((char *)&currentGesture, sizeof(currentGesture));
    
    if(e.message == "save"){
        homegrid.gestures.push_back(currentGesture);
        cout << currentGesture.toString(false);
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
