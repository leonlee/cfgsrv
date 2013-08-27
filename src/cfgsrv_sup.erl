%% Copyright
-module(cfgsrv_sup).
-author("Leon").

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type, Path), {I, {I, start_link, [Path]}, permanent, 5000, Type, [I]}).
-define(CFG_SERVER_PATH, "CFG_SERVER_PATH").

%% API
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    Restart_strategy = {one_for_one, 5, 10},
    Path = case os:getenv(?CFG_SERVER_PATH) of
               false -> "priv/config/dev";
               Value -> Value
           end,
    Children = [
        ?CHILD(cfgsrv_srv, worker, Path)
    ],
    {ok, {Restart_strategy, Children}}.
