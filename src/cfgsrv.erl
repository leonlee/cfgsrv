-module(cfgsrv).
-author('chvanikoff <chvanikoff@gmail.com>').

%% API
-export([
    get/2, get/3,
    get_multiple/2,
    update/0, update/1,
    set_path/1,
    test/0
]).
-define(SERVER, {global, cfg_server}).

%% ===================================================================
%% API functions
%% ===================================================================


get(Path, Key) ->
    get(Path, Key, undefined).


get(Path, Key, Default) ->
    gen_server:call(?SERVER, {get, Path, Key, Default}).


get_multiple(Path, Keys) ->
    get_multiple(Path, Keys, []).


update() ->
    update(undefined).


update(Config_file) ->
    gen_server:cast(?SERVER, {update_config, Config_file}).


set_path(Path) ->
    gen_server:cast(?SERVER, {set_path, Path}).


test() -> gen_server:call(?SERVER, test).


%% ===================================================================
%% Internal functions
%% ===================================================================


%% This is just a wrapper. Maybe later I will implement it on lower level as gen_server callback
get_multiple(_Path, [], Results) ->
    lists:reverse(Results);

get_multiple(Path, [Key | Keys], Results) ->
    {Key2, Default} = if
        is_tuple(Key) -> Key;
        true -> {Key, undefined}
    end,
    get_multiple(Path, Keys, [get(Path, Key2, Default) | Results]).
