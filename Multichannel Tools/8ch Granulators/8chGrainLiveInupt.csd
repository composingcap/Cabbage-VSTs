<Cabbage>
form caption("8ChGrain") size(660, 300), colour(58, 110, 182), pluginid("g8ln")
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
    rslider bounds(140, 100, 70,70) text("Delay") channel("del") range(0, 0.99, 0, 1,0.01)
    rslider bounds(200, 110, 40,40) text("Delay Jitter") channel("delR") range(0, 1, 0.5, 1, 0.01)
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
sr = 44100
ksmps = 32
nchnls = 8
0dbfs = 1
giMaxDelay = 5
giTabLen = sr*giMaxDelay
giBuf ftgenonce 101, 0, giTabLen, 2,0


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
    
    if  kFreeze== 0 then       
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
    
    iTotalADR = iA+iD+iR
    
    
    
    aEnv adsr iA/iTotalADR*p3, iD/iTotalADR*p3, iS, iR/iTotalADR*p3
    aOuts[] init 8
    aOuts *= 0 ;clears array
    
    iAmp = p5
    iRandStart = i(gkDel)*(1-random(0,i(gkDelR)))%1
    aPos wrap gaSync-iRandStart,0,1
    aGrain table3 aPos, 101, 1, 0, 1
   



    aGrain *= aEnv
    aGrain *= iAmp

        iProb chnget "chprob_1"
        iRandy random 0., 1.
        if iRandy <= iProb then  
            iRandom random -i(gkGampR), 0
            aOuts[0] = aGrain*(iRandom+1)        
        endif
        
        iProb chnget "chprob_2"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[1] = aGrain*(iRandom+1)    
        endif    

        iProb chnget "chprob_3"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[2] = aGrain*(iRandom+1)    
        endif
       
        iProb chnget "chprob_4"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[3] = aGrain*(iRandom+1)    
        endif       

        iProb chnget "chprob_5"
        iRandy random 0., 1.
        if iRandy <= iProb then  
            iRandom random -i(gkGampR), 0
            aOuts[4] = aGrain*(iRandom+1)         
        endif
        
        iProb chnget "chprob_6"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[5] = aGrain*(iRandom+1)    
        endif    

        iProb chnget "chprob_7"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[6] = aGrain*(iRandom+1)    
        endif
       
        iProb chnget "chprob_8"
        iRandy random 0., 1.
        if iRandy <= iProb then
            iRandom random -i(gkGampR), 0
            aOuts[7] = aGrain*(iRandom+1)   
        endif       
    
   
    

    outo aOuts[0], aOuts[1], aOuts[2], aOuts[3], aOuts[4], aOuts[5], aOuts[6], aOuts[7]
    
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
