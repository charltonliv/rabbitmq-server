%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2007-2023 VMware, Inc. or its affiliates.  All rights reserved.
%%

-module(rabbit_json).

-export([decode/1, decode/2, try_decode/1, try_decode/2,
	 encode/1, encode/2, try_encode/1, try_encode/2]).

-define(DEFAULT_DECODE_OPTIONS, [return_maps]).


-spec decode(jsx:json_text()) -> jsx:json_term().
decode(JSON) ->
    decode(JSON, ?DEFAULT_DECODE_OPTIONS).


-spec decode(jsx:json_text(), jsx_to_term:config()) -> jsx:json_term().
decode(JSON, Opts) ->
    jsx:decode(JSON, Opts).


-spec try_decode(jsx:json_text()) -> {ok, jsx:json_term()} |
				     {error, Reason :: term()}.
try_decode(JSON) ->
    try_decode(JSON, ?DEFAULT_DECODE_OPTIONS).


-spec try_decode(jsx:json_text(), jsx_to_term:config()) ->
			{ok, jsx:json_term()} | {error, Reason :: term()}.
try_decode(JSON, Opts) ->
    try
        {ok, decode(JSON, Opts)}
    catch error: Reason ->
        {error, Reason}
    end.

-spec encode(jsx:json_term()) -> jsx:json_text().
encode(Term) ->
    encode(Term, []).

-spec encode(jsx:json_term(), jsx_to_json:config()) -> jsx:json_text().
encode(Term, Opts) ->
    jsx:encode(fixup_terms(Term), Opts).

<<<<<<< HEAD
-spec try_encode(jsx:json_term()) -> {ok, jsx:json_text()} |
=======
-spec try_encode(thoas:input_term()) -> {ok, iodata()} |
>>>>>>> 39a6eed6e0 (Fix all dialyzer warnings in peer discovery plugins)
				     {error, Reason :: term()}.
try_encode(Term) ->
    try_encode(Term, []).

<<<<<<< HEAD
-spec try_encode(jsx:json_term(), jsx_to_term:config()) ->
			{ok, jsx:json_text()} | {error, Reason :: term()}.
=======
-spec try_encode(thoas:input_term(), thoas:encode_options()) ->
			{ok, iodata()} | {error, Reason :: term()}.
>>>>>>> 39a6eed6e0 (Fix all dialyzer warnings in peer discovery plugins)
try_encode(Term, Opts) ->
    try
        {ok, encode(Term, Opts)}
    catch error: Reason ->
	    {error, Reason}
    end.

%% Fixup for JSON encoding. Transforms any Funs into strings
%% See rabbit_mgmt_format:format_nulls/1
fixup_terms(Items) when is_list(Items) ->
    [fixup_item(Pair) || Pair <- Items];
fixup_terms(Item) ->
    fixup_item(Item).

fixup_item({Key, Value}) when is_function(Value) ->
    {Key, rabbit_data_coercion:to_binary(Value)};
fixup_item({Key, Value}) when is_list(Value) ->
    {Key, fixup_terms(Value)};
fixup_item({Key, Value}) ->
    {Key, Value};
fixup_item([{_K, _V} | _T] = L) ->
    fixup_terms(L);
fixup_item(Value) when is_function(Value) ->
    rabbit_data_coercion:to_binary(Value);
fixup_item(Value) ->
    Value.
