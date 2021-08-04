<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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


#include "CABBAGESLOTSGUI.csd" 


opcode myeffect, aa, aaSikk

    aL, aR, Sname, iIndex, kSelect, kBypass xin
    
    iIndex += 1 ;The index should be incremented by one because item one in the menu is "none"
    
        //GUI Code
        //You must include a block identifies if the slot is enabled 
        if kSelect == iIndex then
         kenabled = 1 
        else 
         kenabled = 0
        endif
        
        kgain slotSliderUpdate Sname, 0, "gain", 0, 1, "gain", "amps", "", "", kenabled, 3, 2, 0, 10, 1, 0.5
        kstate slotButtonUpdate Sname, 10, "state", 0, 0, "text(off,on) colour:0(red) colour:1(green)", kenabled, 2, 2, 0
         
        
        
     if kSelect == iIndex && kBypass != 0 then    
        //DSP Code Goes Here
        
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

;Declare slot name and menu items
Sname = "mySlot" 

;Create slot 

ix = 10
iy = 10
Smenu= "items(none, myeffect) colour(red)" 

Scontainer, kSelect, kMix, kBypass slotCreate Sname, ix, iy, Smenu, 200, 100

;Initialize GUI elements
Sslot, iId slotGuiInit Sname, 0, "rslider", "", ""
Sslot, iId slotGuiInit Sname, 10, "button", "", ""


;Slot opcodes

aL, aR myeffect aL, aR, Sname, 1, kSelect, kBypass


;mixing and bypass 

outs aL*kGain, aR*kGain


idummy slotParamEditorCreate "paramEdit", 10, 100
idummy slotParamEditorUpdate "paramEdit"

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
