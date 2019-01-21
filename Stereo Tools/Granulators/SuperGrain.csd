<Cabbage>
#define SLIDER1 colour("white"), trackercolour("grey")

form caption("super grain") size(400, 400), colour(20,20,20), pluginid("spgn")
   

    image visible(1) bounds(0,0,120,180) colour(0,0,0,0) identchannel("deviceClock"){
    rslider bounds(10, 30, 70,70), text("Grain Length"), channel("glen"), range(0.001, 3, 0.1, 0.5, 0.01), $SLIDER1
    rslider bounds(70, 40, 40,40) text("Rand") channel("glenR") 
    rslider bounds(10, 100, 70,70) text("Grain Rate") channel("grate") range(0.1, 50, 20,1,0.01 ) identchannel("grateID") $SLIDER1
    rslider bounds(70, 110, 40,40) text("Rand") channel("grateR")  range(0,1,0.25,1,0.01 )
    }
    rslider bounds(140, 30, 70,70) text("Grain Amp") channel("gamp") range(0, 1, 1, 1,0.001) $SLIDER1
    rslider bounds(200, 40, 40,40) text("Rand") channel("gampR") 
    rslider bounds(140, 100, 70,70) text("Delay") channel("del") range(0, 0.9, 0.1, 1,0.01) $SLIDER1
    rslider bounds(200, 110, 40,40) text("Rand") channel("delR") range(0, 1, 0.5, 1, 0.01)
    
    
    image visible(0) bounds(0,0,120,180) colour(0,0,0,0) identchannel("transportSync"){
    label bounds(10,85,70,12) text("Grain Length") 
    image bounds(30,40, 30, 40) colour(0,0,0,0) {
    nslider bounds(0, 0, 30,18) range(1, 64, 1, 1, 1) channel("gLenN")
    nslider bounds(0, 20, 30,18) range(1, 64, 16, 1, 1) channel("gLenD")
    }
    
    rslider bounds(70, 40, 40,40) text("Rand") channel("glenR") 
    
    label bounds(10,150,70,12) text("Grain Rate") 
    image bounds(30,105, 30, 40) colour(0,0,0,0) {
    nslider bounds(0, 0, 30,18) range(1, 64, 1, 1, 1) channel("gRateN")
    nslider bounds(0, 20, 30,18) range(1, 64, 32, 1, 1) channel("gRateD")
    }
    

    rslider bounds(70, 110, 40,40) text("Rand") channel("grateR")  range(0,1,0.25,1,0.01 )
    }

   
    button text("Freeze"), colour:0("grey") colour:1("white") bounds(250,110,100,50) channel("freeze")
    rslider text("mix") channel("grainMix") bounds(250, 30, 100,70) range(0,1,1,1,0.001) $SLIDER1
  
    checkbox bounds(8,170,20, 20) channel("clockMode") 
    label bounds(35,175,100,12) text("transport sync") align("left")
  
    groupbox text("Envelope") bounds(140,210,250,170){
    
        label text("curve") bounds(8,30,50,10)
    
        rslider bounds(50,40,40,40) channel("A") range(0,1,0.2,1,0.001) $SLIDER1
        label text("A") bounds (63,52,15,15) fontcolour("black")
        ;rslider bounds (60,25,20,20) channel("AType") range(-3,3,0,1,0.1)
    
        rslider bounds(90,40,40,40) channel("D")range(0,1,0.1,1,0.001) $SLIDER1
        label text("D") bounds (103,52,15,15) fontcolour("black")
        ;rslider bounds (100,25,20,20) channel("DType") range(-3,3,0,1,0.1)
    
        rslider bounds(130,40,40,40) channel("S")range(0,1,0.5,1,0.001) $SLIDER1
        label text("S") bounds (143,52,15,15) fontcolour("black")
    
        rslider bounds(170,40,40,40) channel("R")range(0,1,0.3,1,0.001) $SLIDER1
        label text("R") bounds (183,52,15,15) fontcolour("black")
        ;rslider bounds (180,25,20,20) channel("RType") range(-3,3,0,1,0.1)
    
        rslider channel("envR") range(0,1,0,1,0.01) bounds(50, 80, 40,40) $SLIDER1
        label text("random envelope length") bounds(100,90,150,10) align("left")
    
        ;rslider channel("typeR") range(0,1,0,1,0.01) bounds(50, 120, 40,40) $SLIDER1
        ;label text("random curve") bounds(100,130,150,10) align("left")
    
    }
    
    
    groupbox text("Spread") bounds(8,210,125,170){
        combobox bounds(10,30,100,20) items("original stereo", "summed mono", "random stereo") channel("spreadMode")
        rslider text("spread center") bounds( 10, 60, 100,50) channel("spreadCenter") range(0,1,0.5,1,0.001) $SLIDER1
        rslider text("spread width") bounds( 10, 120, 100,50) channel("spreadWidth") range(0,0.5,0.5,1,0.001) $SLIDER1
    }

    
    
;keyboard bounds(8, 275, 640, 70)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 

</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1
giMaxDelay = 10
giTabLen = sr*giMaxDelay
giBuf1 ftgenonce 101, 0, giTabLen, 2,0
giBuf2 ftgenonce 102, 0, giTabLen, 2,0

;Opcodes



;INSTRUMENTS
;instrument will be triggered by keyboard widget





instr update
    kClockMode chnget "clockMode"
    kPlaying  chnget "IS_PLAYING"
    kTimeInSamps chnget "TIME_IN_SAMPLES"
    kTimeInSecs= kTimeInSamps*sr
          
    
    SsF init " " 
    gkBPM chnget "HOST_BPM"
    

    if chnget("IS_A_PLUGIN") == 0 then
        gkBPM = 120
    endif

    
    
    
    
    if kClockMode == 0 then

            chnset "visible(1)", "deviceClock"
            chnset "visible(0)", "transportSync"
  
        gkGlen chnget "glen"
        gkGrate chnget "grate"
    
    elseif kClockMode == 1 then 
    

       chnset "visible(0)", "deviceClock"
       chnset "visible(1)", "transportSync"  
        
              
        kLenD chnget "gLenD"
        kLenN chnget "gLenN"
                
        gkGlen = (gkBPM/60)*(kLenN/kLenD)
        
        
        kRateD chnget "gRateD"
        kRateN chnget "gRateN"
                
        gkGrate = (gkBPM/60)*(kRateD/kRateN)
    
    
    endif
        
    
    gkGlenR chnget "glenR"
    
    gkGrateR chnget "grateR"
    gkGrateAR chnget "grateAR"
    gkGamp chnget "gamp"
    gkGampR chnget "gampR"


    gkGXPos chnget "grainCenterX"
    gkGYPos chnget "grainCenterY"
    gkGXPosR chnget "randX"
    gkGYPosR chnget "randY"
    gkDel chnget "del"
    gkDelR chnget "delR"


endin

instr writeTab

    gaIn[] init 2
    gaIn in
    kFreeze init 0
    gaSamp init 0
    kFreeze  chnget "freeze"

    gaSync phasor 1/giMaxDelay
    
    if  kFreeze== 0 then       
        tablew gaIn[0], (gaSync), giBuf1, 1, 0, 1
        tablew gaIn[1], (gaSync), giBuf2, 1, 0, 1        
    endif 
    
    
    
    
        

endin


instr 1

gaOut[] init 2
iTranspose= 1

kThisRate = gkGrate
kRandom random -gkGrateR, gkGrateR
kThisRate *= (1+ kRandom)

kGrainer metro kThisRate, 0
itabLen = giTabLen

gkMix chnget "grainMix"

aMix lowpass2 a(gkMix), 50, 0.5



    if ((kGrainer == 1) && (changed(kGrainer)==1)) then    
        kThisLen = gkGlen
        kRandom random -gkGlenR, gkGlenR
        kThisLen *= (1+ kRandom)
    
        kAmp = gkGamp       
        
        
        event "i", "grain8Gen", 0, kThisLen, 1, kAmp
        kGrainer = 0
    endif



outs gaOut[0]*aMix+gaIn[0]*(1-aMix),gaOut[1]*aMix+gaIn[1]*(1-aMix)

gaOut *= 0

endin



instr grain8Gen
;p3 = glen
;p4 = trans
;p5 = amp
 

    iA chnget "A"
    iAType chnget "AType"
    iD chnget "D"
    iDType chnget "DType"
    iS chnget "S"
    iR chnget "R"
    iRType chnget "RType"
    
    iTypeR chnget "typeR"
    iEnvR chnget "envR"
    
    iA = iA*(1+random(-iEnvR,iEnvR))
    iD = iD*(1+random(-iEnvR,iEnvR))
    iR = iR*(1+random(-iEnvR,iEnvR))
    
    iAType = iAType*(1+random(-iTypeR,iTypeR))
    iDType = iDType*(1+random(-iTypeR,iTypeR))
    iRType = iRType*(1+random(-iTypeR,iTypeR))
    
    iTotalADR = iA+iD+iR
    
    iSpreadWidth chnget "spreadWidth"
    iSpreadCenter chnget "spreadCenter"
    iSpreadMode chnget "spreadMode"
    
        
    ;aEnv transeg 0, iA/iTotalADR*p3, iAType, 1, iD/iTotalADR*p3, iDType, iS, iR/iTotalADR*p3, iRType, 0 ; fancy adsr
    aEnv adsr iA/iTotalADR*p3, iD/iTotalADR*p3, iS, iR/iTotalADR*p3

    iAmp = p5
    
    iRandStart = (((i(gkDel)*0.75)*(random(0,1-i(gkDelR)))+1)%1)+0.001
    
    aPos wrap gaSync-iRandStart,0,1
    
    aGrain[] init 2
    
    if iSpreadMode == 1 then
        aGrain[0] table3 aPos, 101, 1, 0, 1
        aGrain[1] table3 aPos, 102, 1, 0, 1
    elseif iSpreadMode == 2 then
        aGrain[0] table3 aPos, 101, 1, 0, 1
        aGrain[1] table3 aPos, 102, 1, 0, 1
        aGrain[0] = (aGrain[0]+aGrain[1])*0.5
        aGrain[1] = aGrain[0]
   elseif iSpreadMode == 3 then
        iSpreadRand random 0, 1
        if iSpreadRand >= 0.5 then 
            aGrain[0] table3 aPos, 101, 1, 0, 1
            aGrain[1] table3 aPos, 102, 1, 0, 1
        else
            aGrain[1] table3 aPos, 101, 1, 0, 1
            aGrain[0] table3 aPos, 102, 1, 0, 1
        endif
    endif

    iGrainPosRand random iSpreadWidth, -iSpreadWidth
    iGrainPos = limit(iSpreadCenter+iGrainPosRand, 0, 1)
   
   
    aGrain[0] = aEnv*aGrain[0]
    aGrain[0] = iAmp*aGrain[0]
    aGrain[0] = iGrainPos*aGrain[0]
    
    aGrain[1] = aEnv*aGrain[1]
    aGrain[1] = iAmp*aGrain[1]
    aGrain[1] = (1-iGrainPos)*aGrain[1]
    
    gaOut[0] = aGrain[0]+gaOut[0]
    gaOut[1] = aGrain[1]+gaOut[1]
    
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
