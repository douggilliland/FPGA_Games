library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.vga_package.all;

package base_package is
	
	-- Numero di tentativi possibili
	constant GUESSES_NUMBER : positive := 9;

	-- Numero di colori che l'utente deve impostare per ogni tentativo
	constant SQUARES_NUMBER : positive := 4;
	
	-- Numero di colori diversi tra cui l'utente può scegliere
	constant COLORS_NUMBER  : positive := 8;
	
	-- Numero di tipi di indizi che il computer può dare all'utente
	-- Tipo 0 -> colore giusto e posto giusto
	-- Tipo 1 -> colore giusto e posto sbagliato
	-- Tipo 2 -> colore sbagliato
	constant HINTS_NUMBER   : positive := 3;

	-- Tipo che descrive, per ogni colore da impostare per tentativo, che colore può essere
	-- Ognuno di questi colori è definito nel file vga_package
	subtype guess_peg   is natural range 0 to (COLORS_NUMBER - 1);
	-- Tipo che descrive il tentativo dell'utente, che è un'array di 4 colori che l'utente deve impostare
	type guess       is array(0 to (SQUARES_NUMBER - 1)) of guess_peg;
	-- Tipo che descrive l'insieme dei tentativi effettuati, quindi un'array di 9 tentativi (guess)
	type guess_board is array(0 to (GUESSES_NUMBER - 1)) of guess;

	-- Tipo che descrive il singolo colore dell'indizio, che può essere:
	-- Bianco per colore giusto posto sbagliato
	-- Nero per colore giusto posto giusto (o viceversa, come volete voi)
	-- Marrone quando il colore non e' giusto (perchè ho pensato di fare lo sfondo marrone)
	type hint_peg is (PLACE, COLOR, NOTHING);
	-- Tipo che descrive l'indizio dato dal computer, che è un'array di 4 colori che il computer imposta
	type hint        is array(0 to (SQUARES_NUMBER - 1)) of hint_peg;
	-- Tipo che descrive l'insieme degli indizi dati dal computer, quindi un'array di 9 indizi (hint)
	type hint_board  is array(0 to (GUESSES_NUMBER - 1)) of hint;

end package;