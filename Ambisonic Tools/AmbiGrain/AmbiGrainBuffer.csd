<Cabbage>
form caption("Ambi Grain") size(660, 375), colour(58, 110, 182), pluginid("abgnb")
bundle("/ambisonics_udos.txt", "ambisonics_utilities.txt")
combobox items("1", "2", "3", "4", "5", "6", "7") channel("order") bounds(12,40,40,20) value(3)
label text("order") bounds(50,45,45,12)

groupbox text("Spacialization") bounds(8, 80, 300, 170){
    encoder text("Azmuth") bounds(30, 50,70, 70) channel("Az") increment(0.025) textbox(1)
    label text("front") bounds(30,30,50,12) align("Centre") textbox(1)
    rslider bounds(90, 30, 40,40) text("Rand") channel("AzR") range(0, 1, 0, 1, 0.001)
    encoder text("Elevation") bounds(160, 50,70, 70) channel("El") increment(0.025) textbox(1) 
    label text("top") bounds(160,30,50,12) align("Centre")  
    rslider bounds(220, 30, 40,40) text("Rand") channel("ElR")  range(0, 1, 0, 1, 0.001) textbox(1)
    hslider bounds(30,135,100,20) channel ("distance") range(0,3,1,1,0.1)
    rslider bounds(120, 130, 40,40) text("Rand") channel("distanceR")  range(0, 1, 0, 1, 0.001) textbox(1)
    label text("distance") bounds (160,135,70,14)


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
nchnls = 64
0dbfs = 1
#include "ambisonics_utilities.txt"
#include "ambisonics_udos.txt"

;Init
instr startup
    prints "---AmbiGrain is starting---  \n"
    

    giSFTab ftgen 0, 0, 0, 1, "Ob WindSounds.wav", 0, 0, 0
    giSamps nsamp giSFTab
        giSfSr ftsr giSFTab

    chnset "file(\"Ob WindSounds.wav\")", "soundFiler"
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

    gkOrder chnget "order"
    gkDistance chnget "distance"
    gkDistanceR chnget "distanceR"

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

    iAzimuth chnget "Az"
    iAzimuthR chnget "AzR"
    iAngle chnget "El"
    iAngleR chnget "ElR"
    
    iAzimuthR random -iAzimuthR, iAzimuthR
    iAngleR random -iAngleR, iAngleR
    iAzimuth = (abs((iAzimuth + iAzimuthR))* 360+360)%360
    iAngle = (abs(iAngle + iAngleR)*360+360+90)%360
    
    aEnv adsr 0.2*p3, 0.5*p3, 1., 0.2*p3
    
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

    
    iDistance = i(gkDistance) 
    iDistanceR random 0, i(gkDistanceR)
    iDistance = iDistance - iDistance*iDistanceR

    aGrain *= aEnv
    aGrain *= iAmp
    
    aOuts[] init 64
   
    aOuts ambi_enc_dista aGrain, i(gkOrder), iAzimuth, iAngle, iDistance 
 
    out aOuts
    
endin    

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "startup" 0 10
i "update" 0 z
</CsScore>
</CsoundSynthesizer>
