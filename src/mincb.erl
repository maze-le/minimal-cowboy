%%% System Entrypoint
%%% 
%%%   creates cowboy-environment by starting the
%%% dependent apps, and the mincb-application itself.

-module(mincb).
-export([start/0]).

start() ->
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    
    application:start(mincb).

