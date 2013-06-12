%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse
%% Generated on 2013-06-10
%% @doc This site was based on the 'empty' skeleton.

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(tutorial).
-author("Arjan Scherpenisse").

-mod_title("tutorial zotonic site").
-mod_description("An empty Zotonic site, to base your site on.").
-mod_prio(10).
-mod_schema(1).

-include_lib("zotonic.hrl").

-export([manage_schema/2, event/2, observe_rsc_update_done/2]).

%%====================================================================
%% API functions go here
%%====================================================================


%% @doc Installs the initial domain model for this site.
manage_schema(install, _Context) ->
    #datamodel
        {
          categories=[
                      {project,
                       undefined,
                       [{title, <<"Project">>}]}
                     ],

          resources=[
                     %% The page at /projects is a listing of all pages of category 'project'
                     {page_projects,
                      'query',
                      [{title, <<"Projects">>},
                       {page_path, <<"/projects">>},
                       {'query', <<"cat=project\nsort=-publication_start">>}
                      ]},

                     {myself,
                      person,
                      [{title, <<"John 'your name here' Doe">>}]
                     }
                    ]
        }.


%% @doc Event handling function; handles form submits etc.
event(#submit{message={feedback_form, _Args}}, Context) ->
    Email = z_context:get_q_validated("email", Context),
    Message = z_context:get_q("message", Context),
    lager:warning("Email: ~p", [Email]),
    lager:warning("Message: ~p", [Message]),

    Vars = [{email, Email},
            {message, Message}],

    z_email:send_render("arjan@miraclethings.nl", "email_contact.tpl", Vars, Context),

    z_render:update("feedback-area", "<p class='alert alert-info'>Thanks!! An e-mail has been sent.</p>", Context).



%% @doc This notification function gets triggered on the update of any resource.
observe_rsc_update_done(#rsc_update_done{id=Id, post_is_a=Categories}, Context) ->
    lager:warning("Update the resource ~p which is a: ~p", [Id, Categories]),
     
    case Categories of
        [project] ->
            %% updating a project; ensure there is an edge from this
            %% project to the person with the name 'myself':

            Myself = m_rsc:name_to_id_check(myself, Context),
            lager:warning("Myself: ~p", [Myself]),

            case m_edge:get_id(Id, author, Myself, Context) of
                undefined ->
                    %% not here yet, create it
                    lager:warning("Creating author edge for project"),
                    
                    m_edge:insert(Id, author, Myself, Context);
                _ ->
                    %% already exists
                    undefined
            end,
            undefined;
        _ ->
            undefined
    end.

%%====================================================================
%% support functions go here
%%====================================================================


