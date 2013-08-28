%% Copyright
-module(cfgsrv_app).
-author("Leon").

-behaviour(application).

% application
-export([start/2, stop/1]).

%% API
-export([start/0]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case cfgsrv_sup:start_link() of
        {ok, Pid} ->
            io:format("Config server was started: ~p \n", [node()]),
            {ok, Pid};
        Other ->
            io:format("Can not start config server: ~p \n", [Other]),
            {false, Other}
    end.
stop(_State) ->
    ok.


%% API
start() ->
    application:start(cfgsrv).

