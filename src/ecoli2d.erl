-module(ecoli2d).

-include_lib("eunit/include/eunit.hrl").

collide({aabb, _, _, _, _}, {aabb, _, _, _, _}) ->
    false.

%% tests - http://www.erlang.org/doc/apps/eunit/chapter.html
simple_test() ->
    Object1 = {aabb, 0, 0, 0, 0},
    Object2 = {aabb, 1, 1, 1, 1},
    ?assertMatch(false, collide(Object1, Object2)).

