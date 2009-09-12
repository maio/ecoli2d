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
    end.

%% tests - http://www.erlang.org/doc/apps/eunit/chapter.html

simple_test() ->
    Object1 = #aabb{
        top = 3, bottom = 0,
        left = 0, right = 3
    },
    Object2 = #aabb{
        top = 5, bottom = 2,
        left = 2, right = 5
    },
    Object3 = #aabb{
        top = 7, bottom = 4,
        left = 0, right = 3
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

