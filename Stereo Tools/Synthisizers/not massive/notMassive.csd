<Cabbage>
#define OSCSELECT nslider range(2,80,2,1,1) 
/*combobox identchannel("WT") populate("*.wav", "Wavetables") channeltype("float") value(2)*/ 
#define ENVSELECT combobox items("___", "Env 1", "Env 2", "Env 3", "Env 4", "LFO 1", "LFO 2", "LFO 3")
#define PITCHSLIDER nslider range(-100,100,0,1,0.01) bounds(8,25,80,20)  popuppostfix(" semi")
#define MODDEPTHSLIDER nslider range(-100,100,0,1,0.01) bounds(8,50,80,20)  popuppostfix(" semi")
#define FILTERMIX vslider range(-1,1,0,1,0.01) bounds(250,25,15,95)  popuppostfix(" filter mix")
#define FILTERMIX_A label text("A") bounds(270,28,15,18) align("left")
#define FILTERMIX_B label text("B") bounds(270,90,15,18) align("left")
#define WTPOS rslider text("WT-Pos") bounds(8, 72,50,50) range(0,0.999,0.5,1,0.01)
#define WTAMP rslider text("Amp") bounds(68, 72,50,50) range(0,0.999,0.5,1,0.01)

form caption("not massive") size(1000, 600), colour(50,0,0), pluginid("mssv")

groupbox text("osc 1")  bounds(8, 8, 300, 120){
     $PITCHSLIDER       channel("osc1.pitch")
     $MODDEPTHSLIDER    channel("osc1.pitchDepth")
     $ENVSELECT         channel("osc1.pitchEnv")  bounds (90,50,100,20) 
     $FILTERMIX         channel("osc1.filtermix")
        $FILTERMIX_A
        $FILTERMIX_B
     $OSCSELECT         channel("osc1.wt")  bounds (90,25,100,20) 
     $WTPOS             channel("osc1.wtpos")
     $WTAMP             channel("osc1.amp")
}

groupbox text("osc 2")  bounds (8,138,300,120){
     $PITCHSLIDER       channel("osc2.pitch")
     $MODDEPTHSLIDER    channel("osc2.pitchDepth")
     $ENVSELECT         channel("osc2.pitchEnv")  bounds (90,50,100,20) 
     $FILTERMIX         channel("osc2.filtermix")
        $FILTERMIX_A
        $FILTERMIX_B
     $OSCSELECT         channel("osc2.wt")  bounds (90,25,100,20) 
     $WTPOS             channel("osc2.wtpos")
     $WTAMP             channel("osc2.amp")

}

groupbox text("osc 3")  bounds (8,268,300,120){
     $PITCHSLIDER       channel("osc3.pitch")
     $MODDEPTHSLIDER    channel("osc3.pitchDepth")
     $ENVSELECT         channel("osc3.pitchEnv")  bounds (90,50,100,20) 
     $FILTERMIX         channel("osc3.filtermix")
        $FILTERMIX_A
        $FILTERMIX_B
     $OSCSELECT         channel("osc3.wt")  bounds (90,25,100,20) 
     $WTPOS             channel("osc3.wtpos")
     $WTAMP             channel("osc3.amp")

}

groupbox text("filter A")  bounds (328,8,300,120)
groupbox text("filter B")  bounds (328 ,138,300,120)

groupbox text("effect 1")  bounds(648, 8, 300, 120)
groupbox text("effect 2")  bounds (648,138,300,120)

groupbox text("envelope") bounds(328, 268, 618,200)

groupbox text("insert 1") bounds (8,398,140,120)
groupbox text("insert 2") bounds (168,398,140,120)

keyboard bounds(328, 500, 618, 95) 
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1
gaMix init 0


opcode makeOsc, a, iii
    iamp, inote, iOscNumber xin
    aEnv madsr 0.05, 0.1, 0.8, 0.1
    Sprefix sprintf "osc%d.", iOscNumber
    
    kPitch chnget strcat(Sprefix, "pitch")
    kPitch portk kPitch, 0.01
        
    
    iWT chnget strcat(Sprefix, "wt")
    kWTPos chnget strcat(Sprefix, "wtpos")
    kAmp chnget strcat(Sprefix, "amp")
    kAmp portk kAmp, 0.01
    iTabLen = tableng(iWT)
    iTabSlice = iTabLen/2048
    iDivision = 1/iTabSlice - 1
    kWTInterp = kWTPos/iDivision
    kWTInterp portk kWTInterp, 0.05 
    kWTLow = floor(kWTInterp)
    kWTHigh = kWTLow + 1
    kWTInterp = kWTInterp-kWTLow
    
    kcps = cpsmidinn(inote+kPitch)
    
    aMix1 lposcil3 iamp, kcps/21.83, kWTLow*2048, kWTLow*2048+2048, iWT
    aMix2 lposcil3 iamp, kcps/21.83, limit(kWTHigh*2048,0,iTabLen-2048), limit(kWTHigh*2048+2048,0,iTabLen), iWT
    aMix = aMix1*(1-kWTInterp)+aMix2*kWTInterp
    aMix *= aEnv
    aMix *= kAmp
    xout aMix 
 endop

;instrument will be triggered by keyboard widget
instr 1
    aMix makeOsc p5, p4, 1    
    gaMix += aMix
    aMix makeOsc p5, p4, 2    
    gaMix += aMix
    aMix makeOsc p5, p4, 3    
    gaMix += aMix
endin

instr loadWT
;Wavetables Each frame is 2048 samples, to interpolate between the frames crossfade between the frames.  The steps will be determined by the table length
    giBasic ftsamplebank "Wavetables", 1, 0, 0, 0
endin

instr output

    ;gaMix limit gaMix, 0, 1
    gaMix butterbp gaMix, sr/2.1, sr/2    
    outs gaMix, gaMix
    clear gaMix

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i "loadWT" 0 0.1
i "output" 0 z




</CsScore>
</CsoundSynthesizer>
