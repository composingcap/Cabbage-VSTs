<Cabbage>
;bundle("./ambisonics_utilities.txt", "./ambisonics_udos.txt") <-- this does not seem to work-- move the files into the vst when created
form caption("AmbiGrainLive") size(660, 300), colour(58, 110, 182), pluginid("angrL")
combobox items("1", "2", "3", "4", "5", "6", "7") channel("order") bounds(12,40,40,20) value(3)
label text("order") bounds(50,45,45,12)


groupbox text("Spacialization") bounds(8, 108, 300, 170){
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
    rslider bounds(10, 30, 70,70) text("Grain Length") channel("glen") range(0.001, 5, 0.25, 0.5)
    rslider bounds(70, 40, 40,40) text("Rand") channel("glenR") range(0, 1, 0.25, 1,0.01)
    rslider bounds(10, 100, 70,70) text("Grain Rate") channel("grate") range(0.1,100, 1,0.5 ) identchannel("grateID")
    rslider bounds(70, 110, 40,40) text("Rand") channel("grateR") range(0, 1, 0.25, 1,0.01)
    rslider bounds(140, 30, 70,70) text("Grain Amp") channel("gamp") range(0, 1, 1, 1,0.001)
    rslider bounds(200, 40, 40,40) text("Rand") channel("gampR") range(0, 1, 0.25, 1,0.01)
    rslider bounds(140, 100, 70,70) text("Delay") channel("del") range(0, 0.99, 0.25, 1,0.01)
    rslider bounds(200, 110, 40,40) text("Rand") channel("delR") range(0, 1, 0.5, 1, 0.01)
    button text("Freeze"), colour:0("grey") colour:1("blue") bounds(8,180,100,50) channel("freeze")
    rslider text("A") bounds(125,180,50,50) channel("A") range(0,1,0.2,1,0.001)
    rslider text("D") bounds(165,180,50,50) channel("D")range(0,1,0.1,1,0.001)
    rslider text("S") bounds(205,180,50,50) channel("S")range(0,1,0.5,1,0.001)
    rslider text("R") bounds(245,180,50,50) channel("R")range(0,1,0.3,1,0.001)
    
    }
    
;keyboard bounds(8, 275, 640, 70)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 

</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 48000
ksmps = 32
nchnls = 64
0dbfs = 1
giMaxDelay = 5
giTabLen = sr*giMaxDelay
giBuf ftgenonce 101, 0, giTabLen, 2,0

#include "ambisonics_utilities.txt"
#include "ambisonics_udos.txt"

;INSTRUMENTS
;instrument will be triggered by keyboard widget



instr update
    SsF init " " 
    
        
    gkGlen chnget "glen"
    gkGlenR chnget "glenR"
    gkGrate chnget "grate"
    gkGrateR chnget "grateR"
    gkGrateAR chnget "grateAR"
    gkGamp chnget "gamp"
    gkGampR chnget "gampR"
    gkDistance chnget "distance"
    gkDistanceR chnget "distanceR"

    gkOrder chnget "order"
    gkEnable chnget "enable"
    gkGXPos chnget "grainCenterX"
    gkGYPos chnget "grainCenterY"
    gkGXPosR chnget "randX"
    gkGYPosR chnget "randY"
    gkDel chnget "del"
    gkDelR chnget "delR"


endin

instr writeTab

    aIn1 inch 1
    aIn2 inch 2
    aIn = 0
    kFreeze init 0
    gaSamp init 0
    kFreeze  chnget "freeze"
    aIn = (aIn1+aIn2)*0.5

    gaSync phasor 1/giMaxDelay
    
    if  (kFreeze== 0) then       
        tablew aIn, gaSync, giBuf, 1, 0, 1    
    endif 
    
    
    

    
    
    
    
    
    
        

endin


instr 1


iTranspose= 1

kThisRate = gkGrate
kRandom random -gkGrateR, gkGrateR
kThisRate *= (1+ kRandom)

kGrainer metro kThisRate, 0
itabLen = giTabLen


    if ((kGrainer == 1) && (changed(kGrainer)==1)) then    
        kThisLen = gkGlen
        kRandom random -gkGlenR, gkGlenR
        kThisLen *= (1+ kRandom)
    
        kAmp = gkGamp

        kStartPos = (k(gaSamp)-(gkDel*sr)*(1-random(0,gkDelR))+giTabLen)%giTabLen
        
        
        event "i", "grain8Gen", 0, kThisLen, 1, kAmp
        kGrainer = 0
    endif



endin



instr grain8Gen
;p3 = glen
;p4 = trans
;p5 = amp


    iA  chnget "A"
    iD  chnget "D"
    iS chnget "S"
    iR chnget "R"
    
    iAzimuth chnget "Az"
    iAzimuthR chnget "AzR"
    iAngle chnget "El"
    iAngleR chnget "ElR"
    
    iAzimuthR random -iAzimuthR, iAzimuthR
    iAngleR random -iAngleR, iAngleR
    iAzimuth = (abs((iAzimuth + iAzimuthR))* 360+360)%360
    iAngle = (abs(iAngle + iAngleR)*360+360+90)%360
    
    iTotalADR = iA+iD+iR
    
    
    
    aEnv adsr iA/iTotalADR*p3, iD/iTotalADR*p3, iS, iR/iTotalADR*p3

    
    iAmp = p5
    iRandStart = i(gkDel)*(1-random(0,i(gkDelR)))%1
    aPos wrap gaSync-iRandStart,0,1
    aGrain table3 aPos, 101, 1, 0, 1
    
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

i "update" 0 z
i "writeTab" 0 z
i 1 0 z
</CsScore>
</CsoundSynthesizer>
