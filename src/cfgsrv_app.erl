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
    cfgsrv_sup:start_link().

stop(_State) ->
    ok.


%% API
start() ->
    application:start(cfgsrv).

