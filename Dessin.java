
public class Dessin {

    /*
     *Tableau dessin
     *Ce tableau contient tout les signes
     * et leur position respectives.
     **/
    static char [][] dessin = new char[34][18];

    /*Methode servant a dessiner un signe sur un point precis.*/
    public static void dessiner(char signe, int colonne, int ligne){
        dessin[colonne][ligne] = signe ;
    }

    /*
     *Methode d'affichage.
     * affiche ce qu'il y a dans le tableau dessin.
     **/
    public static void  affiche(){
        for(int l = 17; l >= 0; l--){
            for(int c = 0; c <= 33; c++){
                Pep8.charo(dessin[c][l]);
            }
            Pep8.charo('\n');
        }
    }

    /*Methode d'initialisation du canevas*/
    public static void canevas(){

        dessiner('+',0,0);
        for(int c = 1; c <= 32; c++){
            dessiner('-',c,0);
        }
        dessiner('+',33,0);

        for(int l = 1; l <= 16; l++){
            for(int c = 0; c <= 33; c++){
                if(c == 0 || c == 33){
                    dessiner('|',c,l);;
                }else{
                    dessiner(' ',c,l);
                }
            }
        }

        dessiner('+',0,17);
        for(int c = 1; c <= 32; c++){
            dessiner('-',c,17);
        }
        dessiner('+',33,17);
    }

    /*Methode pour dessiner un point*/
    public static void point(){
        char signe = Pep8.chari();
        int colonne = Pep8.deci();
        int ligne = Pep8.deci();

        if(colonne <= 32 && colonne >= 0 && ligne <= 16 && ligne >= 0){
            dessiner(signe,colonne+1,ligne+1);
        }
    }

    /*Methode pour dessiner un rectangle*/
    public static void rectangle(){
        char signe = Pep8.chari();
        int colonne1 = Pep8.deci()+1;
        int ligne1 = Pep8.deci()+1;
        int colonne2 = Pep8.deci()+1;
        int ligne2 = Pep8.deci()+1;

        if(colonne1 > colonne2){
            int transition = colonne1;
            colonne1 = colonne2;
            colonne2 = transition;
        }
        if(ligne1 > ligne2){
            int transition = ligne1;
            ligne1 = ligne2;
            ligne2 = transition;
        }

        for(int c = colonne1; c <= colonne2; c++){
            for(int l = ligne1; l <= ligne2; l++){
                if(c <= 32 && c > 0 && l <= 16 && l > 0){
                    if(l == ligne1 || l == ligne2
                            || c == colonne1 || c == colonne2){
                        dessiner(signe,c,l);
                    }
                }
            }
        }
    }

    /*Methode pour dessiner un rectangle remplit*/
    public static void surface(){
        char signeBord = Pep8.chari();
        char signeInterieur = Pep8.chari();
        int colonne1 = Pep8.deci()+1;
        int ligne1 = Pep8.deci()+1;
        int colonne2 = Pep8.deci()+1;
        int ligne2 = Pep8.deci()+1;

        if(colonne1 > colonne2){
            int transition = colonne1;
            colonne1 = colonne2;
            colonne2 = transition;
        }
        if(ligne1 > ligne2){
            int transition = ligne1;
            ligne1 = ligne2;
            ligne2 = transition;
        }

        for(int c = colonne1; c <= colonne2; c++){
            for(int l = ligne1; l <= ligne2; l++){
                if(c <= 32 && c > 0 && l <= 16 && l > 0){
                    if(l == ligne1 || l == ligne2
                            || c == colonne1 || c == colonne2){
                        dessiner(signeBord,c,l);
                    }else{
                        dessiner(signeInterieur,c,l);
                    }
                }
            }
        }
    }
    
    /*Méthode segment qui appel tracer*/
    public static void segment (){
        char segment_value = Pep8.chari();
        int colonne1 = Pep8.deci()+1;
        int ligne1 = Pep8.deci()+1;
        int colonne2 = Pep8.deci()+1;
        int ligne2= Pep8.deci()+1;

        tracer(colonne1,ligne1,colonne2,ligne2,segment_value);
    }
    /*Méthode tracer qui continent l'algorithme pour dessiner le segment*/
    public static void  tracer (int x1, int  y1, int x2,int  y2,char carac) {
        int dx = abs(x2 - x1);
        int sx = signe(x2 - x1);
        int dy = -abs(y2 - y1);
        int sy = signe(y2 - y1);
        int err = dx + dy;

        while (x1 != x2 || y1 !=y2) {
        	if(x1 <= 32 && x1 > 0 && y1 <= 16 && y1 > 0){
        		dessiner(carac,x1, y1);
        	}
            int e2 = multiplication(2,err);
            if (e2 >= dy) {
                err += dy;
                x1 += sx;
            }
            if (e2 <= dx) {
                err += dx;
                y1 += sy;
            }
        }
        if(x1 <= 32 && x1 > 0 && y1 <= 16 && y1 > 0){
            dessiner(carac,x1, y1);
        }
    }
    /*Calcule la valeur absolue*/
    public static int abs (int a){
        return (a <= 0) ? 0 - a : a;
    }

    /*retourne le signe d'un entier*/
    public static int signe (int a){
        if (a == 0 ) {
            return 0;
        } else if (a > 0){
            return 1;
        } else {
            return -1;
        }
    }
    /*Multiplie deux nombres*/
    public static int multiplication(int a, int b){
        int result = 0;

        if (a < 0 && b < 0){
            for (int i = a; i <= -1; i++)
                result-=b;
        }
        else if (a < 0){
            for (int i = 1; i <= b; i++)
                result+=a;
        }
        else if (b < 0){
            for (int i = 1; i <= a; i++)
                result+=b;
        }
        else {
            for (int i = 1; i <= b; i++)
                result+=a;
        }
        return result;
    }
    /*Fonction remplissage qui appel le premeir remplit*/
    public static void remplissage(){
    	char signe = Pep8.chari();
        int colonne = Pep8.deci()+1;
        int ligne = Pep8.deci()+1;
        char base = dessin[colonne][ligne];
        remplit(base,signe,colonne,ligne);     

    }
    /*Méthode recursive remplit*/
    public static void remplit(char base,char signe,int colonne,int ligne){
    	dessin[colonne][ligne] = signe;
        
        if(dessin[colonne+1][ligne] == base){
        	remplit(base,signe,colonne+1,ligne);
        }
        
        if(dessin[colonne-1][ligne] == base){
        	remplit(base,signe,colonne-1,ligne);
        }
        
        if(dessin[colonne][ligne+1] == base){
        	remplit(base,signe,colonne,ligne+1);
        }
        
        if(dessin[colonne][ligne-1] == base){
        	remplit(base,signe,colonne,ligne-1);
        }
    }


    /*Methode main*/
    public static void main(String[] args) {
        //initialise canevas vide.
        canevas();

        char commande = Pep8.chari();
        while(commande != 'q'){
            if(commande == 'z'){
                canevas();
            }else if(commande == 'a'){
                affiche();
            }else if(commande == 'p'){
                point();
            }else if(commande == 'r'){
                rectangle();
            }else if(commande == 'b'){
                surface();
            }else if(commande == 'l'){
                segment();
            }else if (commande == 'f'){
                remplissage();
            }
            commande = Pep8.chari();
        }
    }

}
