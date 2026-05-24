male(ivan).
male(petr).
male(alexey).
male(sergey).
male(dmitry).

female(anna).
female(olga).
female(maria).
female(irina).
female(elena).

parent(ivan, alexey).
parent(anna, alexey).

parent(ivan, maria).
parent(anna, maria).

parent(petr, sergey).
parent(olga, sergey).

parent(petr, irina).
parent(olga, irina).

parent(alexey, dmitry).
parent(irina, dmitry).

parent(alexey, elena).
parent(irina, elena).

% Father является отцом Child,
% если Father является родителем Child
% и Father является мужчиной.
father(Father, Child) :-
    parent(Father, Child),
    male(Father).

% Mother является матерью Child,
% если Mother является родителем Child
% и Mother является женщиной.
mother(Mother, Child) :-
    parent(Mother, Child),
    female(Mother).

% Son является сыном Parent,
% если Parent является родителем Son
% и Son является мужчиной.
son(Son, Parent) :-
    parent(Parent, Son),
    male(Son).

% Daughter является дочерью Parent,
% если Parent является родителем Daughter
% и Daughter является женщиной.
daughter(Daughter, Parent) :-
    parent(Parent, Daughter),
    female(Daughter).

% Child является ребенком пары Father и Mother,
% если Father является отцом Child,
% а Mother является матерью Child.
child_of_pair(Child, Father, Mother) :-
    father(Father, Child),
    mother(Mother, Child).

% Parents - родители человека Child.
parents(Child, Father, Mother) :-
    father(Father, Child),
    mother(Mother, Child).