-module(ecoli2d).

-export([collide/2]).

-include_lib("eunit/include/eunit.hrl").
-include("ecoli2d.hrl").

collide(#aabb{top=T1, bottom=B1, left=L1, right=R1},
        #aabb{top=T2, bottom=B2, left=L2, right=R2}) ->
    if
        T1 < B2 -> false;
        B1 > T2 -> false;
        L1 > R2 -> false;
        R1 < L2 -> false;
        true -> true
    end;

collide(#aabb{top=Top, bottom=Bottom}, #hline{y=Y}) ->
    if
        Y > Top -> false;
        Y < Bottom -> false;
        true -> true
    end;

collide(#aabb{left=Left, right=Right}, #vline{x=X}) ->
    if
        X > Right -> false;
        X < Left -> false;
        true -> true
    end;

collide(#hline{} = Line, #aabb{} = Box) ->
    collide(Box, Line);

collide(#vline{} = Line, #aabb{} = Box) ->
    collide(Box, Line).


%% tests - http://www.erlang.org/doc/apps/eunit/chapter.html

aabb_test() ->
    Object1 = #aabb{
        left = 0, right = 3,
        top = 3, bottom = 0
    },
    Object2 = #aabb{
        left = 2, right = 5,
        top = 5, bottom = 2
    },
    Object3 = #aabb{
        left = 0, right = 3,
        top = 7, bottom = 4
    },
    Object4 = #aabb{
        left = 10,
        right = 15,
        top = 113.2997314453124,
        bottom = 33.2997314453124
    },
    ?assertMatch(true, collide(Object1, Object1)),
    ?assertMatch(true, collide(Object1, Object2)),
    ?assertMatch(false, collide(Object1, Object3)),
    ?assertMatch(true, collide(Object4, Object4)).

aabb_hline_test() ->
    AABB = #aabb{ top = 5, bottom = 0 },
    Line = #hline{ y = 3 },
    ?assertMatch(false, collide(#hline{ y = 10 }, AABB)),
    ?assertMatch(true, collide(Line, AABB)),
    ?assertMatch(true, collide(AABB, Line)).

aabb_vline_test() ->
    AABB = #aabb{ left = 0, right = 5 },
    Line = #vline{ x = 3 },
    ?assertMatch(false, collide(#vline{ x = 10 }, AABB)),
    ?assertMatch(true, collide(Line, AABB)),
    ?assertMatch(true, collide(AABB, Line)).


