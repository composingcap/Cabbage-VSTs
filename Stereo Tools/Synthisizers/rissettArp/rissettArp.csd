<Cabbage>
form caption("RissetArpSynth") size(400, 300), colour(58, 110, 182), pluginid("rarp")
keyboard bounds(8, 180, 381, 95)



image bounds(8, 5, 200, 150) colour(0,0,0,50) identchannel("rissetPlant") visible(1){
    rslider bounds (10,5,70,50) text("chorus distance") range(0.01, 1, 0.08, 0.25, 0.001) channel("chorusDist")
    rslider bounds (110,5,70,50) text("falloff") range(-.5, .5, 0, 1, 0.01) channel("falloff")
    rslider bounds (10,85,70,50) text ("chorus distance random") range(0,10,0,1,0.001) channel("chorusDistR")
    rslider bounds (110,85,70,50)text("number of saws") range(1,100,20,1,1) channel("nSaws")
    rslider bounds (63,42,70,50)text("random phase") range(0,1,0,1,0.001) channel("rPhase")
    }
    
    image bounds(215, 40, 180, 75) colour(0,0,0,50) identchannel("ADSRPlant") visible(1){
    rslider bounds (0,10,50,50) text("A") range(0.0001, 5, 0.8, 0.25, 0.001) channel("A")
    rslider bounds (40,10,50,50) text("D") range(0.0001, 5, 0.8, 0.25, 0.001)channel("D")
    rslider bounds (80,10,50,50) text ("S") range(0,1,1,1,0.001) channel("S")
    rslider bounds (120,10,50,50)text("R") range(0.0001, 5, 0.8, 0.25, 0.001) channel("R")
    }


</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1


opcode rissetArp, a, iikkkkii 

    /*  This is a recursive opcode-- this means it calls upon itself and eventualy breaks its internal loop 
        This specific opcode creates n saw waves until a counter reaches the number "iSaws" 
        
        iWave- The function table of the desired waveform
        iSaws- the number of saw waves to create
        kFreq- the base frequency of the arp
        kDist- the deviation in frequency between the wavetables 
        kDistR- a random amount of distnce in frequency 
        kFalloff- the amount each saw decreased in amp from the last
        iPhaseR- Random phase start position depth 
        iCount- the accumulator this should be set to 0
    */

    aMix init 0 ;Mix init to 0 because it is in if statment 
    
    iWave, iSaws, kFreq, kDist, kDistR, kFalloff, iPhaseR, iCount xin ;get inputs
    
    kThisFreq = kFreq+(kDist*iCount)*(1+random(-kDistR,kDistR)) ;determine frequency based on the number of the saw
    
    aWave oscil pow((1-kFalloff),iCount), kThisFreq, iWave, random(0,iPhaseR)   ;Synthisize-- random phase is added to give different "start points" to the arp
    
    iCount = iCount + 1 ; increase the accumulator
    
    if iCount < iSaws then ;If the counter is under the number of saws, make another by callinf the function again
        aMix rissetArp iWave, iSaws, kFreq, kDist, kDistR, kFalloff, iPhaseR, iCount   
        else
        
    endif
    
    

    
xout aWave+aMix ;Mix the output with all of the opcodes called
     
    
endop   
    


instr update
    ;This instrument gets updates from the gui
   
       gkRPhase chnget "rPhase"
       gkCorusDist chnget "chorusDist"
       gkCorusDistR chnget "chorusDistR"
       gkFalloff chnget "falloff"
       gkA chnget "A"
       gkD chnget "D"
       gkS chnget "S"
       gkR chnget "R"
   
endin


;instrument will be triggered by keyboard widget
instr 1
    iCount	init	0
    kEnv madsr i(gkA), i(gkD), i(gkS), i(gkR)
    aMix rissetArp 2, 5, p4, gkCorusDist, gkCorusDistR, gkFalloff, i(gkRPhase), iCount
    outs aMix*kEnv*0.25*p5, aMix*kEnv*0.25*p5
endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "update" 0 z
f 2 0 16384 10 1 0.5 0.3 0.25 0.2 0.167 0.14 0.125 .111
</CsScore>
</CsoundSynthesizer>
