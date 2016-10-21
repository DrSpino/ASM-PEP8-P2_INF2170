loop:    CALL    canevas     ;
         CHARI   command,d   ;
         LDBYTEA command,d   ;
         CPA     'q',i       ;
         BREQ    fin         ;while(command != 'q') {
         CPA     'z',i       ;
         BRNE    afficher    ;    if(command == 'z') {
         CALL    canevas     ;        canevas();
         BR      loop        ;
;afficher dessin
afficher:CPA     'a',i       ;
         BRNE    point       ;    }else if(command == 'a'){
         CALL    affiche     ;        affiche();
         BR      loop        ;
; dessiner un point
point:   CPA     'p',i       ;
         BRNE    rect        ;    }else if(command == 'p'){
         CHARO   'p',i       ;        print(p);
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
;
;Methode canevas
canevas: LDX     0,i         ;
         LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[0][0] = '+'
         ADDX    cx,d        ;
loopHigh:CPX     576,i       ;
         BRGT    nexto       ; for(int c = 1//18; c <= 33/576 ; c++//++18){ 
         LDBYTEA '-',i       ;
         STBYTEA dessin,x    ;    dessin[c][0] = '-'
         ADDX    cx,d        ;    
         BR      loopHigh    ; }
nexto:   LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[33][0] = '+'
         ADDX    cx,d        ;
;
;
         LDX     1,i         ;
loopMid: STX     l,d         ;
         CPX     16,i        ;
         BRGT    loopBot     ; for (int l = 1; l <= 16; l++){
         LDX     0,i         ;
         ADDX    l,d         ;
         LDBYTEA '/',i       ;
         STBYTEA dessin,x    ;
loopMidc:CPX     594,i       ;
         BRGT    nextp       ;    for(int c = 0; c <= 33//594; c++//++18){
         ADDX    cx,d        ;
         LDBYTEA '*',i       ;
         STBYTEA dessin,x    ;
         BR      loopMidc    ;    }
nextp:   LDBYTEA '/',i       ;
         STBYTEA dessin,x    ;
         LDX     l,d         ;
         ADDX    1,i         ;
         BR      loopMid     ;}
;
;
nexti:   LDX     17,i        ;
         LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[0][17] = '+'
         ADDX    cx,d        ;
loopBot: CPX     576,i       ;
         BRGT    finfin      ; for(int c = 1//18; c <= 33/594 ; c++//++18){ 
         LDBYTEA '-',i       ;
         STBYTEA dessin,x    ;    dessin[c][17] = '-'
         ADDX    cx,d        ;    
         BR      loopBot     ; }
finfin:  LDBYTEA '+',i       ;
         STBYTEA dessin,x    ; dessin[33][17] = '+'
         ret0                ;
;
;Methode affiche
affiche: LDX     17,i        ;
loop_l:  STX     l,d         ;
         CPX     0,i         ;
         BRLT    finAff      ; for(int l = 17; l >= 0; l--){
         CHARO   '\n',i      ;    SOP('\n');
         LDX     0,i         ;
         ADDX    l,d         ;
loop_c:  CPX     612,i       ;
         BRGT    next        ;    for(int c = 0; c <= 33; c++){    
         CHARO   dessin,x    ;        SOP(dessin[c][l]);
         ADDX    cx,d        ;
         BR      loop_c      ;    }
next:    LDX     l,d         ;         
         SUBX    1,i         ;
         BR      loop_l      ;}
finAff:  ret0   
;
;            
;
;fin du programme   
fin:     STOP                ;
command: .BLOCK 1            ;#1c
dessin:  .BLOCK 613          ;#1c613a 
c:       .BLOCK 1            ;#1c 
cx:      .WORD 18            ;18 octets
l:       .BLOCK 1            ;#1c
         .END     
