<Cabbage> bounds(0, 0, 0, 0)
form caption("MVerb 25ch") size(620, 360) colour(58, 110, 182) pluginid("mv25") fontcolour("white")
label bounds(240, 12, 30, 15) text("wet") fontcolour("white")
label bounds(530, 12, 30, 15) text("dry") fontcolour("white")
hslider bounds(270, 0, 270, 40) channel("mix") range(0, 1, 0.75, 1, 0.001) trackercolour(255, 255, 0, 255) value(0.75)
label bounds(274, 34, 270, 15) text("5x5 mesh reverb resonant frenquencies") fontcolour(255, 255, 255, 255) fontcolour(255, 255, 255, 255)

#define RSliderStyle #valuetextbox(1) fontcolour("white") trackercolour("yellow") colour("white"), textcolour("white") valuetextbox(1) textboxcolour("black")#

nslider bounds(230, 60, 70, 22) channel("res1") range(2, 20000, 102, 0.5, 0.01) value(102)
nslider bounds(305, 60, 70, 22) channel("res2") range(2, 20000, 435, 0.5, 0.01) value(435)
nslider bounds(380, 60, 70, 22) channel("res3") range(2, 20000, 735, 0.5, 0.01) value(735)
nslider bounds(455, 60, 70, 22) channel("res4") range(2, 20000, 76.8, 0.5, 0.01) value(76.8)
nslider bounds(530, 60, 70, 22) channel("res5") range(2, 20000, 114, 0.5, 0.01) value(114)
nslider bounds(230, 85, 70, 22) channel("res6") range(2, 20000, 669.2, 0.5, 0.01) value(669.2)
nslider bounds(305, 85, 70, 22) channel("res7") range(2, 20000, 739.7, 0.5, 0.01) value(739.7)
nslider bounds(380, 85, 70, 22) channel("res8") range(2, 20000, 843.6, 0.5, 0.01) value(843.6)
nslider bounds(455, 85, 70, 22) channel("res9") range(2, 20000, 272.72, 0.5, 0.01) value(272.72)
nslider bounds(530, 85, 70, 22) channel("res10") range(2, 20000, 114.3, 0.5, 0.01) value(114.3)
nslider bounds(230, 110, 70, 22) channel("res11") range(2, 20000, 963.2, 0.5, 0.01) value(963.2)
nslider bounds(305, 110, 70, 22) channel("res12") range(2, 20000, 250.3, 0.5, 0.01) value(250.3)
nslider bounds(380, 110, 70, 22) channel("res13") range(2, 20000, 373.73, 0.5, 0.01) value(373.73)
nslider bounds(455, 110, 70, 22) channel("res14") range(2, 20000, 842, 0.5, 0.01) value(842)
nslider bounds(530, 110, 70, 22) channel("res15") range(2, 20000, 999, 0.5, 0.01) value(999)
nslider bounds(230, 135, 70, 22) channel("res16") range(2, 20000, 621, 0.5, 0.01) value(621)
nslider bounds(305, 135, 70, 22) channel("res17") range(2, 20000, 210, 0.5, 0.01) value(210)
nslider bounds(380, 135, 70, 22) channel("res18") range(2, 20000, 183, 0.5, 0.01) value(183)
nslider bounds(455, 135, 70, 22) channel("res19") range(2, 20000, 578, 0.5, 0.01) value(578)
nslider bounds(530, 135, 70, 22) channel("res20") range(2, 20000, 313, 0.5, 0.01) value(313)
nslider bounds(230, 160, 70, 22) channel("res21") range(2, 20000, 792, 0.5, 0.01) value(792)
nslider bounds(305, 160, 70, 22) channel("res22") range(2, 20000, 159.3, 0.5, 0.01) value(159.3)
nslider bounds(380, 160, 70, 22) channel("res23") range(2, 20000, 401.5, 0.5, 0.01) value(401.5)
nslider bounds(455, 160, 70, 22) channel("res24") range(2, 20000, 733, 0.5, 0.01) value(733)
nslider bounds(530, 160, 70, 22) channel("res25") range(2, 20000, 1010, 0.5, 0.01) value(1010)

rslider bounds(136, 50, 60, 60) channel("FB") range(0, 1, 0.925, 4, 0.001) $RSliderStyle colour(255, 255, 255, 255) fontcolour(255, 255, 255, 255) fontcolour(255, 255, 255, 255) textboxcolour(0, 0, 0, 255) textcolour(255, 255, 255, 255) trackercolour(255, 255, 0, 255) value(0.925) valuetextbox(1) fontcolour(255, 255, 255, 255)
label bounds(104, 34, 120, 15) text("short<->long") fontcolour("white")
label bounds(368, 190, 140, 15) text("mesh reflection EQ") fontcolour("white")
rslider bounds(136, 132, 60, 60) channel("DFact") range(.01,2,1,1,.001) $RSliderStyle
label bounds(102, 116, 120, 15) text("small<->big") fontcolour("white")
label bounds(192, 188, 90, 15) text("EQ") fontcolour(255, 255, 255, 255) fontcolour(255, 255, 255, 255)
combobox bounds(190, 202, 95, 22) channel("EQSelect") text("flat", "high cut 1", "high cut 2", "low cut 1", "low cut 2", "band pass 1", "band pass 2", "2 bands", "3 bands", "evens", "odds")
label bounds(22, 12, 81, 15) text("preset") fontcolour(255, 255, 255, 255) fontcolour(255, 255, 255, 255)
combobox bounds(18, 32, 95, 22) channel("SpaceSelect") items("Small Hall","Medium Hall","Large Hall","Huge Hall","Infinite Space","Dry Echo","Right-Left","Comby 1","Comby 2","Octaves","TriTones","Big Dark","Metallic 1","Weird 1","Weird 2","Weird 3","Large Cymbal 1","Large Cymbal 2","Splash Cymbal 1","Splash Cymbal 2","Turkish Cymbal","Gong", "Small Gong","Metallic 2","Tubular Metallic", "Cowbell", "Finger Cymbal", "Bell", "Chinese Ball", "Cymbal Cap", "Baking Sheet", "Frying Pan", "Squeak", "Trellace", "Monkey Wrench")
;rslider bounds(32, 132, 60, 60) channel("ERamp") range(0,1.5,.9,1,.001) $RSliderStyle
;label bounds(6, 70, 120, 15) text("early reflection") fontcolour(255, 255, 255, 255) fontcolour(255, 255, 255, 255)
;label bounds(12, 116, 100, 15) text("ER level") fontcolour("white")
;combobox bounds(18, 90, 95, 22) value(2) channel("ERSelect") items("None","Small","Medium","Large","Huge","Long Random","Short Backwards","Long Backwards","Strange1","Strange2")
;label bounds(222, 224, 40, 15) text("Q") fontcolour("white")
rslider bounds(214, 240, 60, 60) channel("Q") range(.5,100,.5,1,.01) $RSliderStyle
button bounds(42, 194, 120, 25) channel("random") text("Random On/Off", "Random On/Off")  colour:1(0, 128, 0, 255)
;label bounds(44, 334, 100, 15) text("output") fontcolour(255, 255, 255, 255)
;combobox bounds(140,330,75,22) channel("output") text("stereo", "Quadrophonic", "Five Channel", "Octophonic")
label bounds(50, 218, 100, 15) text("speed range") fontcolour(255, 255, 255, 255) 
label bounds(38, 234, 130, 15) text("slow - - - - fast") fontcolour(255, 255, 255, 255)
label bounds(8, 274, 130, 15) text("deviation") fontcolour(255, 255, 255, 255)
label bounds(12, 286, 130, 15) text("min - - - - max") fontcolour(255, 255, 255, 255)
hrange bounds(6, 246, 200, 30) channel("rslow","rfast") range(0, 100, 0.01:.25, .25, .001) texbox(1) trackercolour("yellow") colour("DimGrey") caption("LP/HP cutoff F") textcolour("MidnightBlue")
;hrange bounds(4, 326, 200, 30) channel("rmin","rmax") range(0, .95, 0.01:.05, 1, .001) texbox(1) trackercolour("yellow") colour("DimGrey") caption("LP/HP cutoff F") textcolour("MidnightBlue")
hslider bounds(6, 298, 200, 30) channel("rmax") range(0,.95,0,1,.01) $RSliderStyle
button bounds(8,330,75,22) channel("FBclear") text("Clear Delays", "Clear Delays") colour:1(0,128,0,255)

;alternatively, get rid of the hrange sliders and use four nsliders, might provide better control

vslider bounds(288, 210, 50, 140) channel("eq1") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(318, 210, 50, 140) channel("eq2") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(348, 210, 50, 140) channel("eq3") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(378, 210, 50, 140) channel("eq4") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(408, 210, 50, 140) channel("eq5") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(438, 210, 50, 140) channel("eq6") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(468, 210, 50, 140) channel("eq7") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(498, 210, 50, 140) channel("eq8") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(528, 210, 50, 140) channel("eq9") range(0,1,1,1,.001) $RSliderStyle
vslider bounds(558, 210, 50, 140) channel("eq10") range(0,1,1,1,.001) $RSliderStyle

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-d -n -m0d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 25
0dbfs = 1

ga1mix init 0
ga2mix init 0
garev1 init 0
garev2 init 0

opcode EQ,a,a ;1 audio out, 1 audio in ;get k-rate data through chnget arguments
ain	xin

kQ  chnget  "Q"
kQ=(kQ*.1)+.5   ;adjust to 1/25 since there is an EQ on each mesh node and it ends up being too great a Q value when routed through multiple instances
kQ  port    kQ,.1
keq1    chnget  "eq1"
keq1    port    keq1,.1
keq2    chnget  "eq2"
keq2    port    keq2,.1
keq3    chnget  "eq3"
keq3    port    keq3,.1
keq4    chnget  "eq4"
keq4    port    keq4,.1
keq5    chnget  "eq5"
keq5    port    keq5,.1
keq6    chnget  "eq6"
keq6    port    keq6,.1
keq7    chnget  "eq7"
keq7    port    keq7,.1
keq8    chnget  "eq8"
keq8    port    keq8,.1
keq9    chnget  "eq9"
keq9    port    keq9,.1
keq10   chnget  "eq10"
keq10   port    keq10,.1

aeq1    pareq    ain,40,keq1,kQ,1
aeq2    pareq    ain,80,keq2,kQ,0
aeq3    pareq    ain,160,keq3,kQ,0
aeq4    pareq    ain,320,keq4,kQ,0
aeq5    pareq    ain,640,keq5,kQ,0
aeq6    pareq    ain,1280,keq6,kQ,0
aeq7    pareq    ain,2560,keq7,kQ,0
aeq8    pareq    ain,5120,keq8,kQ,0
aeq9    pareq    ain,10240,keq9,kQ,0
aeq10   pareq    ain,20480,keq10,kQ,2
asum=aeq1+aeq2+aeq3+aeq4+aeq5+aeq6+aeq7+aeq8+aeq9+aeq10
aout balance  asum,ain
aout dcblock2 aout

xout    aout
endop

opcode  meshEQ,aaaa,aaaaak ;4 audio outs and 5 audio ins one k-rate in for FB value, use for boundary nodes
aUin,aRin,aDin,aLin,adel,kFB xin

afactor=(aUin+aRin+aDin+aLin)*-.5	;calculate raw value

aUout   vdelay  aUin+afactor,adel,1000	;calculate outputs
aRout   vdelay  aRin+afactor,adel,1000
aDout   vdelay  aDin+afactor,adel,1000
aLout   vdelay  aLin+afactor,adel,1000

aUout   EQ  aUout   ;apply EQ on each output
aRout   EQ  aRout
aDout   EQ  aDout
aLout   EQ  aLout

xout	aUout*kFB,aRout*kFB,aDout*kFB,aLout*kFB
endop

opcode randomdel,a,a
adel xin
krand chnget "random"
krslow chnget "rslow"
krfast chnget "rfast"
krmax chnget "rmax"
if krand=1 then
atime randomi krslow,krfast,krfast  ;calculate random cps
adelayA randi krmax,atime   ;calculate value changes expressed as 0-.95
adel=adel+(adel*adelayA)
else
xout adel
endif
endop

gaInputs[] init 25
gaOutputs[] init 25

instr 1 ;activate live audio input 

gaInputs in

endin

instr 4 ;global live/FX mix 

gksource  chnget  "mix"
gkFX=1-gksource
endin

instr 10    ;5x5 mesh
;make multi-channel options both for sound input and output

aAU init    0
aAR init    0   
aAD init    0 
aAL init    0
aBU init    0
aBR init    0   
aBD init    0 
aBL init    0
aCU init    0
aCR init    0   
aCD init    0 
aCL init    0
aDU init    0
aDR init    0   
aDD init    0 
aDL init    0
aEU init    0
aER init    0   
aED init    0 
aEL init    0
aFU init    0
aFR init    0   
aFD init    0 
aFL init    0
aGU init    0
aGR init    0   
aGD init    0 
aGL init    0
aHU init    0
aHR init    0   
aHD init    0 
aHL init    0
aIU init    0
aIR init    0   
aID init    0 
aIL init    0
aJU init    0
aJR init    0   
aJD init    0 
aJL init    0
aKU init    0
aKR init    0   
aKD init    0 
aKL init    0
aLU init    0
aLR init    0   
aLD init    0 
aLL init    0
aMU init    0
aMR init    0   
aMD init    0 
aML init    0
aNU init    0
aNR init    0   
aND init    0 
aNL init    0
aOU init    0
aOR init    0   
aOD init    0 
aOL init    0
aPU init    0
aPR init    0   
aPD init    0 
aPL init    0
aQU init    0
aQR init    0   
aQD init    0 
aQL init    0
aRU init    0
aRR init    0   
aRD init    0 
aRL init    0
aSU init    0
aSR init    0   
aSD init    0 
aSL init    0
aTU init    0
aTR init    0   
aTD init    0 
aTL init    0
aUU init    0
aUR init    0   
aUD init    0 
aUL init    0
aVU init    0
aVR init    0   
aVD init    0 
aVL init    0
aWU init    0
aWR init    0   
aWD init    0 
aWL init    0
aXU init    0
aXR init    0   
aXD init    0 
aXL init    0
aYU init    0
aYR init    0   
aYD init    0 
aYL init    0

kDFact  chnget  "DFact"
kDFact  port    kDFact,.25
kFB chnget  "FB"
kFB port    kFB,.25
;;;"clear delays" coefficient
kdelclear   chnget  "FBclear"
kdelclear   port    kdelclear,.1
kFB=kFB*(1-kdelclear)
kER chnget "ERSelect"
kERamp chnget "ERamp"

;channels: random (on/off), rslow, rfast, rmax 

kres1   chnget  "res1"
adel1=kDFact*(1000/kres1)
adel1 randomdel adel1
kres2   chnget  "res2"
adel2=kDFact*(1000/kres2)
adel2 randomdel adel2
kres3   chnget  "res3"
adel3=kDFact*(1000/kres3)
adel3 randomdel adel3
kres4   chnget  "res4"
adel4=kDFact*(1000/kres4)
adel4 randomdel adel4
kres5   chnget  "res5"
adel5=kDFact*(1000/kres5)
adel5 randomdel adel5
kres6   chnget  "res6"
adel6=kDFact*(1000/kres6)
adel6 randomdel adel6
kres7   chnget  "res7"
adel7=kDFact*(1000/kres7)
adel7 randomdel adel7
kres8   chnget  "res8"
adel8=kDFact*(1000/kres8)
adel8 randomdel adel8
kres9   chnget  "res9"
adel9=kDFact*(1000/kres9)
adel9 randomdel adel9
kres10   chnget  "res10"
adel10=kDFact*(1000/kres10)
adel10 randomdel adel10
kres11   chnget  "res11"
adel11=kDFact*(1000/kres11)
adel11 randomdel adel11
kres12   chnget  "res12"
adel12=kDFact*(1000/kres12)
adel12 randomdel adel12
kres13   chnget  "res13"
adel13=kDFact*(1000/kres13)
adel13 randomdel adel13
kres14   chnget  "res14"
adel14=kDFact*(1000/kres14)
adel14 randomdel adel14
kres15   chnget  "res15"
adel15=kDFact*(1000/kres15)
adel15 randomdel adel15
kres16   chnget  "res16"
adel16=kDFact*(1000/kres16)
adel16 randomdel adel16
kres17   chnget  "res17"
adel17=kDFact*(1000/kres17)
adel17 randomdel adel17
kres18   chnget  "res18"
adel18=kDFact*(1000/kres18)
adel18 randomdel adel18
kres19   chnget  "res19"
adel19=kDFact*(1000/kres19)
adel19 randomdel adel19
kres20   chnget  "res20"
adel20=kDFact*(1000/kres20)
adel20 randomdel adel20
kres21   chnget  "res21"
adel21=kDFact*(1000/kres21)
adel21 randomdel adel21
kres22   chnget  "res22"
adel22=kDFact*(1000/kres22)
adel22 randomdel adel22
kres23   chnget  "res23"
adel23=kDFact*(1000/kres23)
adel23 randomdel adel23
kres24   chnget  "res24"
adel24=kDFact*(1000/kres24)
adel24 randomdel adel24
kres25   chnget  "res25"
adel25=kDFact*(1000/kres25)
adel25 randomdel adel25


aL=0
aR=0


aAU,aAR,aAD,aAL meshEQ    aAU,aBL+gaInputs[0],aFU,aAL,adel1,kFB
aBU,aBR,aBD,aBL meshEQ    aBU,aCL+gaInputs[1],aGU,aAR,adel2,kFB
aCU,aCR,aCD,aCL meshEQ    aCU,aDL+gaInputs[2],aHU,aBR,adel3,kFB
aDU,aDR,aDD,aDL meshEQ    aDU,aEL+gaInputs[3],aIU,aCR,adel4,kFB
aEU,aER,aED,aEL meshEQ    aEU,aER+gaInputs[4],aJU,aDR,adel5,kFB
aFU,aFR,aFD,aFL meshEQ    aAD,aGL+gaInputs[5],aKU,aFL,adel6,kFB
aGU,aGR,aGD,aGL meshEQ    aBD,aHL+gaInputs[6],aLU,aFR,adel7,kFB
aHU,aHR,aHD,aHL meshEQ    aCD,aIL+gaInputs[7],aMU,aGR,adel8,kFB
aIU,aIR,aID,aIL meshEQ    aDD,aJL+gaInputs[8],aNU,aHR,adel9,kFB
aJU,aJR,aJD,aJL meshEQ    aED,aJR+gaInputs[9],aOU,aIR,adel10,kFB
aKU,aKR,aKD,aKL meshEQ    aFD,aLL+gaInputs[10],aPU,aKL,adel11,kFB
aLU,aLR,aLD,aLL meshEQ    aGD,aML+gaInputs[11],aQU,aKR,adel12,kFB
aMU,aMR,aMD,aML meshEQ    aHD,aNL+gaInputs[12],aRU,aLR,adel13,kFB
aNU,aNR,aND,aNL meshEQ    aID,aOL+gaInputs[13],aSU,aMR,adel14,kFB
aOU,aOR,aOD,aOL meshEQ    aJD,aOR+gaInputs[14],aTU,aNR,adel15,kFB
aPU,aPR,aPD,aPL meshEQ    aKD,aQL+gaInputs[15],aUU,aPL,adel16,kFB
aQU,aQR,aQD,aQL meshEQ    aLD,aRL+gaInputs[16],aVU,aPR,adel17,kFB
aRU,aRR,aRD,aRL meshEQ    aMD,aSL+gaInputs[17],aWU,aQR,adel18,kFB
aSU,aSR,aSD,aSL meshEQ    aND,aTL+gaInputs[18],aXU,aRR,adel19,kFB
aTU,aTR,aTD,aTL meshEQ    aOD,aTR+gaInputs[19],aYU,aSR,adel20,kFB
aUU,aUR,aUD,aUL meshEQ    aPD,aVL+gaInputs[20],aUD,aUL,adel21,kFB
aVU,aVR,aVD,aVL meshEQ    aQD,aWL+gaInputs[21],aVD,aUR,adel22,kFB
aWU,aWR,aWD,aWL meshEQ    aRD,aXL+gaInputs[22],aWD,aVR,adel23,kFB
aXU,aXR,aXD,aXL meshEQ    aSD,aYL+gaInputs[23],aXD,aWR,adel24,kFB
aYU,aYR,aYD,aYL meshEQ    aTD,aYR+gaInputs[24],aYD,aXR,adel25,kFB

gaOutputs[0] = aAR
gaOutputs[1] = aBR
gaOutputs[2] = aCR
gaOutputs[3] = aDD
gaOutputs[4] = aED
gaOutputs[5] = aFD
gaOutputs[6] = aGD
gaOutputs[7] = aHD
gaOutputs[8] = aID
gaOutputs[9] = aJD
gaOutputs[10] = aKD
gaOutputs[11] = aLD
gaOutputs[12] = aMD
gaOutputs[13] = aND
gaOutputs[14] = aOD
gaOutputs[15] = aPD
gaOutputs[16] = aQD
gaOutputs[17] = aRD
gaOutputs[18] = aSD
gaOutputs[19] = aTD
gaOutputs[20] = aUD
gaOutputs[21] = aVD
gaOutputs[22] = aWD
gaOutputs[23] = aXD
gaOutputs[24] = aYD

endin

instr	11
 gkpreset	chnget	"SpaceSelect"
 ktrig		changed	gkpreset 
        ;add EQ fader levels to presets? or make a separate, independent preset instrument and then 
        ;just change it by sending the combobox value
 #define SET_PRESET(N'set1'set2'set3'set4'set5'set6'set7'set8'set9'set10'set11'set12'set13'set14'set15'set16'set17'set18'set19'set20'set21'set22'set23'set24'set25'FBset'DFset'Qset'ERamp'ERset'EQset)
 #
 if i(gkpreset)==$N then
  chnset	$set1,"res1"	  
  chnset	$set2,"res2"    
  chnset	$set3,"res3"   
  chnset	$set4,"res4"
  chnset	$set5,"res5"
  chnset	$set6,"res6"  
  chnset	$set7,"res7"
  chnset	$set8,"res8"
  chnset	$set9,"res9"
  chnset	$set10,"res10"
  chnset	$set11,"res11"   
  chnset	$set12,"res12"   
  chnset	$set13,"res13" 
  chnset	$set14,"res14" 
  chnset	$set15,"res15"
  chnset	$set16,"res16"
  chnset	$set17,"res17"
  chnset	$set18,"res18"
  chnset	$set19,"res19"
  chnset	$set20,"res20"
  chnset	$set21,"res21"   
  chnset	$set22,"res22"   
  chnset	$set23,"res23" 
  chnset	$set24,"res24" 
  chnset	$set25,"res25"
  chnset	$FBset,"FB"
  chnset	$DFset,"DFact"
  chnset    $Qset,"Q"
  chnset    $ERamp,"ERamp"
  chnset    $ERset,"ERSelect"
  chnset    $EQset,"EQSelect"
 
 endif
 #
 if ktrig==1 then
  reinit SEND_PRESET
 endif
 SEND_PRESET: ;1-16="Small Hall","Medium Hall","Large Hall","Huge Hall","Infinite Space","Dry Echos","Right","Comby 1","Comby 2","Octaves","TriTones","Big Dark","Metallic","Weird 1","Weird 2","Weird 3""Large Cymbal A","LargeCymbal B","Splash Cymbal A","Splash Cymbal B","Turkish Cymbal","Gong", "Small Gong","Metallic","Tubular Metallic")
 ;           N'set1'set2'set3'set4'set5'set6'set7'set8'set9'set10'set11'set12'set13'set14'set15'set16'set17'set18'set19'set20'set21'set22'set23'set24'set25'FBset'DFset'Qset'ERamp'ERSelect'EQselect)
 $SET_PRESET(1'102'435'735'76.8'114'669.2'739.7'843.6'272.72'114.3'963.2'250.3'373.73'842'999'621'210'183'578'313'792'159.3'401.5'733'1010'.93'1'22'.9'2'1)
 $SET_PRESET(2'57.8'461.1'141.6'442.9'395.4'384.7'156.3'31.7'47.7'181.4'82.3'470.7'283.7'133.7'128.5'426.9'274.1'495'112.3'401.9'126.5'218.9'374.8'140.3'171.3'.943'1'.5'.9'3'1)
 $SET_PRESET(3'23.24'100.43'45.58'105.62'226.26'65.66'216.33'32.41'244.91'84.61'349.42'134.08'444.19'51.83'32.42'42.73'125.7'83.25'23.83'170.28'116.83'40.96'53'78.42'29.42'.95'1'.5'.9'4'1)
 $SET_PRESET(4'3.24'10.43'5.58'105.62'16.26'65.66'216.33'2.41'244.91'4.61'349.42'134.08'444.191'51.83'32.42'2.73'25.7'83.25'3.83'170.28'6.83'40.96'13'8.42'20.42'.95'1'.724'.8'5'1)
 $SET_PRESET(5'3.24'10.43'5.58'105.62'16.26'65.66'216.33'2.41'244.91'4.61'349.42'134.08'444.191'51.83'32.42'2.73'25.7'83.25'3.83'170.28'6.83'40.96'13'8.42'20.42'1'1'.5'.5'5'1)
 $SET_PRESET(6'200'2000'2'2000'200'2000'2'200'2'2000'2'200'2'200'2'2000'2'200'2'2000'200'2000'2'2000'200'.85'1'.5'.9'1'1)
 $SET_PRESET(7'4.4'10.8'33.9'77.23'243'3.1'7.5'26.68'64.9'111.11'2'5.5'17.3'53'97.2'3.6'7.53'26.75'67'113.2'4.57'10.67'33.25'75.3'248'.95'1'21'.9'1'2)
 $SET_PRESET(8'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'75'.99'1'3.85'.9'1'1)
 $SET_PRESET(9'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'275'.995'1'2.85'.9'1'1)
 $SET_PRESET(10'320'80'320'80'2560'640'40'2560'10240'80'2560'640'160'1280'160'640'5120'320'40'10240'1280'40'5120'320'160'.995'1'70'.9'1'2)
 $SET_PRESET(11'369.99'92.5'370'185'65.41'32.7'261.63'46.25'261.63'1046.5'739.99'1479.98'130.81'65.41'23.13'92.5'46.25'130.81'185'32.7'65.41'130.81'523.25'184.99'92.5'.975'1'90'.9'1'3)
 $SET_PRESET(12'41'3.84'50.28'2.38'19.71'3.83'83.27'16.93'27.95'4.33'88.41'39.93'95.02'93.99'84.19'3.38'79.5'69.39'32.79'8.32'97.16'3.23'28.84'8.46'71.69'.96'1'4'.5'10'2)
 $SET_PRESET(13'361.6'66.9'679.5'251.6'395.3'166.4'123.9'314.6'262.5'182.9'245.4'40.4'435.5'253.9'350.5'527.1'628.3'365.2'71.6'699.6'684.8'560.1'408.4'55.4'190'.995'1'35'.9'3'3)
 $SET_PRESET(14'246.96'246.84'246.92'247'246.88'164.83'164.79'164.81'164.85'164.77'138.58'138.57'138.59'138.61'138.6'196.06'195.97'196'196.03'195.94'2.35'6.62'3.38'5.01'2.67'.99'1'16.75'.9'1'9)
 $SET_PRESET(15'2'150.1'10.3'150.3'2.2'150.5'149.9'149.5'149.7'150.8'10.2'109.2'150'149.3'10.1'150.7'149.6'149.4'149.8'150.6'2.3'150.4'10'150.2'2.1'.995'1'25'.9'9'10)
 $SET_PRESET(16'880'587.33'18.35'523.25'987.77'698.46'12.98'9.72'10.91'739.99'19.45'9.18'8.18'8.66'20.6'783.99'11.56'10.3'12.25'659.25'932.33'554.36'17.32'622.25'830.6'.995'1'.5'1.25'6'11)
 $SET_PRESET(17'562'4047'6112'4211'640'4333'661'6276'745'6399'860'6487'445'1011'915'1498'896'2720'4001'2912'3872'6144'4735'9920'2473'.99'1'15'0'1'1)
 $SET_PRESET(18'6154'4559'5043'4399'4740'3839'4829'3656'4649'2577'5106'4309'6343'3378'5478'3286'5269'4230'4122'3126'4026'3048'3965'2897'5806'.99'1'15'0'1'1)
 $SET_PRESET(19'1868'1136'2557'934'1378'1421'487'2026'732'3485'1824'2715'2067'2269'1338'2756'891'689'3243'1580'1176'2312'1623'2514'2799'.993'1'15'0'1'1)
 $SET_PRESET(20'1135'3815'1442'4126'1857'4623'250'2271'287'4681'5151'323'2573'381'2990'594'5323'627'5761'721'3147'3294'4367'3712'3599'.99'1'15'0'1'1)
 $SET_PRESET(21'1699'2867'309'1871'3540'399'2047'3644'503'2920'3733'667'2196'4556'922'2269'4587'1037'2415'4430'1449'100'2720'1524'194'.99'1'15'0'1'1)
 $SET_PRESET(22'1397'7046'7145'7302'2803'7346'1395'2442'5618'2793'4198'11111'8845'2435'12675'4135'4693'5563'6715'6740'4733'9008'8700'10315'8957'.997'1'15'0'1'1)
 $SET_PRESET(23'1150'2638'4630'1203'2875'4697'1257'547'2917'1357'644'3184'1908'717'3532'2014'780'3592'2089'991'3834'2167'1082'4280'2551'.99'1'15'0'1'1)
 $SET_PRESET(24'1538'3268'4500'4511'7620'1818'5762'1313'8902'8123'2222'7200'1435'2253'2345'7652'1111'3342'6671'5669'6359'1515'2626'9821'5589'.99'1'15'0'1'1)
 $SET_PRESET(25'5801'2555'1062'2988'1163'3191'3438'1266'5357'1391'1537'3870'6775'1752'162'316'1899'2141'520'6189'3957'771'4389'974'4870'.979'1'15'0'1'1)
 $SET_PRESET(26'43'427.33'469.63'636.8'879'1194.3'1285'1525'1605.7'1692.6'1834'1913.4'2058'2131.5'2553.4'2697.3'2845'2971'3094.5'3421.33'3517'3704'3824.36'4026'4103.5'.99'1'15'0'1'1)
 $SET_PRESET(27'50.613'162.049'235.200'449.253'649.376'905.887'1472.145'1560.246'1620.714'1719.811'2011.201'2227.079'2321.843'2520.884'3645.568'3719.782'4519.738'5439.683'5550.825'5799.373'5887.881'5985.715'8391.483'8599.464'8742.274'.99'1'15'0'1'1)
 $SET_PRESET(28'1105.304'1103.750'1794.986'1953.592'2048.571'2151.073'2212.690'2294.689'2456.427'2479.858'2588.582'2939.855'3128.298'3338.705'3994.719'5093.901'5302.248'6016.276'6633.354'7061.309'7204.633'7280.145'7396.092'7451.345'7596.472'.99'1'15'0'1'1)
 $SET_PRESET(29'50.613'162.049'235.200'449.253'649.376'905.887'1472.145'1560.246'1620.714'1719.811'2011.201'2227.079'2321.843'2520.884'3645.568'3719.782'4519.738'5439.683'5550.825'5799.373'5887.881'5985.715'8391.483'8599.464'8742.274'.99'1'15'0'1'1)
 $SET_PRESET(30'256.393'395.910'563.166'828.052'1184.536'1335.321'1546.818'1827.957'2480.316'2773.729'3196.038'3341.018'3464.887'3685.670'3978.220'4078.167'4271.071'4423.289'4519.296'4722.426'4897.136'5013.317'5107.348'5175.045'5274.198'.99'1'15'0'1'1)
 $SET_PRESET(31'62.317'165.692'274.382'348.507'415.855'471.671'528.891'558.866'656.594'775.976'876.664'982.164'1118.923'1247.646'1389.558'1512.517'1651.298'1753.110'1837.643'1905.806'1984.672'2048.393'2112.321'2181.847'2288.017'.99'1'15'0'1'1)
 $SET_PRESET(32'53.066'203.032'479.499'543.879'743.276'801.769'892.304'960.408'1056.683'1207.074'1959.924'2512.418'2796.932'2962.237'4128.661'4757.159'5226.305'7228.675'8082.551'8150.188'8996.844'9060.971'9135.351'9440.564'10176.578'.99'1'15'0'1'1)
 $SET_PRESET(33'59.069'633.891'735.346'829.804'1096.602'1281.328'1381.799'1457.992'1601.895'1736.677'1801.428'1882.553'2063.394'2141.092'2241.275'2423.967'2496.568'2740.324'3155.239'3228.240'3422.348'3571.240'3639.228'3668.764'3749.605'.99'1'15'0'1'1)
 $SET_PRESET(34'62.266'120.836'185.376'299.858'459.254'540.377'640.285'831.450'895.198'991.975'1107.400'1266.421'1415.155'1466.344'1641.805'1747.948'1899.558'2223.494'2309.037'2359.031'2439.546'2524.965'2662.755'2801.177'2884.055'.99'1'15'0'1'1)
 $SET_PRESET(35'1193.150'1501.169'1584.422'1760.128'1876.764'2057.868'2297.103'2900.218'3614.225'3719.350'3956.729'5413.109'6072.599'6354.645'6882.175'7042.264'7340.854'8751.580'9774.188'10410.871'10575.217'11393.946'15018.148'16121.814'18907.158'.99'1'15'0'1'1)
endin

instr	12  ;preset for EQ combobox selector
 gkpreset2	chnget	"EQSelect"
 ktrig		changed	gkpreset2
        ;add EQ fader levels to presets? or make a separate, independent preset instrument and then 
        ;just change it by sending the combobox value
        ;combobox bounds(500,215,95,22) channel("EQSelect") items("flat","high cut 1","high cut 2","low cut 1","low cut 2","band pass 1","band pass 2","2 bands","3 bands","evens","odds")

 #define SET_PRESET(N'set1'set2'set3'set4'set5'set6'set7'set8'set9'set10)
 #
 if i(gkpreset2)==$N then
  chnset	$set1,"eq1"	  
  chnset	$set2,"eq2"    
  chnset	$set3,"eq3"   
  chnset	$set4,"eq4"
  chnset	$set5,"eq5"
  chnset	$set6,"eq6"  
  chnset	$set7,"eq7"
  chnset	$set8,"eq8"
  chnset	$set9,"eq9"
  chnset	$set10,"eq10"
 
 endif
 #
 if ktrig==1 then
  reinit SEND_PRESET
 endif
 SEND_PRESET: ;1-11="flat","high cut 1","high cut 2","low cut 1","low cut 2","band pass 1","band pass 2",
            ;"2 bands","3 bands","evens","odds"
            ;N'set1'set2'set3'set4'set5'set6'set7'set8'set9'set10)
 $SET_PRESET(1'1'1'1'1'1'1'1'1'1'1)
 $SET_PRESET(2'1'1'1'1'1'.99'.98'.97'.96'.95)
 $SET_PRESET(3'1'1'1'.95'.9'.85'.8'.75'.7'.65)
 $SET_PRESET(4'.9'.93'.96'.98'1'1'1'1'1'1)
 $SET_PRESET(5'.65'.7'.75'.8'.85'.9'.95'1'1'1)
 $SET_PRESET(6'.25'.75'1'1'1'1'1'1'.75'.25)
 $SET_PRESET(7'.1'.25'.5'.75'1'1'.75'.5'.25'.1)
 $SET_PRESET(8'.25'.75'1'.75'.25'.25'.75'1'.75'.25)
 $SET_PRESET(9'.25'1'1'.25'1'1'.25'1'1'.25)
 $SET_PRESET(10'.1'1'.1'1'.1'1'.1'1'.1'1)
 $SET_PRESET(11'1'.1'1'.1'1'.1'1'.1'1'.1)
endin

instr   100 ;audio outputs
gaOutputs = gaOutputs*(1-gksource) + gaInputs*gksource
out gaOutputs
endin

instr 101   ;clear global audio

endin

</CsInstruments>
<CsScore>

i1 0 999999999999
i4 0 999999999999
i10 0 999999999999
i11 0 999999999999
i12 0 999999999999
i100 0 999999999999
i101 0 999999999999

</CsScore>
</CsoundSynthesizer>
