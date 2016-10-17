
public class Dessin {
	
	/*
	 *Tableau dessin
	 *Ce tableau contient tout les signes
	 * et leur position respectives.
	 **/
	static char [][] dessin = new char[34][18];
	
	/*Methode d'initialisation du canevas*/
	public static void canevas(){
		
		dessin[0][0] = '+';
		for(int c = 1; c <= 32; c++){
			dessin[c][0] = '-';
		}
		dessin[33][0] = '+';
		
		for(int l = 1; l <= 16; l++){
			for(int c = 0; c <= 33; c++){
				if(c == 0 || c == 33){
					dessin[c][l] = '|';
				}else{
					dessin[c][l] = ' ';
				}
			}
		}
		
		dessin[0][17] = '+';
		for(int c = 1; c <= 32; c++){
			dessin[c][17] = '-';
		}
		dessin[33][17] = '+';
	}
	
	/*Methode pour dessiner un point*/
	public static void point(){
		char signe = Pep8.chari();
		int colonne = Pep8.deci();
		int ligne = Pep8.deci();
		
		if(colonne < 32 && colonne >= 0 && ligne < 16 && ligne >= 0){
			dessin[colonne+1][ligne+1] = signe;
		}
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
			}
			commande = Pep8.chari();
		}
	}

}
