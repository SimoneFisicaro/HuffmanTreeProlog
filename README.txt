Nello svolgimento del progetto sono stati usati dei predicati di supporto
utili per il corretto funzionamento del programma, questi sono, 

init/2 
	che inizializza l'input in una lista di nodi del tipo: node(simboli, pesi, sottoalbero_sinistro, sottoalbeero_destro)

insertion_sort/2
	che prende in input una lista di node/4 e la ordina

is_char/1
	che verifica se un argomento è un simbolo

I predicati richiesti per il completamento del progetto sono i seguenti,
è inclusa anche una spiegazione di cosa si aspettano di prendere in input, 
e di cosa viene generato.

generate_huffman_tree(SymbolsAndWeights, HuffmanTree).

	SymbolsAndWeights è una lista del tipo: 
		[['a',1],['b',2],['c',3],['d',4]]

	HuffmanTree è l'albero che viene generato nella forma: 
		node("dcab", 10, node(d, 4, nil, nil), node("cab", 6, node(c, 3, nil, nil), node("ab", 3, node(a, 1, nil, nil), node(b, 2, nil, nil))))


encode(Message, HuffmanTree, Bits).
	
	Message è la stringa da codificare:
		"abcd"

	HuffmanTree è quello generato da generate_huffman_tree/2

	Bits è la stringa data in output


decode(Bits, HuffmanTree, Message).
	
	Bits è la stringa da decodificare:
		"0100101"

	HuffmanTree è quello generato da generate_huffman_tree/2

	Message è la stringa data in output


generate_symbol_bits_table(HuffmanTree, SymbolBitsTable).

	HuffmanTree è quello generato da generate_huffman_tree/2

	SymbolBitsTable è la tabella generata nella forma:
		[d:0][c:10][a:110][b:111]
