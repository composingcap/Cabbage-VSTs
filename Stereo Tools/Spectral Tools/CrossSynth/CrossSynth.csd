<Cabbage>
form caption("Cross Synthisizer") size(600, 325), colour(50, 50, 50), pluginid("xsnt")
image bounds(0,0,600,100) colour(25,25,25){
    image bounds(150,8,200,75) colour(0,0,0,0){
        filebutton text("sound 1") channel("sound1") populate(".wav","~/") bounds(0,0,60,25) value(0) file("fluteHarmonic.wav")
        soundfiler identchannel("sf1_ID") channel("sf1") bounds(60,0,140,75) 
        nslider text("center pitch") bounds(0,25,55,25) range(0,127,60,1,0.1) channel("centerPitch1")

    }
    image bounds(375,8,200,75) colour(0,0,0,0){
        filebutton text("sound 2") channel("sound2") populate(".wav","~/") bounds(0,0,60,25) value(0)
        soundfiler identchannel("sf2_ID") channel("sf2") bounds(60,0,140,75) file("gamalan.wav")
        nslider text("center pitch") bounds(0,25,55,25) range(0,127,60,1,0.1) channel("centerPitch2")

    }
    rslider text("Mod") bounds(0,8,75,75) channel("modMix1") range(0,1,1,1,0.001) trackercolour(255,255,255) colour("grey") 
    rslider text("Phase") bounds(65,8,75,75) channel("phaseMix1") range(0,1,0,1,0.001) trackercolour(255,255,255) colour("grey")
}


image bounds(0,100,600,100) colour(40,40,40){
    image bounds(150,8,200,75) colour(0,0,0,0){
        filebutton text("sound 3") channel("sound3") populate(".wav","~/") bounds(0,0,60,25) value(0) file("taiko.wav")
        soundfiler identchannel("sf3_ID") channel("sf3") bounds(60,0,140,75) 
        nslider text("center pitch") bounds(0,25,55,25) range(0,127,60,1,0.1) channel("centerPitch3")

    }
    image bounds(375,8,200,75) colour(0,0,0,0){
        filebutton text("sound 4") channel("sound4") populate(".wav","~/") bounds(0,0,60,25) value(0)
        soundfiler identchannel("sf4_ID") channel("sf4") bounds(60,0,140,75) file("oboeAiryFlutter.wav")
        nslider text("center pitch") bounds(0,25,55,25) range(0,127,60,1,0.1) channel("centerPitch4")

    }
    rslider text("Mod") bounds(0,8,75,75) channel("modMix2") range(0,1,1,1,0.001) trackercolour(255,255,255) colour("grey") 
    rslider text("Phase") bounds(65,8,75,75) channel("phaseMix2") range(0,1,0,1,0.001) trackercolour(255,255,255) colour("grey")
}
    rslider text("Mod") bounds(0,210,75,75) channel("modMix3") range(0,1,1,1,0.001) trackercolour(255,255,255) colour("grey") 
    rslider text("Phase") bounds(65,210,75,75) channel("phaseMix3") range(0,1,0,1,0.001) trackercolour(255,255,255) colour("grey")
keyboard bounds(150, 200, 442, 92)
label bounds(0,305,590,15) align("right") text("© Christopher Poovey 2018")
button channel("readme") text("readme") bounds(8,290,60,25) latched(0)

image popup(1)  bounds(0,0,650,100) visible(0) identchannel("readMeWindow") colour("black"){
    textbox bounds(8,8,630,284) file("CrossSynthHelp") wrap(1)

}

button channel("adsr") text("adsr") bounds(70,290,60,25) latched(0)
image popup(1)  bounds(0,0,275,75) visible(0) identchannel("adsrWindow") colour("black"){
    rslider range(0.001,5,0.1,0.5,0.001) text("A") channel("A") bounds(8,8,75,75) trackercolour(255,255,255) colour("grey")
    rslider range(0.001,5,0.1,0.5,0.001) text("D") channel("D") bounds(68,8,75,75)trackercolour(255,255,255) colour("grey")
    rslider range(0.001,1,0.9,0.5,0.001) text("S") channel("S") bounds(128,8,75,75)trackercolour(255,255,255) colour("grey")
    rslider range(0.001,5,0.1,0.5,0.001) text("R") channel("R") bounds(188,8,75,75)trackercolour(255,255,255) colour("grey")
}
combobox text("fft size") channel("fftSize")  items("512","1024", "2048", "4096") value(2) bounds(150,300,80,20)
label text("fft size") bounds(235, 305, 80, 10) align("left")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1




;instrument will be triggered by keyboard widget
instr update

 
    gSsf[] fillarray "fluteHarmonic.wav", "gamalan.wav", "taiko.wav", "oboeAiryFlutter.wav"
    
    giSf[] init 4
    kCount = 0 
    
        Sname sprintfk  "sound%d", kCount+1
        gSsf[kCount] chnget, Sname
        if changed(gSsf[kCount])==1 then
            event "i", "loadSF", 0, 5, kCount
        endif
        kCount += 1
        
        Sname sprintfk  "sound%d", kCount+1
        gSsf[kCount] chnget, Sname
        if changed(gSsf[kCount])==1 then
            event "i", "loadSF", 0, 5, kCount
        endif
        kCount += 1
        
        Sname sprintfk  "sound%d", kCount+1
        gSsf[kCount] chnget, Sname
        if changed(gSsf[kCount])==1 then
            event "i", "loadSF", 0, 0.5, kCount
        endif
        kCount += 1
        
        Sname sprintfk  "sound%d", kCount+1
        gSsf[kCount] chnget, Sname
        if changed(gSsf[kCount])==1 then
            event "i", "loadSF", 0, 0.5, kCount
        endif
        
        event_i "i", "loadSF", 0, 5, 1
        event_i "i", "loadSF", 0, 5, 2
        event_i "i", "loadSF", 0, 5, 3
        
        kReadMe chnget "readme"
        if kReadMe == 1 then
         chnset sprintfk("visible(%d)",kReadMe), "readMeWindow"   
        endif 

        kadsr chnget "adsr"
        if kadsr == 1 then
         chnset sprintfk("visible(%d)",kadsr), "adsrWindow"   
        endif 


endin

instr loadSF ;loads a sf

    SoundFile sprintf "file(\"%s\")", gSsf[p4]
    
    chnset SoundFile, sprintf("sf%d_ID", p4+1)
    

    giSf[p4] ftgen 0, 0, 0, 1, gSsf[p4], 0, 0, 1

    prints "Soundfile Loaded \n"  
endin

instr 1

    giWindowSize = pow(2,chnget("fftSize")+8)   
    print giWindowSize
    kNoteOn init 0
    if p5 > 0 then
        kNoteOn = 1
    endif
    iCenterPitch[] init 4
    kSfMod[] init 3
    kSfPhase[] init 3
    
    
    iCenterPitch[0] chnget "centerPitch1"
    iPscale = pow(2,((p4-iCenterPitch[0])/12))
    
    kSfMod[0] chnget "sfmod1"
    kSfPhase[0] chnget "sfphase1"
       

    
    kSfMod[0] chnget "modMix1"
    kSfPhase[0] chnget "phaseMix1"
    
    fSf1 pvstanal kNoteOn, p5, iPscale, giSf[0], 0, 1, 0, giWindowSize, giWindowSize/4

    
    iCenterPitch[1] chnget "centerPitch2"
    iPscale = pow(2,((p4-iCenterPitch[1])/12))

    fSf2 pvstanal kNoteOn, p5, iPscale, giSf[1], 0, 1, 0, giWindowSize, giWindowSize/4
    
    fSfMix1 pvsmorph fSf1, fSf2, kSfMod[0], kSfPhase[0] 
    

    iCenterPitch[2] chnget "centerPitch3"
    iPscale = pow(2,((p4-iCenterPitch[2])/12))
    
    kSfMod[2] chnget "sfmod3"
    kSfPhase[2] chnget "sfphase3"
       

    
    kSfMod[1] chnget "modMix2"
    kSfPhase[1] chnget "phaseMix2"
    
    fSf3 pvstanal kNoteOn, p5, iPscale, giSf[2], 0, 1, 0, giWindowSize, giWindowSize/4

    
    iCenterPitch[3] chnget "centerPitch4"
    iPscale = pow(2,((p4-iCenterPitch[3])/12))

    fSf4 pvstanal kNoteOn, p5, iPscale, giSf[3], 0, 1, 0, giWindowSize, giWindowSize/4
    
    fSfMix2 pvsmorph fSf3, fSf4, kSfMod[1], kSfPhase[1]     

    kSfMod[2] chnget "modMix3"
    kSfPhase[2] chnget "phaseMix3"    
            
    fSfMix3 pvsmorph fSfMix1, fSfMix2, kSfMod[2], kSfPhase[2]            
        
    aOut1 pvsynth fSfMix3
    
    kEnv madsr chnget("A"), chnget("D"), chnget("S"), chnget("R")
    
   if kEnv == 0 then
        kNoteOn = 0
    endif
    
    outs aOut1*kEnv, aOut1*kEnv
    

endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "update" 0 z 

</CsScore>
</CsoundSynthesizer>
