
public class Dessin {
	
	/*
	 *Tableau dessin
	 *Ce tableau contient tout les signes
	 * et leur position respectives.
	 **/
	static char [][] dessins = new char[34][18];
	
	/*Methode d'initialisation du canevas*/
	public static void canevas(){
		
		dessins[0][0] = '+';
		for(int c = 1; c <= 32; c++){
			dessins[c][0] = '-';
		}
		dessins[33][0] = '+';
		
		for(int l = 1; l <= 16; l++){
			for(int c = 0; c <= 33; c++){
				if(c == 0 || c == 33){
					dessins[c][l] = '|';
				}else{
					dessins[c][l] = ' ';
				}
			}
		}
		
		dessins[0][17] = '+';
		for(int c = 1; c <= 32; c++){
			dessins[c][17] = '-';
		}
		dessins[33][17] = '+';
	}
	
	/*
	 *Methode d'affichage.
	 * affiche ce qu'il y a dans le tableau dessin.
	 **/
	public static void  affiche(){
		for(int l = 0; l <= 17; l++){
			for(int c = 0; c <= 33; c++){
				Pep8.charo(dessins[c][l]);
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
			}
			commande = Pep8.chari();
		}
	}

}
