;Boucle principal du dessin,
;Permet d'entrer une commande de l'afficher
;et de quitter.
         CALL    canevas     ;
loop:    LDA     0,i         ;
         LDX     0,i         ;
         CHARI   command,d   ; command = lireChar()
         LDBYTEA command,d   ;
         CPA     'q',i       ;
         BREQ    fin         ; while(command != 'q') {
;vider canevas
         CPA     'z',i       ;
         BRNE    afficher    ;    if(command == 'z') {
         CALL    canevas     ;        canevas()
         BR      loop        ;
;afficher dessin
afficher:CPA     'a',i       ;
         BRNE    DesPoint    ;    }else if(command == 'a'){
         CALL    affiche     ;        affiche()
         BR      loop        ;
; dessiner un point
DesPoint:CPA     'p',i       ;
         BRNE    DesRect     ;    }else if(command == 'p'){
         CALL    point       ;        point()
         BR      loop        ;
;dessiner un rectangle
DesRect: CPA     'r',i       ;
         BRNE    DesSurf     ;    }else if(command == 'r'){
         CALL    rect        ;        rect()
         BR      loop        ;
;dessiner un rectangle remplit
DesSurf: CPA     'b',i       ;
         BRNE    segment     ;    }else if(command == 'b'){
         CALL    surface     ;        surface()
         BR      loop        ;
;dessiner un segement
segment: CPA     'l',i       ;
         BRNE    remplit     ;    }else if(command == 'l'){
         CALL    tracer      ;        tracer(l);
         BR      loop        ;
;remplire
remplit: CPA     'f',i       ;
         BRNE    loop        ;     }else if(command == 'f'){
         CALL    remplire    ;        remplit()
         BR      loop        ; }
;
;
;Fonction canevas
;Lorsqu'on appel cette methode on creer
;un canevas vide.
;
;Dessine le bas du canevas.
canevas: LDX     0,i         ;
         LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[0][0] = '+'
         ADDX    cx,d        ; c++
ligneBas:CPX     576,i       ;
         BRGT    suiteBas    ; while(c <= 33 ){
         LDBYTEA '-',i       ;
         STBYTEA dessin,x    ;    dessin[c][0] = '-'
         ADDX    cx,d        ;    c++
         BR      ligneBas    ; }
suiteBas:LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[33][0] = '+'
         ADDX    cx,d        ;  c++
;Partie pour dessiner les cotes gauche et droit
;et vider le milieu de canevas.
         LDX     1,i         ;
loopMid: STX     l,d         ;
         CPX     16,i        ;
         BRGT    lignHaut    ; while(l <= 16 ){
         LDX     0,i         ;
         ADDX    l,d         ;
         LDBYTEA 124,i       ;
         STBYTEA dessin,x    ;    dessin[c][l] = '|'
videMid: CPX     593,i       ;
         BRGT    suiteMid    ;    while(c <= 33){
         ADDX    cx,d        ;        c++
         LDBYTEA ' ',i       ;
         STBYTEA dessin,x    ;        dessin[c][l] = ' '
         BR      videMid     ;    }
suiteMid:LDBYTEA 124,i       ;
         STBYTEA dessin,x    ;    dessin[c][l] = '|'
         LDX     l,d         ;
         ADDX    1,i         ;    l++
         BR      loopMid     ;}
;Dessine le haut de canevas
lignHaut:LDX     17,i        ;
         LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[0][17] = '+'
         ADDX    cx,d        ;
loopHaut:CPX     593,i       ;
         BRGT    finCan      ; while(c <= 33){
         LDBYTEA '-',i       ;
         STBYTEA dessin,x    ;    dessin[c][17] = '-'
         ADDX    cx,d        ;    c++
         BR      loopHaut    ; }
finCan:  LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[33][17] = '+'
         RET0                ;
;
;
;Fonction Point
;Permet de dessiner un point
;a un endroit precis.
point:   CHARI   signe,d     ; signe = lireChar()
         DECI    colonne,d   ; colonne = lireInt()
         DECI    ligne,d     ; ligne = lireInt()
         CALL    plusUn      ;
         LDX     colonne,d   ;
         CPX     32,i        ;
         BRGT    finPoint    ; if( colonne <= 32){
         CPX     0,i         ;
         BRLT    finPoint    ;    if(colonne >= 0){
         LDX     ligne,d     ;
         CPX     16,i        ;
         BRGT    finPoint    ;        if(ligne <= 16){
         CPX     0,i         ;
         BRLT    finPoint    ;            if(ligne >= 0){
         CALL    cMulti      ;
dessinP: LDX     colonne,d   ;
         ADDX    ligne,d     ;
         LDBYTEA signe,d     ;
         STBYTEA dessin,x    ;                dessin[c][l] = signe
finPoint:RET0                ;}}}}
;
;
;Fonction rectangle
;Permet de dessiner un rectangle vide.
rect:    CHARI   signe,d     ; signe = lireChar()
         DECI    colonne,d   ; colonne = lireInt()
         DECI    ligne,d     ; ligne = lireInt()
         DECI    colonne2,d  ; colonne2 = lireInt()
         DECI    ligne2,d    ; ligne2 = lireInt()
         CALL    plusUn      ;
         CALL    cMulti      ;
         LDX     colonne,d   ;
         CPX     colonne2,d  ;
         BRLE    suiteRec    ; if(colonne > colonne2){
         LDA     colonne,d   ;
         LDX     colonne2,d  ;
         STA     colonne2,d  ;    colonne = colonne2
         STX     colonne,d   ;    colonne2 = colonne }
suiteRec:LDX     ligne,d     ;
         CPX     ligne2,d    ;
         BRLE    loopRect    ; if(ligne > ligne2){
         LDA     ligne,d     ;
         LDX     ligne2,d    ;
         STA     ligne2,d    ;    ligne = ligne2
         STX     ligne,d     ;    ligne2 = ligne }
;Loop pour dessiner le rectangle vide
loopRect:LDX     colonne,d   ;
         STX     cSync,d     ;
loopRecC:CPX     colonne2,d  ;
         BRGT    finRect     ; for(int cSync = colonne; cSync <= colonne2; c++){
         LDX     ligne,d     ;
         STX     lSync,d     ;
loopRecL:CPX     ligne2,d    ;
         BRGT    finRecL     ;    for(int lSync = ligne; lSync <= ligne2; l++){
;Validation que signe present dans canevas
         CPX     16,i        ;
         BRGT    passeRec    ;
         CPX     0,i         ;
         BRLE    passeRec    ;
         LDX     cSync,d     ;
         CPX     576,i       ;
         BRGT    passeRec    ;
         CPX     0,i         ;
         BRLE    passeRec    ;        if(lSync<= 16 && lSync >= 0 && cSync <= 32 && cSync >=0 ){
;Permet de dessiner uniquement sur les cotes du rectangle
         LDX     lSync,d     ;
         CPX     ligne,d     ;
         BREQ    DessRect    ;
         CPX     ligne2,d    ;
         BREQ    DessRect    ;
         LDX     cSync,d     ;
         CPX     colonne,d   ;
         BREQ    DessRect    ;
         CPX     colonne2,d  ;
         BRNE    passeRec    ;            if(lSync == ligne || lSync == ligne2 || cSync == colonne || cSync == colonne2){
;dessine le rectangle
DessRect:LDX     cSync,d     ;
         ADDX    lSync,d     ;
         LDBYTEA signe,d     ;
         STBYTEA dessin,x    ;                dessin[c][l] = signe }
passeRec:LDX     lSync,d     ;        }
         ADDX    1,i         ;
         STX     lSync,d     ;
         BR      loopRecL    ;    }
finRecL: LDX     cSync,d     ;
         ADDX    cx,d        ;
         STX     cSync,d     ;
         BR      loopRecC    ; }
finRect: RET0                ;
;
;
;Fonction surface
;Permet de dessiner un rectangle remplit.
surface: CHARI   signe,d     ; signe = lireChar()
         CHARI   signe2,d    ; signe2 = lireChar()
         DECI    colonne,d   ; colonne = lireInt()
         DECI    ligne,d     ; ligne = lireInt()
         DECI    colonne2,d  ; colonne2 = lireInt()
         DECI    ligne2,d    ; ligne2 = lireInt()
         CALL    plusUn      ;
         CALL    cMulti      ;
         LDX     colonne,d   ;
         CPX     colonne2,d  ;
         BRLE    suiteSur    ; if(colonne > colonne2){
         LDA     colonne,d   ;
         LDX     colonne2,d  ;
         STA     colonne2,d  ;    colonne = colonne2
         STX     colonne,d   ;    colonne2 = colonne }
suiteSur:LDX     ligne,d     ;
         CPX     ligne2,d    ;
         BRLE    loopSurf    ; if(ligne > ligne2){
         LDA     ligne,d     ;
         LDX     ligne2,d    ;
         STA     ligne2,d    ;    ligne = ligne2
         STX     ligne,d     ;    ligne2 = ligne }
;Loop pour dessiner le rectangle remplit
loopSurf:LDX     colonne,d   ;
         STX     cSync,d     ;
loopSurC:CPX     colonne2,d  ;
         BRGT    finSurf     ; for(int cSync = colonne; cSync <= colonne2; c++){
         LDX     ligne,d     ;
         STX     lSync,d     ;
loopSurL:CPX     ligne2,d    ;
         BRGT    finSurLi    ;    for(int lSync = ligne; lSync <= ligne2; l++){
;Validation que signe present dans canevas
         CPX     16,i        ;
         BRGT    passeSur    ;
         CPX     0,i         ;
         BRLE    passeSur    ;
         LDX     cSync,d     ;
         CPX     576,i       ;
         BRGT    passeSur    ;
         CPX     0,i         ;
         BRLE    passeSur    ;        if(lSync<= 16 && lSync >= 0 && cSync <= 32 && cSync >=0 ){
;Permet de dessiner soit les cotes soit l'interieur
         LDX     lSync,d     ;
         CPX     ligne,d     ;
         BREQ    DessSurf    ;
         CPX     ligne2,d    ;
         BREQ    DessSurf    ;
         LDX     cSync,d     ;
         CPX     colonne,d   ;
         BREQ    DessSurf    ;
         CPX     colonne2,d  ;
         BRNE    DessInSu    ;            if(lSync == ligne || lSync == ligne2 || cSync == colonne || cSync == colonne2){
;Dessine les cotes du rectangle
DessSurf:LDX     cSync,d     ;
         ADDX    lSync,d     ;
         LDBYTEA signe,d     ;
         STBYTEA dessin,x    ;                dessin[c][l] = signe }else{
         BR      passeSur    ;
;Dessine l'interieur du rectangle
DessInSu:LDX     cSync,d     ;
         ADDX    lSync,d     ;
         LDBYTEA signe2,d    ;
         STBYTEA dessin,x    ;                dessin[c][l] = signe2 }
passeSur:LDX     lSync,d     ;        }
         ADDX    1,i         ;
         STX     lSync,d     ;
         BR      loopSurL    ;    }
finSurLi:LDX     cSync,d     ;
         ADDX    cx,d        ;
         STX     cSync,d     ;
         BR      loopSurC    ; }
finSurf: RET0                ;
;
;
;Fonction affiche
;Permet d'afficher le tableau et donc de dessiner
;ce qu'il il y'a a l'interieur.
affiche: LDX     17,i        ;
loop_l:  STX     l,d         ;
         CPX     0,i         ;
         BRLT    finAff      ; for(int l = 17; l >= 0; l--){
         LDX     0,i         ;
         ADDX    l,d         ;
loop_c:  CPX     611,i       ;
         BRGT    next        ;    for(int c = 0; c <= 33; c++){
         CHARO   dessin,x    ;        SOP(dessin[c][l]);
         ADDX    cx,d        ;
         BR      loop_c      ;    }
next:    CHARO   '\n',i      ;    SOP('\n');
         LDX     l,d         ;
         SUBX    1,i         ;
         BR      loop_l      ;}
finAff:  RET0                
;
;
;Fonction remplissage
remplire:CHARI   signe,d     ; signe = lireChar();
         DECI    colonne,d   ; colonne = lireInt();
         DECI    ligne,d     ; ligne = lireInt();
         CALL    plusUn      ;
         CALL    cMulti      ;
         LDX     colonne,d   ;
         ADDX    ligne,d     ;
         LDBYTEA dessin,x    ;
         STBYTEA base,d      ; signe2 = dessin[c][l]
         CALL    remplis     ; remplis();
         RET0                
;fonction Recursive de remplissage
remplis: SUBSP   4,i         ; #cPile #lPile
         LDA     colonne,d   ;
         STA     cPile,s     ;
         LDA     ligne,d     ;
         STA     lPile,s     ;
;
         LDX     cPile,s     ;
         ADDX    lPile,s     ;
         LDBYTEA signe,d     ;
         STBYTEA dessin,x    ; dessin[c][l] = signe
;
         LDX     cPile,s     ;
         ADDX    cx,d        ;
         STX     colonne,d   ;
         LDA     lPile,s     ;
         STA     ligne,d     ;
         ADDX    lPile,s     ;
         CPX     0,i         ;
         BRLT    cNega       ;
         CPX     612,i       ;
         BRGT    cNega       ;
         LDA     dessin,x    ;
         LDBYTEA 0,i         ;
         CPA     base,d      ;
         BRNE    cNega       ; if (signe2 == dessin[c+1][l]){
         CALL    remplis     ;    remplis();
;                              }
cNega:   LDX     cPile,s     ;
         SUBX    cx,d        ;
         STX     colonne,d   ;
         LDA     lPile,s     ;
         STA     ligne,d     ;
         ADDX    lPile,s     ;
         CPX     0,i         ;
         BRLT    lPositif    ;
         CPX     612,i       ;
         BRGT    lPositif    ;
         LDA     dessin,x    ;
         LDBYTEA 0,i         ;
         CPA     base,d      ;
         BRNE    lPositif    ; if(signe2 == dessin[c-1][l]){
         CALL    remplis     ;    remplis();
;                              }
lPositif:LDX     lPile,s     ;
         ADDX    1,i         ;
         STX     ligne,d     ;
         LDA     cPile,s     ;
         STA     colonne,d   ;
         ADDX    cPile,s     ;
         CPX     0,i         ;
         BRLT    lNegatif    ;
         CPX     612,i       ;
         BRGT    lNegatif    ;
         LDA     dessin,x    ;
         LDBYTEA 0,i         ;
         CPA     base,d      ;
         BRNE    lNegatif    ; if(signe2 == dessin[c][l+1]){
         CALL    remplis     ;    remplis();
;                              }
lNegatif:LDX     lPile,s     ;
         SUBX    1,i         ;
         STX     ligne,d     ;
         LDA     cPile,s     ;
         STA     colonne,d   ;
         ADDX    cPile,s     ;
         CPX     0,i         ;
         BRLT    finRecur    ;
         CPX     612,i       ;
         BRGT    finRecur    ;
         LDA     dessin,x    ;
         LDBYTEA 0,i         ;
         CPA     base,d      ;
         BRNE    finRecur    ; if(signe2 == dessin[c][l-1]){
         CALL    remplis     ;    remplis();
;                              }
finRecur:ADDSP   4,i         ; #cPile #lPile
         RET0                
;
;
base:    .BLOCK  1           ;#1c
cPile:   .EQUATE 2           ;#2d
lPile:   .EQUATE 0           ;#2d
test:    .BLOCK  1           ;#1c
;
;Petite fonction qui sert a
; multiplier la colonne par 18.
cMulti:  LDX     0,i         ;
         LDA     colonne,d   ;
loopMult:CPX     17,i        ;
         BRGE    c2Mult      ; for (int i = 0; i < 17; i++){
         ADDA    colonne,d   ;    colonne = colonne+colonne
         ADDX    1,i         ;
         BR      loopMult    ; }
c2Mult:  STA     colonne,d   ;
         LDX     0,i         ;
         LDA     colonne2,d  ;
lop2Mult:CPX     17,i        ;
         BRGE    finMult     ; for (int i = 0; i < 17; i++){
         ADDA    colonne2,d  ;    colonne2 = colonne2+colonne2
         ADDX    1,i         ;
         BR      lop2Mult    ; }
finMult: STA     colonne2,d  ;
         RET0                ;
;
;Petite fonction qui sert a ajouter 1
;aux ligne et colonne.
plusUn:  LDA     ligne,d     ;
         ADDA    1,i         ;
         STA     ligne,d     ; ligne += 1
         LDA     ligne2,d    ;
         ADDA    1,i         ;
         STA     ligne2,d    ; ligne2 += 1
         LDA     colonne,d   ;
         ADDA    1,i         ;
         STA     colonne,d   ; colonne += 1
         LDA     colonne2,d  ;
         ADDA    1,i         ;
         STA     colonne2,d  ; colonne2 += 1
         RET0                ;
;
tracer:  CHARI   carac,d     ; char segment_value = Pep8.chari();
         DECI    x1,d        ; int colonne1 = Pep8.deci()+1;
         LDA     x1,d        ;
         ADDA    1,i         ;
         STA     x1,d        ;
         DECI    y1,d        ; int ligne1 = Pep8.deci()+1;
         LDA     y1,d        ;
         ADDA    1,i         ;
         STA     y1,d        ;
         DECI    x2,d        ; int colonne2 = Pep8.deci()+1;
         LDA     x2,d        ;
         ADDA    1,i         ;
         STA     x2,d        ;
         DECI    y2,d        ; int ligne2= Pep8.deci()+1;
         LDA     y2,d        ;
         ADDA    1,i         ;
         STA     y2,d        ;
         LDA     x2,d        ;int dx = abs(x2 - x1);
         SUBA    x1,d        ;
         STA     int,d       ;
;
         CALL    abs         ;
         LDA     absres,d    ;
         STA     dx,d        ;
;
         LDA     x2,d        ; int sx = signe(x2 - x1);
         SUBA    x1,d        ;
         STA     signv,d     ;
         CALL    sign        ;
         LDA     sigres,d    ;
         STA     sx,d        ;
;
         LDA     y2,d        ; int dy = -abs(y2 - y1);
         SUBA    y1,d        ;
         STA     int,d       ;
         CALL    abs         ;
         LDA     absres,d    ;
         NEGA                ;
         STA     dy,d        ;
;
         LDA     y2,d        ; int sy = signe(y2 - y1);
         SUBA    y1,d        ;
         STA     signv,d     ;
         CALL    sign        ;
         LDA     sigres,d    ;
         STA     sy,d        ;
;
         LDA     dx,d        ; int err = dx + dy;
         ADDA    dy,d        ;
         STA     err,d       ;
;
looptr:  LDA     x1,d        ; while (x1 != x2 || y1 !=y2)
         CPA     x2,d        ;
         BRNE    true        ;
         LDA     y1,d        ;
         CPA     y2,d        ;
         BRNE    true        ;
         BR      traceout    ;
;
true:    LDA     x1,d        ; x1 <= 32
         CPA     32,i        ;
         BRGT    inte2       ;
         LDA     x1,d        ; x1 > 0
         CPA     0,i         ;
         BRLE    inte2       ;
         LDA     y1,d        ; y1 <= 16
         CPA     16,i        ;
         BRGT    inte2       ;
         LDA     y1,d        ; y1 > 0
         CPA     0,i         ;
         BRLE    inte2       ;
;
         LDX     x1,d        ; dessiner(carac,x1, y1);
         CALL    mul         ;
         ADDX    y1,d        ;
         LDBYTEA carac,d     ;
         STBYTEA dessin,x    ;
;
inte2:   LDX     2,i         ; int e2 = multiplication(2,err);
         LDA     err,d       ;
         ADDA    err,d       ;
         STA     e2,d        ;
;
         LDA     e2,d        ; if (e2 >= dy)
         CPA     dy,d        ;
         BRLT    nextif      ;
         LDA     err,d       ; err += dy;
         ADDA    dy,d        ;
         STA     err,d       ;
         LDA     x1,d        ; x1 += sx;
         ADDA    sx,d        ;
         STA     x1,d        ;
;
nextif:  LDA     e2,d        ; if (e2 <= dx)
         CPA     dx,d        ;
         BRGT    looptr      ;
         LDA     err,d       ; err += dx;
         ADDA    dx,d        ;
         STA     err,d       ;
         LDA     y1,d        ; y1 += sy;
         ADDA    sy,d        ;
         STA     y1,d        ;
;
         BR      looptr      
;
traceout:LDA     x1,d        ; x1 <= 32
         CPA     32,i        ;
         BRGT    out2        ;
         LDA     x1,d        ; x1 > 0
         CPA     0,i         ;
         BRLE    out2        ;
         LDA     y1,d        ; y1 <= 16
         CPA     16,i        ;
         BRGT    out2        ;
         LDA     y1,d        ; y1 > 0
         CPA     0,i         ;
         BRLE    out2        ;
;
         LDX     x1,d        ; dessiner(carac,x1, y1);
         CALL    mul         ;
         ADDX    y1,d        ;
         LDBYTEA carac,d     ;
         STBYTEA dessin,x    ;
;
out2:    RET0                
; fonction multiplier
mul:     LDA     0,i         
mullp:   CPA     17,i         
         BRGE    mulout       
         ADDX    x1,d 
         ADDA    1,i       
         BR      mullp       
mulout:  RET0                
;
; fonction abs
abs:     LDA     0,i         
         LDA     int,d       
         CPA     0,i         
         BRLE    neg         
         LDA     int,d       
         STA     absres,d    
         BR      absout      
neg:     LDA     0,i         
         LDA     int,d       
         NEGA                
         STA     absres,d    
absout:  RET0                
;
; fonction sign
sign:    LDA     signv,d     
         CPA     0,i         
         BRLT    less        
         BRGT    sup         
         LDA     0,i         
         STA     sigres,d    
         BR      out         
sup:     LDA     1,i         
         STA     sigres,d    
         BR      out         
less:    LDA     -1,i        
         STA     sigres,d    
out:     RET0                
;fin du programme
fin:     STOP                ;
;
dessin:  .BLOCK  612         ;#1c612a // contient toute les valeurs du dessin
command: .BLOCK  1           ;#1c
signe:   .BLOCK  1           ;#1c
signe2:  .BLOCK  1           ;#1c
ligne:   .BLOCK  2           ;#2d
colonne: .BLOCK  2           ;#2d
ligne2:  .BLOCK  2           ;#2d
colonne2:.BLOCK  2           ;#2d
c:       .BLOCK  1           ;#1c
cx:      .WORD   18          ;utilise pour sauter de 18 octets
l:       .BLOCK  1           ;#1c
lSync:   .BLOCK  2           ;#2d utile pour les boucles
cSync:   .BLOCK  2           ;#2d utile pour les boucles
inc:     .BLOCK  2           ;#2d incrémentation multiplication
absres:  .BLOCK  2           ;#2d reslutat de la fonction abs
int:     .BLOCK  2           ;#2d parametre de la fonction abs
dx:      .BLOCK  2           ;#2d
sx:      .BLOCK  2           ;#2d
dy:      .BLOCK  2           ;#2d
sy:      .BLOCK  2           ;#2d
err:     .BLOCK  2           ;#2d parametre de la fonction tracer
x1:      .BLOCK  2           ;#2d idem
y1:      .BLOCK  2           ;#2d idem
x2:      .BLOCK  2           ;#2d idem
y2:      .BLOCK  2           ;#2d idem
signv:   .BLOCK  2           ;#2d parametre de la fonction sign
sigres:  .BLOCK  2           ;#2d resultat de la fonction sign
e2:      .BLOCK  2           ;#2d
carac:   .BLOCK  1           ;#1c
         .END                  
