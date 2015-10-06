-module(mincb_app).

-behaviour(application).

-define(C_ACCEPTORS, 100).
-define(DEFAULT_PORT, 8080).

-export([start/2, stop/1]).


%% Start Application
%% 
%%   start the cowboy web-server, with predefined routing and ports.
%% 
start(_StartType, _StartArgs) ->
    Routes    = routes(),
    Dispatch  = cowboy_router:compile(Routes),
    Port      = ?DEFAULT_PORT,
    TransOpts = [{port, Port}],
    ProtoOpts = [{env, [{dispatch, Dispatch}]}],
    
    {ok, _}   = cowboy:start_http(http, ?C_ACCEPTORS, TransOpts, ProtoOpts),
    mincb_sup:start_link().


%% Stop Application
%% 
%%   terminate with the atom: ok
stop(_State) ->
    ok.


%% Routing
%% 
%%   routing-table for static routing of the applications 
%% priv directory to the root url
routes() ->
    [ {'_', [
            {"/", cowboy_static, {file, priv_dir("index.html")}},
            {"/[...]", cowboy_static, {dir, priv_dir()}}
            ]
      }
    ].

priv_dir() -> priv_dir("").
priv_dir(Target) ->
    {ModulePath, _} = filename:find_src(?MODULE),
    AppPath = filename:dirname(filename:dirname(ModulePath)),
    PrivPath = filename:join(AppPath, "priv/"),
    
    filename:join(PrivPath, Target).
    
