
% remove_all(Элемент, ИсходныйСписок, Результат)
% Результат - это список без всех вхождений заданного элемента.

remove_all(_, [], []).

remove_all(X, [X | Tail], Result) :-
    remove_all(X, Tail, Result).

remove_all(X, [Head | Tail], [Head | Result]) :-
    X \= Head,
    remove_all(X, Tail, Result).

% count_element(Элемент, Список, Количество)
% Количество - число вхождений элемента в список.

count_element(_, [], 0).

count_element(X, [X | Tail], Count) :-
    count_element(X, Tail, Count1),
    Count is Count1 + 1.

count_element(X, [Head | Tail], Count) :-
    X \= Head,
    count_element(X, Tail, Count).

% remove_all_count(Элемент, ИсходныйСписок, Результат, Количество)
% Удаляет элемент и считает, сколько раз он был удален.

remove_all_count(X, List, Result, Count) :-
    remove_all(X, List, Result),
    count_element(X, List, Count).