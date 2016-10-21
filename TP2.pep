;Boucle principal du dessin,
;Permet d'entrer une commande de l'afficher
;et de quitter.
         CALL    canevas     ;
loop:    CHARI   command,d   ; command = lireChar()
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
         BRNE    lePoint     ;    }else if(command == 'a'){
         CALL    affiche     ;        affiche()
         BR      loop        ;
; dessiner un point
lePoint: CPA     'p',i       ;
         BRNE    rect        ;    }else if(command == 'p'){
         CALL    point       ;        point()
         BR      loop        ;
;dessiner un rectangle        
rect:    CPA     'r',i       ;
         BRNE    surface     ;    }else if(command == 'r'){  
         CHARO   'r',i       ;        print(r);
         BR      loop        ;
;dessiner un rectangle remplit
surface: CPA     'b',i       ;
         BRNE    segment     ;    }else if(command == 'b'){
         CHARO   'b',i       ;        print(b);
         BR      loop        ;
;dessiner un segement
segment: CPA     'l',i       ;
         BRNE    remplit     ;    }else if(command == 'l'){
         CHARO   'l',i       ;        print(l);
         BR      loop        ;
;remplire
remplit: CPA     'f',i       ;
         BRNE    loop        ;     }else if(command == 'f'){
         CHARO   'f',i       ;        print(r); }
         BR      loop        ; }
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
         ret0                ;
;              
;Fonction Point
;Permet de dessiner un point
;a un endroit precis.
point:   CHARI   signe,d     ; signe = lireChar()
         DECI    colonne,d   ; colonne = lireInt()
         DECI    ligne,d     ; ligne = lireInt()
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
dessinP: STA     colonne,d   ;
         LDX     colonne,d   ;
         ADDX    ligne,d     ;
         LDBYTEA signe,d     ;
         STBYTEA dessin,x    ;                dessin[c][l] = signe
finPoint:ret0                ;}}}}
;
;Fonction affiche
;Permet d'afficher le tableau et donc de dessiner
;ce qu'il il y'a a l'interieur.
affiche: LDX     17,i        ;
loop_l:  STX     l,d         ;
         CPX     0,i         ;
         BRLT    finAff      ; for(int l = 17; l >= 0; l--){
         CHARO   '\n',i      ;    SOP('\n');
         LDX     0,i         ;
         ADDX    l,d         ;
loop_c:  CPX     611,i       ;
         BRGT    next        ;    for(int c = 0; c <= 33; c++){    
         CHARO   dessin,x    ;        SOP(dessin[c][l]);
         ADDX    cx,d        ;
         BR      loop_c      ;    }
next:    LDX     l,d         ;         
         SUBX    1,i         ;
         BR      loop_l      ;}
finAff:  ret0   
;
;Petite fonction qui sert a
; multiplier la colonne par 18.
cMulti:  LDX     0,i         ;
         LDA     colonne,d   ;
loopMult:CPX     17,i        ;
         BRGE    finMult     ; for (int i = 0; i < 17; i++){
         ADDA    colonne,d   ;    colonne = colonne+colonne
         ADDX    1,i         ;         
         BR      loopMult    ; }
finMult: ret0                ;
;
;fin du programme   
fin:     STOP                ;
;
dessin:  .BLOCK 612          ;#1c612a // contient toute les valeurs du dessin
command: .BLOCK 1            ;#1c
signe:   .BLOCK 1            ;#1c
ligne:   .BLOCK 2            ;#2d
colonne: .BLOCK 2            ;#2d
c:       .BLOCK 1            ;#1c 
cx:      .WORD 18            ;utilise pour sauter de 18 octets
l:       .BLOCK 1            ;#1c
         .END     
