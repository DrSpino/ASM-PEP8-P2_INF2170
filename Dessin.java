
public class Dessin {
	
	/*
	 *Tableau dessin
	 *Ce tableau contient tout les signes
	 * et leur position respectives.
	 **/
	static char [] dessin = new char[631];
	
	/*Methode d'initialisation du canevas*/
	public static void canevas(){
		dessin[0] = '+';
		for(int i = 1; i <= 32; i++){
			dessin[i] = '-';
		}
		dessin[33] = '+';
		
		for(int i = 35; i < 596; i++){
			if((i%35)== 1){
				dessin[i] = '|';
			}else if((i%35)== 0){
				dessin[i] = '\n';
			}else if((i%35)== 34){
				dessin[i] = '|';
			}else{
				dessin[i] = ' ';
			}
		}
		dessin[596] = '+';
		for(int i = 597; i <= 628; i++){
			dessin[i] = '-';
		}
		dessin[629] = '+';
		dessin[630] = '\n';
	}
	
	/*
	 *Methode d'affichage.
	 * affiche ce qu'il y a dans le tableau dessin.
	 **/
	public static void affiche(){
		for (int i = 0; i < dessin.length ; i++){
			System.out.print(dessin[i]);
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
