<Cabbage>
bundle("manpluck.aiff", "impuls21.aiff")
form caption("VL Vocoder") size(400, 120), colour(black), pluginid("VLVO")
#define SLIDER trackercolour(white) colour(grey)
rslider text("Q") channel("Q") range(0.4, 10, 2, 1, 0.01) bounds (200, 0, 60,60) $SLIDER
rslider text("Number of Filters") channel("Num") range(1, 50, 5, 1, 1) bounds (275, 0, 100,60) $SLIDER
combobox bounds(8, 8, 80, 24) items("Analog Synth", "Moog", "Flute", "Bowed Bar", "Bowed String", "Noise") channel("select")
keyboard bounds(8, 60, 381, 50)
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


/*
Vocoder - channel vocoder with user-specified number of bands

DESCRIPTION
Vocoder is a channel vocoder using 4th order butteworth filters. It takes an input signal and analyses it with a user-specified number of log-spaced (constant-Q) filter bands (between a min and max) and  frequency) and then applies the analysed spectral envelope to an excitation signal.

SYNTAX
asig Vocoder aexc, ain, kminf, kmaxf, kq, ibands

INITIALIZATION
ibands - number of filter bands between kminf and kmaxf

PERFORMANCE
asig - output
aexc - excitation signal, generally a broadband source (ie. lots of spectral components)
ain - input signal, generally a signal with a strong spectral envelope or contour, formants, etc. (such as vocal sound)
kminf - lowest analysis frequency
kmaxf - highest analysis frequency
kq - filter Q 


CREDITS
Victor Lazzarini, 2005
*/

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


;instrument will be triggered by keyboard widget
instr 1
kFilterQ chnget "Q" 
iNumFilters chnget "Num" 
kEnv madsr .1, .2, .6, .4
aIn inch 1

kSelect chnget "select"

if kSelect == 1 then
a1 vco2 p5, p4

elseif kSelect == 2 then

kfreq  = p4
kfiltq = p5
kfiltrate = 0.0002
kvibf  = 5
kvamp  = .01
a1 moog .15, kfreq, kfiltq, kfiltrate, kvibf, kvamp, 1, 2, 3

elseif kSelect == 3 then

a1 wgflute p5, p4, 0.3, 0.1, 0.1, 0.1, 0.5, 0.02


elseif kSelect == 4 then

a1 wgbowedbar p5, p4, 3, 0.5, 0.8

elseif kSelect == 5 then

a1 wgbow p5, p4, 3, 0.1, 5, 0.01

elseif kSelect == 6 then

a1 noise 1, 0

endif



aOut Vocoder a1, aIn, 100, 5000, kFilterQ, iNumFilters
aOut balance aOut, aIn
outs aOut*kEnv, aOut*kEnv

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 1 0 8192 1 "mandpluk.aiff" 0 0 0
f 2 0 256 1 "impuls20.aiff" 0 0 0
f 3 0 256 10 1	; sine
</CsScore>
</CsoundSynthesizer>
