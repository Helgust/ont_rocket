% TEE rockets-ontology

:- dynamic sub_class/2.
:- dynamic instance_of/2.
:- dynamic country/2.
:- dynamic agency/2.
:- dynamic composition/2.
:- dynamic developer/2.
:- dynamic stages/2.
:- dynamic fuel/2.
:- dynamic cost/2.
:- dynamic class_ow/2.
:- dynamic payload/2.
:- dynamic engine/2.
:- dynamic thrust/2.




% class country

sub_class(angara_family, rocket).
sub_class(ariane_family, rocket).

instance_of(angara_a5,angara_family).
instance_of(ariane_5,ariane_family).
instance_of(Rocket, _) :- sub_class(Rocket, _), !, fail.
instance_of(Rocket_family, _) :- sub_class(_, Rocket_family), !, fail.
instance_of(Rocket, BigClass) :- instance_of(Rocket, Class), sub_class(Class, BigClass),!.

%country
country(angara_family,russia).
country(ariane_family,france).
country(Fam,Country) :- instance_of(Fam, Class), country(Class,Country).
country(_,null).

%agency
agency(angara_family,roscosmos).
agency(ariane_family,esa).
agency(Fam,Agency) :- instance_of(Fam, Class), agency(Class,Agency).
agency(_,null).

%composition
composition(angara_family,batch).
composition(ariane_family,batch).
composition(Family,Comp) :- instance_of(Family, Class), composition(Class,Comp).
composition(_,null).

%developer
developer(angara_family,khrunichev).
developer(ariane_family,airbus).
developer(Fam,Dev) :- instance_of(Fam, Class), developer(Class,Dev).
developer(_,null).

%count of stages
stages(angara_family,3).
stages(ariane_family,2).
stages(Fam,C):- instance_of(Fam, Class), stages(Class,C).
stages(_,null).

%Fuel
fuel(angara_a5,'RP-1/LOX').
fuel(ariane_5,' LH2/LOX').
fuel(_,null).

%cost
cost(angara_a5,105).
cost(ariane_5,220).
cost(_,null).

%class of weight
class_ow(angara_a5,heavy).
class_ow(ariane_5,heavy).
class_ow(_,null).

%payload
payload(angara_a5,24.5).
payload(ariane_5,20).
payload(_,null).

%engine
engine(angara_a5,'RD-191').
engine(ariane_5,'Vulcain 2').
engine(_,null).

%thrust
thrust(angara_a5,1922.1).
thrust(ariane_5,960).
thrust(_,null).


angara_fam(R):-instance_of(R, angara_family), !.
rocket(R) :- instance_of(R, rocket), !.

%Show Functions
%Show Country
show_country(russia) :- write("Russia"), !.
show_country(france) :- write("France"), !.

show_agency(roscosmos) :- write("Roscosmos"), !.
show_agency(esa) :- write("European Space Agency"), !.
show_composition(batch) :- write("Batch"), !.

show_developer(khrunichev) :- write("Khrunichev"), !.
show_developer(airbus) :- write("Airbus Defence and Space"), !.

show_class_ow(heavy):-write("Heavy class"),!.

% создаем "пользовательский" вывод предикатов - выводит строку
% в конце всегда вернет успех
%1 - страна
%2 - agency
%3 - composition
%4 - developer
%5 - count of stages
%6 - fuel
%7 - cost
%8 - weight-class
%9 - payload
%10 - engine
%11 - engine thrust

not_null(null) :- !, fail.
not_null(_) :- !.

get_attribute(1, C) :- country(C, X), not_null(X), write("Country of Origin: "), show_country(X), !.
get_attribute(1, C) :- country(C, null), write("Country of Origin: is null").
get_attribute(2, C) :- agency(C, X), not_null(X), write("Agency: "), show_agency(X), !.
get_attribute(2, C) :- agency(C, null), write("Agency: is null").
get_attribute(3, C) :- composition(C, X), not_null(X), write("Composition: "), show_composition(X), !.
get_attribute(3, C) :- composition(C, null), write("Composition: is null").
get_attribute(4, C) :- developer(C, X), not_null(X), write("Developer: "), show_developer(X), !.
get_attribute(4, C) :- developer(C, null), write("Developer: is null").
get_attribute(5, C) :- stages(C, X), not_null(X), write("Count of stages: "), write(X), !.
get_attribute(5, C) :- stages(C, null), write("Count of stages: is null").
get_attribute(6, C) :- fuel(C, X), not_null(X), write("Fuel pair: "), write(X), !.
get_attribute(6, C) :- fuel(C, null), write("Fuel pair: is null").
get_attribute(7, C) :- cost(C, X), not_null(X), write("Cost: "), write(X),write("M dollars"), !.
get_attribute(7, C) :- cost(C, null), write("Cost: is null").
get_attribute(8, C) :- class_ow(C, X), not_null(X), write("Rocket class: "), show_class_ow(X), !.
get_attribute(8, C) :- class_ow(C, null), write("Rocket class: is null").
get_attribute(9, C) :- payload(C, X), not_null(X), write("Payload mass: "), write(X),write("t on LEO"), !.
get_attribute(9, C) :- payload(C, null), write("Payload mass: is null").
get_attribute(10, C) :- engine(C, X), not_null(X), write("Engine: "), write(X), !.
get_attribute(10, C) :- engine(C, null), write("Engine: is null").
get_attribute(11, C) :- thrust(C, X), not_null(X), write("Engine Thrust: "), write(X),write("kN on sea level"), !.
get_attribute(11, C) :- thrust(C, null), write("Engine Thrust: is null").
get_attribute(_, _) :- write("No such attribute.").


get_all(C) :- get_attribute(1, C), nl, get_attribute(2, C), nl,
    get_attribute(3, C), nl, get_attribute(4, C), nl,
    get_attribute(5, C), nl, get_attribute(6, C), nl,
    get_attribute(7, C), nl, get_attribute(8, C), nl,
    get_attribute(9, C), nl, get_attribute(10, C), nl,
    get_attribute(11, C), !.

dif_bool(Bool1, Bool2) :- Bool1, Bool2, !, fail.
dif_bool(Bool1, _) :- Bool1, !.
dif_bool(_, Bool2) :- Bool2, !.
dif_bool(_, _) :- !, fail.

show_if_different(V1, V2, Attr, C1, C2) :- dif(V1, V2), get_attribute(Attr, C1), write(", "), get_attribute(Attr, C2), nl, !.
show_if_different(_, _, _, _, _) :- !.

show_diff_attr(C1, C2) :-
    country(C1, V1), country(C2, V2), show_if_different(V1, V2, 1, C1, C2),
    agency(C1, V3), agency(C2, V4), show_if_different(V3, V4, 2, C1, C2),
    composition(C1, V5), composition(C2, V6), show_if_different(V5, V6, 3, C1, C2),
    developer(C1, V7), developer(C2, V8), show_if_different(V7, V8, 4, C1, C2),
    stages(C1, V9), stages(C2, V10), show_if_different(V9, V10, 5, C1, C2),
    fuel(C1, V11), fuel(C2, V12), show_if_different(V11, V12, 6, C1, C2),
    cost(C1, V13), cost(C2, V14), show_if_different(V13, V14, 7, C1, C2),
    class_ow(C1, V15), class_ow(C2, V16), show_if_different(V15, V16, 8, C1, C2),
    payload(C1, V17), payload(C2, V18), show_if_different(V17, V18, 9, C1, C2),
    engine(C1, V19), engine(C2, V20), show_if_different(V19, V20, 10, C1, C2),
    thrust(C1, V21), thrust(C2, V22), show_if_different(V21, V22, 11, C1, C2), !.

% edit attributes
  edit_attribute(C,1,B) :- retract(country(C,_)),assert(country(C,B)).
  edit_attribute(C,2,B) :- retract(agency(C,_)),assert(agency(C,B)).
  edit_attribute(C,3,B) :- retract(composition(C,_)),assert(composition(C,B)).
  edit_attribute(C,4,B) :- retract(developer(C,_)),assert(developer(C,B)).
  edit_attribute(C,5,B) :- retract(stages(C,_)),assert(stages(C,B)).
  edit_attribute(C,6,B) :- retract(fuel(C,_)),assert(fuel(C,B)).
  edit_attribute(C,7,B) :- retract(cost(C,_)),assert(cost(C,B)).
  edit_attribute(C,8,B) :- retract(class_ow(C,_)),assert(class_ow(C,B)).
  edit_attribute(C,9,B) :- retract(payload(C,_)),assert(payload(C,B)).
  edit_attribute(C,10,B) :- retract(engine(C,_)),assert(engine(C,B)).
  edit_attribute(C,11,B) :- retract(thrust(C,_)),assert(thrust(C,B)).

% реализация формата пользовательского ввода

start :- write("Choose action: (1 = Get attribute, 2 = Get all attributes, 3 = Show difference, 4 = Edit data, q = exit)"), nl, read(X), process_action(X).

process_action(1) :- write("Which rocket are you interested in?"), nl, read(C),
    write("Which attribute to display? (\"1 = Country of origin\",\"2 = Agency\",\"3 = Composition\",\"4 = Developer\",\"5 = Count of stages\")"),nl,
    write("\"6 = Fuel pair\",\"7 = Cost\",\"8 = Rocket Class\",\"9 = Payload mass\",\"10 = Engine\",\"11 = Engine thrust\""), nl, read(A), get_attribute(A, C),nl,!,start.

process_action(2) :- write("For which object to display attributes?"), nl, read(C), get_all(C),nl,!,start.

process_action(3) :- write("Choose first object?"), nl, read(C1), write("Choose second object?"), nl, read(C2), show_diff_attr(C1, C2),nl,!,start.

process_action(4) :- add_or_edit(),!,start.
process_action(q) :- !.

process_action(_) :- write("No such action."), nl,
    write("Enter action again or 5 for  exit:"), nl, read(S), process_action(S).

add_or_edit :- write("Choose action: (1 = Add new object, 2 = Edit exist data, q = Exit from edit mode)"), nl, read(X), process_edit(X).

process_edit(1) :- write("What are you want to add?: 1 = rocket family 2 = rocket "), nl, read(E),add_object(E).

process_edit(2) :- write("What are you want to edit?: 1 = rocket family 2 = rocket "), nl, read(E),edit_object(E).

process_edit(q) :- !.

process_edit(_) :- write("No such action."), nl,
    write("Enter action again or q for  exit:"), nl, read(S), process_edit(S).

edit_object(1):-  write("Which rocket family are you interested in?"),nl, read(C),
                  write("Which class atribute you want to edit?(\"1 = Country of origin\",\"2 = Agency\",\"3 = Composition\",\"4 = Developer\",\"5 = Count of stages\")"), nl,read(A),
                  write("New value of this attribute?"), nl, read(B), edit_attribute(C,A,B),nl,!,add_or_edit.

edit_object(2):-  write("Which rocket are you interested in?"),nl, read(C),
                  write("Which rocket atribute you want to edit?(\"6 = Fuel pair\",\"7 = Cost\",\"8 = Rocket Class\",\"9 = Payload mass\",\"10 = Engine\",\"11 = Engine thrust\")"), nl,read(A),
                  write("New value of this attribute?"), nl, read(B), edit_attribute(C,A,B),nl,!,add_or_edit.

add_object(1):-   write("Name of new rocket family"), nl, read(A),nl,
                  write("Country of new rocket family"), nl, read(B),nl,
                  write("Agency of new rocket family"), nl, read(C),nl,
                  write("Composition of new rocket family"), nl, read(D),nl,
                  write("Developer of new rocket family"), nl, read(E),nl,
                  write("Count of stages in new rocket family"), nl, read(F),nl,assert(sub_class(A,rocket)),
                                                                                 assert(country(A,B)),
                                                                                 assert(agency(A,C)),
                                                                                 assert(composition(A,D)),
                                                                                 assert(developer(A,E)),
                                                                                 assert(stages(A,F)).

add_object(2):-  write("Name of exist rocket family"), nl, read(A),nl,
                  write("Name of new rocket"), nl, read(B),nl,
                  write("Fuel of new rocket"), nl, read(C),nl,
                  write("Cost of new rocket"), nl, read(D),nl,
                  write("Class of  new rocket"), nl, read(E),nl,
                  write("Payload of  new rocket"), nl, read(F),nl,
                  write("Engine of  new rocket"), nl, read(G),nl,
                  write("Thrust of  new rocket"), nl, read(U),nl, assert(instance_of(B,A)),
                                                                 assert(fuel(B,C)),
                                                                 assert(cost(B,D)),
                                                                 assert(class_ow(B,E)),
                                                                 assert(payload(B,F)),
                                                                 assert(engine(B,G)),
                                                                 assert(thrust(B,U)).
