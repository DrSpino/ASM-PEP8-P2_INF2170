
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
			Pep8.charo('\n');
			for(int c = 0; c <= 33; c++){
				Pep8.charo(dessin[c][l]);
			}
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
				if(c <= 32 && c >= 0 && l <= 16 && l >= 0){
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
				if(c <= 32 && c >= 0 && l <= 16 && l >= 0){
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
			}
			commande = Pep8.chari();
		}
	}

}
