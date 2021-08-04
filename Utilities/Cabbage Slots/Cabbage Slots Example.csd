<Cabbage>
form caption("Untitled") size(480, 150), guiMode("queue") pluginId("def1")
rslider bounds(250, 50, 50, 50), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

//Libraries 

#include "CABBAGESLOTSGUI.csd" ;This has to be imported first- contains gui opcodes for slot modules 

#include "CABBAGESLOTSDSP.csd" ;Contains slot modules 

opcode exampleEffect, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin ;Slots must have these input arguments 
    
    iIndex += 1 ;The index should be incremented by one because item one in the menu is "none"
    
        //GUI Code
        //You must include a block identifies if the slot is enabled 
        if kSelect == iIndex then
         kenabled = 1 
        else 
         kenabled = 0
        endif

        //You must use gui objects defined in the slot this effect is in. The slot update function will make the gui object appear as a parameter for this effect 
        //Each of these updates both reveals a slider with the correct diplay values and gets the value to be used in the dsp code         
        
        kgain slotSliderUpdate Sslot, 0, "gain", 0, 1, "gain", "amps","","", kenabled, 3, 2, 0, 1, 1, 1 
        kstate slotButtonUpdate Sslot, 1, "state", 0,0,"text(off, on)", kenabled, 2,2

        printk2 kstate
    
    if kSelect == iIndex && kBypass != 0 then    
        //DSP Code Goes Here
    
        // The DSP code must go in this if block so that it only runs when this slot is selected and not bypassed 
        
        kgain port kgain*kstate, 0.05
        
        aL *= kgain
        aR *= kgain
        
        
        
    endif
    

    xout aL, aR 


endop


instr 1
    kGain cabbageGetValue "gain"

    aL inch 1
    aR inch 2

    Sname = "exSlot"

    //Menu items must be given to the slot on creation and cannot be modified once initialized
    Smenu = "items(none, example)"
    
    Scontainer,kselect, kmix, kbypass slotCreate Sname, 10, 10, Smenu, 200, 100
  
    //Init the gui sliders and buttons
    
    Sparam, iId slotGuiInit Sname, 0, "rslider", "", ""
    Sparam, iId slotGuiInit Sname, 1, "button", "", ""
  
    aOutL = aL
    aOutR = aR
    
    aOutL, aOutR exampleEffect aOutL, aOutR, Sname, 1, kselect, kbypass


    kmix port kmix, 0.05
        
    aOutL = (aL*(1-kmix)+aOutL*kmix)*kbypass+aL*(1-kbypass)
    aOutR = (aR*(1-kmix)+aOutR*kmix)*kbypass+aR*(1-kbypass)


    idummy slotParamEditorCreate "exampleSlotEditor", 10, 110
    idummy slotParamEditorUpdate "exampleSlotEditor"

    outs aOutL*kGain, aOutL*kGain
endin

</CsInstruments>
<CsScore>



;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
