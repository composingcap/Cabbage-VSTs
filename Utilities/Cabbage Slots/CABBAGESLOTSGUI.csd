
chnset 0.0, "slotLastSelectedValue"

/*
slotGuiInit will create and initalize a slot gui item 
params:
    Sslot   :   the slot identifier 
    iId     :   the gui items id number 
    SType   :   the type of gui item 
    SGui    :   any custom gui code that effects the slider can be set as a string here 
    SlableGui:  any custom information that effects the label above the gui can be set as a string here 
*/
opcode slotGuiInit, Si, SiSSS
    Sslot, iId, SType, SGui, SlableGui xin 

    Sname sprintf "%s.Param%d", Sslot, iId
    
    Screate sprintf "bounds(0,0,30,30) colour(56, 150, 180, 255) trackerColour(56,255,182,255) outlineColour(17,37,37,155) channel(%s) parent(%s.slot) visible(0) %s", Sname, Sslot, SGui
    cabbageCreate SType, Screate
    
    

    Screate sprintf "channel(%sl) parent(%s.slot) text(param %d) fontColour(white) visible(0) %s", Sname, Sslot, iId, SlableGui
    cabbageCreate "label", Screate
    
    
    xout Sslot, iId

endop 

/*
slotSliderUpdate will modify and existing slot slider to certain display parameters. 
params:
    Sslot   :   the slot identifier 
    iId     :   the id number of the gui object 
    Sname   :   the name of the parameter for internal use 
    icol    :   column position of the gui slider 
    irow    :   row of the gui object 
    SdisplayName: the name displayed on the slider 
    Sunit   :   the unit displayed 
    Sgui    :   any custom gui code that effects the slider can be set as a string here 
    Sguil   :   any custom information that effects the label above the gui can be set as a string here 
    kenabled:   flag to enable and disable the gui display
        
optional:
    iw      :   the number of columns- sizes are based on the slots size  (default 4) 
    ih      :   the number of rows- sizes are based on the slot size  (default 2) 
    imin    :   minimum displayed value (default 0) 
    imax    :   maximum displayed value (default 1) 
    ifact   :   exponent to which the normalized range is mapped (default 1) 
    idefault:   a default value for the slider 
*/

opcode slotSliderUpdate, k,SiSiiSSSSkoooppo
    
    Sslot, iId, Sname, icol, irow, SdisplayName, Sunit, Sgui, Sguil, kenabled, iw, ih, imin, imax, ifact, idefault  xin


    
    kinit init 1 

    Schan sprintf "%s.Param%d", Sslot, iId

    if ih == 0 then 
        ih = 2
    endif
    
    if iw == 0 then 
        iw = 4
    endif

    iBounds[] cabbageGet sprintf("%s.slot",Sslot), "bounds"
    Slabel sprintf "%sl",Schan

   
   kNewVal init imin
   
   kturnoff chnget sprintf("%s.turnoff", Schan) ;Deals with out of order turn off
    
   if kenabled == 1 then 
          
       SselSlot chnget "slotLastSelectedSlot"
       SselName chnget "slotLastSelectedName"
        if strcmpk(SselSlot,Sslot)==0 && strcmpk(SselName, Sname)==0 then 
                kNewVal chnget "slotLastSelectedValue"
                //printk2(kNewVal)
                if changed2:k(kNewVal)==1 then 
                kVal scale  kNewVal, 0,1, imin, imax
                kVal  pow kVal, 1/ifact
                kVal limit kVal, 0,1
                cabbageSetValue Schan, kVal
                endif
                
            endif
        
   
       kVal cabbageGetValue Schan
       kNewVal = pow(kVal, ifact)
    
       kNewVal scale  kNewVal, imin, imax
    
       kNewVal = round(kNewVal*100)/100


   endif 
   if changed2:k(kNewVal)==1 then 
        cabbageSet k(1), Schan, "popupText", sprintfk("%s: %.2f %s",SdisplayName, kNewVal, Sunit)
    endif 
    
    if changed2:k(kenabled)==1 || kturnoff == 1 then 

        if kenabled == 1 then 
            
            cabbageSet k(1), Schan, "visible", 1
            cabbageSet k(1), Slabel, "visible", 1
            cabbageSet k(1), Slabel, "text", SdisplayName
            cabbageSet k(1), Slabel, "bounds", icol*iBounds[2]/iw+iBounds[2]/(iw*6), irow*iBounds[3]/ih,  iBounds[2]/(iw*1.5), iBounds[3]/(ih*4)
            cabbageSet k(1), Schan, "bounds", icol*iBounds[2]/iw+iBounds[2]/(iw*6), irow*iBounds[3]/ih+iBounds[3]/(ih*6),  iBounds[2]/(iw*1.5), iBounds[3]/(ih*1.25)
            cabbageSet k(1), Schan, "popupText", sprintfk("%s: %.2f %s",SdisplayName, kNewVal, Sunit)
            
            cabbageSet k(1), Schan, Sgui
            cabbageSet k(1), Slabel, Sguil
            
            chnset k(0), sprintf("%s.turnoff", Schan)
            kVal scale  idefault, 0,1, imin, imax
            kVal  pow kVal, 1/ifact
            kVal limit kVal, 0,1
            cabbageSetValue Schan, kVal
            cabbageSet k(1), Schan, "defaultValue", kVal 

            
        elseif kturnoff == 0 then   
            cabbageSet k(1), Schan, "visible", 0
             cabbageSet k(1), Slabel, "visible", 0
             chnset k(1), sprintf("%s.turnoff", Schan)
            endif
    endif 

    if changed2:k(kNewVal) == 1 then 
        chnset sprintfk("%s", Sslot), "slotLastSelectedSlot"
        chnset sprintfk("%s", Sname), "slotLastSelectedName"
        chnset sprintfk("%.2f - %.2f", imin, imax), "slotLastSelectedRange"
        chnset kNewVal, "slotLastSelectedValue"
        
    
    endif 
    
    kinit = 0 


    xout kNewVal

endop


/* 
slotButtonUpdate will modify and existing slot button to certain display parameters. 
params:
    Sslot   :   the slot identifier 
    iId     :   the id number of the gui object 
    Sname   :   the name of the parameter for internal use 
    icol    :   column position of the gui slider 
    irow    :   row of the gui object 
    Sgui    :   any custom gui code that effects the slider can be set as a string here 
    kenabled:   flag to enable and disable the gui display
        
optional:
    iw      :   the number of columns- sizes are based on the slots size  (default 4) 
    ih      :   the number of rows- sizes are based on the slot size  (default 2) 
    idefault:   a default value for the slider 

*/
opcode slotButtonUpdate, k,SiSiiSkooo 
    
    Sslot, iId, Sname, icol, irow, Sgui, kenabled, iw, ih, idefault  xin


    if ih == 0 then 
        ih = 2
    endif
    
    if iw == 0 then 
        iw = 4
    endif
  
    Schan sprintf "%s.Param%d", Sslot, iId

    iBounds[] cabbageGet sprintf("%s.slot",Sslot), "bounds"
    Slabel sprintf "%sl",Schan

   
   kVal init 0
    kturnoff chnget sprintf("%s.turnoff", Schan) ;Deals with out of order turn off
    
   if kenabled == 1 then 
       kVal cabbageGetValue Schan   
   endif 

    if changed2:k(kenabled) == 1 || kturnoff == 1 then 

        if kenabled == 1 then 
            
            cabbageSet k(1), Schan, "visible", 1
            cabbageSet k(1), Schan, "text", Sname
            cabbageSet k(1), Schan, "bounds", icol*iBounds[2]/iw+iBounds[2]/(iw*6), irow*iBounds[3]/ih+iBounds[3]/(ih*6),  iBounds[2]/(iw*1.05), iBounds[3]/(ih*1.25)/1.75           
            cabbageSet k(1), Schan, Sgui
            chnset k(0), sprintf("%s.turnoff", Schan)
            cabbageSetValue Schan, k(idefault) 
            
        elseif kturnoff == 0 then     
            cabbageSet k(1), Schan, "visible", 0
            chnset k(1), sprintf("%s.turnoff", Schan)

            endif
    endif 

    xout kVal

endop

/*
    slotParamEditorCreate generates a parameter editor that allows a user to see and imput data to the slider they are modifying 
    params:
        SName : idetnifier for the parameter name 
        SRange: identifier for the parameter range 
        SValue: identifier for the parameter value 
        ix: x position 
        iy: y position 
    
*/

opcode slotParamEditorCreate, i, Soo 


    SName, ix, iy xin 
    
    SRange sprintf "%s_range", SName
    SValue sprintf "%s_value", SName

    cabbageCreate "image",  sprintf("bounds(%f,%f,450,30) colour(76,130,180,155) outlineColour(black) outlineThickness(2) channel(_slotparamedit)", ix, iy)
    cabbageCreate "label", sprintf("bounds(10,5,150,20) readOnly(1) channel(%s) parent(_slotparamedit) presetIgnore(1) automatable(0) align(right) fontColour(white)", SName)
    cabbageCreate "texteditor", sprintf("bounds(170,5,100,20) channel(%s) parent(_slotparamedit) presetIgnore(1) automatable(0) colour(black) fontColour(white)", SValue)
    cabbageCreate "label", sprintf("bounds(275,5,150,20) readOnly(1) text(0000 - 0000) channel(%s) parent(_slotparamedit) presetIgnore(1) automatable(0) align(left) fontColour(lightgrey)", SRange)

    xout 1
endop


/*
    slotParamEditorUpdate updates the param editor based on the last changed slider parameter 
    params:
        SName : idetnifier for the parameter name 
        SRange: identifier for the parameter range 
        SValue: identifier for the parameter value     
*/
opcode slotParamEditorUpdate, i,S
    
    SName xin
    
    SRange sprintf "%s_range", SName
    SValue sprintf "%s_value", SName
    
    SselectedName chnget "slotLastSelectedName"
    SselectedSlot chnget "slotLastSelectedSlot"
    kSelectedVal chnget  "slotLastSelectedValue"
    Srange chnget "slotLastSelectedRange"

    SthisVal = sprintfk("%.2f",kSelectedVal)
    SNewVal cabbageGet SValue

    if changed2:k(SselectedSlot) == 1 || changed2:k(SselectedName) == 1  then 
        cabbageSet k(1), SName, "text", sprintfk("%s: %s",SselectedSlot, SselectedName)
        cabbageSet k(1), SRange, "text", sprintfk("%s", Srange)
    
    endif 

    if changed2:k(kSelectedVal) == 1 then 

        cabbageSet k(1), SValue, "text", SthisVal

    endif

    if strcmp(SthisVal, SNewVal)!= 0 && changed2:k(SNewVal)==1 then 
        if strlenk(SNewVal) > 0 then
            SNewVal init "0.0"
            kNewVal strtodk SNewVal
            printk2(kNewVal)
            chnset kNewVal, "slotLastSelectedValue"
        endif 

    endif
    
    
    kinit init 1 

    if kinit == 1 then 
        chnset "", "slotLastSelectedName"
        chnset "none", "slotLastSelectedSlot"
    endif
    
    kinit = 0 
    
    xout 0 
    
endop 

opcode slotCreate, Skkk,SiiSoo
    
    Sname, ix, iy, Smenu, iw, ih xin 
    
    if ih == 0 then 
        ih = 100
    endif 
    
    if iw == 0 then 
    iw = 150
    endif 
    
    
    Scontainer =  sprintf("%s.container", Sname)
    
    Screate sprintf "bounds(%f, %f, %f, %f) channel(%s) colour(0,0,0,0)", ix, iy, iw, ih, Scontainer
    
    cabbageCreate "image", Screate 
    
    Screate sprintf "bounds(5,5,95,16) channel(%s.select) parent(%s) %s", Sname, Scontainer, Smenu
    
    cabbageCreate "combobox", Screate 
    
    Screate sprintf "bounds(%f, %f, %f, %f) channel(%s.slot) parent(%s) colour(52, 88, 140, 255)", 5, 20, iw-10, 70, Sname, Scontainer
    
    cabbageCreate "image", Screate 
    
    
    Screate sprintf "colour(56, 150, 180, 255) trackerColour(56,255,182,255) outlineColour(17,37,37,155) bounds(%f, %f, %f, %f) channel(%s.mix) parent(%s.container) colour(0,0,0) value(1) popupPrefix(mix: )", 102, 2, 20, 20, Sname, Sname
    
    cabbageCreate "rslider", Screate 
    
    Screate sprintf "outlineColour(17,37,37,155) bounds(%f, %f, %f, %f) channel(%s.bypass) parent(%s.container) colour(0,0,0) value(1) text(-|x|-, -|-|-) colour:0(79,79,79,105) colour:1(MediumTurquoise) colour:0(DarkSlateGrey)", 125, 6, 20, 10, Sname, Sname
    
    cabbageCreate "button", Screate 
    
    cabbageSet Scontainer, "toFront", 1 
    

    
    kBypass = chnget:k(sprintf("%s.bypass", Sname));
    kMix = chnget:k(sprintf("%s.mix", Sname));
    kSelect = chnget:k(sprintf("%s.select", Sname));
    xout Scontainer, kSelect, kMix, kBypass

endop