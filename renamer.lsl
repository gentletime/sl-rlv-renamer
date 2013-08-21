// LSL script generated: renamer.lslp Wed Aug 21 20:02:33 Mitteleuropäische Sommerzeit 2013

list DIALOG_CHOICES = ["ResetRenamer","RenameMenu","SetOwner","RenameOn"];
list selected;

float Timeout = 60;
string PREV_PG_DIALOG_PREFIX = "< Page ";
string NEXT_PG_DIALOG_PREFIX = "> Page ";
string DIALOG_DONE_BTN = "Done";
string DIALOG_BACK_BTN = "<< Back";

key ToucherID;

integer channel_dialog;
integer listen_id;
integer pageNum;
integer N_DIALOG_CHOICES;
integer MAX_DIALOG_CHOICES_PER_PG = 9;

giveDialog(key ID,integer pageNum,list selection){
    list buttons;
    integer firstChoice;
    integer lastChoice;
    integer prevPage;
    integer nextPage;
    string OnePage;
    (N_DIALOG_CHOICES = llGetListLength(selection));
    if ((N_DIALOG_CHOICES <= 10)) {
        (buttons = selection);
        (OnePage = "Yes");
    }
    else  {
        integer nPages = (((N_DIALOG_CHOICES + MAX_DIALOG_CHOICES_PER_PG) - 1) / MAX_DIALOG_CHOICES_PER_PG);
        if (((pageNum < 1) || (pageNum > nPages))) {
            (pageNum = 1);
        }
        (firstChoice = ((pageNum - 1) * MAX_DIALOG_CHOICES_PER_PG));
        (lastChoice = ((firstChoice + MAX_DIALOG_CHOICES_PER_PG) - 1));
        if ((lastChoice >= N_DIALOG_CHOICES)) {
            (lastChoice = N_DIALOG_CHOICES);
        }
        if ((pageNum <= 1)) {
            (prevPage = nPages);
            (nextPage = 2);
        }
        else  if ((pageNum >= nPages)) {
            (prevPage = (nPages - 1));
            (nextPage = 1);
        }
        else  {
            (prevPage = (pageNum - 1));
            (nextPage = (pageNum + 1));
        }
        (buttons = llList2List(selection,firstChoice,lastChoice));
    }
    list buttons01 = llList2List(buttons,0,2);
    list buttons02 = llList2List(buttons,3,5);
    list buttons03 = llList2List(buttons,6,8);
    list buttons04;
    if ((OnePage == "Yes")) {
        (buttons04 = llList2List(buttons,9,11));
    }
    (buttons = (((buttons04 + buttons03) + buttons02) + buttons01));
    if ((OnePage == "Yes")) {
        (buttons = ([DIALOG_DONE_BTN,DIALOG_BACK_BTN] + buttons));
    }
    else  {
        (buttons = (((buttons = []) + [(PREV_PG_DIALOG_PREFIX + ((string)prevPage)),DIALOG_BACK_BTN,(NEXT_PG_DIALOG_PREFIX + ((string)nextPage)),DIALOG_DONE_BTN]) + buttons));
    }
    llDialog(ID,(("Page " + ((string)pageNum)) + "\nChoose one:"),buttons,channel_dialog);
}
 
 
CancelListen(){
    llListenRemove(listen_id);
    llSetTimerEvent(0);
}

default {

    state_entry() {
        (channel_dialog = ((-1) * ((integer)("0x" + llGetSubString(((string)llGetKey()),(-5),(-1))))));
        llOwnerSay("Hello Scripter");
    }

    touch_start(integer total_number) {
        (selected = DIALOG_CHOICES);
        (ToucherID = llDetectedKey(0));
        (listen_id = llListen(channel_dialog,"",ToucherID,""));
        llSetTimerEvent(Timeout);
        (pageNum = 1);
        giveDialog(ToucherID,pageNum,selected);
    }

    listen(integer channel,string name,key id,string choice) {
        if ((choice == "-")) {
            giveDialog(ToucherID,pageNum,selected);
        }
        else  if ((choice == DIALOG_DONE_BTN)) {
            CancelListen();
            return;
        }
        else  if ((choice == DIALOG_BACK_BTN)) {
            CancelListen();
        }
        else  if ((llSubStringIndex(choice,PREV_PG_DIALOG_PREFIX) == 0)) {
            (pageNum = ((integer)llGetSubString(choice,llStringLength(PREV_PG_DIALOG_PREFIX),(-1))));
            giveDialog(ToucherID,pageNum,selected);
        }
        else  if ((llSubStringIndex(choice,NEXT_PG_DIALOG_PREFIX) == 0)) {
            (pageNum = ((integer)llGetSubString(choice,llStringLength(NEXT_PG_DIALOG_PREFIX),(-1))));
            giveDialog(ToucherID,pageNum,selected);
        }
        else  if ((llSubStringIndex(choice,NEXT_PG_DIALOG_PREFIX) == 0)) {
        }
    }
}
