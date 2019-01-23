<Cabbage>
#define SLIDER1 colour("white"), trackercolour("grey")

form caption("super grain vc") size(400, 400), colour(20,20,20), pluginid("vcgn")
   

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
  
    groupbox text("Envelope") bounds(140,210,250,100){
    
        label text("curve") bounds(8,30,50,10)
    
        rslider bounds(50,40,40,40) channel("A") range(0,1,0.2,1,0.001) $SLIDER1
        label text("A") bounds (63,52,15,15) fontcolour("black")
    
        rslider bounds(90,40,40,40) channel("D")range(0,1,0.1,1,0.001) $SLIDER1
        label text("D") bounds (103,52,15,15) fontcolour("black")

    
        rslider bounds(130,40,40,40) channel("S")range(0,1,0.5,1,0.001) $SLIDER1
        label text("S") bounds (143,52,15,15) fontcolour("black")
    
        rslider bounds(170,40,40,40) channel("R")range(0,1,0.3,1,0.001) $SLIDER1
        label text("R") bounds (183,52,15,15) fontcolour("black")  
    
    }
    
    
    groupbox text("Spread") bounds(8,210,125,180){
        combobox bounds(10,30,100,20) items("original stereo", "summed mono", "random stereo") channel("spreadMode")
        rslider text("spread center") bounds( 10, 60, 100,50) channel("spreadCenter") range(0,1,0.5,1,0.001) $SLIDER1
        rslider text("spread width") bounds( 10, 120, 100,50) channel("spreadWidth") range(0,0.5,0.5,1,0.001) $SLIDER1
    }
    
    groupbox text("vocoder") bounds (140,320,250,70){
    combobox bounds(8, 25, 80, 24) items("Analog Synth", "Moog", "Flute", "Bowed Bar", "Bowed String", "Noise") channel("select")
    rslider bounds (100,25,50,40) text("mix") channel("vocoderMix")
    button text("more") channel("vSettings") bounds(150,30,50,25)

    
    }
    
    image popup(1) visible(0) identchannel("vWindow") bounds(50,50,400,300) colour(black){
    label text("Vocoder Settings") bounds(8,8,400,18)
    groupbox text("Pitch Chance") bounds(8,35,370,200){
        rslider channel("p1") bounds(8,25,50,50) text("C") value(0.5) $SLIDER1
        rslider channel("p2") bounds(58,25,50,50) text("C#") $SLIDER1
        rslider channel("p3") bounds(108,25,50,50) text("D") $SLIDER1
        rslider channel("p4") bounds(158,25,50,50) text("D#") $SLIDER1
        rslider channel("p5") bounds(208,25,50,50) text("E") value(0.5) $SLIDER1
        rslider channel("p6") bounds(258,25,50,50) text("F")value(0.5) $SLIDER1
        rslider channel("p7") bounds(8,80,50,50) text("F#") $SLIDER1
        rslider channel("p8") bounds(58,80,50,50) text("G") $SLIDER1
        rslider channel("p9") bounds(108,80,50,50) text("G#") value(0.5) $SLIDER1
        rslider channel("p10") bounds(158,80,50,50) text("A") $SLIDER1
        rslider channel("p11") bounds(208,80,50,50) text("A#") $SLIDER1
        rslider channel("p12") bounds(258,80,50,50) text("B") $SLIDER1
        
        label text("8ve") bounds (308,30,50,18)
        checkbox channel("o1") text("1") bounds(328,60,25,10)
        checkbox channel("o2") text("2") bounds(328,75,25,10)
        checkbox channel("o3") text("3") bounds(328,90,25,10) value(1)
        checkbox channel("o4") text("4") bounds(328,105,25,10)
        checkbox channel("o5") text("5") bounds(328,120,25,10)value(1)
        checkbox channel("o6") text("6") bounds(328,135,25,10)
        checkbox channel("o7") text("7") bounds(328,150,25,10)
        checkbox channel("o8") text("8") bounds(328,165,25,10)
        
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
opcode Vocoder, a, aakkkpp			;p is an init input with default value of 1

as1,as2,kmin,kmax,kq,ibnd,icnt  xin	;icnt isn't specified in instr, default value=1

if kmax < kmin then
ktmp = kmin
kmin = kmax
kmax = ktmp
endif			;this code inverts the cps if max is less than min

if kmin == 0 then 
kmin = 1
endif			;sets min to 1 if inadvertently set to 0 by error

if (icnt >= ibnd) goto bank
abnd   Vocoder as1,as2,kmin,kmax,kq,ibnd,icnt+1	
			;by using UDO inside of itself it is iterative until icnt exceeds ibnd

bank:
kfreq = kmin*(kmax/kmin)^((icnt-1)/(ibnd-1))
kbw = kfreq/kq
an  butterbp  as2, kfreq, kbw
an  butterbp  an, kfreq, kbw
as  butterbp  as1, kfreq, kbw
as  butterbp  as, kfreq, kbw
ao balance as, an

amix = ao + abnd

     xout amix

endop


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

    kSettings chnget "vSettings"
  
    kSettingsVisible init 0
    if changed(kSettings)==1 then
      kSettingsVisible = (kSettingsVisible+1)
      kSettingsVisible = kSettingsVisible%2
      printk2 kSettingsVisible
        chnset sprintfk("visible(%d)",kSettingsVisible), "vWindow"
    
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
gkVoderMix chnget "vocoderMix"

aMix lowpass2 a(gkMix), 50, 0.5
gaVocodermix lowpass2 a(gkVoderMix), 50, 0.5



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
    ;kSelect chnget "select"
    kSelect chnget "select"
    iFreq = 440
    
    
    if i(gkVoderMix) > 0 then
    
    iPitchProb[] init 12
    iCount = 0 
    while iCount < 12 do 
        Schan sprintf "p%d", iCount+1
        iPitchProb[iCount] chnget Schan
        iCount += 1
    od 


    iRegProb[] init 8
    iCount = 0 
    while iCount < 8 do 
        Schan sprintfk "o%d", iCount+1
        iRegProb[iCount] chnget Schan
        iCount += 1
    od 
    
    
    iCount = 0
    iVal = 0
    iPitch = 0
    while iCount < 12 do
    
        iTemp = rnd(1)*iPitchProb[iCount]
        
        if iTemp >= iVal then
            iVal = iTemp
            iPitch = iCount
            endif
        iCount += 1
        
    od
    iCount = 0
    iVal = 0
    
    while iCount < 8 do         
        iTemp = rnd(1)*iRegProb[iCount]
        if iTemp >= iVal then
            iVal = iTemp
            iReg = iCount
            endif
        iCount += 1
        od
       
    iFreq cpsmidinn iReg*12+iPitch
  
    
    endif 

    
    
    
    if kSelect == 1 then
        a1 vco2 1, iFreq

    elseif kSelect == 2 then

    kfreq  = iFreq
    kfiltq = 0.75
    kfiltrate = 0.0002
    kvibf  = 5
    kvamp  = .01
        a1 moog .15, kfreq, kfiltq, kfiltrate, kvibf, kvamp, 11, 12, 13

    elseif kSelect == 3 then

        a1 wgflute 1, iFreq, 0.3, 0.1, 0.1, 0.1, 0.5, 0.02


    elseif kSelect == 4 then

        a1 wgbowedbar 0.75, iFreq, 3, 0.5, 0.8

    elseif kSelect == 5 then

        a1 wgbow 1, iFreq, 3, 0.1, 5, 0.01

    elseif kSelect == 6 then

    a1 noise 1, 0

    endif
        
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
   
    aV1 Vocoder a1, aGrain[0], 100, 5000, 5, 10
    aGrain[0] = ((1-gaVocodermix)*aGrain[0]+gaVocodermix*aV1)*aEnv
    aGrain[0] = iAmp*aGrain[0]
    aGrain[0] = iGrainPos*aGrain[0]
    
    
    aV2 Vocoder a1, aGrain[1], 100, 5000, 5, 10
    aGrain[1] = ((1-gaVocodermix)*aGrain[1]+ gaVocodermix*aV2)*aEnv
    aGrain[1] = iAmp*aGrain[1]
    aGrain[1] = (1-iGrainPos)*aGrain[1]
    
    
    
    gaOut[0] = aGrain[0]+gaOut[0]
    gaOut[1] = aGrain[1]+gaOut[1]
    
endin    



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 11 0 8192 1 "mandpluk.aiff" 0 0 0
f 12 0 256 1 "impuls20.aiff" 0 0 0
f 13 0 256 10 1	; sine

i "update" 0 z
i "writeTab" 0 z

i 1 0 z
</CsScore>
</CsoundSynthesizer>
