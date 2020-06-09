<Cabbage>
form caption("8ChGrain") size(660, 375), colour(58, 110, 182), pluginid("gr8n")
groupbox text("Panning Probabilities") bounds(8, 8, 300, 250){
    vslider     channel("chprob_1") bounds(30,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_2") bounds(60,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_3") bounds(90,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_4") bounds(120,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_5") bounds(150,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_6") bounds(180,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_7") bounds(210,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
    vslider     channel("chprob_8") bounds(240,30,20,200) range(0, 1, 0.25, 0.5, 0.001)
}
groupbox text("Parameters") bounds(350,8, 300, 250){
    rslider bounds(10, 30, 70,70) text("Grain Length") channel("glen") range(0.001, 3, 0.1, 0.5)
    rslider bounds(70, 40, 40,40) text("Rand") channel("glenR") 
    rslider bounds(10, 100, 70,70) text("Grain Rate") channel("grate") range(0.1, 50, 2,1 ) identchannel("grateID")
    rslider bounds(70, 110, 40,40) text("Rand") channel("grateR") 
    rslider bounds(140, 30, 70,70) text("Grain Amp") channel("gamp") range(0, 1, 1, 1,0.001)
    rslider bounds(200, 40, 40,40) text("Rand") channel("gampR") 
    rslider bounds(140, 100, 70,70) text("Traversal") channel("trav") range(-5, 5, 1, 1,0.01)
    rslider bounds(200, 110, 40,40) text("Rand") channel("travR") range(0, 3, 0, 1, 0.1)
    soundfiler bounds(10, 180, 280, 60) channel("start", "len") identchannel("soundFiler") 
    filebutton text("Open SF") channel("SF") bounds(230, 160, 50, 20) value("startup.wav")
    
    }
    
keyboard bounds(8, 275, 640, 70)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 8
0dbfs = 1


;Init
instr startup
    prints "---Grain8 is starting---  \n"
    

    giSFTab ftgen 0, 0, 0, 1, "startup.wav", 0, 0, 0
    giSamps nsamp giSFTab
        giSfSr ftsr giSFTab

    chnset "file(\"startup.wav\")", "soundFiler"
    prints "Soundfile Loaded \n"   

    prints "---Startup Complete--- \n"
    
endin

;INSTRUMENTS
;instrument will be triggered by keyboard widget

 

instr update
    SsF init " " 
    SsF chnget "SF"

    if (changed(SsF)==1) then
        event "i", "loadSF", 0, 0.1
        endif
        
    gkGlen chnget "glen"
    gkGlenR chnget "glenR"
    gkGrate chnget "grate"
    gkGrateR chnget "grateR"
    gkGrateAR chnget "grateAR"
    gkGamp chnget "gamp"
    gkGampR chnget "gampR"


    gkGXPos chnget "grainCenterX"
    gkGYPos chnget "grainCenterY"
    gkGXPosR chnget "randX"
    gkGYPosR chnget "randY"
    gkTrav chnget "trav"
    gkTravR chnget "travR"
    gkStart chnget "start"
    gkLen chnget "len"
    gkLoopStart	=	gkStart/(ftlen(giSFTab))*giSamps
    gkLoopLen = (gkLen)/(ftlen(giSFTab))*giSamps


endin
instr 1

iTranspose= pow(2,(p4-60)/12)
kTraversal phasor (gkTrav/giSamps*giSfSr)
kTraversal += random(-gkTravR,gkTravR)
kTraveral = kTraversal % gkLoopLen
kTraversal += gkLoopStart


kThisRate = gkGrate
kRandom random -gkGrateR, gkGrateR
kThisRate *= (1+ kRandom)

kGrainer metro kThisRate, 0
itabLen ftlen giSFTab


    if ((kGrainer == 1) && (changed(kGrainer)==1)) then    
        kThisLen = gkGlen
        kRandom random -gkGlenR, gkGlenR
        kThisLen *= (1+ kRandom)
    
        kAmp = gkGamp
        kRandom random -gkGampR*gkGamp, 0
        kAmp *= (1+ kRandom) 
        
        event "i", "grain8Gen", 0, kThisLen, iTranspose, kAmp, kTraversal
        kGrainer = 0
    endif


endin


instr loadSF ;loads a sf
    SsF chnget "SF"
    SoundFile sprintf "file(\"%s\")", SsF
    chnset SoundFile, "soundFiler"
    

    giSFTab ftgen 0, 0, 0, 1, SsF, 0, 0, 0
    giSamps nsamp giSFTab
    giSfSr ftsr giSFTab
    prints "Soundfile Loaded \n"  
endin

instr grain8Gen
;p3 = glen
;p4 = trans
;p5 = amp
    
    aEnv adsr 0.2*p3, 0.5*p3, 1., 0.2*p3
    aOuts[] init 8
    aOuts *= 0 ;clears array
    
    iAmp = p5
    iSpeed = p4
    iStart = round (p6*giSamps)

    
    iNCh ftchnls giSFTab
    if iNCh==1 then 
        aGrain loscilx iAmp, iSpeed, giSFTab, 4, 1, iStart, 1
        elseif iNCh == 2 then
        aGrain, aGrain loscilx iAmp, iSpeed, giSFTab, 4, 1, iStart, 1
        aGrain *= 0.5
    else
        prints "Please use a mono or stereo file"
    endif

    aGrain *= aEnv

        iProb chnget "chprob_1"
        iRandy random 0., 1.
        if iRandy <= iProb then  
            aOuts[0] = aGrain        
        endif
        
        iProb chnget "chprob_2"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[1] = aGrain
        endif    

        iProb chnget "chprob_3"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[2] = aGrain
        endif
       
        iProb chnget "chprob_4"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[3] = aGrain
        endif       

        iProb chnget "chprob_5"
        iRandy random 0., 1.
        if iRandy <= iProb then  
            aOuts[4] = aGrain        
        endif
        
        iProb chnget "chprob_6"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[5] = aGrain
        endif    

        iProb chnget "chprob_7"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[6] = aGrain
        endif
       
        iProb chnget "chprob_8"
        iRandy random 0., 1.
        if iRandy <= iProb then
            aOuts[7] = aGrain
        endif       
    
   
    

    outo aOuts[0], aOuts[1], aOuts[2], aOuts[3], aOuts[4], aOuts[5], aOuts[6], aOuts[7]
    
endin    

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "startup" 0 10
i "update" 0 z
</CsScore>
</CsoundSynthesizer>
