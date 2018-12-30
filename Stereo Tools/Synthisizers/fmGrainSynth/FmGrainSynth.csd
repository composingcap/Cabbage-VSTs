<Cabbage>
form caption("Fm Grain"), size(500, 400), colour("grey"), pluginID("cpFG"), fontcolour("black")
keyboard bounds(8, 300, 480, 95)
rslider bounds(88, 60, 75, 50), range(0, 0.5, 0, 1, 0.001), channel("FreqJitter"), text("Freq Jitter"), textcolour("black"), trackercolour("black")
rslider bounds(8, 10, 75, 50), range(0.5,500, 10, .25, 0.01), channel("GrainRate"), text("Grains Rate"), textcolour("black"), trackercolour("black")
rslider bounds(8, 60, 75, 50), range(0 , 0.8 , 0 , 1, 0.001), channel("GrainRateJitter"), text("Rate Jitter"), textcolour("black"), trackercolour("black")
rslider bounds(88, 10, 75, 50), range(0, 1, 0, 1, 0.001), channel("AmpJitter"), text("Amp Jitter"), textcolour("black"), trackercolour("black")
rslider bounds(168, 10, 75, 50), range(10, 100, 10, 2, .5), channel("ModDepth"), text("ModDepth"), textcolour("black"), trackercolour("black")
rslider bounds(168, 60, 75, 50), range(0, 1, 0, 1, 0.001), channel("ModDepthJitter"), text("ModJitter"), textcolour("black"), trackercolour("black")
rslider bounds(248, 10, 75, 50), range(1, 10, 3.172, 1.5, 0.001), channel("Index"), text("Index"), textcolour("black"), trackercolour("black")
rslider bounds(248, 60, 75, 50), range(0, 0.1, 0, 1, 0.0001), channel("IndexJitter"), text("Index Jitter"), textcolour("black"), trackercolour("black")
rslider bounds(328, 10, 75, 50), range(0.01, 5, 1, 0.5, 0.001), channel("GrainLength"), text("Grain Length"), textcolour("black"), trackercolour("black")
rslider bounds(328, 60, 75, 50), range(0, 0.1, 0, 1, 0.0001), channel("GrainLengthJitter"), text("Length Jitter"), textcolour("black"), trackercolour("black")
rslider bounds(8, 110, 75, 50), range(0, 1, 0.5, 1, 0.001), channel("pan"), text("pan position"), textcolour("black"), trackercolour("black")
rslider bounds(88, 110, 75, 50), range (0, 1, 0, 1, 0.01), channel("panJitter"), text("pan jitter"), textcolour("black"), trackercolour("black")
groupbox bounds(178,122, 90, 50) text("Grain Envelope") 
rslider bounds(178, 147, 30, 20) range(0.01, 1, 0.1, 1, 0.001) channel("grainA") text("") popuptext("Attack"), textcolour("black"), trackercolour("black")
rslider bounds(198, 147, 30, 20) range(0.01, 1, 0.8, 1, 0.001) channel("grainD") text("") popuptext("Decay"), textcolour("black"), trackercolour("black")
rslider bounds(218, 147, 30, 20) range(0, 1, 0.5, 1, 0.001) channel("grainS") text("") popuptext("Sustain"), textcolour("black"), trackercolour("black")
rslider bounds(238, 147, 30, 20) range(0.01, 1, 0.1, 1, 0.001) channel("grainR") text("") popuptext("Release"), textcolour("black"), trackercolour("black")
groupbox bounds(308,122, 90, 50) text("Voice Envelope") 
rslider bounds(308, 147, 30, 20) range(.05, 2, .1, 1, 0.1) channel("VoiceA") text("") textcolour("black"), trackercolour("black")
rslider bounds(328, 147, 30, 20) range(.05, 2, .25, 1, 0.1) channel("VoiceD") text("") textcolour("black"), trackercolour("black")
rslider bounds(348, 147, 30, 20) range(0, 1, 0.5, 1, 0.001) channel("VoiceS") text(""), textcolour("black"), trackercolour("black")
rslider bounds(368, 147, 30, 20) range(0.05, 5, .25, 1, 0.1) channel("VoiceR"), text(""), textcolour("black"), trackercolour("black")
vslider bounds(450, 0, 20, 150, text("Gain"), range(0, 1.5, 0.8, 0.5, 0.01), channel("gain")
xypad bounds(8, 180, 400, 95) channel("bpCenter", "bpGain") rangex(-1, 1, 0) rangey(0,1,0.5) text("Band Pass")
rslider bounds(428, 180, 50, 50) channel("bpWidth") text("Width"), range(50, 1000, 200, 0.5, 1)
rslider bounds(428, 240, 50, 50) channel("bJitter") text("FreqJitter"), range(0, 0.5, 0, 1, 0.0001)
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

; Instrument will be triggered by keyboard widget
instr 1

iUniqueTag = random(0, 5000)*10000 + p4
SEnvChan sprintf "chan_%d", iUniqueTag	;Clunky way to create a unique chan shared between instruments

;Query Gui

kFreqJitter chnget "FreqJitter"
kAmpJitter chnget "AmpJitter"
kModDepth chnget "ModDepth"
kModDepthJitter chnget "ModDepthJitter"
kIndex chnget "Index"
kIndexJitter chnget "IndexJitter"
kGrainRate chnget "GrainRate"
kGrainRateJitter chnget "GrainRateJitter"
kGrainLength chnget "GrainLength"
kGrainLengthJitter chnget "GrainLengthJitter"
kPan chnget "pan"
kPanJitter chnget "panJitter"

;Grain Envelope Vars
kGrainA chnget "grainA"
kGrainD chnget "grainD"
kGrainS chnget "grainS"
kGrainR chnget "grainR"

;Voice Envelope Vars
iVoiceA chnget "VoiceA"
iVoiceD chnget "VoiceD"
iVoiceS chnget "VoiceS"
iVoiceR chnget "VoiceR"

;Band pass params
kBpWidth chnget "bpWidth"
kBpGain chnget "bpGain"
kBpCenter chnget "bpCenter"
kBpJitter chnget "bpJitter"

; Granulate params
kFmAmpJitter jitter kAmpJitter, 10, 20
kFmAmp = p5 + p5*kFmAmpJitter

kFmCarFreqJitter jitter kFreqJitter, 10, 20
kFmCarFreq = p4 + p4*kFmCarFreqJitter

kFmModJitter jitter kModDepthJitter, 10, 20
kFmMod = (kModDepth)*(kFmModJitter+1)

kFmIndexJitter jitter kIndexJitter, 10, 20
kFmIndex = kIndex + kFmIndexJitter

kGrainRateJitter jitter kGrainRateJitter, 10, 20
kGrainsPerSecond = kGrainRate*(1 + kGrainRateJitter) ;

kPanJitter jitter kPanJitter, 10, 20
kPan = kPan*(1 + kPanJitter*0.5) ;

kGrainLengthJitter jitter kGrainLengthJitter, 10, 20
kGrainLength = kGrainLength*(1+kGrainLengthJitter)

kBpCenterJitter jitter kBpJitter, 10, 20
kBpCenter = kBpCenter + kBpCenterJitter

ktrigger metro kGrainsPerSecond, 1
schedkwhen ktrigger, 0,0,2,0, kGrainLength, kFmAmp, kFmCarFreq, kFmMod, kFmIndex, kPan, kGrainA, kGrainD, kGrainS, kGrainR, kBpCenter, kBpGain, kBpWidth, iUniqueTag 

;note envelope
kEnv madsr iVoiceA, iVoiceD, iVoiceS, iVoiceR 
chnset kEnv, SEnvChan ;Clunky way to create a unique chan shared between instruments
endin

instr 2

;this is the grain voice
kGain chnget "gain"
SEnvChan sprintf "chan_%d", p16 ;Clunky way to create a unique chan shared between instruments 
kEnv chnget SEnvChan
aGrain foscil p4, p7, p5, p6, p7, 1 
iTotalTime = p9+p10+p12	;Get the total ratio
aReson resonr aGrain, p13*p4, p15
aGrain = aReson*p14 + aGrain*(1-p14) 
kFmEnv adsr p3*(p9/iTotalTime), p3*(p10/iTotalTime), p11, p3*(p12/iTotalTime) ;grainEnvelope
outs kEnv*aGrain*kFmEnv*0.05*p8*kGain, kEnv*aGrain*kFmEnv*0.05*(1-p8)*kGain
 

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f1 0 4097 10 1 ;a sine wave
</CsScore>
</CsoundSynthesizer>
