-module(pub_members_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    Children = [?CHILD(pub_members_sender, worker),
    			?CHILD(pub_members_state, worker),
                ?CHILD(pub_members_scanner, worker)],
	RestartStrategy = {one_for_one, 0, 1},
	{ok, {RestartStrategy, Children}}.

