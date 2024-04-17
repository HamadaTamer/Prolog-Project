% This line consults the knowledge bases from this file,
% instead of needing to consult the files individually.
% This line MUST be included in the final submission.
:- ['transport_kb', 'slots_kb'].

group_helper(Group,day_timing(Week, Day)):-
    scheduled_slot(Week, Day, _, _, Group).

group_days(Group, List):-
    setof(day_timing(Week,Day), group_helper(Group,day_timing(Week, Day)), List).


day_slots_helper(Group, Week, Day, Slots):-
    scheduled_slot(Week, Day, Slots, _, Group).
    
day_slots(Group, Week, Day, S):-
    setof(Slots ,day_slots_helper(Group, Week, Day, Slots),S).


earliest_slot(Group, Week, Day, H):-
    day_slots(Group, Week, Day , [H|_]).

proper_connection(Station_A, Station_B, Duration, Line):-
    (connection(Station_A, Station_B, Duration, Line); connection(Station_B, Station_A, Duration, Line)),
    \+ unidirectional(Line).
        
proper_connection(Station_A, Station_B, Duration, Line):-
    (connection(Station_A, Station_B, Duration, Line)),
    unidirectional(Line).
    
delete_last(List, Result) :-
        append(Result, [_], List).

        append_connection(Conn_Source, Conn_Destination, Conn_Duration, Conn_Line, Routes_So_Far, Routes):-
           last(Routes_So_Far,route(Conn_Line1, Conn_Source1, Conn_Destination1, Conn_Duration1 ) ),
            Conn_Source=Conn_Destination1,
            Conn_Line =Conn_Line1,
            D is Conn_Duration +Conn_Duration1,
            X =Conn_Source1,
            delete_last(Routes_So_Far, R),
            append(R,[route(Conn_Line, X, Conn_Destination, D )], Routes ).
    




            append_connection(Conn_Source, Conn_Destination, Conn_Duration, Conn_Line, Routes_So_Far, Routes):-
                proper_connection(Conn_Source, Conn_Destination, Conn_Duration, Conn_Line),
                last(Routes_So_Far,route(Conn_Line1, Conn_Source1, Conn_Destination1, Conn_Duration1 ) ),
                (Conn_Source\=Conn_Destination1;
                Conn_Line \=Conn_Line1),
                append(Routes_So_Far,[route(Conn_Line, Conn_Source, Conn_Destination, Conn_Duration )], Routes ).



