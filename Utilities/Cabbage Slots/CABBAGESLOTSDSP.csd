//#DELAY SLOT 

opcode slotDelay, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    
     
    //GUI Code
        //You must include a block identifies if the slot is enabled 
        if kSelect == iIndex then
         kenabled = 1 
        else 
         kenabled = 0
        endif

        //You must use gui objects defined in the slot this effect is in. The slot update function will make the gui object appear as a parameter for this effect 
        //Each of these updates both reveals a slider with the correct diplay values and gets the value to be used in the dsp code         
        
        kdelayTime slotSliderUpdate Sslot, 1, "time", 0, 1, "time", "ms","","", kenabled, 3, 2, 10, 500, 1, 250 
        kFeedback slotSliderUpdate Sslot, 2, "fb", 1, 1, "fb", "","","",kenabled, 3, 2, 0, 1, 1 
        kMode slotButtonUpdate Sslot, 10, "mode", 0,0,"text(stereo, pingpong)", kenabled, 2,2

        
    
    if kSelect == iIndex && kBypass != 0 then    
        //DSP Code Goes Here
    
        // The DSP code must go in this if block so that it only runs when this slot is selected and not bypassed 
        
        kMode init 0
        aFbL init 0 
        aFbR init 0 
    
        aL vdelay3 aL+aFbL, kdelayTime, 5000
        aR vdelay3 aR+aFbR, kdelayTime, 5000   
    
        aFbL = aL*port(kFeedback,0.1)
        aFbR = aL*port(kFeedback,0.1)
    
        if kMode ==1 then 
            aFbtmp = aFbL
            aFbL= aFbR
            aFbR= aFbtmp
        endif

    endif
    

    xout aL, aR 

endop



//#CHORUS SLOT 

opcode slotChorus, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    
    
  
    kenabled init 0 
     
    //GUI Code
    if kSelect == iIndex then
        kenabled = 1 
    else 
        kenabled = 0 
    endif 
        icols = 3 
        irows = 2
        
        kdelayTime slotSliderUpdate Sslot, 0, "time", 0, 0, "time", "ms","","", kenabled, icols, irows, 0.1, 2000, 2 , 250
        kFeedback slotSliderUpdate Sslot, 1, "fb", 1, 0, "fb", "ms","","", kenabled, icols, irows, 0, 1, 1 , 0 
        kDepth slotSliderUpdate Sslot, 2, "depth", 2, 0, "depth", "","","", kenabled, icols, irows, 0, 50, 1, 10
        kFreq slotSliderUpdate Sslot, 3, "freq", 0, 1, "freq", "hz","","", kenabled, icols, irows, 0.1, 25, 1 ,10
        kdepthrand slotSliderUpdate Sslot, 4, "rDepth", 2, 1, "rDepth", "","","", kenabled, icols, irows, 0, 1, 1, 0

    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    
    kchFB = kFeedback
    kchdel = kdelayTime
    
    kchdepth = kDepth
    kchcps = kFreq
    kchrand  = 0 


    achorusFBL init 0
    achorusFBR init 0
    
    afeedL=aL+achorusFBL
    afeedR=aR+achorusFBR
    
    kdepthrand=kchdepth*kchrand*.001
    
    kchdel=kchdel*.001
    kcpsrand=kchcps*kchrand
    kchcps randomi kchcps-kcpsrand,kchcps+kcpsrand,kchcps
    kchdepth randomi kchdepth-kdepthrand,kchdepth+kdepthrand,kchcps
    kchdepth port kchdepth,.1
    ardelL oscili kchdepth,kchcps,25
    ardelR oscili kchdepth,kchcps,25,.25
    ardel3 oscili kchdepth,kchcps,25,.5
    ardel4 oscili kchdepth,kchcps,25,.75
    ardelL=ardelL+(kchdepth*2.1+kchdel)
    ardelR=ardelR+(kchdepth*2.1+kchdel)
    ardel3=ardel3+(kchdepth*2.1+kchdel)
    ardel4=ardel4+(kchdepth*2.1+kchdel)
    amodL vdelay afeedL,ardelL,200
    amodR vdelay afeedR,ardelR,200
    amod3 vdelay afeedL*.33+afeedR*.66,ardel3,200
    amod4 vdelay afeedR*.33+afeedL*.66,ardel4,200
    achorusFBL=dcblock(((amodL*.6)+(amod4*.3)+(amod3*.15))*-kchFB)
    achorusFBR=dcblock(((amodR*.6)+(amod3*.3)+(amod4*.15))*-kchFB)
    
    aL= afeedL*.7+amodL
    aR= afeedR*.7+amodR
   
   
    endif
    

    xout aL, aR 

endop

//#HARMONIZER
opcode slotHarmonizer, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    
     
    //GUI Code
    kenabled init 0 
    if kSelect == iIndex then
        kenabled = 1 
    else 
        kenabled = 0 
    endif 
    
    icols = 3 
    irows = 2 
    
    kPitch slotSliderUpdate Sslot, 0, "pitch", 0, 0, "pitch", "st","","", kenabled, icols, irows, -12, 12, 1, -4 
    kPitchR slotSliderUpdate Sslot, 1, "pchRnd", 0, 1, "pchRnd", "st","","", kenabled, icols, irows, 0, 12, 1
    
    kVibRate slotSliderUpdate Sslot, 2, "vibRate", 1, 0, "vibRate", "hz","","", kenabled, icols, irows, 0, 20, 1  
    kVibDepth slotSliderUpdate Sslot, 3, "vibDpth", 1, 1, "pchRnd", "st","","", kenabled, icols, irows, 0, 12, 1 
    
    kfb slotSliderUpdate Sslot, 4, "fb", 2, 0, "fb", "","","", kenabled, icols, irows, 0, 1, 1 


    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    
    afbL init 0 
    afbR init 0 
    
    ideltabL ftgenonce 0, 0, 1*sr, 7, 0  
    ideltabR ftgenonce 0, 0, 1*sr, 7, 0
    iwindow  ftgenonce 0, 0, 4096, 20, 2
    
    idelay = 1
     kPitch init 0
     ktranspose init 0 
     
    
    ktranspose port kPitch, 0.01
    ktranspose += random(-kPitchR, kPitchR)

    
    klfohz = 10

    iminDelay = ksmps/sr
    
    klfoperiod = 1/klfohz
    
    
    krate = ktranspose/12
    aclock phasor klfohz     
    
    aclock2 = wrap(aclock+0.5,0,1)
    
    aVibAmount =  kVibDepth/12
    

    
    if krate < 0 then
        astart = iminDelay+aVibAmount*-klfoperiod
        atarget = -klfoperiod*(krate+aVibAmount)+iminDelay
    else
    
        astart = klfoperiod*(krate+aVibAmount)+iminDelay
        atarget = iminDelay+aVibAmount*klfoperiod
   
    endif
    

   
    
    atrig = limit(aclock-0.999,0,1)
    astart1 samphold astart, atrig , 0
    aVibAmount1 samphold aVibAmount, atrig, 0
    atargetDelay1  samphold atarget, atrig, 0
    
    atrig = limit(aclock2-0.999,0,1)
    astart2 samphold astart, atrig, 0
    aVibAmount2 samphold aVibAmount, atrig, 0
    atargetDelay2  samphold atarget, atrig, 0
    
    
    aVib1 oscil aVibAmount1*klfoperiod, kVibRate
    aVib2 oscil aVibAmount2*klfoperiod, kVibRate
    
    adummy delayr idelay
    
    av1 deltapi (1-aclock)*(astart1)+aclock*atargetDelay1+aVib1
    aenv1 tablei limit(aclock*1.05,0,1), iwindow, 1
    av1 *= aenv1
    
    av2 deltapi (1-aclock2)*(astart2)+aclock2*atargetDelay2+aVib2
    aenv2 tablei limit(aclock2*1.05,0,1), iwindow, 1
    av2*= aenv2 
    
    aLOut = av1+av2      

    delayw aL + afbL 
    
    
    adummy delayr idelay
    
    av1 deltapi (1-aclock)*(astart1)+aclock*atargetDelay1+aVib1
    aenv1 tablei limit(aclock*1.05,0,1), iwindow, 1
    av1 *= aenv1
    
    av2 deltapi (1-aclock2)*(astart2)+aclock2*atargetDelay2+aVib2
    aenv2 tablei limit(aclock2*1.05,0,1), iwindow, 1
    av2*= aenv2 
    
    aROut = av1+av2      

    delayw aR + afbR
    
    aL = aLOut
    
    aR = aROut
    
    kfbsmooth port kfb, 0.01
    afbL = aLOut*kfbsmooth
    afbR = aROut*kfbsmooth

    
    endif

    xout aL, aR 
    
    endop

//#FREEVERB SLOT 

opcode slotFreeverb, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    

    kenabled init 0 
    //GUI Code
    if kSelect == iIndex then
    kenabled = 1 
    else 
    kenabled = 0 
    endif 
    
    icols = 2
    irows = 2 
    
    
    kpreGain slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -48, 48, 1 
    kpostGain slotSliderUpdate Sslot, 1, "post", 1, 0, "post", "dB","","", kenabled, icols, irows, -48, 48, 1 
    
    kroomSize slotSliderUpdate Sslot, 2, "size", 0, 1, "size", "","","", kenabled, icols, irows, 0, 1, 1, 0.5
    kdamp slotSliderUpdate Sslot, 3, "damp", 1, 1, "damp", "","","", kenabled, icols, irows, 0, 1, 1, 0.1

    if kSelect == iIndex && kBypass != 0 then
        //DSP Code Goes Here
        aL, aR freeverb aL, aR, kroomSize, kdamp, sr
    endif
    

    xout aL, aR 

endop


//#FDN Reverb SLOT 

opcode slotFdnReverb, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    
    //Create image container 
    
     
    //GUI Code
    kenabled init 0 
    
    if kSelect == iIndex then    
        kenabled = 1 
    else 
        kenabled = 0 
    endif 
    
    icols = 3
    irows = 2 
    
    kpreGain slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -48, 48, 1 
    kpostGain slotSliderUpdate Sslot, 1, "post", 1, 0, "post", "dB","","", kenabled, icols, irows, -48, 48, 1 
    
    kfb slotSliderUpdate Sslot, 2, "fb", 0, 1, "fb", "","","", kenabled, icols, irows, 0, 1, 1, 0.5 
    kcuttoff slotSliderUpdate Sslot, 3, "cuttoff", 1, 1, "cuttoff", "hz","","", kenabled, icols, irows, 50, 15000, 2, 15000
    kpitchR slotSliderUpdate Sslot, 4, "rndPch", 2, 1, "rndPch", "","","", kenabled, icols, irows, 0, 10, 1, 1



    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    if changed2:k(kpitchR) == 1 then 
        reinit FDNVERBINIT
    endif
    
    aL *= db(port(kpreGain,0.01))
    aR *= db(port(kpreGain,0.01)) 
        
    FDNVERBINIT:
        ipitchR =i(kpitchR)
        aL, aR reverbsc aL, aR, kfb, kcuttoff, sr, ipitchR
    rireturn   
    
    aL *= db(port(kpostGain,0.01))
    aR *= db(port(kpostGain,0.01)) 
    
    endif
    

    
    xout aL, aR 

endop


//#Mesh Reverb SLOT 

opcode meshRectScatter, aaaa, aaaaakk
    
    aIn1, aIn2, aIn3, aIn4, aDt, kRc, kCuttoff xin 
    
    az = (aIn1+aIn2+aIn3+aIn4)*0.5
    
    az butterlp az, kCuttoff
    
    aOut1 vdelay aIn1-az, aDt, 5  
    aOut2 vdelay aIn2-az, aDt, 5  
    aOut3 vdelay aIn3-az, aDt, 5  
    aOut4 vdelay aIn4-az, aDt, 5  
    
    xout aOut1*kRc, aOut2*kRc, aOut3*kRc, aOut4*kRc 
endop 

opcode meshWallBounce, a, aakk
    
    aIn, aDt, kRc, kCuttoff xin 
    
    aOut vdelay -aIn, aDt, 2500  
    aOut butterlp aOut, kCuttoff
    
    xout aOut*kRc
endop 


opcode slotTinyMesh, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 

     
    //GUI Code

    kenabled init 0 

    if kSelect == iIndex then    
        kenabled = 1 
    else 
        kenabled = 0 
    endif
    
    icols = 3
    irows = 2 
    
    kpreGain slotSliderUpdate Sslot, 0, "pre", 2, 0, "pre", "dB","","", kenabled, icols, irows, -48, 48, 1 
    kpostGain slotSliderUpdate Sslot, 1, "post", 2, 1, "post", "dB","","",kenabled, icols, irows, -48, 48, 1
    
    kRc slotSliderUpdate Sslot, 2, "rc", 0, 0, "rc", "","","", kenabled, icols, irows, 0, 1, 1, 0.5 
    kflange slotSliderUpdate Sslot, 3, "flng", 1, 0, "flng", "dB","","", kenabled, icols, irows, 0, 1, 1,  0.5
    kCuttoff slotSliderUpdate Sslot, 4, "cutt", 0, 1, "cutt", "dB","","", kenabled, icols, irows, 50, 10000, 0.5,  5000 
    kTime slotSliderUpdate Sslot, 5, "time", 1, 1, "time", "dB","","", kenabled, icols, irows, 4, 500, 0.5,  253
         

if kSelect == iIndex then    

    //DSP Code Goes Here
    
    kRc init -0.75
    kCuttoff init 500
    
    kf oscil kflange*0.01, kflange*2+0.1
    
    adtA = a(port(kTime*1*(1+kf),0.05))
    adtB = a(port((kTime*1.079+10)*(1+kf),0.05))
    adtC = a(port((kTime*0.995-21)*(1+kf),0.05))
    adtD = a(port((kTime*0.991+53)*(1+kf),0.05))
    
    adtWall = a(port(kTime*1.05*(1+kf),0.05))
    
    aA1, aA2, aA3, aA4 init 0 
    aB1, aB2, aB3, aB4 init 0 
    aC1, aC2, aC3, aC4 init 0
    aD1, aD2, aD3, aD4 init 0 
    
    aW1, aW2, aW3, aW4, aW5, aW6, aW7, aW8 init 0 
    
    aW1 meshWallBounce aA3, adtWall, kRc, kCuttoff 
    aW2 meshWallBounce aB3, adtWall+27, kRc, kCuttoff 
    aW3 meshWallBounce aB2, adtWall+18, kRc, kCuttoff 
    aW4 meshWallBounce aD2, adtWall+35, kRc, kCuttoff 
    aW5 meshWallBounce aD4, adtWall+07, kRc, kCuttoff 
    aW6 meshWallBounce aC4, adtWall+03, kRc, kCuttoff 
    aW7 meshWallBounce aC1, adtWall+22, kRc, kCuttoff 
    aW8 meshWallBounce aA1, adtWall+31, kRc, kCuttoff 
    
    aA1, aA2, aA3, aA4 meshRectScatter aW8+aL, aB1, aW1, aC3, adtA, kRc, kCuttoff 
    aB1, aB2, aB3, aB4 meshRectScatter aA2, aW3, aW2+aR, aD3, adtB, kRc, kCuttoff
    aC1, aC2, aC3, aC4 meshRectScatter aW7, aD1, aA4, aW6, adtC, kRc, kCuttoff 
    aD1, aD2, aD3, aD4 meshRectScatter aC2, aW4, aB4, aW5, adtD, kRc, kCuttoff
    
    aL = limit(aC1,-1,1)
    aR = limit(aD4,-1,1)
        aL *= db(port(kpostGain,0.01))
    aR *= db(port(kpostGain,0.01)) 
    endif
    

    
    xout aL, aR 

endop




//#Compressor SLOT 

    /*
    
    From Compressor/Expander.csd
    Written by Iain McCurdy, 2015.
    Adapted to work in cabbage slot format by Christopher Poovey 2021 
    
    Attribution-NonCommercial-ShareAlike 4.0 International
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    */
    
opcode slotComp, aa, aaSikk

    
    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 

    
     
    //GUI Code
    
    kenabled init 0 
    
    if kSelect == iIndex then
        kenabled = 1 
    else 
        kenabled = 0 
    endif
        
        irows = 2
        icols = 4
        
        kpre slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -48, 48, 1
        kpost slotSliderUpdate Sslot, 1, "post", 0, 1, "post", "dB","","", kenabled, icols, irows, -48, 48, 1 
        
        kthresh slotSliderUpdate Sslot, 2, "thrsh", 1, 0, "thrsh", "dB","","", kenabled, icols, irows, -98, 0, 1, -48 
        kcomp slotSliderUpdate Sslot, 3, "comp", 2, 0, "comp", "","","",kenabled,  icols, irows, 0, 1, 1,  0.5
        kcurve slotSliderUpdate Sslot, 4, "curve", 3, 0, "curve", "","","", kenabled, icols, irows, 0, 1, 1,  0.5
        kceil slotSliderUpdate Sslot, 5, "ceil", 1, 1, "ceil", "dB","","", kenabled, icols, irows, -48, 0, 1,  0
        ksmooth slotSliderUpdate Sslot, 6, "smth", 2, 1, "smth", "","","", kenabled, icols, irows, 0, 1, 1,  0.25 





    
    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    
    kpre port db(kpre), 0.05
    kpost port db(kpost), 0.05
   

     kpeg metro 2
     if kpeg==1 then                                                       
      if changed(kthresh,kcomp,kcurve,kceil)==1 then
       reinit REBUILD_TABLE
      endif
     endif
     
     REBUILD_TABLE:
         icurve     = i(kcurve)
         ithresh    = i(kthresh)
         iTabLen    = 4096
         ithreshi   = int(iTabLen * ithresh)                                    
         irem       = iTabLen - ithreshi
         iceil      = i(kceil)
         irem1      = int(irem * (1 - iceil))
         irem2      = irem - irem1
         icomp      = i(kcomp)
         iTransferFunc ftgenonce 0, 0, iTabLen, 16, 0, ithreshi, 0, ithresh*icomp, irem1, icurve, 1, irem2, 0, 1
     rireturn
     
     katt = ksmooth*0.99+0.01
     
     aFollow    follow2    (aL + aR) * kpre, katt, katt
     kRMS       downsamp   aFollow

     aMap       table      aFollow, iTransferFunc, 1 
     aDiff      =          1 + (aMap - aFollow)   
     aDiff      pow        aDiff, 3                                             
     aDiff      tone       aDiff, 1/(1+ksmooth*19 )                                         
     aDynL      =          aL * aDiff                                                
     aDynR      =          aR * aDiff
     
     aL = aDynL * kpost
     aR = aDynR * kpost
                
    endif 
    
    xout aL, aR 

endop

//# Slot Gate

opcode slotGate, aa, aaSikk   
    
    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    
     
    //GUI Code
    kenabled init 0 
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif
       
        irows = 2
        icols = 3
        
        kpre slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -48, 48, 1  
        kpost slotSliderUpdate Sslot, 1, "post", 0, 1, "post", "dB","","", kenabled, icols, irows, -48, 48, 1 
        
        kthresh slotSliderUpdate Sslot, 2, "up", 1, 0, "up", "dB","","", kenabled, icols, irows, -48, 48, 1,  -24
        kthresh2 slotSliderUpdate Sslot, 3, "down", 1, 1, "down", "dB","","", kenabled, icols, irows, -48, 48, 1, -24 
        
        kattack slotSliderUpdate Sslot, 4, "att", 2, 0, "att", "ms","","", kenabled, icols, irows, 2, 200, 2, 50 
        krel slotSliderUpdate Sslot, 5, "rel", 2, 1, "rel", "ms","","", kenabled, icols, irows, 2, 200, 2, 50

    
    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
        aEnv follow (aL+aR)*0.75, 0.001
        kstate init 0 
        kEnv = k(aEnv)
        kportTime init 0
        
        
        if kEnv >= db(kthresh) && kstate == 0 then 
            kportTime = kattack/1000
            kstate = 1
        
        elseif kEnv <= db(kthresh2) && kstate == 1 then 
            kportTime = krel/1000
            kstate = 0
        
        
        endif
        
           
        kgate portk kstate, kportTime
        
        aL *= butterlp(a(kgate),15)
        aR *= butterlp(a(kgate),15)    

    endif 
    
    xout aL, aR 

endop

//#Phaser SLOT 

opcode slotPhaser, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
      
    
     
    //GUI Code
    kenabled init 0 
    if kSelect == iIndex then
    kenabled = 1 
    else 
    kenabled = 0 
    endif
    
        icols =2;
        irows = 2;
        
        kphscps slotSliderUpdate Sslot, 0, "rate", 0, 0, "rate", "hz","","", kenabled, icols, irows, 0.1, 100, 0.25,  80 
        kphsdev slotSliderUpdate Sslot, 1, "phsDev", 1, 0, "phsDev", "","","", kenabled, icols, irows, 0, 1, 1,  0.5 
        kphsQ slotSliderUpdate Sslot, 2, "Q", 1, 1, "Q", "","","", kenabled, icols, irows, 0.01, 100, 0.25,  10
        kphsFB slotSliderUpdate Sslot, 3, "Fb", 0, 1, "Fb", "","","", kenabled, icols, irows, 0, 1, 1,  0.5 
        
    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
        kphsdev oscil 25,kphscps,25
        aLphs phaser2 aL,100+kphsdev,kphsQ,20,1,1,kphsFB
        aRphs phaser2 aR,100+kphsdev,kphsQ,20,1,1,kphsFB
        aL=aLphs
        aR=aRphs
    
    endif 
    xout aL, aR 

endop


//#Flanger SLOT 

opcode slotFlanger, aa, aaSikko

    aL, aR, Sslot, iIndex, kSelect, kBypass, itab xin
    
    iIndex += 1 
    
    //Create image container 

     
    //GUI Code
    kenabled init 0 
    if kSelect == iIndex then
    kenabled = 1 
    else 
    kenabled = 0 
    endif
    

        icols = 2;
        irows = 2;
        
        kflcps slotSliderUpdate Sslot, 2, "rate", 1, 0, "rate", "hz","","", kenabled, icols, irows, 0.01, 100, 0.25,  80 
        kflFB slotSliderUpdate Sslot, 3, "Fb", 0, 0, "Fb", "","","", kenabled, icols, irows, 0, 1, 1,  0.5 

    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    
    if (itab == 0) then 
    
        itab ftgenonce 0, 0, 16385, 7, 0, 8192, 1, 8193, 0
    
    endif
    
    
    adel oscil .02,kflcps,itab
    aLfl flanger aL,adel*.05,kflFB,.1
    aLfl clip aLfl,1,1
    aRfl flanger aR,adel*.05,kflFB,.1
    aRfl clip aRfl,1,1

    aL = aLfl
    aR= aRfl
    endif 
    xout aL, aR 

endop

//#Clip SLOT 

opcode slotClip, aa, aaSikko

    aL, aR, Sslot, iIndex, kSelect, kBypass, itab xin
    
    iIndex += 1 

    //GUI Code
    
    kenabled init 0 
    if kSelect == iIndex then
    kenabled = 1 
    else 
    kenabled = 0 
    endif
    

        icols = 3;
        irows = 2;
        
        
         kpre slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -96, 48, 1 
         kpost slotSliderUpdate Sslot, 1, "post", 0, 1, "post", "dB","","", kenabled, icols, irows, -96, 48, 1
         
         
         ktanh slotSliderUpdate Sslot, 2, "tanh", 2, 0, "tanh", "dB","","", kenabled, icols, irows, -96, 48, 1, 0 
         ksin slotSliderUpdate Sslot, 3, "sin", 2, 1, "sin", "dB","","", kenabled, icols, irows, -96, 48, 1, -96
         
         kfold slotSliderUpdate Sslot, 4, "mirror", 1, 0, "mirror", "dB","","", kenabled, icols, irows, -96, 48, 1, -96 
         kclip slotSliderUpdate Sslot, 5, "soft", 1, 1, "soft", "dB","","", kenabled, icols, irows, -96, 48, 1, -96

    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    
    kpre port db(kpre), 0.05
    kpost port db(kpost), 0.05
    kfold port db(kfold), 0.05
    ktanh port db(ktanh), 0.05
    ksin port db(ksin), 0.5
    kclip port db(kclip), 0.05
    
    
    aL *= kpre 
    aR *= kpost 
    
    aLfold mirror aL, -1,1 
    aRfold mirror aR, -1,1 
    
    atanhL clip aL, 2,1, 0.5
    atanhR clip aR, 2,1, 0.5
    
    
    asinL clip aL, 1, 1, 0.5
    asinR clip aR, 1, 1, 0.5 
    
    aclipL clip aL, 0, 1, 0.5
    aclipR clip aR, 0, 1, 0.5 
    
    aL = 0 
    aR = 0 
    
    aL += aLfold*kfold
    aR += aRfold*kfold
    aL += aclipL*kclip
    aR += aclipR*kclip
    aL += atanhL*ktanh
    aR += atanhR*ktanh
    aL += asinL*ksin
    aR += asinR*ksin
    
    aL *= kpost 
    aR*= kpost
    
    endif 
    xout aL, aR 

endop



//#Shape SLOT 

opcode slotShape, aa, aaSikko

    aL, aR, Sname, iIndex, kSelect, kBypass, itab xin
    
    iIndex += 1 
    

    kenabled init 0 
    //GUI Code
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif
        icols = 5
        irows = 3
        

         kpre slotSliderUpdate Sname, 0, "pre", 0, 0, "pre", "dB","","", kenabled, 4, 2, -96, 48, 1  
         kpost slotSliderUpdate Sname, 1, "post", 0, 1, "post", "dB","","", kenabled, 4, 2, -96, 48, 1 

         kp1 slotButtonUpdate Sname, 10, "x^2", 1,0, "", kenabled, icols, irows   
         kp2 slotButtonUpdate Sname, 11, "x^3", 2,0, "", kenabled, icols, irows
         kp3 slotButtonUpdate Sname, 12, "x^4", 3,0, "", kenabled, icols, irows   
         kp4 slotButtonUpdate Sname, 13, "x^5", 4,0, "", kenabled, icols, irows
         kp5 slotButtonUpdate Sname, 14, "x^6", 1,1, "", kenabled, icols, irows   
         kp6 slotButtonUpdate Sname, 15, "x^7", 2,1, "", kenabled, icols, irows
         kp7 slotButtonUpdate Sname, 16, "x^8", 3,1, "", kenabled, icols, irows   
         kp8 slotButtonUpdate Sname, 17, "x^9", 4,1, "", kenabled, icols, irows
         kp9 slotButtonUpdate Sname, 18, "x^10", 1,2, "", kenabled, icols, irows   
         kp10 slotButtonUpdate Sname, 19, "x^11", 2,2, "", kenabled, icols, irows
         kp11 slotButtonUpdate Sname, 20, "x^12", 3,2, "", kenabled, icols, irows   
         kp12 slotButtonUpdate Sname, 21, "x^13", 4,2, "", kenabled, icols, irows

    if (itab == 0) then 
    
        itab ftgenonce 0, 0, 16385, 10, 1
    
    endif 
    
    
    if kSelect == iIndex && kBypass != 0 then
    
        kpre port db(kpre), 0.05
        kpost port db(kpost), 0.05
        
        aL *= kpre 
        aR *= kpre 
        
        aL polynomial aL, 0, kp1, kp2, kp3, kp4, kp5, kp6, kp7, kp8, kp9, kp10, kp11, kp12
        aR polynomial aR, 0, kp1, kp2, kp3, kp4, kp5, kp6, kp7, kp8, kp9, kp10, kp11, kp12
        
        aL tablei aL, itab, 1
        aR tablei aR, itab, 1
        
        
        aL limit aL, -1, 1
        aR limit aR, -1, 1 
        
        aL dcblock2 aL
        aR dcblock2 aR 
        
        aL *= kpost 
        aR *= kpost 
        
    endif 
    xout aL, aR 

endop
;
//#Degrade slot
opcode slotDegrade, aa, aaSikko

    aL, aR, Sslot, iIndex, kSelect, kBypass, itab xin
    
    iIndex += 1 

    kenabled init 0 
    //GUI Code
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif

    
        icols = 3
        irows = 2
        
        kpre slotSliderUpdate Sslot, 0, "pre", 0, 0, "pre", "dB","","", kenabled, icols, irows, -96, 48, 1 
        kpost slotSliderUpdate Sslot, 1, "post", 0, 1, "post", "dB","","", kenabled, icols, irows, -96, 48, 1
        
        kbit slotSliderUpdate Sslot, 2, "bits", 1, 0, "bits", "bits","","", kenabled, icols, irows, 1, 24, 1,  8 
        kfold slotSliderUpdate Sslot, 3, "fold", 1, 1, "fold", "","","", kenabled, icols, irows, 1, 64, 1, 0 

    if kSelect == iIndex && kBypass != 0 then
    
        
        kpre port db(kpre), 0.05
        kpost port db(kpost), 0.05
        
        aL *= kpre
        aR *= kpre 
        aL limit aL, 0,1
        aR limit aR, 0,1
        
        kbitmul = powoftwo(floor(kbit))
        aL = (round((aL*0.5+0.5)*kbitmul)/kbitmul-0.5)*2
        aR = (round((aR*0.5+0.5)*kbitmul)/kbitmul-0.5)*2

        
        aL fold aL, kfold
        aR fold aR, kfold
        
        aL *= kpost
        aR *= kpost
        
    endif 
    xout aL, aR 

endop
;
//#Multitap SLOT 

opcode slotMultitap, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 

     
    //GUI Code
        kenabled init 0 
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif
        icols = 5
        irows = 3
        

    ktaps[] init 4 
    kamps[] init 4
        icols = 4;
        irows = 2;
       
         ktaps[0] slotSliderUpdate Sslot, 0, "t1", 0, 0, "t1", "ms","","", kenabled, icols, irows, 1, 1000, 2,  100 
         kamps[0] slotSliderUpdate Sslot, 1, "a1", 0, 1, "a1", "","","", kenabled, icols, irows, 0, 1, 1, 0.5
         
         ktaps[1] slotSliderUpdate Sslot, 2, "t2", 1, 0, "t2", "ms","","", kenabled, icols, irows, 1, 1000, 2, 151 
         kamps[1] slotSliderUpdate Sslot, 3, "a2", 1, 1, "a2", "","","", kenabled, icols, irows, 0, 1, 1, 0.25
         
         ktaps[2] slotSliderUpdate Sslot, 4, "t3", 2, 0, "t3", "ms","","", kenabled, icols, irows, 1, 1000, 2, 177.5
         kamps[2] slotSliderUpdate Sslot, 5, "a3", 2, 1, "a3", "","","", kenabled, icols, irows, 0, 1, 1, 0.25
         
         ktaps[3] slotSliderUpdate Sslot, 6, "t4", 3, 0, "t4", "ms","","", kenabled, icols, irows, 1, 1000, 2, 189.154 
         kamps[3] slotSliderUpdate Sslot, 7, "a4", 3, 1, "a4", "","","", kenabled, icols, irows, 0, 1, 1, 0.2 


    
    if kSelect == iIndex && kBypass != 0 then
    
    //DSP Code Goes Here
    aLDel = 0 
    aRDel = 0 

    
    ktaps = ktaps/1000
        adummy delayr 1
        
        aLDel += deltapi(port(ktaps[0],0.01))*kamps[0]
        aLDel += deltapi(port(ktaps[1],0.01))*kamps[1]
        aLDel += deltapi(port(ktaps[2],0.01))*kamps[2]
        aLDel += deltapi(port(ktaps[3],0.01))*kamps[3]
        //aLDel += deltapi(port(ktaps[4],0.01))*kamps[4]
        //aLDel += deltapi(port(ktaps[5],0.01) )*kamps[5]
        
         
        
        delayw aL     
        


        adummy delayr 1
        
        aRDel += deltapi(port(ktaps[0],0.01))*kamps[0]
        aRDel += deltapi(port(ktaps[1],0.01))*kamps[1]
        aRDel += deltapi(port(ktaps[2],0.01))*kamps[2]
        aRDel += deltapi(port(ktaps[3],0.01))*kamps[3]
        //aRDel += deltapi(port(ktaps[4],0.01))*kamps[4]
        //aRDel += deltapi(port(ktaps[5],0.01) )*kamps[5]
        
         
        
        delayw aR        
        

        aL = aLDel
        aR = aRDel

    endif 
    
    xout aL, aR 

endop
;
//#Waveshapes slot
opcode slotWaveshapes, aa, aaSikki[]

    aL, aR, Sslot, iIndex, kSelect, kBypass, itabs[] xin
    
    iIndex += 1 
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif
        icols = 5
        irows = 3

        icols = 4
        irows = 2
        
        kws slotButtonUpdate Sslot, 10, "mode", 0,0,"text(sin, square)", 2.5,2, 0
        kf1 slotSliderUpdate Sslot, 0, "f1", 2, 0, "f1", "hz","","", kenabled, icols, irows, 40, 1000, 0.25, 500 
        ka1 slotSliderUpdate Sslot, 1, "a1", 3, 0, "a1", "","","", kenabled, icols, irows, 0, 1, 1, 1
        kf2 slotSliderUpdate Sslot, 2, "f2", 0, 1, "f2", "hz","","", kenabled, icols, irows, 40, 1000, 0.25, 1000 
        ka2 slotSliderUpdate Sslot, 3, "a2", 1, 1, "a2", "","","", kenabled, icols, irows, 0, 1, 1, 0.5
        kf3 slotSliderUpdate Sslot, 4, "f3", 2, 1, "f3", "hz","","", kenabled, icols, irows, 40, 1000, 0.25, 1500
        ka3 slotSliderUpdate Sslot, 5, "a3", 3, 1, "a3", "","","", kenabled, icols, irows, 0, 1, 1, 0.33
         

    
    if kSelect == iIndex && kBypass != 0 then
    
        aenvL follow aL, 0.01
        aenvR follow aR, 0.01
         if kws = 0 then 
        ktab = itabs[0]
        else
        ktaps = itabs[2]
        endif 
        
        if ftexists:k(ktab) == 1 then 
        
            ao1 oscilikt port(ka1,0.05), port(kf1,0.05), ktab
            ao2 oscilikt port(ka2,0.05), port(kf2,0.05), ktab
            ao3 oscilikt port(ka3,0.05), port(kf3,0.05), ktab
        
            aoSum = ao1+ao2+ao3
        
            aL = aoSum*butterlp(aenvL,15)
            aR = aoSum*butterlp(aenvR,15)
        endif 
        
    endif 
    xout aL, aR 

endop


//#Waveguide slot
opcode slotWaveguide, aa, aaSikk

    aL, aR, Sslot, iIndex, kSelect, kBypass xin
    
    iIndex += 1 
    

     
    //GUI Code

        kenabled init 0 
    if kSelect == iIndex then
        kenabled = 1 
    else
        kenabled = 0
    endif
    

        icols = 3
        irows = 2
        
        kf1 slotSliderUpdate Sslot, 0, "f1", 1, 0, "f1", "hz","","", kenabled, icols, irows, 10, 1000, 2, 200 
        ka1 slotSliderUpdate Sslot, 1, "a1", 1, 1, "a1", "","","", kenabled, icols, irows, 0, 1, 1, 1 
        
        kfb slotSliderUpdate Sslot, 2, "fb", 0, 1, "fb", "","","", kenabled, icols, irows, 0, 0.999, 1, 0.9 
        kthresh slotSliderUpdate Sslot, 3, "thrsh", 0, 0, "thrsh", "dB","","", kenabled, icols, irows, -48, 0, 1, -24 

        kf2 slotSliderUpdate Sslot, 4, "f2", 2, 0, "f2", "hz","","", kenabled, icols, irows, 10, 1000, 2, 410
        ka2 slotSliderUpdate Sslot, 5, "a1", 2, 1, "a2", "","","", kenabled, icols, irows, 0, 1, 1, 1

    if kSelect == iIndex && kBypass != 0 then
    
        kf1 port kf1, 0.05
        kf2 port kf2, 0.05
        ka1 port ka1, 0.05 
        ka2 port ka2, 0.05
    
        kimpulse init 0 
        
        aEnvL follow (aL), 0.01
        aEnvR follow (aR), 0.01
        aEnv = aEnvL*0.75+aEnvR*0.75

       kval init 0 
       ktime init 0.01 
       ktrig trigger k(aEnv), db(kthresh), 0
       
      
        aimpulseL = 0 
        aimpulseR = 0 
      
       if changed2:k(ktrig) == 1 then 
       
        aimpulseL = limit(aEnvL/aEnvR,0.5,1)*(aEnv*0.5+0.5)
        aimpulseR = limit(aEnvR/aEnvL,0.5,1)*(aEnv*0.5+0.5)
       
       endif 
        

        aWg1L wguide1 aimpulseL,kf1,k(1000),kfb
        aWg2L wguide1 aimpulseL,kf2,k(1000),kfb
        
        aWg1R wguide1 aimpulseR,kf1,k(1000),kfb
        aWg2R wguide1 aimpulseR,kf2,k(1000),kfb
        
        aWgL = aWg1L*port(ka1,0.05) + aWg2L*port(ka2,0.05)
        aWgR = aWg1R*port(ka1,0.05) + aWg2R*port(ka2,0.05)
        
        aL = aWgL
        aR = aWgR
        
        
    endif 
    xout aL, aR 

endop