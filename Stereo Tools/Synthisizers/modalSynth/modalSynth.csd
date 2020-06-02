<Cabbage>
form caption("Modal Synth") size(800, 800), colour(58, 110, 182), pluginid("cpmd")
image bounds(0, 0, 700, 240) visible(1) popup(0){
checkbox bounds(10,10,20,20) widgetarray("enable", 23) identchannel("enable_ident0") channel("enable0") value(0)
nslider bounds(40,10,40,20) widgetarray("note", 23) identchannel("note_ident0") channel("note0")
rslider bounds(85,10,20,20) range(0,1,0.5,1,0.001) widgetarray("q", 23) identchannel("q_ident0") channel("q0") 
rslider bounds(110,10,20,20) range (0, 1, 0.25, 0.5, 0.001)widgetarray("gain", 23) identchannel("gain_ident0") channel("gain0") 
rslider bounds(135,10,20,20) widgetarray("pan", 23) identchannel("pan_ident0") channel("pan0") value(0.5)
}
combobox items("stereo", "discrete channels (24)") bounds(10,280,80,20) channel("outputMode")
button text("all on") bounds(10,320,80,20) channel("allOn") identchannel("allOn_ident")
button text("all off") bounds(100,320,80,20) channel("allOff") 
button text("randomize notes") bounds(200,320,160,20) channel("randNotes") 
button text("randomize q") bounds(200,350,160,20) channel("randQ") 
hrange bounds(375,350,160,20) range(25, 2500, 100:250, 0.5, 1) channel("qMin","qMax")
button text("randomize gain") bounds(200,380,160,20) channel("randGain") 
button text("randomize pan") bounds(200,410,160,20) channel("randPan") 
keyboard bounds(8, 700, 700, 50)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 24
0dbfs = 1

;instrument will be triggered by keyboard widget

opcode resonbank, aa, akk[]k[]k[]k[]k[]kai

//Resonant filters in parallel

    aSig, kBaseNote, kNotes[], kQs[], kGains[],kPans[], kEnabled[], kOutputMode, aEnv, iCount xin
    iNumber= lenarray(kNotes)-1
    aOutL = 0
    aOutR = 0
    kQ init 0
    
   
    aTemp = 0
    if (kEnabled[iCount]*kGains[iCount] != 0) then
        kThisFreq = mtof(kNotes[iCount]+kBaseNote)
        kQ = kThisFreq/kQs[iCount] 
        if qnan(kQ) == 1 then 
            kQ = kThisFreq/150
        endif     
        aTemp resonz aSig, kThisFreq, kQ
        aTemp *= kGains[iCount]

    endif
    
    
    if (kOutputMode == 1) then
        aOutL = aTemp*(1-kPans[iCount])
        aOutR = aTemp*(kPans[iCount])
       
        
    elseif (kOutputMode == 2) then
        outch iCount+1, aTemp*aEnv
    endif
    
    

    if (iCount >= iNumber) goto RESONSKIP
        aTempL, aTempR resonbank aSig,kBaseNote, kNotes, kQs, kGains,kPans, kEnabled, kOutputMode, aEnv, iCount+1
        if (kOutputMode == 1) then
        aOutL += aTempL
        aOutR += aTempR 
        endif

    RESONSKIP:
    
    xout aOutL, aOutR

endop

gkOutputMode init 1
giEnabled ftgen 0, 0, 24, 27, 0, 0
giPans ftgen 0, 0, 24, 27, 0, 0.5
giNotes ftgen 0, 0, 24, 27, 0, 0
giAmps ftgen 0, 0, 24, 27, 0, 0.5
giQs ftgen 0, 0, 24, 27, 0, 0.5
gkQMin init 0
gkQMax init 0


instr 1
kInit init 0

if kInit = 1 goto SKIP

kInit = 1
kOutputMode = gkOutputMode
kEnabled[] tab2array giEnabled
kPans[] tab2array giPans
kNotes[] tab2array giNotes
kAmps[] tab2array giAmps
kQs[] tab2array giQs
kCount init 0
kNum = 24

scalearray kQs, gkQMin, gkQMax

SKIP:

if (lenarray(kQs) > 0) then

aIndex line 0, 0.001, 1


aIn table aIndex, 1

aIn*= 0.001
aEnv madsr 0.001, 0, 1, 1 

aOutL, aOutR resonbank aIn, p4, kNotes, kQs, kAmps, kPans, kEnabled,kOutputMode, aEnv, 0


aOutL *= aEnv
aOutR *= aEnv

outs aOutL, aOutR
endif

endin

instr makeGui

iCount = 0;

until iCount >= 24 do
    SName sprintf "enable_ident%d", iCount
    SMessage sprintf "bounds(%d,%d,20,20)", 10+(iCount%4)*170, 10+floor(iCount/4)*40
    chnset SMessage, SName
    
    SName sprintf "note_ident%d", iCount
    SMessage sprintf "bounds(%d,%d,40,20)", 40+(iCount%4)*170, 10+floor(iCount/4)*40
    chnset SMessage, SName
    
    SName sprintf "q_ident%d", iCount
    SMessage sprintf "bounds(%d,%d,20,20)", 85+(iCount%4)*170, 10+floor(iCount/4)*40
    chnset SMessage, SName
    
    
    SName sprintf "gain_ident%d", iCount
    SMessage sprintf "bounds(%d,%d,20,20)", 110+(iCount%4)*170, 10+floor(iCount/4)*40
    chnset SMessage, SName
    
    SName sprintf "pan_ident%d", iCount
    SMessage sprintf "bounds(%d,%d,20,20)", 135+(iCount%4)*170, 10+floor(iCount/4)*40
    chnset SMessage, SName
    
    iCount += 1
   

od


turnoff

endin

instr refresh

kAllOnTrigger chnget "allOn"
kAllOffTrigger chnget "allOff"
kRandomFreqTrigger chnget "randNotes"
kRandomQTrigger chnget "randQ"
kRandomGainTrigger chnget "randGain"
kRandomPanTrigger chnget "randPan"

kAllOn changed kAllOnTrigger
kAllOff changed kAllOffTrigger
kRandomFreq changed kRandomFreqTrigger
kRandomQ changed kRandomQTrigger
kRandomGain changed kRandomGainTrigger
kRandomPan changed kRandomPanTrigger


kCount = 0

until kCount >= 24 do

if kAllOn == 1 then
SName sprintfk "enable%d", kCount
chnset k(1), SName
endif

if kAllOff == 1 then
SName sprintfk "enable%d", kCount
chnset k(0), SName

endif

SName sprintfk "enable%d", kCount
kValue chnget SName
tabw kValue, kCount, giEnabled

if kRandomFreq == 1 then
    if kCount == 0 then
        kLastRand = 0
    elseif k(rand(1))<0.5 then
       kLastRand += rand(0.5)+0.5
    else
        kLastRand += rand(5)+5
    endif
    
    SName sprintfk "note%d", kCount
    chnset kLastRand, SName
endif



SName sprintfk "note%d", kCount
kValue chnget SName 
tabw kValue, kCount, giNotes

if kRandomQ == 1 then

    kQ = k(rand(0.5)+0.5)
    SName sprintfk "q%d", kCount
    chnset kQ, SName

endif

SName sprintfk "q%d", kCount
kValue chnget SName 
tabw kValue, kCount, giQs

if kRandomGain == 1 then
    kGain = k(rand(0.45))+0.45+0.1
    SName sprintfk "gain%d", kCount
    chnset kGain, SName
    endif


SName sprintfk "gain%d", kCount
kValue chnget SName 
tabw kValue, kCount, giAmps


if kRandomPan == 1 then
    kPan = k(rand(0.5))+0.5
    SName sprintfk "pan%d", kCount
    chnset kPan, SName
    endif


SName sprintfk "pan%d", kCount
kValue chnget SName 
tabw kValue, kCount, giPans

kCount +=1

od

gkOutputMode chnget "outputMode"

gkQMin chnget "qMin"
gkQMax chnget "qMax"


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "makeGui" 0 -1
i "refresh" 0 -1
f 1 0 100 7 0 3 1 10 0

</CsScore>
</CsoundSynthesizer>
