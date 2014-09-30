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
    homegrid.gestures.push_back(Gesture("17273368 3477\n3572|189,194,0|181,194,17|163,194,34|143,194,51|126,198,68|100,209,86|84,222,104|70,238,120|60,253,138|55,266,155|50,281,172|46,305,189|46,324,206|48,346,224|56,367,241|69,388,258|85,404,275|103,418,294|117,425,311|140,429,327|159,429,344|180,426,362|199,417,378|216,403,395|234,389,413|248,373,430|260,354,448|265,339,465|270,312,483|271,288,500|270,264,517|264,242,534|257,227,551|249,212,568|242,200,584|235,192,601|227,188,619|217,185,636|208,184,653|193,184,670|181,186,688|169,189,704|163,191,722|156,192,739|154,194,756\n3112|109,254,0|109,246,18|112,238,35|116,229,52|121,222,69|125,218,86|131,214,103|134,213,119|138,212,136|141,212,154|145,212,171|148,213,188|150,219,205|152,229,223|153,237,240|154,244,256|154,245,275|154,247,292|154,248,308\n3078|173,232,0|175,228,17|181,221,34|188,213,51|194,206,68|200,200,86|204,198,104|207,197,121|209,197,138|210,197,155|212,200,172|214,207,189|216,224,207|216,239,223|216,255,240|215,264,258|214,267,274\n3683|108,268,0|108,275,17|108,310,46|108,333,64|108,347,81|108,361,97|108,371,114|108,379,131|113,385,148|119,393,167|125,398,184|129,399,201|135,401,218|144,402,234|152,402,252|163,399,269|177,388,286|188,375,303|196,358,321|202,343,338|206,326,355|208,311,372|209,297,389|209,286,406|209,278,423|209,272,440|209,269,457|209,268,474|209,268,491|208,268,556|207,268,601|200,272,630|191,276,647|173,283,665|148,290,681|128,295,698|104,297,715|84,297,733|75,297,751|70,297,768|68,297,785|67,297,802"));
}
void ofApp::menuEvent(MenuEvent &e) {
    ofstream ofs("/Applications/of_v0.8.4_ios_release/apps/myApps/GestureRecorder/bin/data/fifthgrade.ros", ios::binary);
	ofs.write((char *)&currentGesture, sizeof(currentGesture));
    
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
