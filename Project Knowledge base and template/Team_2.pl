% This line consults the knowledge bases from this file,
% instead of needing to consult the files individually.
% This line MUST be included in the final submission.
:- ['transport_kb', 'slots_kb'].

group_helper(Group,day_timing(Week, Day)):-
    scheduled_slot(Week, Day, _, _, Group).

group_days(Group, List):-
    setof(day_timing(Week,Day), group_helper(Group,day_timing(Week, Day)), List).
