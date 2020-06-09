<Cabbage>


form caption("Modal Synth") size(800, 800), colour("whitesmoke"), pluginid("cpmd"), import( "./lfo.plant", "./modalSynthPlants.plant"), bundle("./impulses","./lfo.plant", "./modalSynthPlants.plant")



//modalSynthMatrix namespace("cp"), bounds(0,0,800,280)

combobox items("stereo", "discrete channels (24)") bounds(10,600,80,20) channel("outputMode")


image bounds(0,280,250,80) colour(0,0,0,0){
    rslider channel("voiceAttack") bounds(8,0,40,40) range(5,5000,10,0.25,0.001)
    rslider channel("voiceDecay") bounds(68,0,40,40) range(0,5000,10,0.25,0.001)
    rslider channel("voiceSustain") bounds(128,0,40,40) range(0,1,0.8,1,0.001)
    rslider channel("voiceRelease") bounds(188,0,40,40) range(5,5000,500,0.25,0.001)
    hrange bounds(8,50,132,20) range(50, 2000, 100:250, 0.5, 1) channel("qMin","qMax")
    label text("q range") bounds(130,52,160,14) align("left") fontcolour(0,0,0,255)

    

}

image bounds(0,550,250,30) colour(0,0,0,0){
label text("exitation") bounds (0,4,80,14) fontcolour(0,0,0,255)
    combobox bounds (80,0,140,20) populate("*.aif","./impulses") channel("impulseSelect") channeltype("string") value("env_hammer1")
}

image bounds(0, 380, 200, 150)colour(0,0,0,0) {
    label text("Macro Buttons")  bounds(20,4,160,14)  fontcolour(0,0,0,255)
    button text("all on") bounds(20,25,75,20) channel("allOn") identchannel("allOn_ident")
    button text("all off") bounds(105,25,75,20) channel("allOff") 
    button text("randomize notes") bounds(20,50,160,20) channel("randNotes") 
    button text("randomize q") bounds(20,75,160,20) channel("randQ")     
    button text("randomize gain") bounds(20,100,160,20) channel("randGain") 
    button text("randomize pan") bounds(20,125,160,20) channel("randPan") 
}

image colour("grey") bounds(250,400,550,220){
    label text("Modulators") fontcolour("black")
    
    //lfocp namespace("lfocp") bounds(0,0,150,50) channel("globalPitch")
    //lfocp namespace("lfocp") bounds(0,150,150,50) channel("globalQ")
    //lfocp namespace("lfocp") bounds(0,50,150,50) channel("glodalGain") 
    //lfocp namespace("lfocp") bounds(0,100,150,50) channel("glodalPan") 
   

    }
}


keyboard bounds (250 ,280,550,80)


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

gkGlobalPitchLFO init 
gkGlobalGainLFO init 1
gkGlobalQLFO init 1
gkGlobalPanLFO init 1

giSfTab init 1
gkOutputMode init 1
giEnabled ftgen 0, 0, 24, 27, 0, 0
giPans ftgen 0, 0, 24, 27, 0, 0.5
giNotes ftgen 0, 0, 24, 27, 0, 0
giAmps ftgen 0, 0, 24, 27, 0, 0.5
giQs ftgen 0, 0, 24, 27, 0, 0.5
gkQMin init 0
gkQMax init 0
gkADSR[] fillarray 5, 5, 0.8, 500 

giSfTabs ftgen giSfTab, 0, 0, 1, "./impulses/env_hammer1.aif", 0, 0, 0 

opcode resonbank, aa, akiiiiikai
//Resonant filters in parallel

    aSig, kBaseNote, iNotesTab, iQsTab, iGainsTab,iPansTab, iEnabledTab, kOutputMode, aEnv, iCount xin
    
    iNumber= tableng(iNotesTab)-1
    aOutL = 0
    aOutR = 0
    kQ init 0
    RESONTOP:
    
    iEnabled tab_i iCount, iEnabledTab
    iGain tab_i iCount, iGainsTab
    
    
    
    aTemp = 0
    if (iEnabled*iGain == 0) then 
        iCount += 1
        if iCount >= iNumber goto RESONSKIP
            goto RESONTOP
        endif
        iNote tab_i iCount, iNotesTab
        
        kThisFreq = mtof(iNote+kBaseNote)
        
        kQ = kThisFreq/tab_i(iCount, iQsTab)
        if qnan(kQ) == 1 then 
            kQ = kThisFreq/150
        endif 
        kQ *= gkGlobalQLFO    
        //aTemp resonz aSig, kThisFreq, kQ
        kGain = iGain*gkGlobalGainLFO
        aTemp *= iGain
    
    
    if (kOutputMode == 1) then
    iPan tab_i iCount, iPansTab
    
        kPan limit (iPan+gkGlobalPanLFO*2-1)*0.5, 0, 1

        aOutL = aTemp*(1-kPan)
        aOutR = aTemp*(kPan)
        
    elseif (kOutputMode == 2) then
        outch iCount+1, aTemp*aEnv
    endif
    
    

    if (iCount >= iNumber) goto RESONSKIP
        aTempL, aTempR resonbank aSig,kBaseNote, iNotesTab, iQsTab, iGainsTab,iPansTab, iEnabledTab, kOutputMode, aEnv, iCount+1
        if (kOutputMode == 1) then
        aOutL += aTempL
        aOutR += aTempR 
        endif

    RESONSKIP:
    
    xout aOutL, aOutR

endop
/*
opcode performLfo, k, S
    
    Sname xin
    
    Sselect sprintfk "%sselect", Sname
 
    kSelect chnget Sselect


    kOut = 1
    
    if (kSelect == 1) kgoto END        

       
    Srate sprintfk "%srate", Sname
    kRate chnget Srate
    
    
    Srmin sprintfk "%srangeMin", Sname
    krMin chnget Srmin
    
    Srmax sprintfk "%srangeMax", Sname
    krMax chnget Srmax
    
    krMin = 1+krMin
    krMax = 1+krMax
    if (kSelect == 2) then                     
        kOut oscil 0.5, kRate, 201  
        kOut = (kOut+1)*(krMax-krMin)+krMin
    elseif (kSelect == 3) then
            kOut oscil 0.5, kRate, 202  
            kOut = (kOut+1)*(krMax-krMin)+krMin
    elseif (kSelect == 4) then
            kOut oscil 0.5, kRate, 203  
            kOut = (kOut+1)*(krMax-krMin)+krMin    
    elseif (kSelect == 5) then
        kOut randomi krMin, krMax, kRate, 2, 0
    
    elseif (kSelect == 6) then
        kOut randomh krMin, krMax, kRate, 2, 0
    
    elseif (kSelect == 7) then
        kOut random krMin, krMax
    endif  
    END:
    xout kOut
endop
*/




opcode updateTables, i ,p
    idummy xin
    iCount = 0

    until iCount >= 24 do

        SName sprintf "enable%d", iCount
        tablew chnget(SName), iCount, giEnabled

        SName sprintf "note%d", iCount
        tablew chnget(SName), iCount, giNotes

        SName sprintf "gain%d", iCount
        tablew chnget(SName), iCount, giAmps
        
        SName sprintf "pan%d", iCount
        tablew chnget(SName), iCount, giPans
        
        SName sprintf "q%d", iCount
        tablew chnget(SName), iCount, giQs
        
        iCount += 1
    od
    xout 1
endop


instr 1
aOutL, aOutR init 0
ihandle updateTables 0
kInit init 0
iAttack chnget "voiceAttack"
iAttack *= 0.001
iDecay chnget "voiceDecay"
iDecay *= 0.001
iSustain chnget "voiceSustain"
iRelease chnget "voiceRelease"
iRelease *= 0.001


kOutputMode = gkOutputMode

iTabSize tableng giNotes

iQsTab ftgen 0, 0, iTabSize, -24, giQs, i(gkQMin), i(gkQMax)


kCount init 0
kNum = 24



SKIP:


iSampleTime = tableng(1)/sr
aIndex line 0, iSampleTime, 1

aIn table3 aIndex, giSfTab, 1, 0, 0

aIn *= 0.005
;aIn *= 0.1 ;If triggering with an envelope this is needed
aEnv transegr 0, iAttack, 1, 1, iDecay, 0, iSustain, iRelease, -1, 0 
//kPitch = p4+((gkGlobalPitchLFO-0.5))*6

//aOutL, aOutR resonbank aIn, kPitch, giNotes, iQsTab, giAmps, giPans, giEnabled,kOutputMode, aEnv, 0

aOutL *= aEnv
aOutR *= aEnv

gaOutL += aOutL
gaOutR += aOutR


endin

instr io
kGain = 1;
outs gaOutL*kGain, gaOutR*kGain
clear gaOutL, gaOutR

endin



instr update



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

SName sprintfk "pan%d", kCount
tabw chnget(SName), kCount, giPans

endif
/*
SName sprintfk "enable%d", kCount
tabw chnget(SName), kCount, giEnabled
*/

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

/*
SName sprintfk "note%d", kCount
tabw chnget(SName), kCount, giNotes
*/

if kRandomQ == 1 then

    kQ = k(rand(0.5)+0.5)
    SName sprintfk "q%d", kCount
    chnset kQ, SName

endif

SName sprintfk "q%d", kCount
tabw chnget(SName), kCount, giQs

if kRandomGain == 1 then
    kGain = k(rand(0.45))+0.45+0.1
    SName sprintfk "gain%d", kCount
    chnset kGain, SName
    endif

/*
SName sprintfk "gain%d", kCount
tabw chnget(SName), kCount, giAmps
*/

if kRandomPan == 1 then
    kPan = k(rand(0.5))+0.5
    SName sprintfk "pan%d", kCount
    chnset kPan, SName
    endif

/*
SName sprintfk "pan%d", kCount
tabw chnget(SName), kCount, giPans
*/

kCount +=1

od

gkOutputMode chnget "outputMode"

gkQMin chnget "qMin"
gkQMax chnget "qMax"

gSImpulseSelect chnget "impulseSelect"

if changed(gSImpulseSelect) == 1 then
    
    //event "i", "readSoundfile", 0, 0
    
endif

endin

instr refresh


endin

instr readSoundfile 

    if (strcmpk(gSImpulseSelect, "") != 0) then   
    giSfTab = giSfTab%5+1
    giSfTabs ftgen giSfTab, 0, 0, 1, gSImpulseSelect, 0, 0, 0 
    Smessage sprintf "tablenumber(%d)", giSfTab
    chnset Smessage, "impulseDisplay"
    endif

    
    turnoff
    

endin

 

instr lfoDrive

    //gkGlobalPitchLFO performLfo "globalPitch"
    //gkGlobalGainLFO performLfo "globalGain"
    //gkGlobalQLFO performLfo "globalQ"
    //gkGlobalPanLFO performLfo "globalPan"
    
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
//f 201 0 2049 11 1
//f 202 0 2049 7 1 2048 -1 
//f 203 0 2049 7 0 1024 1 1024 -1
;i "lfoDrive" 0 100000000000
;i "update" 0 z


</CsScore>
</CsoundSynthesizer>
