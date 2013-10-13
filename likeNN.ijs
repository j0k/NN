NB. WARN. don't copy my J-style; i'm still J-n0b

NB. it's smth like neural networks. 
NB. not grad thinking

NB. in> --- (r|v) -->[N p:a] ---> out
NB. r - rename in : v <- in
NB. N - neuron

NB. let's see on most simple case: fa (x) = ax
fa =: {. * {:			NB. a*x 

NB. type NN 1
NN1 =: 10;0.01

evalNN1 =: 4 : 0
       a =. > 0{x
       v  =. y
       fa a , v
)
NB. e
NN1 evalNN1 2

learnNN1 =: 4 : 0
	 'a nu' =. nn =. x
	 for_val. y do.
	   v   =. 0{>val
	   q   =. fa @: (,&v)
	   dW  =. (q D. 1) a	NB. dFa/da
	   nnN =. a;nu
	   R   =. (1{>val)
	   a   =. a + nu * ((nnN evalNN1 v) - R) *  (- dW)
	 end.
	 a;nu
)

faR =: 2: * ]			NB.we want 2 learn it
]Lseq =: (],faR) L:0 (<"0) 1+i.10	NB.example inputs


NB. ┌───┬───┬───┬───┬────┬────┬────┬────┬────┬─────┐
NB. │1 2│2 4│3 6│4 8│5 10│6 12│7 14│8 16│9 18│10 20│
NB. └───┴───┴───┴───┴────┴────┴────┴────┴────┴─────┘
      
NN1;<NN1 learnNN1 Lseq


NB. ┌─────────┬────────┐
NB. │┌──┬────┐│┌─┬────┐│
NB. ││10│0.01│││2│0.01││
NB. │└──┴────┘│└─┴────┘│
NB. └─────────┴────────┘

tableNN1 =: 4 : 0		NB.proc of learn
	 'a nu' =. nn =. x
	 R =. 0 4 $ ''
	 for_v. y do.
	   nn =. nn learnNN1 v
	   vr =. nn evalNN1 (0{>v)
	   E  =. vr - (1{>v)
	   R  =. R, (v_index;(>0{nn);vr;E)
	 end.
	 R	 
)


NN1 learnNN1 Lseq
NN1 tableNN1 Lseq
NB.  i a       R(es)   E(rror)
NB. ┌─┬───────┬───────┬───────────┐
NB. │0│9.92   │9.92   │7.92       │
NB. ├─┼───────┼───────┼───────────┤
NB. │1│9.6032 │19.2064│15.2064    │
NB. ├─┼───────┼───────┼───────────┤
NB. │2│8.91891│26.7567│20.7567    │
NB. ├─┼───────┼───────┼───────────┤
NB. │3│7.81189│31.2475│23.2475    │
NB. ├─┼───────┼───────┼───────────┤
NB. │4│6.35891│31.7946│21.7946    │
NB. ├─┼───────┼───────┼───────────┤
NB. │5│4.78971│28.7382│16.7382    │
NB. ├─┼───────┼───────┼───────────┤
NB. │6│3.42275│23.9592│9.95925    │
NB. ├─┼───────┼───────┼───────────┤
NB. │7│2.51219│20.0975│4.09752    │
NB. ├─┼───────┼───────┼───────────┤
NB. │8│2.09732│18.8758│0.875845   │
NB. ├─┼───────┼───────┼───────────┤
NB. │9│2      │20     │9.37028e_11│
NB. └─┴───────┴───────┴───────────┘
      
NB. let's take another func
faR =: _17.7 * ]			NB.we want 2 learn it
]Lseq =: (],faR) L:0 (<"0) 1+i.10	NB.example inputs
NN1 tableNN1 Lseq	

NB. Lseq
NB. ┌───────┬───────┬───────┬───────┬───────┬────────┬────────┬────────┬────────┬───────┐
NB. │1 _17.7│2 _35.4│3 _53.1│4 _70.8│5 _88.5│6 _106.2│7 _123.9│8 _141.6│9 _159.3│10 _177│
NB. └───────┴───────┴───────┴───────┴───────┴────────┴────────┴────────┴────────┴───────┘

NB. table
NB. ┌─┬────────┬────────┬───────────┐
NB. │0│9.723   │9.723   │27.423     │
NB. ├─┼────────┼────────┼───────────┤
NB. │1│8.62608 │17.2522 │52.6522    │
NB. ├─┼────────┼────────┼───────────┤
NB. │2│6.25673 │18.7702 │71.8702    │
NB. ├─┼────────┼────────┼───────────┤
NB. │3│2.42366 │9.69462 │80.4946    │
NB. ├─┼────────┼────────┼───────────┤
NB. │4│_2.60726│_13.0363│75.4637    │
NB. ├─┼────────┼────────┼───────────┤
NB. │5│_8.04065│_48.2439│57.9561    │
NB. ├─┼────────┼────────┼───────────┤
NB. │6│_12.7737│_89.4161│34.4839    │
NB. ├─┼────────┼────────┼───────────┤
NB. │7│_15.9265│_127.412│14.1877    │
NB. ├─┼────────┼────────┼───────────┤
NB. │8│_17.363 │_156.267│3.03261    │
NB. ├─┼────────┼────────┼───────────┤
NB. │9│_17.7   │_177    │_4.79022e_9│
NB. └─┴────────┴────────┴───────────┘

	

load 'debug'
dbss 'learnNN1 *:*'
dbss 'tableNN1 *:*'
dbr 1
dbr 0				NB.