//
//  Menu.mm
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#include "Menu.h"

Menu::Menu(){
    stage = 3;
    btnText = "BEGIN";
    font.loadFont("Futura.ttc", 12);
    hasTouch = false;
}
Boolean Menu::click(int mouseY){
    if(stage==2 && mouseY>ofGetWindowHeight()-Settings::menuBtnHeight*2){
        hasTouch = true;
        if(mouseY<ofGetWindowHeight()-Settings::menuBtnHeight){
            stage = 1;
            btnText = "SAVE";
        }
        else{
            stage = 0;
            btnText = "NEW";
        }
    }
    else if(mouseY>ofGetWindowHeight()-Settings::menuBtnHeight){
        hasTouch = true;
        if(stage == 0){
            stage = 1;
            btnText = "SAVE";
        }
        else if(stage == 1){
            stage = 2;
            btnText = "OK";
        }
        else if(stage==3){
            stage = 5;
            btnText = "ADD VERSION";
        }
        else if(stage==5){
            stage = 0;
            btnText = "NEW";
        }
    }
    return hasTouch;
}
void Menu::draw(){
    ofFill();
    ofSetColor(176);
    ofRect(0, ofGetWindowHeight()-Settings::menuBtnHeight, ofGetWindowWidth(), ofGetWindowHeight()-Settings::menuBtnHeight);
    ofSetColor(255);
    int w = font.stringWidth(btnText);
    font.drawString(btnText, ofGetWindowWidth()/2-(w/2), ofGetWindowHeight()-Settings::menuBtnHeight+(Settings::menuBtnHeight/2)+6);
}