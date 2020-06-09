<Cabbage>


form caption("Modal Synth") size(800, 800), colour("whitesmoke"), pluginid("cpmd"), import( "./lfo.plant", "./modalSynthPlants.plant"), bundle("./impulses","./lfo.plant", "./modalSynthPlants.plant")

label text("Modal Synth") bounds(20,10,500,36) align("left") fontcolour("black")
image colour(0,0,0,0) bounds(20, 50, 200,100) {
    //combobox bounds(0, 0, 100, 25), channel("preset"), populate("*.snaps")
    //filebutton bounds(110, 0, 60, 25), channel("but1"), text("Save"), mode("snapshot")
}
image bounds(0,100,800,800) colour(0,0,0,0)
{
modalSynthMatrix namespace("cp"), bounds(0,0,800,280) 


image bounds(0,280,250,80) colour(0,0,0,0){
    rslider channel("voiceAttack") bounds(8,0,40,40) range(5,5000,10,0.25,0.001)
    rslider channel("voiceDecay") bounds(68,0,40,40) range(0,5000,10,0.25,0.001)
    rslider channel("voiceSustain") bounds(128,0,40,40) range(0,1,0.8,1,0.001)
    rslider channel("voiceRelease") bounds(188,0,40,40) range(5,5000,500,0.25,0.001)
    hrange bounds(8,50,132,20) range(50, 3000, 100:250, 0.25, 1) channel("qMin","qMax")
    label text("q range") bounds(135,52,160,14) align("left") fontcolour(0,0,0,255)

    

}

image bounds(0,550,250,30) colour(0,0,0,0){
label text("exitation") bounds (0,4,80,14) fontcolour(0,0,0,255)
    combobox bounds (80,0,140,20) populate("*.aif","./impulses") channel("impulseSelect") channeltype("string")  value("env_hammer1")
}

image bounds(0, 380, 200, 150)colour(0,0,0,0) {
    label text("Macro Buttons")  bounds(20,4,160,14)  fontcolour(0,0,0,255)
    button text("all on") bounds(20,25,75,20) channel("allOn") identchannel("allOn_ident") latched(0)
    button text("all off") bounds(105,25,75,20) channel("allOff") latched(0)
    button text("randomize notes") bounds(20,50,160,20) channel("randNotes") latched(0)
    button text("randomize q") bounds(20,75,160,20) channel("randQ")     latched(0)
    button text("randomize gain") bounds(20,100,160,20) channel("randGain") latched(0)
    button text("randomize pan") bounds(20,125,160,20) channel("randPan") latched(0)
}

image colour(0,0,0,0) bounds(250,400,550,220){
    rslider channel("randomPitchPerNote") range(0,12,0,0.5,0.01) bounds(0,0,50,50)
    rslider channel("randomQPerNote") range(0,1000,0,0.5,0.01) bounds(60,0,50,50)
    rslider channel("randomGainPerNote") range(0,1,0,0.5,0.01) bounds(120,0,50,50)
    rslider channel("randomPanPerNote") range(0,1,0,0.5,0.01) bounds(180,0,50,50)

    }


image bounds(250,280,550,80) colour(0,0,0,0){
    image bounds(15,0, 40, 80) colour(0,0,0,0){
        rslider bounds(0,0,20,20) channel("vibratoRate") range(0.001,15,1, 0.25,0.01)
        rslider bounds(0,20,20,20) channel("vibratoDepth") range(1,12,3,1,0.01)
        rslider bounds(0,40,20,20) channel("vibratoDeviation") range(0,1,0.1,1,0.01)
        vslider bounds(15,0,20,80) channel("vibrato") range(0,1,0,1,0.01)
        }

image bounds(70,0, 40, 80) colour(0,0,0,0){
rslider bounds(0,0,20,20) channel("tremRate") range(0.001,15,1, 0.25,0.01)
rslider bounds(0,40,20,20) channel("tremDeviation") range(0,1,0.1,1,0.01)
vslider bounds(15,0,20,80) channel("trem") range(0,1,0,1,0.01)


}

keyboard bounds (110,0,350,80)
rslider channel("gain") bounds(475,10,55,55) range(0,2,1,0.5,0.01) trackercolour(255,0,0,255) outlinecolour(0,0,0,0) colour(0,0,0,0)
combobox items("stereo", "discrete channels (24)") bounds(470,60,70,20) channel("outputMode")

}
}



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

gkVibrato[] init 4
gaTrem[] init 4

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
 
gkRandomPitch init 0
gkRandomGain init 0
gkRandomQ init 0
gkRandomPan init 0
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
    iVib random 0, 1
    iRandomPitchDepth = i(gkRandomPitch);
    if (iCount != 0) then
    iRandomPitch random -iRandomPitchDepth, iRandomPitchDepth
    else
    iRandomPitch = 0
    endif 
    kThisVib = gkVibrato[0]*((iVib)%1)+gkVibrato[1]*((iVib+0.25)%1)+gkVibrato[2]*((iVib+0.5)%1)+gkVibrato[3]*((iVib+0.75)%1)
    kThisNote = (iNote+kBaseNote+iRandomPitch)+kThisVib   
    kThisFreq = mtof(kThisNote)
    
    GETQ:    
    kQ = kThisFreq/tab_i(iCount, iQsTab)
    if qnan(kQ) == 1 then 
        kQ = kThisFreq/150;
    endif 
    iQRandomAmount = i(gkRandomQ)
    iQRandom random -iQRandomAmount,iQRandomAmount
    kQ += iQRandom
    kQ limit kQ, 1, 6000
    aTemp resonz aSig, kThisFreq, kQ
    iTrem random 0, 1
    aThisTrem = gaTrem[0]*((iTrem)%1)+gaTrem[1]*((iTrem+0.25)%1)+gaTrem[2]*((iTrem+0.5)%1)+gaTrem[3]*((iTrem+0.75)%1)
    
    iRandomGainAmount = i(gkRandomGain)
    iRandomGain random 1, 1-iRandomGainAmount

    aGain = (iGain*iRandomGain)*(1-aThisTrem)
    aGain limit aGain, 0 ,1
    aTemp *= aGain
    
    
    if (kOutputMode == 1) then
    iPan tab_i iCount, iPansTab
        iRandomPanAmount = i(gkRandomPan)
        iRandomPan random -iRandomPanAmount,iRandomPanAmount
        iPan = (iPan+iRandomPan)%1
        aOutL = aTemp*(1-iPan)
        aOutR = aTemp*(iPan)
        
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
aEnv transegr 0, iAttack, 1, 1, iDecay, 0, iSustain, iRelease, -1, 0 
kPitch = p4

aOutL, aOutR resonbank aIn, kPitch, giNotes, iQsTab, giAmps, giPans, giEnabled,kOutputMode, aEnv, 0

aOutL *= aEnv
aOutR *= aEnv

gaOutL += aOutL*p5
gaOutR += aOutR*p5


endin

instr io
kGain chnget "gain"
aGain interp kGain
outs gaOutL*aGain, gaOutR*aGain
clear gaOutL, gaOutR

endin



instr update



kAllOnTrigger chnget "allOn"
kAllOffTrigger chnget "allOff"
kRandomFreqTrigger chnget "randNotes"
kRandomQTrigger chnget "randQ"
kRandomGainTrigger chnget "randGain"
kRandomPanTrigger chnget "randPan"

kAllOn changed2 kAllOnTrigger
kAllOn *= kAllOnTrigger
kAllOff changed2 kAllOffTrigger
kAllOff *= kAllOffTrigger
kRandomFreq changed2 kRandomFreqTrigger
kRandomFreq *= kRandomFreqTrigger
kRandomQ changed2 kRandomQTrigger
kRandomQ *= kRandomQTrigger
kRandomGain changed2 kRandomGainTrigger
kRandomGain *= kRandomGainTrigger
kRandomPan changed2 kRandomPanTrigger
kRandomPan *= kRandomPanTrigger


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



if kRandomPan == 1 then
    kPan = k(rand(0.5))+0.5
    SName sprintfk "pan%d", kCount
    chnset kPan, SName
    endif



kCount +=1

od

gkOutputMode chnget "outputMode"

gkQMin chnget "qMin"
gkQMax chnget "qMax"

gSImpulseSelect chnget "impulseSelect"

if changed(gSImpulseSelect) == 1 then
    
    event "i", "readSoundfile", 0, 0
    
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
    gkRandomPitch chnget "randomPitchPerNote"
    gkRandomGain chnget "randomGainPerNote"
    gkRandomQ chnget "randomQPerNote"
    gkRandomPan chnget "randomPanPerNote"
    
    kVib chnget "vibrato"
    kVibRate chnget "vibratoRate"
    kVibDepth chnget "vibratoDepth"
    kVibDeviate chnget "vibratoDeviation"

    if (kVib > 0) then
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[0] oscil kVib*0.5*kVibDepth,kThisVibRate , 201, 0
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[1] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.125
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[2] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.25
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[3] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.375
    
    else
        gkVibrato = gkVibrato*0
    
    endif
    
    kTrem chnget "trem"
    kTremRate chnget "tremRate"
    kTremDeviate chnget "tremDeviation"
    aTrem interp kTrem
    
    if (kTrem > 0) then
        kThisTremRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[0] oscil aTrem*0.5,kThisTremRate , 201, 0
        
        kThisVibRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[1] oscil aTrem*0.5,kThisTremRate  , 201, 0.125
        
        kThisVibRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[2] oscil aTrem*0.5,kThisTremRate  , 201, 0.25
        
        kThisVibRate = kVibRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[3] oscil aTrem*0.5,kThisTremRate  , 201, 0.375
    
    else
        gaTrem = gaTrem*0
    
    endif
                
endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 201 0 2049 11 1
f 202 0 2049 7 1 2048 -1 
f 203 0 2049 7 0 1024 1 1024 -1
i "io" 0 z
i "lfoDrive" 0 z
i "update" 0 z


</CsScore>
</CsoundSynthesizer>
