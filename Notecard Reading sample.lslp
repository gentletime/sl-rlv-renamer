//Notecard Reading template
//Copyright 2007, Gigs Taggart
//Released under BSD license
//http://www.opensource.org/licenses/bsd-license.php
 
key gSetupQueryId;
integer gSetupNotecardLine;
string  gSetupNotecardName = "setup";
 
//define config variables here
string gPassword;
 
 
readSettingsNotecard()
{
	gSetupNotecardLine = 0;
   gSetupQueryId = llGetNotecardLine(gSetupNotecardName,gSetupNotecardLine); 
}
 
 
default
{
    state_entry()
    {
         readSettingsNotecard();
    }
    dataserver(key queryId, string data)
    {
        if(queryId == gSetupQueryId) 
        {
            if(data != EOF)
            {
                list tmp = llParseString2List(data, ["="], []);
                string setting = llList2String(tmp,0);
 
                if (setting == "password")
                {
                    gPassword=llList2String(tmp,1);
                }
                //add more if statements here, for each config variable
                //you can also do stuff like variable=val1,val2,val3, simply
                //do llCSV2List(llList2String(tmp,1));
 
                gSetupQueryId = llGetNotecardLine(gSetupNotecardName,++gSetupNotecardLine); 
            }
            else
            {
                state running;   
            }
        }
    }           
    changed(integer change)
    {
        if (change&CHANGED_INVENTORY)
            llResetScript();
    }
}
 
state running
{
 
    changed(integer change)
    {
        if (change&CHANGED_INVENTORY)
            llResetScript();
    }
}