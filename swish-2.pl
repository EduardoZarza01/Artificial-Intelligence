% Initial and Goal States
start([Ml, Cl, left, Mr, Cr]) :-   % Define the initial state where 3 missionaries and 3 cannibals are on the left bank.
    Ml = 3, Cl = 3, Mr = 0, Cr = 0.

goal([Ml, Cl, right, Mr, Cr]) :-   % Define the goal state where all missionaries and cannibals are on the right bank.
    Ml = 0, Cl = 0, Mr = 3, Cr = 3.

% Check if the state is legal
legal(Cl, Ml, Cr, Mr) :-    % Predicate to check if a state is legal (number of missionaries >= number of cannibals)
    Ml >= 0, Cl >= 0, Mr >= 0, Cr >= 0,   % Ensure non-negative values
    (Ml >= Cl ; Ml = 0),   % Check if the number of missionaries is greater than or equal to the number of cannibals on the left side
    (Mr >= Cr ; Mr = 0).   % Check if the number of missionaries is greater than or equal to the number of cannibals on the right side

% Possible moves
move([Cl, Ml, left, Cr, Mr], [Cl, Ml2, right, Cr, Mr2]) :-   % Move two missionaries from left to right
    Mr2 is Mr + 2,
    Ml2 is Ml - 2,
    legal(Cl, Ml2, Cr, Mr2).

move([Cl, Ml, left, Cr, Mr], [Cl2, Ml, right, Cr2, Mr]) :-   % Move two cannibals from left to right
    Cr2 is Cr + 2,
    Cl2 is Cl - 2,
    legal(Cl2, Ml, Cr2, Mr).

move([Cl, Ml, left, Cr, Mr], [Cl2, Ml2, right, Cr2, Mr2]) :-   % Move one missionary and one cannibal from left to right
    Cr2 is Cr + 1,
    Cl2 is Cl - 1,
    Mr2 is Mr + 1,
    Ml2 is Ml - 1,
    legal(Cl2, Ml2, Cr2, Mr2).

move([Cl, Ml, left, Cr, Mr], [Cl, Ml2, right, Cr, Mr2]) :-   % Move one missionary from left to right
    Mr2 is Mr + 1,
    Ml2 is Ml - 1,
    legal(Cl, Ml2, Cr, Mr2).

move([Cl, Ml, left, Cr, Mr], [Cl2, Ml, right, Cr2, Mr]) :-   % Move one cannibal from left to right
    Cr2 is Cr + 1,
    Cl2 is Cl - 1,
    legal(Cl2, Ml, Cr2, Mr).

move([Cl, Ml, right, Cr, Mr], [Cl, Ml2, left, Cr, Mr2]) :-   % Move two missionaries from right to left
    Mr2 is Mr - 2,
    Ml2 is Ml + 2,
    legal(Cl, Ml2, Cr, Mr2).

move([Cl, Ml, right, Cr, Mr], [Cl2, Ml, left, Cr2, Mr]) :-   % Move two cannibals from right to left
    Cr2 is Cr - 2,
    Cl2 is Cl + 2,
    legal(Cl2, Ml, Cr2, Mr).

move([Cl, Ml, right, Cr, Mr], [Cl2, Ml2, left, Cr2, Mr2]) :-   % Move one missionary and one cannibal from right to left
    Cr2 is Cr - 1,
    Cl2 is Cl + 1,
    Mr2 is Mr - 1,
    Ml2 is Ml + 1,
    legal(Cl2, Ml2, Cr2, Mr2).

move([Cl, Ml, right, Cr, Mr], [Cl, Ml2, left, Cr, Mr2]) :-   % Move one missionary from right to left
    Mr2 is Mr - 1,
    Ml2 is Ml + 1,
    legal(Cl, Ml2, Cr, Mr2).

move([Cl, Ml, right, Cr, Mr], [Cl2, Ml, left, Cr2, Mr]) :-   % Move one cannibal from right to left
    Cr2 is Cr - 1,
    Cl2 is Cl + 1,
    legal(Cl2, Ml, Cr2, Mr).

% Recursive call to solve the problem
path([Cl1, Ml1, B1, Cr1, Mr1], [Cl2, Ml2, B2, Cr2, Mr2], Explored, MovesList) :-
    move([Cl1, Ml1, B1, Cr1, Mr1], [Cl3, Ml3, B3, Cr3, Mr3]),
    not(member([Cl3, Ml3, B3, Cr3, Mr3], Explored)),
    path([Cl3, Ml3, B3, Cr3, Mr3], [Cl2, Ml2, B2, Cr2, Mr2], [[Cl3, Ml3, B3, Cr3, Mr3] | Explored], [[[Cl3, Ml3, B3, Cr3, Mr3], [Cl1, Ml1, B1, Cr1, Mr1]] | MovesList]).

% Solution found
path([Cl, Ml, B, Cr, Mr], [Cl, Ml, B, Cr, Mr], _, MovesList) :-
    output(MovesList).

% Printing
output([]) :-
    nl.
output([[A, B] | MovesList]) :-
    output(MovesList),
    write(B), write(' -> '), write(A), nl.

% Find the solution for the missionaries and cannibals problem
find :-
    path([3, 3, left, 0, 0], [0, 0, right, 3, 3], [[3, 3, left, 0, 0]], _).

?- find.
