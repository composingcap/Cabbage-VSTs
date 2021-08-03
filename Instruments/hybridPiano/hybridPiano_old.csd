<Cabbage>
#define PSLIDER colour(10,10,10, 50), textcolour("white"), trackercolour("white") markercolour("white")

form caption("Hybrid Piano") size(400, 250), colour(58, 110, 182), pluginid("cphb"), bundle("./media") titlebarcolour("black") style("flat")

image file("./media/pianoBackground.png") bounds(0,0,400,250) 
image bounds(125,10,225,125) colour(0,0,0,100) corners(15){
rslider channel("attackTime") range(10,5000, 500, 0.5) bounds(0,0,70,50) text("attack time") $PSLIDER
rslider channel("attackAmp") range(0,1, 0.25, 0.5) bounds(75,0,70,50) text("sustain amp") $PSLIDER
rslider channel("decayTime") range(10,5000, 50, 0.5) bounds(0,75,70,50) text("release time") $PSLIDER
rslider channel("decayAmp") range(0.001,1, 1, 0.5) bounds(75,75,70,50) text("release amp") $PSLIDER
rslider channel("envelopeCurve") range(-2,2, 0.5, 1) bounds(150,0,80,50) text("envelope curve") $PSLIDER
rslider channel("rev") text("reverb mix")range(0,1, 0, 1) bounds(150,75,80,50) $PSLIDER
}

vslider channel("amp") range(0,1,0.75, 2) bounds(20,20,50,125) $PSLIDER markercolour("white") colour("white") text("amp")

keyboard bounds(8, 158, 381, 60)
image colour("white") bounds(0,225,400,25){
    label text("Created by Christopher Poovey") bounds(5,2,150, 10) fontcolour("black") align("left")
    label text("Samples taken from Salamander Grand Piano") bounds(5,15,250, 10) fontcolour("black") align("left")
}
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 128
nchnls = 2
0dbfs = 1



;If adding your own samples the samples should be ordered by pitch class, octave (increasing), the velocity step (increasing) 
;The code also assumes pitches are in a dimishished chord starting on A0 this will need to be modifies if your samples are different. 

giSf init 0
gSSampleFolder init "./media/Salamander Samples Min" ;Path to a folder with samples 
gSirPath init "./media/Reverb/salmanderPianoIR.wav" ;Path to an impulse response for the IR 
giVelSamps init 4 ;The number of velocity steps per pitch 
giPcOffset init 32 ; this is the number of files per pitchclass-- can be computed through numberOfOctaves*numberOfVelSteps


;instrument will be triggered by keyboard widget




instr 1


iAttackTime chnget "attackTime"
iAttackAmp chnget "attackAmp"

iDecayTime chnget "decayTime"
iDecayAmp chnget "decayAmp"

iEnvCurve chnget "envelopeCurve"

xtratim iDecayTime/1000+0.25 ;Adds extra decay time for the realease envelope 

aFade linseg 0, 0.25, 1 

kRel release 

kLineAmp init 0 
kLineDur init 0 
kStart init 1
kReleaseEnv init 1
if (kRel == 1) then
    ;This is the release envelope 
    //aEnv linseg iAttackAmp, iDecayTime/1000, iDecayAmp, 0.05, 0
    kLineAmp = iDecayAmp
    kLineDur = iDecayTime/1000
    kReleaseEnv linseg 1, iDecayTime/1000, 1, 0.05, 0 

elseif (kStart == 0) then
    ;This is the attack envelope 
    //aEnv linseg 0, iAttackTime/1000, iAttackAmp
    kLineAmp = iAttackAmp
    kLineDur = iAttackTime/1000
else
    kStart = 0 
endif

kEnv lineto kLineAmp, kLineDur
kEnv *= kReleaseEnv
//aEnv = a(kEnv*kReleaseEnv)

iExponent = pow(2,iEnvCurve)

kEnv pow kEnv, iExponent
//aEnv lowpass2  aEnv, 20, 1 ;Prevents clicks when the envelope jumps 

iPitch = p4-12

iPc = iPitch%12
iTune = 1
iOctave = floor((iPitch)/12)
if (iPc < 3) then
    iTune = pow(2,iPc/12)
    iPcOffset = giPcOffset*0
    

elseif iPc < 6 then
    iTune = pow(2,(iPc-3)/12)
    iPcOffset = giPcOffset*1

elseif iPc < 9 then
    iTune = pow(2,(iPc-6)/12)
    iPcOffset = giPcOffset*2
    iOctave -= 1
    
elseif iPc < 12 then
    iTune = pow(2,(iPc-9)/12)
    iPcOffset = giPcOffset*3
    iOctave -= 1

endif 



iVelStep= (p5/128)*giVelSamps
iVelStep floor iVelStep

itableNumber = iPcOffset+iOctave*giVelSamps+iVelStep+100

aSamp loscil 1, iTune, itableNumber, 1, 0

kRate randomi -0.1,0.1, 10
kOverlap randomi 2,3, 10

kSize = randomi(0.1,0.2, 10)

aGrain syncloop 1, 1/(kSize/kOverlap), iTune, kSize, kRate, 0.5, 1.5, itableNumber, 10, 5, 0.5

aOut = aGrain*aFade+aSamp
aOut butterhp aOut, cpsmidinn(p4)
aOut = aOut * pow(p5/127,2)
gaOut += aOut*kEnv*0.5
endin



instr io

kAmp chnget "amp"
aAmp = a(kAmp)
kRev chnget "rev"
aOut = gaOut*aAmp
aRev = a(kRev)

if kRev > 0 then 
    ;Perform convolution if it is more than 0
   aRev1, aRev2 pconvolve  aOut, gSirPath, 2048
endif 

outs aOut*(1-aRev)+aRev1*aRev*0.125, aOut*(1-aRev)+aRev2*aRev*0.125


clear gaOut


endin

instr loadSamples

giNSamples ftsamplebank gSSampleFolder, 100, 0, 4, 1
;The bank used has 4 velocity steps per note and is organized by pc then octave. Each pitch class has 32 members
;pitch classed 0, 3, 6, and 9 are repesented   
endin 

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 10 0 8192 20 2 1
i "loadSamples" 0 0 
i "io" 0 z
</CsScore>
</CsoundSynthesizer>
