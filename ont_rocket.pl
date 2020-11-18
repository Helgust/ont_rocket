% TEE rockets-ontology




% class country

sub_class(russia, rocket).
sub_class(angara_family, russia).

instance_of(angara_a5,angara_family).
instance_of(Rocket, _) :- sub_class(Rocket, _), !, fail.
instance_of(Rocket_family, _) :- sub_class(_, Rocket_family), !, fail.
instance_of(Car, BigClass) :- instance_of(Car, Class), sub_class(Class, BigClass),!.

%who_use
who_use(russia,roscosmos).
who_use(Country,Agency) :- instance_of(Country, Class), who_use(Class,Agency).
who_use(_,null).
%composition
composition(angara_family,batch).
composition(Family,Comp) :- instance_of(Family, Class), composition(Class,Comp).
composition(_,null).
%developer
developer(angara_family,khrunichev).
developer(Fam,Dev) :- instance_of(Fam, Class), developer(Class,Dev).
developer(_,null)
%count of stages
stages(angara_family,'2-3').
stages(Fam,C):- instance_of(Fam, Class), stages(Class,C).
stages(_,null).
%Fuel
fuel(angara_a5,'RP-1/LOX').
fuel(_,null).
%cost
cost(angara_a5,105).
cost(_,null).
%class of weight
class_ow(angara_a5,heavy).
class_ow(_,null).
%payload
payload(angara_a5,24.5).
payload(_,null).
%engine
engine(angara_a5,'RD-191').
engine(_,null).
%thrust
thrust(angara_a5,1922.1).
thrust(_,null).

angara_fam(R):-instance_of(R, angara_family), !.
rocket(R) :- instance_of(R, rocket), !.



% создаем "пользовательский" вывод предикатов - выводит строку
% в конце всегда вернет успех
get_attribute("спорткар", C) :- write("спорткар: "), show_bool(sports_car(C)).
get_attribute("представительский класс", C) :- write("представительский класс: "), show_bool(executive_class(C)).
get_attribute("семейное авто", C) :- write("семейное авто: "), show_bool(family_car(C)).
get_attribute("двухместное авто", C) :- write("двухместное авто: "), show_bool(two_seats(C)).
get_attribute("четырехместное авто", C) :- write("четырехместное авто: "), show_bool(four_seats(C)).
get_attribute("пятиместное авто", C) :- write("пятиместное авто: "), show_bool(five_seats(C)).
get_attribute("тип кузова", C) :- body_type(C, Type), not_unknown(Type), write("тип кузова: "), show_body_type(Type), !.
get_attribute("тип кузова", C) :- body_type(C, unknown), write("тип кузова: не определен").
get_attribute("число дверей", C) :- number_of_doors(C, N), not_unknown(N), write("число дверей: "), write(N), !.
get_attribute("число дверей", C) :- number_of_doors(C, unknown), write("число дверей: не определено").
get_attribute("мощность двигателя", C) :- engine_power(C, N), not_unknown(N), write("мощность двигателя: "), write(N), write(" л.c."), !.
get_attribute("мощность двигателя", C) :- engine_power(C, unknown), write("мощность двигателя: не определена").
get_attribute("страна происхождения", C) :- country_of_origin(C, X), not_unknown(X), write("страна происхождения: "), show_country(X), !.
get_attribute("страна происхождения", C) :- country_of_origin(C, unknown), write("страна происхождения: не определена").
get_attribute("год начала", C) :- year_of_beginning(C, N), write("год начала: "), not_unknown(N), write(N), write(" г."), !.
get_attribute("год начала", C) :- year_of_beginning(C, unknown), write("год начала: не определен").
get_attribute(_, _) :- write("Нет такого атрибута (возможно, Вы задали атрибут без кавычек).").
% реализация формата пользовательского ввода

start :- write("Choose action: (1 = Get attribute, 2 = Get all attributes, 3 = Show difference, 4 = exit)"), nl, read(X), process_action(X).

process_action(1) :- write("Which rocket are you interested in?"), nl, read(C),
    write("Which attribute to display? (\"спорткар\",\"представительский класс\",\"семейное авто\",\"двухместное авто\",\"четырехместное авто\",\"пятиместное авто\",\"тип кузова\",\"число дверей\",\"мощность двигателя\",\"страна происхождения\",\"год начала\")"), nl, read(A), get_attribute(A, C).

process_action(2) :- write("Для какого объекта вывести атрибуты?"), nl, read(C), get_all_attribute(C).

process_action(3) :- write("Какой первый объект хотите сравнить?"), nl, read(C1), write("С каким объектои хотите сравнить?"), nl, read(C2), show_diff_attr(C1, C2).

process_action(4) :- !.

process_action(_) :- write("Нет такого действия (возможно, Вы ввели действие без кавычек)."), nl,
    write("Введите действие еще раз или введите \"Отмена\":"), nl, read(S), process_action(S).
