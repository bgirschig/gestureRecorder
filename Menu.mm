//
//  Menu.mm
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#include "Menu.h"

Menu::Menu(){
    stage = 0;
    btnText = "NEW";
    font.loadFont("futura.ttf", Settings::menuFontSize);
    hasTouch = false;
}
Boolean Menu::click(int mouseY){
    if((stage==2 || stage==3 || stage==5) && mouseY>ofGetWindowHeight()-Settings::menuBtnHeight*2){
        hasTouch = true;
        if(mouseY<ofGetWindowHeight()-Settings::menuBtnHeight){
            gotoStage(0);
            static MenuEvent newEvent;
            newEvent.message = "backToHome";
            ofNotifyEvent(MenuEvent::events, newEvent);
        }
        else{
            if(stage==2){
                static MenuEvent newEvent;
                newEvent.message = "save";
                ofNotifyEvent(MenuEvent::events, newEvent);
                gotoStage(0);
            }
            else if(stage == 3){
                static MenuEvent newEvent;
                newEvent.message = "newVersion";
                ofNotifyEvent(MenuEvent::events, newEvent);
                gotoStage(5);
            }
            else if(stage == 5){
                static MenuEvent newEvent;
                newEvent.message = "addVersion";
                ofNotifyEvent(MenuEvent::events, newEvent);
                gotoStage(0);
            }
        }
    }
    else if(mouseY>ofGetWindowHeight()-Settings::menuBtnHeight){
        hasTouch = true;
        if(stage == 0){
            static MenuEvent newEvent;
            newEvent.message = "newGesture";
            ofNotifyEvent(MenuEvent::events, newEvent);
            gotoStage(1);
        }
        else if(stage == 1){
            static MenuEvent newEvent;
            newEvent.message = "displayResult";
            ofNotifyEvent(MenuEvent::events, newEvent);
            gotoStage(2);
        }
    }
    return hasTouch;
}
void Menu::gotoStage(int _stage){
    switch (_stage) {
        case 0:
            stage = _stage;
            btnText = "NEW";
            break;
        case 1:
            stage = _stage;
            btnText = "DONE";
            break;
        case 2:
            btnText = "SAVE";
            stage = _stage;
            break;
        case 3:
            btnText = "REPRODUCE";
            stage = _stage;
            break;
        case 4:
            btnText = "...wait";
            stage = _stage;
            break;
        case 5:
            btnText = "SAVE";
            stage = _stage;
            break;
            
        default:
            break;
    }
}

void Menu::draw(){
    ofFill();
    ofSetColor(176);
    
    ofRect(0, ofGetWindowHeight()-Settings::menuBtnHeight, ofGetWindowWidth(), Settings::menuBtnHeight);
    if(stage==2 || stage==3 || stage==5) ofRect(0, ofGetWindowHeight()-(2.07*Settings::menuBtnHeight), ofGetWindowWidth(),Settings::menuBtnHeight);
    ofSetColor(255);
    int w = font.stringWidth(btnText);
    font.drawString(btnText, ofGetWindowWidth()/2-(w/2), ofGetWindowHeight()-Settings::menuBtnHeight+(Settings::menuBtnHeight/2)+6);
    if(stage==2 || stage==3 || stage==5){
        w = font.stringWidth("CANCEL");
        font.drawString("CANCEL", ofGetWindowWidth()/2-(w/2), ofGetWindowHeight()-(2.07*Settings::menuBtnHeight)+(Settings::menuBtnHeight/2)+6);
    }
}