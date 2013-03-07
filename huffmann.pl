%Fisicaro Simone 755547 - Longoni Mattia 753403 - Giliberto Alessandro 748108

% GENERA UN HUFFMAN TREE, L'INPUT VIENE DATO NELLA FORMA:
% generate_huffman_tree([['a',5],['b',1],['c',2],['d',8]], HT).
generate_huffman_tree([L|INPUT], GENERATED) :-
	INPUT\=[],
	init([L|INPUT], INITIALIZED),
	generate(INITIALIZED, GENERATED).

init([], []) :- !.
init([[S, W]|Ls], [node(S, W, nil, nil)|OUTPUT]) :-
     init(Ls, OUTPUT).

insert_sort(List, Sorted) :- insert_sort2(List,[],Sorted).
insert_sort2([],Acc,Acc) :- !.
insert_sort2([H|T],Acc,Sorted) :-
	insert(H,Acc,NAcc), insert_sort2(T,NAcc,Sorted).

insert(X,[],[X]) :- !.
insert(node(S,W,L,R),[node(S1,W1,L1,R1)|T],[node(S1,W1,L1,R1)|NT]) :-
	W>W1, insert(node(S,W,L,R),T,NT), !.
insert(node(S,W,L,R),[node(S1,W1,L1,R1)|T],[node(S,W,L,R),node(S1,W1,L1,R1)|T]):-
	W=<W1.

generate([X], X) :- !.
generate(T, OUTPUT) :-
	insert_sort(T, [node(S1,W1,L1,R1),node(S2,W2,L2,R2)|L]),
	R is W1 + W2,
	string_concat(S1, S2, Nodes),
	generate([node(Nodes,R,node(S1,W1,L1,R1),node(S2,W2,L2,R2))|L], OUTPUT).

%DATI UN HUFFMAN TREE E UN MESSAGGIO IN INPUT, RITORNA UNA CODIFICA IN BIT
%L'INPUT VIENE DATO NELLA FORMA:
%encode("message", HT, BITS).
encode("", _, '') :- !.
encode(MESSAGE, HT, BITS) :-
	string_to_atom(MESSAGE, ATOM),
	atom_chars(ATOM, CHARs),
	encode_2(CHARs, HT, BITS).

encode_2([], _, '') :- !.
encode_2([C|MESSAGE], HT, BITS) :-
	get_code(C, HT, L),
	encode_2(MESSAGE, HT, REST),
	string_concat(L, REST, BITS).

get_code(C, node(S,_, nil, nil), '') :-
	is_char(S), !,
	C==S.
get_code(C, node(_,_,L,_), OUTPUT) :-
	get_code(C, L, REST), !,
	string_concat('0', REST, OUTPUT).
get_code(C, node(_,_,_,R), OUTPUT) :-
	get_code(C, R, REST),
	string_concat('1', REST, OUTPUT).

%DATI UN HUFFMAN TREE E UNA CODIFICA IN BIT IN INPUT
%RITORNA UN MESSAGGIO,
%L'INPUT VIENE DATO NELLA FORMA:
%decode("01001010", HT, MESSAGE).
decode("", _, '') :- !.
decode(BITS, HT, MESSAGE) :-
	string_to_atom(BITS, ATOM),
	atom_chars(ATOM, CHARS),
	decode_2(CHARS, HT, MESSAGE).

decode_2([], _, '') :- !.
decode_2(CHARS, HT, MESSAGE) :-
	get_char(CHARS, HT,REST, L1),
	decode_2(REST, HT, L2),
	string_concat(L1, L2, MESSAGE).

get_char(REST, node(S, _, _, _), REST, S):-
	is_char(S), !.

get_char([C|REST], node(_, _, L, _), OTHER_BITS, S) :-
	C=='0',
	get_char(REST, L, OTHER_BITS, S), !.

get_char([C|REST], node(_, _, _, R), OTHER_BITS, S) :-
	C=='1',
	get_char(REST, R, OTHER_BITS, S).

% DATO UN HUFFMAN TREE IN INPUT,
% RITORNA LA TABELLA DELLE CORRISPONDENZE
% MESSAGGIO:BITS
generate_symbol_bits_table(node(ListOfNodes, A, B, C), L):-
	string_to_atom(ListOfNodes,ListOfAtoms),
	atom_chars(ListOfAtoms,Nodes),
	search(node(ListOfNodes, A, B, C), Nodes, L).

search(_, [], []) :- !.
search(Ht,[N |Next], [[N,R] | R2]) :-
	 encode_2([N],Ht,R),
	 search(Ht, Next, R2).

is_char(A) :- iis_char(A).
iis_char([_ | _]) :- !, fail.
iis_char(A) :- atom_chars(A, [A]).











