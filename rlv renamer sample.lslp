integer gagchan = 1725;
integer emotechan = 1726;
integer active=TRUE;
integer randIntBetween(integer min, integer max)
{
    return min + randInt(max - min);
}

integer randInt(integer n)
{
    return (integer)llFrand(n + 1);
}

default
{
    touch_start(integer num_detected)
    {
        active=!active;
        if (active)
        {
            llSetColor(<1.0,1.0,1.0>,ALL_SIDES);
            llOwnerSay("@redirchat:"+(string)gagchan+"=add");
            llOwnerSay("@emote=add,rediremote:"+(string)emotechan+"=add");

        }
        else
        {
            llSetColor(<0.0,0.0,0.0>,ALL_SIDES);
            llOwnerSay("@clear"); 
        }
    }

    state_entry()
    {
        gagchan=randIntBetween(1000,9999);
        emotechan=gagchan+1;
        llListen(gagchan,"",llGetOwner(),"");
        llListen(emotechan,"",llGetOwner(),"");
        
        if (llGetAttached())
        {
            llSetColor(<1.0,1.0,1.0>,ALL_SIDES);
            llOwnerSay("@redirchat:"+(string)gagchan+"=add");
            llOwnerSay("@emote=add,rediremote:"+(string)emotechan+"=add");
        }
    }

            
    attach(key id)
    {
        if (id == NULL_KEY)
        {
            llOwnerSay("@clear");
        }
    }

    on_rez(integer param)
    {
        llResetScript();
    }
    
    listen(integer chan, string who, key id, string msg)
    {
        if (id ==llGetOwner())
        {
            if (chan==gagchan)
            {
                    llSay(0, msg);
            }
            else if (chan==emotechan)
            {
                llSay(0, msg);
            }
        }
    }
}
