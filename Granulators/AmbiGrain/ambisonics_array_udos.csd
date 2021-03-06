<CsoundSynthesizer>
<CsInstruments>
opcode	ambi_encode, k, aikk

asnd,iorder,kaz,kel	xin

kaz = $M_PI*kaz/180
kel = $M_PI*kel/180

kcos_el = cos(kel)
ksin_el = sin(kel)
kcos_az = cos(kaz)
ksin_az = sin(kaz)

	zawm	asnd,0							; W
	zawm	kcos_el*ksin_az*asnd,1		; Y	 = Y(1,-1)
	zawm	ksin_el*asnd,2 				; Z	 = Y(1,0)
	zawm	kcos_el*kcos_az*asnd,3		; X	 = Y(1,1)

	if		iorder < 2 goto	end

i2	= sqrt(3)/2
kcos_el_p2 = kcos_el*kcos_el
ksin_el_p2 = ksin_el*ksin_el
kcos_2az = cos(2*kaz)
ksin_2az = sin(2*kaz)
kcos_2el = cos(2*kel)
ksin_2el = sin(2*kel)

	zawm i2*kcos_el_p2*ksin_2az*asnd,4	; V = Y(2,-2)
	zawm i2*ksin_2el*ksin_az*asnd,5		; S = Y(2,-1)
	zawm .5*(3*ksin_el_p2 - 1)*asnd,6		; R = Y(2,0)
	zawm i2*ksin_2el*kcos_az*asnd,7		; S = Y(2,1)
	zawm i2*kcos_el_p2*kcos_2az*asnd,8	; U = Y(2,2)

	if		iorder < 3 goto	end

i31 = sqrt(5/8)
i32 = sqrt(15)/2
i33 = sqrt(3/8)

kcos_el_p3 = kcos_el*kcos_el_p2
ksin_el_p3 = ksin_el*ksin_el_p2
kcos_3az = cos(3*kaz)
ksin_3az = sin(3*kaz)
kcos_3el = cos(3*kel)
ksin_3el = sin(3*kel)

zawm i31*kcos_el_p3*ksin_3az*asnd,9					; Q = Y(3,-3)
zawm i32*ksin_el*kcos_el_p2*ksin_2az*asnd,10		; O = Y(3,-2)
zawm i33*kcos_el*(5*ksin_el_p2-1)*ksin_az*asnd,11	; M = Y(3,-1)
zawm .5*ksin_el*(5*ksin_el_p2-3)*asnd,12			; K = Y(3,0)
zawm i33*kcos_el*(5*ksin_el_p2-1)*kcos_az*asnd,13	; L = Y(3,1)
zawm i32*ksin_el*kcos_el_p2*kcos_2az*asnd,14		; N = Y(3,2)
zawm i31*kcos_el_p3*kcos_3az*asnd,15					; P = Y(3,3)

	if		iorder < 4 goto	end

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
kcos_el_p4 = kcos_el*kcos_el_p3
ksin_el_p4 = ksin_el*ksin_el_p3
kcos_4az = cos(4*kaz)
ksin_4az = sin(4*kaz)
kcos_4el = cos(4*kel)
ksin_4el = sin(4*kel)
zawm ic41*kcos_el_p4*ksin_4az*asnd,16							; Y(4,-4)
zawm ic42*ksin_el*kcos_el_p3*ksin_3az*asnd,17					; Y(4,-3)
zawm ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*ksin_2az*asnd,18	; Y(4,-2)
zawm ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*ksin_az*asnd,19		; Y(4,-1)
zawm (1/8)*(35.*ksin_el_p4 - 30.*ksin_el_p2 + 3.)*asnd,20	; Y(4,0)
zawm ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*kcos_az*asnd,21		; Y(4,1)
zawm ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*kcos_2az*asnd,22	; Y(4,2)
zawm ic42*ksin_el*kcos_el_p3*kcos_3az*asnd,23					; Y(4,3)
zawm ic41*kcos_el_p4*kcos_4az*asnd,24							; Y(4,4)

	if		iorder < 5 goto	end

ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
kcos_el_p5 = kcos_el*kcos_el_p4
ksin_el_p5 = ksin_el*ksin_el_p4
kcos_5az = cos(5*kaz)
ksin_5az = sin(5*kaz)
kcos_5el = cos(5*kel)
ksin_5el = sin(5*kel)
zawm ic51*kcos_el_p5*ksin_5az*asnd,25										; Y(5,-5)
zawm ic52*ksin_el*kcos_el_p4*ksin_4az*asnd,26								; Y(5,-4)
zawm ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*ksin_3az*asnd,27					; Y(5,-3)
zawm ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*ksin_2az*asnd,28		; Y(5,-2)
zawm ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*ksin_az*asnd,29	; Y(5,-1)
zawm (1/8)*(63*ksin_el_p5 - 70*ksin_el_p3 + 15*ksin_el)*asnd,30			; Y(5,0)
zawm ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*kcos_az*asnd,31	; Y(5,1)
zawm ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*kcos_2az*asnd,32		; Y(5,2)
zawm ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*kcos_3az*asnd,33					; Y(5,3)
zawm ic52*ksin_el*kcos_el_p4*kcos_4az*asnd,34								; Y(5,4)
zawm ic51*kcos_el_p5*kcos_5az*asnd,35										; Y(5,5)

	if		iorder < 6 goto	end

ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
kcos_el_p6 = kcos_el*kcos_el_p5
ksin_el_p6 = ksin_el*ksin_el_p5
kcos_6az = cos(6*kaz)
ksin_6az = sin(6*kaz)
kcos_6el = cos(6*kel)
ksin_6el = sin(6*kel)
zawm ic61*kcos_el_p6*ksin_6az*asnd,36
zawm ic62*ksin_el*kcos_el_p5*ksin_5az*asnd,37
zawm ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*ksin_4az*asnd,38
zawm ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*ksin_3az*asnd,39
zawm ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*ksin_2az*asnd,40
zawm ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*ksin_az*asnd,41
zawm (1/16)*(231*ksin_el_p6 - 315*ksin_el_p4 + 105*ksin_el_p2 - 5)*asnd,42
zawm ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*kcos_az*asnd,43
zawm ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*kcos_2az*asnd,44
zawm ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*kcos_3az*asnd,45
zawm ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*kcos_4az*asnd,46
zawm ic62*ksin_el*kcos_el_p5*kcos_5az*asnd,47
zawm ic61*kcos_el_p6*kcos_6az*asnd,48

	if		iorder < 7 goto	end
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
kcos_el_p7 = kcos_el*kcos_el_p6
ksin_el_p7 = ksin_el*ksin_el_p6
kcos_7az = cos(7*kaz)
ksin_7az = sin(7*kaz)
kcos_7el = cos(7*kel)
ksin_7el = sin(7*kel)
zawm ic71*kcos_el_p7*ksin_7az*asnd,49
zawm ic72*ksin_el*kcos_el_p6*ksin_6az*asnd,50
zawm ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*ksin_5az*asnd,51
zawm ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*ksin_4az*asnd,52
zawm ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*ksin_3az*asnd,53
zawm ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*ksin_2az*asnd,54
zawm ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*ksin_az*asnd,55
zawm (1/16)*(429*ksin_el_p7 - 693*ksin_el_p5 + 315*ksin_el_p3 - 35*ksin_el)*asnd,56
zawm ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*kcos_az*asnd,57
zawm ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*kcos_2az*asnd,58
zawm ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*kcos_3az*asnd,59
zawm ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*kcos_4az*asnd,60
zawm ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*kcos_5az*asnd,61
zawm ic72*ksin_el*kcos_el_p6*kcos_6az*asnd,62
zawm ic71*kcos_el_p7*kcos_7az*asnd,63

	if		iorder < 8 goto	end
ic81 = (3/128)*sqrt(715)
ic82 = (3/32)*sqrt(715)
ic83 = (1/32)*sqrt(429/2)
ic84 = (3/32)*sqrt(1001)
ic85 = (3/64)*sqrt(77)
ic86 = (1/32)*sqrt(1155)
ic87 = (3/32)*sqrt(35/2)
ic88 = (3/32)
kcos_el_p8 = kcos_el*kcos_el_p7
ksin_el_p8 = ksin_el*ksin_el_p7
kcos_8az = cos(8*kaz)
ksin_8az = sin(8*kaz)
kcos_8el = cos(8*kel)
ksin_8el = sin(8*kel)
zawm ic81*kcos_el_p8*ksin_8az*asnd,64
zawm ic82*ksin_el*kcos_el_p7*ksin_7az*asnd,65
zawm ic83*(15*ksin_el_p2 - 1)*kcos_el_p6*ksin_6az*asnd,66
zawm ic84*(5*ksin_el_p3 - ksin_el)*kcos_el_p5*ksin_5az*asnd,67
zawm ic85*(65*ksin_el_p4 - 26*ksin_el_p2 + 1)*kcos_el_p4*ksin_4az*asnd,68
zawm ic86*(39*ksin_el_p5 - 26*ksin_el_p3 + 3*ksin_el)*kcos_el_p3*ksin_3az*asnd,69
zawm ic87*(143*ksin_el_p6 - 143*ksin_el_p4 + 33*ksin_el_p2 - 1)*kcos_el_p2*ksin_2az*asnd,70
zawm ic88*(715*ksin_el_p7 - 1001*ksin_el_p5 + 385*ksin_el_p3 - 35*ksin_el)*kcos_el*ksin_az*asnd,71
zawm (1/128)*(6435*ksin_el_p8 - 12012*ksin_el_p6 + 6930*ksin_el_p4 - 1260*ksin_el_p2 + 35)*asnd,72
zawm ic88*(715*ksin_el_p7 - 1001*ksin_el_p5 + 385*ksin_el_p3 - 35*ksin_el)*kcos_el*kcos_az*asnd,73
zawm ic87*(143*ksin_el_p6 - 143*ksin_el_p4 + 33*ksin_el_p2 - 1)*kcos_el_p2*kcos_2az*asnd,74
zawm ic86*(39*ksin_el_p5 - 26*ksin_el_p3 + 3*ksin_el)*kcos_el_p3*kcos_3az*asnd,75
zawm ic85*(65*ksin_el_p4 - 26*ksin_el_p2 + 1)*kcos_el_p4*kcos_4az*asnd,76
zawm ic84*(5*ksin_el_p3 - ksin_el)*kcos_el_p5*kcos_5az*asnd,77
zawm ic83*(15*ksin_el_p2 - 1)*kcos_el_p6*kcos_6az*asnd,78
zawm ic82*ksin_el*kcos_el_p7*kcos_7az*asnd,79
zawm ic81*kcos_el_p8*kcos_8az*asnd,80

end:
	kZero = 0
		xout kZero
endop
;;;;;;;;;;;;
opcode	ambi_enc_dist, k, aikkk

asnd,iorder,kaz,kel,kdist	xin

kaz = $M_PI*kaz/180
kel = $M_PI*kel/180

kaz	=		(kdist < 0 ? kaz + $M_PI : kaz)
kel	=		(kdist < 0 ? -kel : kel)
kdist =	abs(kdist)+0.000001
kgainW	=	taninv(kdist*1.5707963) / (kdist*1.5708)
kgainHO =	(1 - exp(-kdist)) ;*kgainW
	outvalue "kgainHO", kgainHO
	outvalue "kgainW", kgainW
kcos_el = cos(kel)
ksin_el = sin(kel)
kcos_az = cos(kaz)
ksin_az = sin(kaz)
asnd =		kgainW*asnd
	zawm	asnd,0							; W
asnd = 	kgainHO*asnd
	zawm	kcos_el*ksin_az*asnd,1		; Y	 = Y(1,-1)
	zawm	ksin_el*asnd,2 				; Z	 = Y(1,0)
	zawm	kcos_el*kcos_az*asnd,3		; X	 = Y(1,1)

	if		iorder < 2 goto	end

i2	= sqrt(3)/2
kcos_el_p2 = kcos_el*kcos_el
ksin_el_p2 = ksin_el*ksin_el
kcos_2az = cos(2*kaz)
ksin_2az = sin(2*kaz)
kcos_2el = cos(2*kel)
ksin_2el = sin(2*kel)

	zawm i2*kcos_el_p2*ksin_2az*asnd,4	; V = Y(2,-2)
	zawm i2*ksin_2el*ksin_az*asnd,5		; S = Y(2,-1)
	zawm .5*(3*ksin_el_p2 - 1)*asnd,6		; R = Y(2,0)
	zawm i2*ksin_2el*kcos_az*asnd,7		; S = Y(2,1)
	zawm i2*kcos_el_p2*kcos_2az*asnd,8	; U = Y(2,2)

	if		iorder < 3 goto	end

i31 = sqrt(5/8)
i32 = sqrt(15)/2
i33 = sqrt(3/8)

kcos_el_p3 = kcos_el*kcos_el_p2
ksin_el_p3 = ksin_el*ksin_el_p2
kcos_3az = cos(3*kaz)
ksin_3az = sin(3*kaz)
kcos_3el = cos(3*kel)
ksin_3el = sin(3*kel)

zawm i31*kcos_el_p3*ksin_3az*asnd,9					; Q = Y(3,-3)
zawm i32*ksin_el*kcos_el_p2*ksin_2az*asnd,10		; O = Y(3,-2)
zawm i33*kcos_el*(5*ksin_el_p2-1)*ksin_az*asnd,11	; M = Y(3,-1)
zawm .5*ksin_el*(5*ksin_el_p2-3)*asnd,12			; K = Y(3,0)
zawm i33*kcos_el*(5*ksin_el_p2-1)*kcos_az*asnd,13	; L = Y(3,1)
zawm i32*ksin_el*kcos_el_p2*kcos_2az*asnd,14		; N = Y(3,2)
zawm i31*kcos_el_p3*kcos_3az*asnd,15					; P = Y(3,3)

	if		iorder < 4 goto	end

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
kcos_el_p4 = kcos_el*kcos_el_p3
ksin_el_p4 = ksin_el*ksin_el_p3
kcos_4az = cos(4*kaz)
ksin_4az = sin(4*kaz)
kcos_4el = cos(4*kel)
ksin_4el = sin(4*kel)
zawm ic41*kcos_el_p4*ksin_4az*asnd,16							; Y(4,-4)
zawm ic42*ksin_el*kcos_el_p3*ksin_3az*asnd,17					; Y(4,-3)
zawm ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*ksin_2az*asnd,18	; Y(4,-2)
zawm ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*ksin_az*asnd,19		; Y(4,-1)
zawm (1/8)*(35.*ksin_el_p4 - 30.*ksin_el_p2 + 3.)*asnd,20	; Y(4,0)
zawm ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*kcos_az*asnd,21		; Y(4,1)
zawm ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*kcos_2az*asnd,22	; Y(4,2)
zawm ic42*ksin_el*kcos_el_p3*kcos_3az*asnd,23					; Y(4,3)
zawm ic41*kcos_el_p4*kcos_4az*asnd,24							; Y(4,4)

	if		iorder < 5 goto	end

ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
kcos_el_p5 = kcos_el*kcos_el_p4
ksin_el_p5 = ksin_el*ksin_el_p4
kcos_5az = cos(5*kaz)
ksin_5az = sin(5*kaz)
kcos_5el = cos(5*kel)
ksin_5el = sin(5*kel)
zawm ic51*kcos_el_p5*ksin_5az*asnd,25										; Y(5,-5)
zawm ic52*ksin_el*kcos_el_p4*ksin_4az*asnd,26								; Y(5,-4)
zawm ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*ksin_3az*asnd,27					; Y(5,-3)
zawm ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*ksin_2az*asnd,28		; Y(5,-2)
zawm ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*ksin_az*asnd,29	; Y(5,-1)
zawm (1/8)*(63*ksin_el_p5 - 70*ksin_el_p3 + 15*ksin_el)*asnd,30			; Y(5,0)
zawm ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*kcos_az*asnd,31	; Y(5,1)
zawm ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*kcos_2az*asnd,32		; Y(5,2)
zawm ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*kcos_3az*asnd,33					; Y(5,3)
zawm ic52*ksin_el*kcos_el_p4*kcos_4az*asnd,34								; Y(5,4)
zawm ic51*kcos_el_p5*kcos_5az*asnd,35										; Y(5,5)

	if		iorder < 6 goto	end

ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
kcos_el_p6 = kcos_el*kcos_el_p5
ksin_el_p6 = ksin_el*ksin_el_p5
kcos_6az = cos(6*kaz)
ksin_6az = sin(6*kaz)
kcos_6el = cos(6*kel)
ksin_6el = sin(6*kel)
zawm ic61*kcos_el_p6*ksin_6az*asnd,36
zawm ic62*ksin_el*kcos_el_p5*ksin_5az*asnd,37
zawm ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*ksin_4az*asnd,38
zawm ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*ksin_3az*asnd,39
zawm ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*ksin_2az*asnd,40
zawm ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*ksin_az*asnd,41
zawm (1/16)*(231*ksin_el_p6 - 315*ksin_el_p4 + 105*ksin_el_p2 - 5)*asnd,42
zawm ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*kcos_az*asnd,43
zawm ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*kcos_2az*asnd,44
zawm ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*kcos_3az*asnd,45
zawm ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*kcos_4az*asnd,46
zawm ic62*ksin_el*kcos_el_p5*kcos_5az*asnd,47
zawm ic61*kcos_el_p6*kcos_6az*asnd,48

	if		iorder < 7 goto	end
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
kcos_el_p7 = kcos_el*kcos_el_p6
ksin_el_p7 = ksin_el*ksin_el_p6
kcos_7az = cos(7*kaz)
ksin_7az = sin(7*kaz)
kcos_7el = cos(7*kel)
ksin_7el = sin(7*kel)
zawm ic71*kcos_el_p7*ksin_7az*asnd,49
zawm ic72*ksin_el*kcos_el_p6*ksin_6az*asnd,50
zawm ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*ksin_5az*asnd,51
zawm ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*ksin_4az*asnd,52
zawm ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*ksin_3az*asnd,53
zawm ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*ksin_2az*asnd,54
zawm ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*ksin_az*asnd,55
zawm (1/16)*(429*ksin_el_p7 - 693*ksin_el_p5 + 315*ksin_el_p3 - 35*ksin_el)*asnd,56
zawm ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*kcos_az*asnd,57
zawm ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*kcos_2az*asnd,58
zawm ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*kcos_3az*asnd,59
zawm ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*kcos_4az*asnd,60
zawm ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*kcos_5az*asnd,61
zawm ic72*ksin_el*kcos_el_p6*kcos_6az*asnd,62
zawm ic71*kcos_el_p7*kcos_7az*asnd,63

	if		iorder < 8 goto	end
ic81 = (3/128)*sqrt(715)
ic82 = (3/32)*sqrt(715)
ic83 = (1/32)*sqrt(429/2)
ic84 = (3/32)*sqrt(1001)
ic85 = (3/64)*sqrt(77)
ic86 = (1/32)*sqrt(1155)
ic87 = (3/32)*sqrt(35/2)
ic88 = (3/32)
kcos_el_p8 = kcos_el*kcos_el_p7
ksin_el_p8 = ksin_el*ksin_el_p7
kcos_8az = cos(8*kaz)
ksin_8az = sin(8*kaz)
kcos_8el = cos(8*kel)
ksin_8el = sin(8*kel)
zawm ic81*kcos_el_p8*ksin_8az*asnd,64
zawm ic82*ksin_el*kcos_el_p7*ksin_7az*asnd,65
zawm ic83*(15*ksin_el_p2 - 1)*kcos_el_p6*ksin_6az*asnd,66
zawm ic84*(5*ksin_el_p3 - ksin_el)*kcos_el_p5*ksin_5az*asnd,67
zawm ic85*(65*ksin_el_p4 - 26*ksin_el_p2 + 1)*kcos_el_p4*ksin_4az*asnd,68
zawm ic86*(39*ksin_el_p5 - 26*ksin_el_p3 + 3*ksin_el)*kcos_el_p3*ksin_3az*asnd,69
zawm ic87*(143*ksin_el_p6 - 143*ksin_el_p4 + 33*ksin_el_p2 - 1)*kcos_el_p2*ksin_2az*asnd,70
zawm ic88*(715*ksin_el_p7 - 1001*ksin_el_p5 + 385*ksin_el_p3 - 35*ksin_el)*kcos_el*ksin_az*asnd,71
zawm (1/128)*(6435*ksin_el_p8 - 12012*ksin_el_p6 + 6930*ksin_el_p4 - 1260*ksin_el_p2 + 35)*asnd,72
zawm ic88*(715*ksin_el_p7 - 1001*ksin_el_p5 + 385*ksin_el_p3 - 35*ksin_el)*kcos_el*kcos_az*asnd,73
zawm ic87*(143*ksin_el_p6 - 143*ksin_el_p4 + 33*ksin_el_p2 - 1)*kcos_el_p2*kcos_2az*asnd,74
zawm ic86*(39*ksin_el_p5 - 26*ksin_el_p3 + 3*ksin_el)*kcos_el_p3*kcos_3az*asnd,75
zawm ic85*(65*ksin_el_p4 - 26*ksin_el_p2 + 1)*kcos_el_p4*kcos_4az*asnd,76
zawm ic84*(5*ksin_el_p3 - ksin_el)*kcos_el_p5*kcos_5az*asnd,77
zawm ic83*(15*ksin_el_p2 - 1)*kcos_el_p6*kcos_6az*asnd,78
zawm ic82*ksin_el*kcos_el_p7*kcos_7az*asnd,79
zawm ic81*kcos_el_p8*kcos_8az*asnd,80

end:
kZero = 0
		xout	kZero
endop

;;;;;;;;;;;;

opcode	ambi_decode1, a, iii

iorder,iaz,iel	xin

iaz = $M_PI*iaz/180
iel = $M_PI*iel/180

a0=zar(0)
	if	iorder > 0 goto c0
aout = a0
	goto	end
c0:
a1=zar(1)
a2=zar(2)
a3=zar(3)
icos_el = cos(iel)
isin_el = sin(iel)
icos_az = cos(iaz)
isin_az = sin(iaz)
i1	=	icos_el*isin_az			; Y	 = Y(1,-1)
i2	=	isin_el					; Z	 = Y(1,0)
i3	=	icos_el*icos_az			; X	 = Y(1,1)
	if iorder > 1 goto c1
aout	=	(1/2)*(a0 + i1*a1 + i2*a2 + i3*a3)
	goto end
c1:
a4=zar(4)
a5=zar(5)
a6=zar(6)
a7=zar(7)
a8=zar(8)

ic2	= sqrt(3)/2

icos_el_p2 = icos_el*icos_el
isin_el_p2 = isin_el*isin_el
icos_2az = cos(2*iaz)
isin_2az = sin(2*iaz)
icos_2el = cos(2*iel)
isin_2el = sin(2*iel)


i4 = ic2*icos_el_p2*isin_2az	; V = Y(2,-2)
i5	= ic2*isin_2el*isin_az		; S = Y(2,-1)
i6 = .5*(3*isin_el_p2 - 1)		; R = Y(2,0)
i7 = ic2*isin_2el*icos_az		; S = Y(2,1)
i8 = ic2*icos_el_p2*icos_2az	; U = Y(2,2)
	if iorder > 2 goto c2
aout	=	(1/9)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8)
	goto end
c2:
a9=zar(9)
a10=zar(10)
a11=zar(11)
a12=zar(12)
a13=zar(13)
a14=zar(14)
a15=zar(15)

ic31 = sqrt(5/8)
ic32 = sqrt(15)/2
ic33 = sqrt(3/8)
icos_el_p3 = icos_el*icos_el_p2;
isin_el_p3 = isin_el*isin_el_p2;
icos_3az = cos(3*iaz);
isin_3az = sin(3*iaz);
icos_3el = cos(3*iel);
isin_3el = sin(3*iel);

i9 = ic31*icos_el_p3*isin_3az					; Q = Y(3,-3)
i10 = ic32*isin_el*icos_el_p2*isin_2az		; O = Y(3,-2)
i11 = ic33*icos_el*(5*isin_el_p2-1)*isin_az	; M = Y(3,-1)
i12 = .5*isin_el*(5*isin_el_p2-3)				; K = Y(3,0)
i13 = ic33*icos_el*(5*isin_el_p2-1)*icos_az	; L = Y(3,1)
i14 = ic32*isin_el*icos_el_p2*icos_2az		; N = Y(3,2)
i15 = ic31*icos_el_p3*icos_3az				; P = Y(3,3)
	if iorder > 3 goto c3
aout	=	(1/16)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15)
	goto end
c3:
a16=zar(16)
a17=zar(17)
a18=zar(18)
a19=zar(19)
a20=zar(20)
a21=zar(21)
a22=zar(22)
a23=zar(23)
a24=zar(24)

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
icos_el_p4 = icos_el*icos_el_p3
isin_el_p4 = isin_el*isin_el_p3
icos_4az = cos(4*iaz)
isin_4az = sin(4*iaz)
icos_4el = cos(4*iel)
isin_4el = sin(4*iel)
i16 = ic41*icos_el_p4*isin_4az							; Y(4,-4)
i17 = ic42*isin_el*icos_el_p3*isin_3az					; Y(4,-3)
i18 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*isin_2az	; Y(4,-2)
i19 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*isin_az		; Y(4,-1)
i20 = (1/8)*(35.*isin_el_p4 - 30.*isin_el_p2 + 3.)	; Y(4,0)
i21 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*icos_az		; Y(4,1)
i22 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*icos_2az	; Y(4,2)
i23 = ic42*isin_el*icos_el_p3*icos_3az					; Y(4,3)
i24 = ic41*icos_el_p4*icos_4az							; Y(4,4)

	if iorder > 4 goto c4
aout	=	(1/25)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24)
	goto end
c4:

a25=zar(25)
a26=zar(26)
a27=zar(27)
a28=zar(28)
a29=zar(29)
a30=zar(30)
a31=zar(31)
a32=zar(32)
a33=zar(33)
a34=zar(34)
a35=zar(35)
ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
icos_el_p5 = icos_el*icos_el_p4
isin_el_p5 = isin_el*isin_el_p4
icos_5az = cos(5*iaz)
isin_5az = sin(5*iaz)
icos_5el = cos(5*iel)
isin_5el = sin(5*iel)
i25 = ic51*icos_el_p5*isin_5az										; Y(5,-5)
i26 = ic52*isin_el*icos_el_p4*isin_4az								; Y(5,-4)
i27 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*isin_3az					; Y(5,-3)
i28 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*isin_2az		; Y(5,-2)
i29 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*isin_az	; Y(5,-1)
i30 = (1/8)*(63*isin_el_p5 - 70*isin_el_p3 + 15*isin_el)			; Y(5,0)
i31 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*icos_az	; Y(5,1)
i32 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*icos_2az;		; Y(5,2)
i33 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*icos_3az					; Y(5,3)
i34 = ic52*isin_el*icos_el_p4*icos_4az								; Y(5,4)
i35 = ic51*icos_el_p5*icos_5az										; Y(5,5)
	if iorder > 5 goto c5
aout =	(1/36)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35)
	goto end
c5:

a36=zar(36)
a37=zar(37)
a38=zar(38)
a39=zar(39)
a40=zar(40)
a41=zar(41)
a42=zar(42)
a43=zar(43)
a44=zar(44)
a45=zar(45)
a46=zar(46)
a47=zar(47)
a48=zar(48)
ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
icos_el_p6 = icos_el*icos_el_p5
isin_el_p6 = isin_el*isin_el_p5
icos_6az = cos(6*iaz)
isin_6az = sin(6*iaz)
icos_6el = cos(6*iel)
isin_6el = sin(6*iel)
i36 = ic61*icos_el_p6*isin_6az
i37 = ic62*isin_el*icos_el_p5*isin_5az
i38 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*isin_4az
i39 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*isin_3az
i40 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*isin_2az
i41 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*isin_az
i42 = (1/16)*(231*isin_el_p6 - 315*isin_el_p4 + 105*isin_el_p2 - 5)
i43 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*icos_az
i44 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*icos_2az
i45 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*icos_3az
i46 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*icos_4az
i47 = ic62*isin_el*icos_el_p5*icos_5az
i48 = ic61*icos_el_p6*icos_6az
	if iorder > 6 goto c6
aout =	(1/49)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48)
	goto end
c6:
a49=zar(49)
a50=zar(50)
a51=zar(51)
a52=zar(52)
a53=zar(53)
a54=zar(54)
a55=zar(55)
a56=zar(56)
a57=zar(57)
a58=zar(58)
a59=zar(59)
a60=zar(60)
a61=zar(61)
a62=zar(62)
a63=zar(63)
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
icos_el_p7 = icos_el*icos_el_p6
isin_el_p7 = isin_el*isin_el_p6
icos_7az = cos(7*iaz)
isin_7az = sin(7*iaz)
icos_7el = cos(7*iel)
isin_7el = sin(7*iel)
i49 = ic71*icos_el_p7*isin_7az
i50 = ic72*isin_el*icos_el_p6*isin_6az
i51 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*isin_5az
i52 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*isin_4az
i53 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*isin_3az
i54 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*isin_2az
i55 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*isin_az
i56 = (1/16)*(429*isin_el_p7 - 693*isin_el_p5 + 315*isin_el_p3 - 35*isin_el)
i57 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*icos_az
i58 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*icos_2az
i59 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*icos_3az
i60 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*icos_4az
i61 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*icos_5az
i62 = ic72*isin_el*icos_el_p6*icos_6az
i63 = ic71*icos_el_p7*icos_7az
	if iorder > 7 goto c7
aout =	(1/64)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63)
	goto end
c7:
a64=zar(64)
a65=zar(65)
a66=zar(66)
a67=zar(67)
a68=zar(68)
a69=zar(69)
a70=zar(70)
a71=zar(71)
a72=zar(72)
a73=zar(73)
a74=zar(74)
a75=zar(75)
a76=zar(76)
a77=zar(77)
a78=zar(78)
a79=zar(79)
a80=zar(80)
ic81 = (3/128)*sqrt(715)
ic82 = (3/32)*sqrt(715)
ic83 = (1/32)*sqrt(429/2)
ic84 = (3/32)*sqrt(1001)
ic85 = (3/64)*sqrt(77)
ic86 = (1/32)*sqrt(1155)
ic87 = (3/32)*sqrt(35/2)
ic88 = (3/32)
icos_el_p8 = icos_el*icos_el_p7
isin_el_p8 = isin_el*isin_el_p7
icos_8az = cos(8*iaz)
isin_8az = sin(8*iaz)
icos_8el = cos(8*iel)
isin_8el = sin(8*iel)
i64 = ic81*icos_el_p8*isin_8az
i65 = ic82*isin_el*icos_el_p7*isin_7az
i66 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*isin_6az
i67 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*isin_5az
i68 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*isin_4az
i69 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*isin_3az
i70 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*isin_2az
i71 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*isin_az
i72 = (1/128)*(6435*isin_el_p8 - 12012*isin_el_p6 + 6930*isin_el_p4 - 1260*isin_el_p2 + 35)
i73 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*icos_az
i74 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*icos_2az
i75 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*icos_3az
i76 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*icos_4az
i77 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*icos_5az
i78 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*icos_6az
i79 = ic82*isin_el*icos_el_p7*icos_7az
i80 = ic81*icos_el_p8*icos_8az
;	if iorder > 7 goto c7
aout =	(1/81)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63 + 17*i64*a64 + 17*i65*a65 + 17*i66*a66 + 17*i67*a67 + 17*i68*a68 + 17*i69*a69 + 17*i70*a70 + 17*i71*a71 + 17*i72*a72 + 17*i73*a73 + 17*i74*a74 + 17*i75*a75 + 17*i76*a76 + 17*i77*a77 + 17*i78*a78 + 17*i79*a79 + 17*i80*a80)
end:
		xout			aout
endop
;;;;;;;;;;;


opcode	ambi_decode,	a,ii
iorder,ifn xin
		xout	ambi_decode1(iorder,table(1,ifn),table(2,ifn))
endop
opcode	ambi_decode,	aa,ii
iorder,ifn xin
		xout				ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn))
endop
opcode	ambi_decode,	aaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn))
endop
opcode	ambi_decode,	aaaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn))
endop
opcode	ambi_decode,	aaaaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn)),
		ambi_decode1(iorder,table(9,ifn),table(10,ifn))
endop
opcode	ambi_decode,	aaaaaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn)),
		ambi_decode1(iorder,table(9,ifn),table(10,ifn)),
		ambi_decode1(iorder,table(11,ifn),table(12,ifn))
endop
opcode	ambi_decode,	aaaaaaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn)),
		ambi_decode1(iorder,table(9,ifn),table(10,ifn)),
		ambi_decode1(iorder,table(11,ifn),table(12,ifn)),									ambi_decode1(iorder,table(13,ifn),table(14,ifn))
endop
opcode	ambi_decode,	aaaaaaaa,ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn)),
		ambi_decode1(iorder,table(9,ifn),table(10,ifn)),
		ambi_decode1(iorder,table(11,ifn),table(12,ifn)),								ambi_decode1(iorder,table(13,ifn),table(14,ifn)),
		ambi_decode1(iorder,table(15,ifn),table(16,ifn))
endop

;;;;;;;;;;;;

opcode	ambi_dec1_inph, a, iii

; weights and norms up to 12th order
;iNorm2D[] array 1,0.75,0.625,0.546875,0.492188,0.451172,0.418945,
;					0.392761,0.370941,0.352394,0.336376,0.322360
iWeight3D[][] init   8,8
iWeight3D     array  0.333333,0,0,0,0,0,0,0,
	0.5,0.1,0,0,0,0,0,0,
	0.6,0.2,0.0285714,0,0,0,0,0,
	0.666667,0.285714,0.0714286,0.0079365,0,0,0,0,
	0.714286,0.357143,0.119048,0.0238095,0.0021645,0,0,0,
	0.75,0.416667,0.166667,0.0454545,0.00757576,0.00058275,0,0,
	0.777778,0.466667,0.212121,0.0707071,0.016317,0.002331,0.0001554,0,
  	0.8,0.509091,0.254545,0.0979021,0.027972,0.0055944,0.0006993,0.00004114


iorder,iaz,iel	xin

iaz = $M_PI*iaz/180
iel = $M_PI*iel/180

a0=zar(0)
	if	iorder > 0 goto c0
aout = a0
	goto	end
c0:
a1=iWeight3D[iorder-1][0]*zar(1)
a2=iWeight3D[iorder-1][0]*zar(2)
a3=iWeight3D[iorder-1][0]*zar(3)
icos_el = cos(iel)
isin_el = sin(iel)
icos_az = cos(iaz)
isin_az = sin(iaz)
i1	=	icos_el*isin_az			; Y	 = Y(1,-1)
i2	=	isin_el				; Z	 = Y(1,0)
i3	=	icos_el*icos_az			; X	 = Y(1,1)
	if iorder > 1 goto c1
aout	=	(3/4)*(a0 + i1*a1 + i2*a2 + i3*a3)
	goto end
c1:
a4=iWeight3D[iorder-1][1]*zar(4)
a5=iWeight3D[iorder-1][1]*zar(5)
a6=iWeight3D[iorder-1][1]*zar(6)
a7=iWeight3D[iorder-1][1]*zar(7)
a8=iWeight3D[iorder-1][1]*zar(8)

ic2	= sqrt(3)/2

icos_el_p2 = icos_el*icos_el
isin_el_p2 = isin_el*isin_el
icos_2az = cos(2*iaz)
isin_2az = sin(2*iaz)
icos_2el = cos(2*iel)
isin_2el = sin(2*iel)


i4 = ic2*icos_el_p2*isin_2az	; V = Y(2,-2)
i5	= ic2*isin_2el*isin_az		; S = Y(2,-1)
i6 = .5*(3*isin_el_p2 - 1)		; R = Y(2,0)
i7 = ic2*isin_2el*icos_az		; S = Y(2,1)
i8 = ic2*icos_el_p2*icos_2az	; U = Y(2,2)
	if iorder > 2 goto c2
aout	=	(1/3)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8)
	goto end
c2:
a9=iWeight3D[iorder-1][2]*zar(9)
a10=iWeight3D[iorder-1][2]*zar(10)
a11=iWeight3D[iorder-1][2]*zar(11)
a12=iWeight3D[iorder-1][2]*zar(12)
a13=iWeight3D[iorder-1][2]*zar(13)
a14=iWeight3D[iorder-1][2]*zar(14)
a15=iWeight3D[iorder-1][2]*zar(15)

ic31 = sqrt(5/8)
ic32 = sqrt(15)/2
ic33 = sqrt(3/8)
icos_el_p3 = icos_el*icos_el_p2;
isin_el_p3 = isin_el*isin_el_p2;
icos_3az = cos(3*iaz);
isin_3az = sin(3*iaz);
icos_3el = cos(3*iel);
isin_3el = sin(3*iel);

i9 = ic31*icos_el_p3*isin_3az					; Q = Y(3,-3)
i10 = ic32*isin_el*icos_el_p2*isin_2az		; O = Y(3,-2)
i11 = ic33*icos_el*(5*isin_el_p2-1)*isin_az	; M = Y(3,-1)
i12 = .5*isin_el*(5*isin_el_p2-3)				; K = Y(3,0)
i13 = ic33*icos_el*(5*isin_el_p2-1)*icos_az	; L = Y(3,1)
i14 = ic32*isin_el*icos_el_p2*icos_2az		; N = Y(3,2)
i15 = ic31*icos_el_p3*icos_3az				; P = Y(3,3)
	if iorder > 3 goto c3
aout	=	(1/4)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15)
	goto end
c3:
a16=iWeight3D[iorder-1][3]*zar(16)
a17=iWeight3D[iorder-1][3]*zar(17)
a18=iWeight3D[iorder-1][3]*zar(18)
a19=iWeight3D[iorder-1][3]*zar(19)
a20=iWeight3D[iorder-1][3]*zar(20)
a21=iWeight3D[iorder-1][3]*zar(21)
a22=iWeight3D[iorder-1][3]*zar(22)
a23=iWeight3D[iorder-1][3]*zar(23)
a24=iWeight3D[iorder-1][3]*zar(24)

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
icos_el_p4 = icos_el*icos_el_p3
isin_el_p4 = isin_el*isin_el_p3
icos_4az = cos(4*iaz)
isin_4az = sin(4*iaz)
icos_4el = cos(4*iel)
isin_4el = sin(4*iel)
i16 = ic41*icos_el_p4*isin_4az							; Y(4,-4)
i17 = ic42*isin_el*icos_el_p3*isin_3az					; Y(4,-3)
i18 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*isin_2az	; Y(4,-2)
i19 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*isin_az		; Y(4,-1)
i20 = (1/8)*(35.*isin_el_p4 - 30.*isin_el_p2 + 3.)	; Y(4,0)
i21 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*icos_az		; Y(4,1)
i22 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*icos_2az	; Y(4,2)
i23 = ic42*isin_el*icos_el_p3*icos_3az					; Y(4,3)
i24 = ic41*icos_el_p4*icos_4az							; Y(4,4)

	if iorder > 4 goto c4
aout	=	(1/5)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24)
	goto end
c4:

a25=iWeight3D[iorder-1][4]*zar(25)
a26=iWeight3D[iorder-1][4]*zar(26)
a27=iWeight3D[iorder-1][4]*zar(27)
a28=iWeight3D[iorder-1][4]*zar(28)
a29=iWeight3D[iorder-1][4]*zar(29)
a30=iWeight3D[iorder-1][4]*zar(30)
a31=iWeight3D[iorder-1][4]*zar(31)
a32=iWeight3D[iorder-1][4]*zar(32)
a33=iWeight3D[iorder-1][4]*zar(33)
a34=iWeight3D[iorder-1][4]*zar(34)
a35=iWeight3D[iorder-1][4]*zar(35)
ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
icos_el_p5 = icos_el*icos_el_p4
isin_el_p5 = isin_el*isin_el_p4
icos_5az = cos(5*iaz)
isin_5az = sin(5*iaz)
icos_5el = cos(5*iel)
isin_5el = sin(5*iel)
i25 = ic51*icos_el_p5*isin_5az										; Y(5,-5)
i26 = ic52*isin_el*icos_el_p4*isin_4az								; Y(5,-4)
i27 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*isin_3az					; Y(5,-3)
i28 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*isin_2az		; Y(5,-2)
i29 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*isin_az	; Y(5,-1)
i30 = (1/8)*(63*isin_el_p5 - 70*isin_el_p3 + 15*isin_el)			; Y(5,0)
i31 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*icos_az	; Y(5,1)
i32 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*icos_2az;		; Y(5,2)
i33 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*icos_3az					; Y(5,3)
i34 = ic52*isin_el*icos_el_p4*icos_4az								; Y(5,4)
i35 = ic51*icos_el_p5*icos_5az										; Y(5,5)
	if iorder > 5 goto c5
aout =	(1/6)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35)
	goto end
c5:

a36=iWeight3D[iorder-1][5]*zar(36)
a37=iWeight3D[iorder-1][5]*zar(37)
a38=iWeight3D[iorder-1][5]*zar(38)
a39=iWeight3D[iorder-1][5]*zar(39)
a40=iWeight3D[iorder-1][5]*zar(40)
a41=iWeight3D[iorder-1][5]*zar(41)
a42=iWeight3D[iorder-1][5]*zar(42)
a43=iWeight3D[iorder-1][5]*zar(43)
a44=iWeight3D[iorder-1][5]*zar(44)
a45=iWeight3D[iorder-1][5]*zar(45)
a46=iWeight3D[iorder-1][5]*zar(46)
a47=iWeight3D[iorder-1][5]*zar(47)
a48=iWeight3D[iorder-1][5]*zar(48)
ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
icos_el_p6 = icos_el*icos_el_p5
isin_el_p6 = isin_el*isin_el_p5
icos_6az = cos(6*iaz)
isin_6az = sin(6*iaz)
icos_6el = cos(6*iel)
isin_6el = sin(6*iel)
i36 = ic61*icos_el_p6*isin_6az
i37 = ic62*isin_el*icos_el_p5*isin_5az
i38 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*isin_4az
i39 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*isin_3az
i40 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*isin_2az
i41 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*isin_az
i42 = (1/16)*(231*isin_el_p6 - 315*isin_el_p4 + 105*isin_el_p2 - 5)
i43 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*icos_az
i44 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*icos_2az
i45 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*icos_3az
i46 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*icos_4az
i47 = ic62*isin_el*icos_el_p5*icos_5az
i48 = ic61*icos_el_p6*icos_6az
	if iorder > 6 goto c6
aout =	(1/7)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48)
	goto end
c6:
a49=iWeight3D[iorder-1][6]*zar(49)
a50=iWeight3D[iorder-1][6]*zar(50)
a51=iWeight3D[iorder-1][6]*zar(51)
a52=iWeight3D[iorder-1][6]*zar(52)
a53=iWeight3D[iorder-1][6]*zar(53)
a54=iWeight3D[iorder-1][6]*zar(54)
a55=iWeight3D[iorder-1][6]*zar(55)
a56=iWeight3D[iorder-1][6]*zar(56)
a57=iWeight3D[iorder-1][6]*zar(57)
a58=iWeight3D[iorder-1][6]*zar(58)
a59=iWeight3D[iorder-1][6]*zar(59)
a60=iWeight3D[iorder-1][6]*zar(60)
a61=iWeight3D[iorder-1][6]*zar(61)
a62=iWeight3D[iorder-1][6]*zar(62)
a63=iWeight3D[iorder-1][6]*zar(63)
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
icos_el_p7 = icos_el*icos_el_p6
isin_el_p7 = isin_el*isin_el_p6
icos_7az = cos(7*iaz)
isin_7az = sin(7*iaz)
icos_7el = cos(7*iel)
isin_7el = sin(7*iel)
i49 = ic71*icos_el_p7*isin_7az
i50 = ic72*isin_el*icos_el_p6*isin_6az
i51 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*isin_5az
i52 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*isin_4az
i53 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*isin_3az
i54 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*isin_2az
i55 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*isin_az
i56 = (1/16)*(429*isin_el_p7 - 693*isin_el_p5 + 315*isin_el_p3 - 35*isin_el)
i57 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*icos_az
i58 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*icos_2az
i59 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*icos_3az
i60 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*icos_4az
i61 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*icos_5az
i62 = ic72*isin_el*icos_el_p6*icos_6az
i63 = ic71*icos_el_p7*icos_7az
	if iorder > 7 goto c7
aout =	(1/8)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63)
	goto end
c7:
a64=iWeight3D[iorder-1][7]*zar(64)
a65=iWeight3D[iorder-1][7]*zar(65)
a66=iWeight3D[iorder-1][7]*zar(66)
a67=iWeight3D[iorder-1][7]*zar(67)
a68=iWeight3D[iorder-1][7]*zar(68)
a69=iWeight3D[iorder-1][7]*zar(69)
a70=iWeight3D[iorder-1][7]*zar(70)
a71=iWeight3D[iorder-1][7]*zar(71)
a72=iWeight3D[iorder-1][7]*zar(72)
a73=iWeight3D[iorder-1][7]*zar(73)
a74=iWeight3D[iorder-1][7]*zar(74)
a75=iWeight3D[iorder-1][7]*zar(75)
a76=iWeight3D[iorder-1][7]*zar(76)
a77=iWeight3D[iorder-1][7]*zar(77)
a78=iWeight3D[iorder-1][7]*zar(78)
a79=iWeight3D[iorder-1][7]*zar(79)
a80=iWeight3D[iorder-1][7]*zar(80)
ic81 = (3/128)*sqrt(715)
ic82 = (3/32)*sqrt(715)
ic83 = (1/32)*sqrt(429/2)
ic84 = (3/32)*sqrt(1001)
ic85 = (3/64)*sqrt(77)
ic86 = (1/32)*sqrt(1155)
ic87 = (3/32)*sqrt(35/2)
ic88 = (3/32)
icos_el_p8 = icos_el*icos_el_p7
isin_el_p8 = isin_el*isin_el_p7
icos_8az = cos(8*iaz)
isin_8az = sin(8*iaz)
icos_8el = cos(8*iel)
isin_8el = sin(8*iel)
i64 = ic81*icos_el_p8*isin_8az
i65 = ic82*isin_el*icos_el_p7*isin_7az
i66 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*isin_6az
i67 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*isin_5az
i68 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*isin_4az
i69 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*isin_3az
i70 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*isin_2az
i71 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*isin_az
i72 = (1/128)*(6435*isin_el_p8 - 12012*isin_el_p6 + 6930*isin_el_p4 - 1260*isin_el_p2 + 35)
i73 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*icos_az
i74 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*icos_2az
i75 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*icos_3az
i76 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*icos_4az
i77 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*icos_5az
i78 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*icos_6az
i79 = ic82*isin_el*icos_el_p7*icos_7az
i80 = ic81*icos_el_p8*icos_8az
;	if iorder > 7 goto c7
aout =	(1/9)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63 + 17*i64*a64 + 17*i65*a65 + 17*i66*a66 + 17*i67*a67 + 17*i68*a68 + 17*i69*a69 + 17*i70*a70 + 17*i71*a71 + 17*i72*a72 + 17*i73*a73 + 17*i74*a74 + 17*i75*a75 + 17*i76*a76 + 17*i77*a77 + 17*i78*a78 + 17*i79*a79 + 17*i80*a80)
end:
		xout			aout
endop

;;;;;;;;;;



opcode	ambi_dec_inph,	a,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn))
endop
opcode	ambi_dec_inph,	aa,ii
iorder,ifn xin
		xout				ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn))
endop
opcode	ambi_dec_inph,	aaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn))
endop
opcode	ambi_dec_inph,	aaaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn)),
		ambi_dec1_inph(iorder,table(7,ifn),table(8,ifn))
endop
opcode	ambi_dec_inph,	aaaaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn)),
		ambi_dec1_inph(iorder,table(7,ifn),table(8,ifn)),
		ambi_dec1_inph(iorder,table(9,ifn),table(10,ifn))
endop
opcode	ambi_dec_inph,	aaaaaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn)),
		ambi_dec1_inph(iorder,table(7,ifn),table(8,ifn)),
		ambi_dec1_inph(iorder,table(9,ifn),table(10,ifn)),
		ambi_dec1_inph(iorder,table(11,ifn),table(12,ifn))
endop
opcode	ambi_dec_inph,	aaaaaaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn)),
		ambi_dec1_inph(iorder,table(7,ifn),table(8,ifn)),
		ambi_dec1_inph(iorder,table(9,ifn),table(10,ifn)),
		ambi_dec1_inph(iorder,table(11,ifn),table(12,ifn)),									ambi_dec1_inph(iorder,table(13,ifn),table(14,ifn))
endop
opcode	ambi_dec_inph,	aaaaaaaa,ii
iorder,ifn xin
		xout		ambi_dec1_inph(iorder,table(1,ifn),table(2,ifn)),
		ambi_dec1_inph(iorder,table(3,ifn),table(4,ifn)),
		ambi_dec1_inph(iorder,table(5,ifn),table(6,ifn)),
		ambi_dec1_inph(iorder,table(7,ifn),table(8,ifn)),
		ambi_dec1_inph(iorder,table(9,ifn),table(10,ifn)),
		ambi_dec1_inph(iorder,table(11,ifn),table(12,ifn)),								ambi_dec1_inph(iorder,table(13,ifn),table(14,ifn)),
		ambi_dec1_inph(iorder,table(15,ifn),table(16,ifn))
endop

;;;;;;;;;;;;


opcode	ambi_write_B,	k, Sii
Sname,iorder,iformat		xin
	if(iorder == 1) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3)
	elseif(iorder == 2) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
	zar(7),zar(8)
	elseif(iorder == 3) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15)
	elseif(iorder == 4) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15),zar(16),zar(17),zar(18),zar(19),zar(20),zar(21),zar(22),zar(23),zar(24)
	elseif(iorder == 5) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15),zar(16),zar(17),zar(18),zar(19),zar(20),zar(21),zar(22),zar(23),zar(24),zar(25),zar(26),zar(27),zar(28),zar(29),zar(30),zar(31),zar(32),zar(33),zar(34),zar(35)
	elseif(iorder == 6) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15),zar(16),zar(17),zar(18),zar(19),zar(20),zar(21),zar(22),zar(23),zar(24),zar(25),zar(26),zar(27),zar(28),zar(29),zar(30),zar(31),zar(32),zar(33),zar(34),zar(35),zar(36),zar(37),zar(38),zar(39),zar(40),zar(41),zar(42),zar(43),zar(44),zar(45),zar(46),zar(47),zar(48)
	elseif(iorder == 7) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15),zar(16),zar(17),zar(18),zar(19),zar(20),zar(21),zar(22),zar(23),zar(24),zar(25),zar(26),zar(27),zar(28),zar(29),zar(30),zar(31),zar(32),zar(33),zar(34),zar(35),zar(36),zar(37),zar(38),zar(39),zar(40),zar(41),zar(42),zar(43),zar(44),zar(45),zar(46),zar(47),zar(48),zar(49),zar(50),zar(51),zar(52),zar(53),zar(54),zar(55),zar(56),zar(57),zar(58),zar(59),zar(60),zar(61),zar(62),zar(63)
	elseif(iorder == 8) then
	fout	Sname,iformat,zar(0),zar(1),zar(2),zar(3),zar(4),zar(5),zar(6),
zar(7),zar(8),zar(9),zar(10),zar(11),zar(12),zar(13),zar(14),zar(15),zar(16),zar(17),zar(18),zar(19),zar(20),zar(21),zar(22),zar(23),zar(24),zar(25),zar(26),zar(27),zar(28),zar(29),zar(30),zar(31),zar(32),zar(33),zar(34),zar(35),zar(36),zar(37),zar(38),zar(39),zar(40),zar(41),zar(42),zar(43),zar(44),zar(45),zar(46),zar(47),zar(48),zar(49),zar(50),zar(51),zar(52),zar(53),zar(54),zar(55),zar(56),zar(57),zar(58),zar(59),zar(60),zar(61),zar(62),zar(63),zar(64),zar(65),zar(66),zar(67),zar(68),zar(69),zar(70),zar(71),zar(72),zar(73),zar(74),zar(75),zar(76),zar(77),zar(78),zar(79),zar(80)
	endif
xout 0
endop

;;;;;;;;;;;


opcode	ambi_read_B, k,	Si
Sname,iorder			xin
if(iorder == 1) then

a1,a2,a3,a4	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
endif
if(iorder == 2) then
a1,a2,a3,a4,a5,a6,a7,a8,a9	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
endif
if(iorder == 3) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
endif
if(iorder == 4) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
	zawm	a17,16
	zawm	a18,17
	zawm	a19,18
	zawm	a20,19
	zawm	a21,20
	zawm	a22,21
	zawm	a23,22
	zawm	a24,23
	zawm	a25,24
endif
if(iorder == 5) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
	zawm	a17,16
	zawm	a18,17
	zawm	a19,18
	zawm	a20,19
	zawm	a21,20
	zawm	a22,21
	zawm	a23,22
	zawm	a24,23
	zawm	a25,24
	zawm	a26,25
	zawm	a27,26
	zawm	a28,27
	zawm	a29,28
	zawm	a30,29
	zawm	a31,30
	zawm	a32,31
	zawm	a33,32
	zawm	a34,33
	zawm	a35,34
	zawm	a36,35
endif
if(iorder == 6) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
	zawm	a17,16
	zawm	a18,17
	zawm	a19,18
	zawm	a20,19
	zawm	a21,20
	zawm	a22,21
	zawm	a23,22
	zawm	a24,23
	zawm	a25,24
	zawm	a26,25
	zawm	a27,26
	zawm	a28,27
	zawm	a29,28
	zawm	a30,29
	zawm	a31,30
	zawm	a32,31
	zawm	a33,32
	zawm	a34,33
	zawm	a35,34
	zawm	a36,35
	zawm	a37,36
	zawm	a38,37
	zawm	a39,38
	zawm	a40,39
	zawm	a41,40
	zawm	a42,41
	zawm	a43,42
	zawm	a44,43
	zawm	a45,44
	zawm	a46,45
	zawm	a47,46
	zawm	a48,47
	zawm	a49,48
endif
if(iorder == 7) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
	zawm	a17,16
	zawm	a18,17
	zawm	a19,18
	zawm	a20,19
	zawm	a21,20
	zawm	a22,21
	zawm	a23,22
	zawm	a24,23
	zawm	a25,24
	zawm	a26,25
	zawm	a27,26
	zawm	a28,27
	zawm	a29,28
	zawm	a30,29
	zawm	a31,30
	zawm	a32,31
	zawm	a33,32
	zawm	a34,33
	zawm	a35,34
	zawm	a36,35
	zawm	a37,36
	zawm	a38,37
	zawm	a39,38
	zawm	a40,39
	zawm	a41,40
	zawm	a42,41
	zawm	a43,42
	zawm	a44,43
	zawm	a45,44
	zawm	a46,45
	zawm	a47,46
	zawm	a48,47
	zawm	a49,48
	zawm	a50,49
	zawm	a51,50
	zawm	a52,51
	zawm	a53,52
	zawm	a54,53
	zawm	a55,54
	zawm	a56,55
	zawm	a57,56
	zawm	a58,57
	zawm	a59,58
	zawm	a60,59
	zawm	a61,60
	zawm	a62,61
	zawm	a63,62
	zawm	a64,63
endif
if(iorder == 8) then
a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64,a65,a66,a67,a68,a69,a70,a71,a72,a73,a74,a75,a76,a77,a78,a79,a80,a81	soundin Sname
	zawm	a1,0
	zawm	a2,1
	zawm	a3,2
	zawm	a4,3
	zawm	a5,4
	zawm	a6,5
	zawm	a7,6
	zawm	a8,7
	zawm	a9,8
	zawm	a10,9
	zawm	a11,10
	zawm	a12,11
	zawm	a13,12
	zawm	a14,13
	zawm	a15,14
	zawm	a16,15
	zawm	a17,16
	zawm	a18,17
	zawm	a19,18
	zawm	a20,19
	zawm	a21,20
	zawm	a22,21
	zawm	a23,22
	zawm	a24,23
	zawm	a25,24
	zawm	a26,25
	zawm	a27,26
	zawm	a28,27
	zawm	a29,28
	zawm	a30,29
	zawm	a31,30
	zawm	a32,31
	zawm	a33,32
	zawm	a34,33
	zawm	a35,34
	zawm	a36,35
	zawm	a37,36
	zawm	a38,37
	zawm	a39,38
	zawm	a40,39
	zawm	a41,40
	zawm	a42,41
	zawm	a43,42
	zawm	a44,43
	zawm	a45,44
	zawm	a46,45
	zawm	a47,46
	zawm	a48,47
	zawm	a49,48
	zawm	a50,49
	zawm	a51,50
	zawm	a52,51
	zawm	a53,52
	zawm	a54,53
	zawm	a55,54
	zawm	a56,55
	zawm	a57,56
	zawm	a58,57
	zawm	a59,58
	zawm	a60,59
	zawm	a61,60
	zawm	a62,61
	zawm	a63,62
	zawm	a64,63
	zawm	a65,64
	zawm	a66,65
	zawm	a67,66
	zawm	a68,67
	zawm	a69,68
	zawm	a70,69
	zawm	a71,70
	zawm	a72,71
	zawm	a73,72
	zawm	a74,73
	zawm	a75,74
	zawm	a76,75
	zawm	a77,76
	zawm	a78,77
	zawm	a79,78
	zawm	a80,79
	zawm	a81,80
endif
kZero = 0
	xout kZero
endop

;;;;;;;;;;;;

opcode xyz_to_aed, kkk, kkk
kx,ky,kz		xin
kdist =	sqrt(kx*kx+ky*ky+kz*kz)
kaz 		taninv2	ky,kx
kel			taninv2	kz,sqrt(kx*kx+ky*ky)
			xout		kaz, kel, kdist
endop


;;;;Array ops -- hack by Christopher Poovey

opcode	ambi_enc_dista, a[], aikkk

asnd,iorder,kaz,kel,kdist	xin
iChans = pow(iorder+1,2)
aOut[] init iChans

kaz = $M_PI*kaz/180
kel = $M_PI*kel/180

kaz	=		(kdist < 0 ? kaz + $M_PI : kaz)
kel	=		(kdist < 0 ? -kel : kel)
kdist =	abs(kdist)+0.000001
kgainW	=	taninv(kdist*1.5707963) / (kdist*1.5708)
kgainHO =	(1 - exp(-kdist)) ;*kgainW
	outvalue "kgainHO", kgainHO
	outvalue "kgainW", kgainW
kcos_el = cos(kel)
ksin_el = sin(kel)
kcos_az = cos(kaz)
ksin_az = sin(kaz)

;;Order1
asnd =		kgainW*asnd
	aOut[0] =	asnd							; W
asnd = 	kgainHO*asnd
	aOut[1] =	kcos_el*ksin_az*asnd		; Y	 = Y(1,-1)
	aOut[2] =	ksin_el*asnd				; Z	 = Y(1,0)
	aOut[3] =	kcos_el*kcos_az*asnd	; X	 = Y(1,1)


;;Order 2
	if		iorder < 2 goto	end

i2	= sqrt(3)/2
kcos_el_p2 = kcos_el*kcos_el
ksin_el_p2 = ksin_el*ksin_el
kcos_2az = cos(2*kaz)
ksin_2az = sin(2*kaz)
kcos_2el = cos(2*kel)
ksin_2el = sin(2*kel)

	aOut[4] = i2*kcos_el_p2*ksin_2az*asnd	; V = Y(2,-2)
	aOut[5] = i2*ksin_2el*ksin_az*asnd		; S = Y(2,-1)
	aOut[6] = .5*(3*ksin_el_p2 - 1)*asnd		; R = Y(2,0)
	aOut[7] = i2*ksin_2el*kcos_az*asnd		; S = Y(2,1)
	aOut[8] = i2*kcos_el_p2*kcos_2az*asnd	; U = Y(2,2)


;;Order 3
	if		iorder < 3 goto	end

i31 = sqrt(5/8)
i32 = sqrt(15)/2
i33 = sqrt(3/8)

kcos_el_p3 = kcos_el*kcos_el_p2
ksin_el_p3 = ksin_el*ksin_el_p2
kcos_3az = cos(3*kaz)
ksin_3az = sin(3*kaz)
kcos_3el = cos(3*kel)
ksin_3el = sin(3*kel)

aOut[9]= i31*kcos_el_p3*ksin_3az*asnd				; Q = Y(3,-3)
aOut[10]= i32*ksin_el*kcos_el_p2*ksin_2az*asnd		; O = Y(3,-2)
aOut[11]= i33*kcos_el*(5*ksin_el_p2-1)*ksin_az*asnd	; M = Y(3,-1)
aOut[12]= .5*ksin_el*(5*ksin_el_p2-3)*asnd			; K = Y(3,0)
aOut[13]= i33*kcos_el*(5*ksin_el_p2-1)*kcos_az*asnd	; L = Y(3,1)
aOut[14]= i32*ksin_el*kcos_el_p2*kcos_2az*asnd	; N = Y(3,2)
aOut[15]= i31*kcos_el_p3*kcos_3az*asnd					; P = Y(3,3)

;; Order 4

	if		iorder < 4 goto	end

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
kcos_el_p4 = kcos_el*kcos_el_p3
ksin_el_p4 = ksin_el*ksin_el_p3
kcos_4az = cos(4*kaz)
ksin_4az = sin(4*kaz)
kcos_4el = cos(4*kel)
ksin_4el = sin(4*kel)
aOut[16]= ic41*kcos_el_p4*ksin_4az*asnd						; Y(4,-4)
aOut[17]= ic42*ksin_el*kcos_el_p3*ksin_3az*asnd					; Y(4,-3)
aOut[18]= ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*ksin_2az*asnd	; Y(4,-2)
aOut[19]= ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*ksin_az*asnd		; Y(4,-1)
aOut[20]= (1/8)*(35.*ksin_el_p4 - 30.*ksin_el_p2 + 3.)*asnd	; Y(4,0)
aOut[21]= ic44*ksin_2el*(7.*ksin_el_p2 - 3.)*kcos_az*asnd		; Y(4,1)
aOut[22]= ic43*(7.*ksin_el_p2 - 1.)*kcos_el_p2*kcos_2az*asnd	; Y(4,2)
aOut[23]= ic42*ksin_el*kcos_el_p3*kcos_3az*asnd					; Y(4,3)
aOut[24]= ic41*kcos_el_p4*kcos_4az*asnd						; Y(4,4)

;Order 5

	if		iorder < 5 goto	end

ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
kcos_el_p5 = kcos_el*kcos_el_p4
ksin_el_p5 = ksin_el*ksin_el_p4
kcos_5az = cos(5*kaz)
ksin_5az = sin(5*kaz)
kcos_5el = cos(5*kel)
ksin_5el = sin(5*kel)
aOut[25]= ic51*kcos_el_p5*ksin_5az*asnd									; Y(5,-5)
aOut[26]= ic52*ksin_el*kcos_el_p4*ksin_4az*asnd								; Y(5,-4)
aOut[27]= ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*ksin_3az*asnd					; Y(5,-3)
aOut[28]= ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*ksin_2az*asnd	; Y(5,-2)
aOut[29]= ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*ksin_az*asnd	; Y(5,-1)
aOut[30]= (1/8)*(63*ksin_el_p5 - 70*ksin_el_p3 + 15*ksin_el)*asnd		; Y(5,0)
aOut[31]= ic55*(21*ksin_el_p4 - 14*ksin_el_p3 + 1)*kcos_el*kcos_az*asnd	; Y(5,1)
aOut[32]= ic54*ksin_el*(3*ksin_el_p2 - 1)*kcos_el_p2*kcos_2az*asnd		; Y(5,2)
aOut[33]= ic53*(9*ksin_el_p2 - 1)*kcos_el_p3*kcos_3az*asnd				; Y(5,3)
aOut[34]= ic52*ksin_el*kcos_el_p4*kcos_4az*asnd								; Y(5,4)
aOut[35]= ic51*kcos_el_p5*kcos_5az*asnd									; Y(5,5)

;Order 6

	if		iorder < 6 goto	end

ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
kcos_el_p6 = kcos_el*kcos_el_p5
ksin_el_p6 = ksin_el*ksin_el_p5
kcos_6az = cos(6*kaz)
ksin_6az = sin(6*kaz)
kcos_6el = cos(6*kel)
ksin_6el = sin(6*kel)
aOut[36]= ic61*kcos_el_p6*ksin_6az*asnd
aOut[37]= ic62*ksin_el*kcos_el_p5*ksin_5az*asnd
aOut[38]= ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*ksin_4az*asnd
aOut[39]= ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*ksin_3az*asnd
aOut[40]= ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*ksin_2az*asnd
aOut[41]= ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*ksin_az*asnd
aOut[42]= (1/16)*(231*ksin_el_p6 - 315*ksin_el_p4 + 105*ksin_el_p2 - 5)*asnd
aOut[43]= ic66*ksin_2el*(33*ksin_el_p4 - 30*ksin_el_p2 + 5)*kcos_az*asnd
aOut[44]= ic65*((33*ksin_el_p4) - 18*ksin_el_p2 + 1)*kcos_el_p2*kcos_2az*asnd
aOut[45]= ic64*ksin_el*(11*ksin_el_p2 - 3)*kcos_el_p3*kcos_3az*asnd
aOut[46]= ic63*(11*ksin_el_p2 - 1)*kcos_el_p4*kcos_4az*asnd
aOut[47]= ic62*ksin_el*kcos_el_p5*kcos_5az*asnd
aOut[48]= ic61*kcos_el_p6*kcos_6az*asnd

;Order 7

	if		iorder < 7 goto	end
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
kcos_el_p7 = kcos_el*kcos_el_p6
ksin_el_p7 = ksin_el*ksin_el_p6
kcos_7az = cos(7*kaz)
ksin_7az = sin(7*kaz)
kcos_7el = cos(7*kel)
ksin_7el = sin(7*kel)
aOut[49]= ic71*kcos_el_p7*ksin_7az*asnd
aOut[50]= ic72*ksin_el*kcos_el_p6*ksin_6az*asnd
aOut[51]= ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*ksin_5az*asnd
aOut[52]= ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*ksin_4az*asnd
aOut[53]= ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*ksin_3az*asnd
aOut[54]= ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*ksin_2az*asnd
aOut[55]= ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*ksin_az*asnd
aOut[56]= (1/16)*(429*ksin_el_p7 - 693*ksin_el_p5 + 315*ksin_el_p3 - 35*ksin_el)*asnd
aOut[57]= ic77*(429*ksin_el_p6 - 495*ksin_el_p4 + 135*ksin_el_p2 - 5)*kcos_el*kcos_az*asnd
aOut[58]= ic76*(143*ksin_el_p5 - 110*ksin_el_p3 + 15*ksin_el)*kcos_el_p2*kcos_2az*asnd
aOut[59]= ic75*(143*ksin_el_p4 - 66*ksin_el_p2 + 3)*kcos_el_p3*kcos_3az*asnd
aOut[60]= ic74*(13*ksin_el_p3 - 3*ksin_el)*kcos_el_p4*kcos_4az*asnd
aOut[61]= ic73*(13*ksin_el_p2 - 1)*kcos_el_p5*kcos_5az*asnd
aOut[62]= ic72*ksin_el*kcos_el_p6*kcos_6az*asnd
aOut[63]= ic71*kcos_el_p7*kcos_7az*asnd

end:

		xout	aOut
endop


opcode	ambi_decode1, a[], a[]iii

ambi, iorder,iaz,iel	xin

iaz = $M_PI*iaz/180
iel = $M_PI*iel/180

a0= ambi[0]
	if	iorder > 0 goto c0
aout = a0
	goto	end
c0:
a1= ambi[1]
a2= ambi[2]
a3= ambi[3]
icos_el = cos(iel)
isin_el = sin(iel)
icos_az = cos(iaz)
isin_az = sin(iaz)
i1	=	icos_el*isin_az			; Y	 = Y(1,-1)
i2	=	isin_el					; Z	 = Y(1,0)
i3	=	icos_el*icos_az			; X	 = Y(1,1)
	if iorder > 1 goto c1
aout	=	(1/2)*(a0 + i1*a1 + i2*a2 + i3*a3)
	goto end
c1:
a4=zar(4)
a5=zar(5)
a6=zar(6)
a7=zar(7)
a8=zar(8)

ic2	= sqrt(3)/2

icos_el_p2 = icos_el*icos_el
isin_el_p2 = isin_el*isin_el
icos_2az = cos(2*iaz)
isin_2az = sin(2*iaz)
icos_2el = cos(2*iel)
isin_2el = sin(2*iel)


i4 = ic2*icos_el_p2*isin_2az	; V = Y(2,-2)
i5	= ic2*isin_2el*isin_az		; S = Y(2,-1)
i6 = .5*(3*isin_el_p2 - 1)		; R = Y(2,0)
i7 = ic2*isin_2el*icos_az		; S = Y(2,1)
i8 = ic2*icos_el_p2*icos_2az	; U = Y(2,2)
	if iorder > 2 goto c2
aout	=	(1/9)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8)
	goto end
c2:
a9=zar(9)
a10=zar(10)
a11=zar(11)
a12=zar(12)
a13=zar(13)
a14=zar(14)
a15=zar(15)

ic31 = sqrt(5/8)
ic32 = sqrt(15)/2
ic33 = sqrt(3/8)
icos_el_p3 = icos_el*icos_el_p2;
isin_el_p3 = isin_el*isin_el_p2;
icos_3az = cos(3*iaz);
isin_3az = sin(3*iaz);
icos_3el = cos(3*iel);
isin_3el = sin(3*iel);

i9 = ic31*icos_el_p3*isin_3az					; Q = Y(3,-3)
i10 = ic32*isin_el*icos_el_p2*isin_2az		; O = Y(3,-2)
i11 = ic33*icos_el*(5*isin_el_p2-1)*isin_az	; M = Y(3,-1)
i12 = .5*isin_el*(5*isin_el_p2-3)				; K = Y(3,0)
i13 = ic33*icos_el*(5*isin_el_p2-1)*icos_az	; L = Y(3,1)
i14 = ic32*isin_el*icos_el_p2*icos_2az		; N = Y(3,2)
i15 = ic31*icos_el_p3*icos_3az				; P = Y(3,3)
	if iorder > 3 goto c3
aout	=	(1/16)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15)
	goto end
c3:
a16=zar(16)
a17=zar(17)
a18=zar(18)
a19=zar(19)
a20=zar(20)
a21=zar(21)
a22=zar(22)
a23=zar(23)
a24=zar(24)

ic41 = (1/8)*sqrt(35)
ic42 =	(1/2)*sqrt(35/2)
ic43 = sqrt(5)/4
ic44 = sqrt(5/2)/4
icos_el_p4 = icos_el*icos_el_p3
isin_el_p4 = isin_el*isin_el_p3
icos_4az = cos(4*iaz)
isin_4az = sin(4*iaz)
icos_4el = cos(4*iel)
isin_4el = sin(4*iel)
i16 = ic41*icos_el_p4*isin_4az							; Y(4,-4)
i17 = ic42*isin_el*icos_el_p3*isin_3az					; Y(4,-3)
i18 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*isin_2az	; Y(4,-2)
i19 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*isin_az		; Y(4,-1)
i20 = (1/8)*(35.*isin_el_p4 - 30.*isin_el_p2 + 3.)	; Y(4,0)
i21 = ic44*isin_2el*(7.*isin_el_p2 - 3.)*icos_az		; Y(4,1)
i22 = ic43*(7.*isin_el_p2 - 1.)*icos_el_p2*icos_2az	; Y(4,2)
i23 = ic42*isin_el*icos_el_p3*icos_3az					; Y(4,3)
i24 = ic41*icos_el_p4*icos_4az							; Y(4,4)

	if iorder > 4 goto c4
aout	=	(1/25)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24)
	goto end
c4:

a25=zar(25)
a26=zar(26)
a27=zar(27)
a28=zar(28)
a29=zar(29)
a30=zar(30)
a31=zar(31)
a32=zar(32)
a33=zar(33)
a34=zar(34)
a35=zar(35)
ic51 = (3/8)*sqrt(7/2)
ic52 = (3/8)*sqrt(35)
ic53 = (1/8)*sqrt(35/2)
ic54 = sqrt(105)/4
ic55 = sqrt(15)/8
icos_el_p5 = icos_el*icos_el_p4
isin_el_p5 = isin_el*isin_el_p4
icos_5az = cos(5*iaz)
isin_5az = sin(5*iaz)
icos_5el = cos(5*iel)
isin_5el = sin(5*iel)
i25 = ic51*icos_el_p5*isin_5az										; Y(5,-5)
i26 = ic52*isin_el*icos_el_p4*isin_4az								; Y(5,-4)
i27 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*isin_3az					; Y(5,-3)
i28 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*isin_2az		; Y(5,-2)
i29 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*isin_az	; Y(5,-1)
i30 = (1/8)*(63*isin_el_p5 - 70*isin_el_p3 + 15*isin_el)			; Y(5,0)
i31 = ic55*(21*isin_el_p4 - 14*isin_el_p3 + 1)*icos_el*icos_az	; Y(5,1)
i32 = ic54*isin_el*(3*isin_el_p2 - 1)*icos_el_p2*icos_2az;		; Y(5,2)
i33 = ic53*(9*isin_el_p2 - 1)*icos_el_p3*icos_3az					; Y(5,3)
i34 = ic52*isin_el*icos_el_p4*icos_4az								; Y(5,4)
i35 = ic51*icos_el_p5*icos_5az										; Y(5,5)
	if iorder > 5 goto c5
aout =	(1/36)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35)
	goto end
c5:

a36=zar(36)
a37=zar(37)
a38=zar(38)
a39=zar(39)
a40=zar(40)
a41=zar(41)
a42=zar(42)
a43=zar(43)
a44=zar(44)
a45=zar(45)
a46=zar(46)
a47=zar(47)
a48=zar(48)
ic61 = (1/16)*sqrt(231/2)
ic62 = (3/8)*sqrt(77/2)
ic63 = (3/16)*sqrt(7)
ic64 = (1/8)*sqrt(105/2)
ic65 = (1/16)*sqrt(105/2)
ic66 = (1/16)*sqrt(21)
icos_el_p6 = icos_el*icos_el_p5
isin_el_p6 = isin_el*isin_el_p5
icos_6az = cos(6*iaz)
isin_6az = sin(6*iaz)
icos_6el = cos(6*iel)
isin_6el = sin(6*iel)
i36 = ic61*icos_el_p6*isin_6az
i37 = ic62*isin_el*icos_el_p5*isin_5az
i38 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*isin_4az
i39 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*isin_3az
i40 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*isin_2az
i41 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*isin_az
i42 = (1/16)*(231*isin_el_p6 - 315*isin_el_p4 + 105*isin_el_p2 - 5)
i43 = ic66*isin_2el*(33*isin_el_p4 - 30*isin_el_p2 + 5)*icos_az
i44 = ic65*((33*isin_el_p4) - 18*isin_el_p2 + 1)*icos_el_p2*icos_2az
i45 = ic64*isin_el*(11*isin_el_p2 - 3)*icos_el_p3*icos_3az
i46 = ic63*(11*isin_el_p2 - 1)*icos_el_p4*icos_4az
i47 = ic62*isin_el*icos_el_p5*icos_5az
i48 = ic61*icos_el_p6*icos_6az
	if iorder > 6 goto c6
aout =	(1/49)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48)
	goto end
c6:
a49=zar(49)
a50=zar(50)
a51=zar(51)
a52=zar(52)
a53=zar(53)
a54=zar(54)
a55=zar(55)
a56=zar(56)
a57=zar(57)
a58=zar(58)
a59=zar(59)
a60=zar(60)
a61=zar(61)
a62=zar(62)
a63=zar(63)
ic71 = (3/32)*sqrt(143/3)
ic72 = (3/16)*sqrt(101/3)
ic73 = (3/32)*sqrt(77/3)
ic74 = (3/16)*sqrt(77/3)
ic75 = (3/32)*sqrt(7/3)
ic76 = (3/16)*sqrt(7/6)
ic77 = (1/32)*sqrt(7)
icos_el_p7 = icos_el*icos_el_p6
isin_el_p7 = isin_el*isin_el_p6
icos_7az = cos(7*iaz)
isin_7az = sin(7*iaz)
icos_7el = cos(7*iel)
isin_7el = sin(7*iel)
i49 = ic71*icos_el_p7*isin_7az
i50 = ic72*isin_el*icos_el_p6*isin_6az
i51 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*isin_5az
i52 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*isin_4az
i53 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*isin_3az
i54 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*isin_2az
i55 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*isin_az
i56 = (1/16)*(429*isin_el_p7 - 693*isin_el_p5 + 315*isin_el_p3 - 35*isin_el)
i57 = ic77*(429*isin_el_p6 - 495*isin_el_p4 + 135*isin_el_p2 - 5)*icos_el*icos_az
i58 = ic76*(143*isin_el_p5 - 110*isin_el_p3 + 15*isin_el)*icos_el_p2*icos_2az
i59 = ic75*(143*isin_el_p4 - 66*isin_el_p2 + 3)*icos_el_p3*icos_3az
i60 = ic74*(13*isin_el_p3 - 3*isin_el)*icos_el_p4*icos_4az
i61 = ic73*(13*isin_el_p2 - 1)*icos_el_p5*icos_5az
i62 = ic72*isin_el*icos_el_p6*icos_6az
i63 = ic71*icos_el_p7*icos_7az
	if iorder > 7 goto c7
aout =	(1/64)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63)
	goto end
c7:
a64=zar(64)
a65=zar(65)
a66=zar(66)
a67=zar(67)
a68=zar(68)
a69=zar(69)
a70=zar(70)
a71=zar(71)
a72=zar(72)
a73=zar(73)
a74=zar(74)
a75=zar(75)
a76=zar(76)
a77=zar(77)
a78=zar(78)
a79=zar(79)
a80=zar(80)
ic81 = (3/128)*sqrt(715)
ic82 = (3/32)*sqrt(715)
ic83 = (1/32)*sqrt(429/2)
ic84 = (3/32)*sqrt(1001)
ic85 = (3/64)*sqrt(77)
ic86 = (1/32)*sqrt(1155)
ic87 = (3/32)*sqrt(35/2)
ic88 = (3/32)
icos_el_p8 = icos_el*icos_el_p7
isin_el_p8 = isin_el*isin_el_p7
icos_8az = cos(8*iaz)
isin_8az = sin(8*iaz)
icos_8el = cos(8*iel)
isin_8el = sin(8*iel)
i64 = ic81*icos_el_p8*isin_8az
i65 = ic82*isin_el*icos_el_p7*isin_7az
i66 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*isin_6az
i67 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*isin_5az
i68 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*isin_4az
i69 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*isin_3az
i70 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*isin_2az
i71 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*isin_az
i72 = (1/128)*(6435*isin_el_p8 - 12012*isin_el_p6 + 6930*isin_el_p4 - 1260*isin_el_p2 + 35)
i73 = ic88*(715*isin_el_p7 - 1001*isin_el_p5 + 385*isin_el_p3 - 35*isin_el)*icos_el*icos_az
i74 = ic87*(143*isin_el_p6 - 143*isin_el_p4 + 33*isin_el_p2 - 1)*icos_el_p2*icos_2az
i75 = ic86*(39*isin_el_p5 - 26*isin_el_p3 + 3*isin_el)*icos_el_p3*icos_3az
i76 = ic85*(65*isin_el_p4 - 26*isin_el_p2 + 1)*icos_el_p4*icos_4az
i77 = ic84*(5*isin_el_p3 - isin_el)*icos_el_p5*icos_5az
i78 = ic83*(15*isin_el_p2 - 1)*icos_el_p6*icos_6az
i79 = ic82*isin_el*icos_el_p7*icos_7az
i80 = ic81*icos_el_p8*icos_8az
;	if iorder > 7 goto c7
aout =	(1/81)*(a0 + 3*i1*a1 + 3*i2*a2 + 3*i3*a3 + 5*i4*a4 + 5*i5*a5 + 5*i6*a6 + 5*i7*a7 + 5*i8*a8 + 7*i9*a9 + 7*i10*a10 + 7*i11*a11 + 7*i12*a12 + 7*i13*a13 + 7*i14*a14 + 7*i15*a15 + 9*i16*a16 + 9*i17*a17 + 9*i18*a18 + 9*i19*a19 + 9*i20*a20 + 9*i21*a21 + 9*i22*a22 + 9*i23*a23 + 9*i24*a24 + 11*i25*a25 + 11*i26*a26 + 11*i27*a27 + 11*i28*a28 + 11*i29*a29 + 11*i30*a30 + 11*i31*a31 + 11*i32*a32 + 11*i33*a33 + 11*i34*a34 + 11*i35*a35 + 13*i36*a36 + 13*i37*a37 + 13*i38*a38 + 13*i39*a39 + 13*i40*a40 + 13*i41*a41 + 13*i42*a42 + 13*i43*a43 + 13*i44*a44 + 13*i45*a45 + 13*i46*a46 + 13*i47*a47 + 13*i48*a48 + 15*i49*a49 + 15*i50*a50 + 15*i51*a51 + 15*i52*a52 + 15*i53*a53 + 15*i54*a54 + 15*i55*a55 + 15*i56*a56 + 15*i57*a57 + 15*i58*a58 + 15*i59*a59 + 15*i60*a60 + 15*i61*a61 + 15*i62*a62 + 15*i63*a63 + 17*i64*a64 + 17*i65*a65 + 17*i66*a66 + 17*i67*a67 + 17*i68*a68 + 17*i69*a69 + 17*i70*a70 + 17*i71*a71 + 17*i72*a72 + 17*i73*a73 + 17*i74*a74 + 17*i75*a75 + 17*i76*a76 + 17*i77*a77 + 17*i78*a78 + 17*i79*a79 + 17*i80*a80)
end:
		xout			aout
endop
;;;;;;;;;;;

opcode	ambi_decode,	a[],a[]ii
iorder,ifn xin
		xout		ambi_decode1(iorder,table(1,ifn),table(2,ifn)),
		ambi_decode1(iorder,table(3,ifn),table(4,ifn)),
		ambi_decode1(iorder,table(5,ifn),table(6,ifn)),
		ambi_decode1(iorder,table(7,ifn),table(8,ifn)),
		ambi_decode1(iorder,table(9,ifn),table(10,ifn)),
		ambi_decode1(iorder,table(11,ifn),table(12,ifn)),
		ambi_decode1(iorder,table(13,ifn),table(14,ifn)),
		ambi_decode1(iorder,table(15,ifn),table(16,ifn))
endop


</CsInstruments>
</CsoundSynthesizer>
