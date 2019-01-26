<Cabbage>
form caption("Untitled") size(600, 300), colour(58, 110, 182), pluginid("def1")
    groupbox text("Synth 1") bounds(8,8,225,200){
            vslider bounds(18,25,10,100) channel("amp1.1") range(0,1,1,1,0.01)
            vslider bounds(38,25,10,100) channel("amp1.2") range(0,1,0.5,1,0.01)
            vslider bounds(58,25,10,100) channel("amp1.3") range(0,1,0.25,1,0.01)
            vslider bounds(78,25,10,100) channel("amp1.4") range(0,1,0.1,1,0.01)
            vslider bounds(98,25,10,100) channel("amp1.5") range(0,1,0.1,1,0.01)
            vslider bounds(118,25,10,100) channel("amp1.6") range(0,1,0.1,1,0.01)
            vslider bounds(138,25,10,100) channel("amp1.7") range(0,1,0.05,1,0.01)
            vslider bounds(158,25,10,100) channel("amp1.8") range(0,1,0.05,1,0.01)
            vslider bounds(178,25,10,100) channel("amp1.9") range(0,1,0.05,1,0.01)
            vslider bounds(198,25,10,100) channel("amp1.10") range(0,1,0.05,1,0.01)
            
            rslider bounds(12,130,20,20) channel("detune1.1") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(32,130,20,20) channel("detune1.2") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(52,130,20,20) channel("detune1.3") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(72,130,20,20) channel("detune1.4") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(92,130,20,20) channel("detune1.5") range(0.95,1.05, 1, 1, 0.0001))
            rslider bounds(112,130,20,20) channel("detune1.6") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(132,130,20,20) channel("detune1.7") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(152,130,20,20) channel("detune1.8") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(172,130,20,20) channel("detune1.9") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(192,130,20,20) channel("detune1.10") range(0.95,1.05, 1, 1, 0.0001)
    }
    
        groupbox text("Synth 2") bounds(250,8,225,200){
            vslider bounds(18,25,10,100) channel("amp2.1") range(0,1,0.25,1,0.01)
            vslider bounds(38,25,10,100) channel("amp2.2") range(0,1,1,1,0.01)
            vslider bounds(58,25,10,100) channel("amp2.3") range(0,1,0.25,1,0.01)
            vslider bounds(78,25,10,100) channel("amp2.4") range(0,1,0.25,1,0.01)
            vslider bounds(98,25,10,100) channel("amp2.5") range(0,1,0.1,1,0.01)
            vslider bounds(118,25,10,100) channel("amp2.6") range(0,1,0.1,1,0.01)
            vslider bounds(138,25,10,100) channel("amp2.7") range(0,1,0.1,1,0.01)
            vslider bounds(158,25,10,100) channel("amp2.8") range(0,1,0.05,1,0.01)
            vslider bounds(178,25,10,100) channel("amp2.9") range(0,1,0.6,1,0.01)
            vslider bounds(198,25,10,100) channel("amp2.10") range(0,1,0.05,1,0.01)
            
            rslider bounds(12,130,20,20) channel("detune2.1") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(32,130,20,20) channel("detune2.2") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(52,130,20,20) channel("detune2.3") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(72,130,20,20) channel("detune2.4") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(92,130,20,20) channel("detune2.5") range(0.95,1.05, 1, 1, 0.0001))
            rslider bounds(112,130,20,20) channel("detune2.6") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(132,130,20,20) channel("detune2.7") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(152,130,20,20) channel("detune2.8") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(172,130,20,20) channel("detune2.9") range(0.95,1.05, 1, 1, 0.0001)
            rslider bounds(192,130,20,20) channel("detune2.10") range(0.95,1.05, 1, 1, 0.0001)
    }


hrange channel ("interpLow", "interpHigh") bounds(8, 210, 450, 20) 
rslider channel ("interpCorse") bounds(450,210,50,50) text("index rate") range(0, 10,0,2,0.01)
rslider channel ("interpFine") bounds(500,210,50,50) text("freq rate") range(0,100,0,1,0.01)


keyboard bounds(8, 240, 381, 50)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5


</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1



;instrument will be triggered by keyboard widget
instr 1
    aLeft = 0 
    aRight = 0
    kCorse chnget "interpCorse"
    kCorse = kCorse*p4
    kFine chnget "interpFine"
    kInterp oscil 1, kFine+kCorse, 1, 0
    kInterp = (kInterp+1)*0.5
    kLow chnget "interpLow"
    kHigh chnget "interpHigh"
    
    kInterp scale kInterp, kLow, kHigh
    kCount = 0
    kTab = 1
    

    kCount = 0
    kPan = 0.5
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    iPhase rnd 3.14
    Samp sprintfk "amp1.%d", kCount+1 
    kAmp1 chnget Samp
    Samp sprintfk "amp2.%d", kCount+1 
    kAmp2 chnget Samp
    kAmp = kAmp1*(1-kInterp) + kAmp2*kInterp    
    SDetune  sprintfk "detune1.%d", kCount+1
    kDetune1 chnget SDetune
    SDetune  sprintfk "detune2.%d", kCount+1
    kDetune2 chnget SDetune
    kDetune = kDetune1*(1-kInterp) + kDetune2*kInterp
    kFreq = kCount*p4*kDetune
    aOsc oscilikt kAmp, kFreq, kTab, iPhase 
    aLeft += aOsc*(1-kPan)
    aRight += aOsc*kPan
    kCount += 1
    
    
   
    
    kCount = 0
    
    aEnv madsr 0.1, 0.1, 0.8, 0.2
    
    outs aLeft*aEnv*p5*0.1 , aRight*aEnv*p5*0.1 
    


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z 
f1 0 16384 10 1 ;Sine
f2 0 16384 10 1 0.5 0.3 0.25 0.2 0.167 0.14 0.125 .11 ;Saw
f3 0 16384 10 1 0 0.3 0 0.2 0 0.14 0 .111 ; Square
f4 0 16384 10 1 1 1 1 0.7 0.5 0.3 0.1; pulse
</CsScore>
</CsoundSynthesizer>
