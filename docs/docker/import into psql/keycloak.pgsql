--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloakusers;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloakusers;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloakusers;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloakusers;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloakusers;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloakusers;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloakusers;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloakusers;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloakusers;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloakusers;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloakusers;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloakusers;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloakusers;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloakusers;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloakusers;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloakusers;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloakusers;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloakusers;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloakusers;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloakusers;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloakusers;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloakusers;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloakusers;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloakusers;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloakusers;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloakusers;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloakusers;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloakusers;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloakusers;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloakusers;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloakusers;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloakusers;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloakusers;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloakusers;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloakusers;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloakusers;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloakusers;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloakusers;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloakusers;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloakusers;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloakusers;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloakusers;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloakusers;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloakusers;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloakusers;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloakusers;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloakusers;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloakusers;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloakusers;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloakusers;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloakusers;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloakusers;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloakusers;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloakusers;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloakusers;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloakusers;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloakusers;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloakusers;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloakusers;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloakusers;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloakusers;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloakusers;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloakusers;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloakusers;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloakusers;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloakusers;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloakusers;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloakusers;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloakusers;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloakusers;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloakusers;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloakusers;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloakusers;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloakusers;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloakusers;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloakusers;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloakusers;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloakusers;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloakusers;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloakusers;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloakusers;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloakusers;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloakusers;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloakusers;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloakusers;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloakusers;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloakusers;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloakusers;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloakusers;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloakusers;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloakusers;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloakusers
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloakusers;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
bbb8ec1d-0a5f-405d-9f78-157f8f25549e	\N	auth-cookie	master	7ba5febe-098a-4977-b156-48c315583b84	2	10	f	\N	\N
1bf34bab-f140-4a38-8520-3ab84ed298f5	\N	auth-spnego	master	7ba5febe-098a-4977-b156-48c315583b84	3	20	f	\N	\N
8529d8cc-49a7-4dcb-853f-0fedf43f03bc	\N	identity-provider-redirector	master	7ba5febe-098a-4977-b156-48c315583b84	2	25	f	\N	\N
eb5933d9-940f-469a-836c-afe2f97ef5f2	\N	\N	master	7ba5febe-098a-4977-b156-48c315583b84	2	30	t	51c7b0ba-418a-40a6-a0ac-622723b68a3f	\N
d0f7ae9d-f498-485d-b54b-4027e8544090	\N	auth-username-password-form	master	51c7b0ba-418a-40a6-a0ac-622723b68a3f	0	10	f	\N	\N
f4aaa148-557e-4cec-94c5-e321b05dac3b	\N	\N	master	51c7b0ba-418a-40a6-a0ac-622723b68a3f	1	20	t	b6c62a91-ff1e-4ccc-8556-8132d2d8a8b1	\N
40b65e9a-14a3-45af-a4a7-71b1c9335893	\N	conditional-user-configured	master	b6c62a91-ff1e-4ccc-8556-8132d2d8a8b1	0	10	f	\N	\N
7ec4953c-4411-45d0-a696-08f4afaf4fd1	\N	auth-otp-form	master	b6c62a91-ff1e-4ccc-8556-8132d2d8a8b1	0	20	f	\N	\N
3b89a2ed-cc47-4ffd-afa8-d3d6fee006b1	\N	direct-grant-validate-username	master	5e675127-c8a1-433d-b6c8-5ee2397eb0e7	0	10	f	\N	\N
dca77e37-a636-4142-ab1b-591ac0ef8662	\N	direct-grant-validate-password	master	5e675127-c8a1-433d-b6c8-5ee2397eb0e7	0	20	f	\N	\N
b51041b5-f6c2-47f3-9610-033439b46127	\N	\N	master	5e675127-c8a1-433d-b6c8-5ee2397eb0e7	1	30	t	2c6624d0-706c-4c8f-9d12-75da4739d58b	\N
67d9fb54-976b-4def-9782-f3e4014a9d15	\N	conditional-user-configured	master	2c6624d0-706c-4c8f-9d12-75da4739d58b	0	10	f	\N	\N
2716d34d-a543-46bb-b791-f94f32360ea1	\N	direct-grant-validate-otp	master	2c6624d0-706c-4c8f-9d12-75da4739d58b	0	20	f	\N	\N
3d2fbfeb-6962-4a35-a777-e5b946fd1ef0	\N	registration-page-form	master	172fc65a-d71f-446d-af56-397b84ea1bfa	0	10	t	f697ac7f-40f0-470e-978e-3c036f919c9c	\N
3a0228e8-97b8-43a1-a9a1-b6df454402e7	\N	registration-user-creation	master	f697ac7f-40f0-470e-978e-3c036f919c9c	0	20	f	\N	\N
bc4aae11-c260-46b5-a35c-ed91beeb0033	\N	registration-profile-action	master	f697ac7f-40f0-470e-978e-3c036f919c9c	0	40	f	\N	\N
0686b2e9-e084-4c98-a2f9-93067b053d5e	\N	registration-password-action	master	f697ac7f-40f0-470e-978e-3c036f919c9c	0	50	f	\N	\N
a712ff2f-e91f-4c19-b17f-631dbac79bcb	\N	registration-recaptcha-action	master	f697ac7f-40f0-470e-978e-3c036f919c9c	3	60	f	\N	\N
c5a8b2f1-55c9-4826-8f49-6b148fdf3a39	\N	reset-credentials-choose-user	master	f03c51a7-60d5-407d-abd6-b464e3e77274	0	10	f	\N	\N
575e8d9d-ea20-48e7-aa1a-9637aec22b43	\N	reset-credential-email	master	f03c51a7-60d5-407d-abd6-b464e3e77274	0	20	f	\N	\N
9ff949a3-2cd4-40a4-a8a6-5d0a634fec04	\N	reset-password	master	f03c51a7-60d5-407d-abd6-b464e3e77274	0	30	f	\N	\N
289cf7fb-b00b-4be4-afe7-fcfe9c8546e8	\N	\N	master	f03c51a7-60d5-407d-abd6-b464e3e77274	1	40	t	c8f8bfe5-6bfa-41ca-9a00-484e9fa82a43	\N
6ce4d012-b77c-40e5-9979-6f8b4c535ec7	\N	conditional-user-configured	master	c8f8bfe5-6bfa-41ca-9a00-484e9fa82a43	0	10	f	\N	\N
711eb1df-efc6-4164-94df-7c9871cbcdb9	\N	reset-otp	master	c8f8bfe5-6bfa-41ca-9a00-484e9fa82a43	0	20	f	\N	\N
3fe36a54-ae71-4565-b3ad-48b0ded83921	\N	client-secret	master	07117dc9-9c2d-4366-a3cc-4c65683bbc39	2	10	f	\N	\N
1768ea1d-d83c-4116-b003-6c0445281f7b	\N	client-jwt	master	07117dc9-9c2d-4366-a3cc-4c65683bbc39	2	20	f	\N	\N
dd465e57-9020-40c9-a639-2db8cddf0491	\N	client-secret-jwt	master	07117dc9-9c2d-4366-a3cc-4c65683bbc39	2	30	f	\N	\N
1adbdce4-2a72-4429-96ca-6eac92677d45	\N	client-x509	master	07117dc9-9c2d-4366-a3cc-4c65683bbc39	2	40	f	\N	\N
b92df4fa-bec5-4719-9886-d654f4f523f8	\N	idp-review-profile	master	8c936f63-a1fb-4d5c-8846-f5b20b58a248	0	10	f	\N	5298b32b-44ef-4098-aa1e-06f1849296b3
3cbb9856-d33d-4c67-83ad-e44148970f1c	\N	\N	master	8c936f63-a1fb-4d5c-8846-f5b20b58a248	0	20	t	a1d05a37-9814-43f5-972a-78f2d67ef612	\N
4a6af20d-cf0c-49bf-83d3-8d6a3f78b9a5	\N	idp-create-user-if-unique	master	a1d05a37-9814-43f5-972a-78f2d67ef612	2	10	f	\N	64199d84-772b-47bd-b237-e18224852fc5
22fb3866-8ef3-42c9-95e5-0b7a7dd8cc35	\N	\N	master	a1d05a37-9814-43f5-972a-78f2d67ef612	2	20	t	4d1f263c-b8cd-45aa-a26e-da490cf833fe	\N
edaacc53-1678-45bd-8515-b9c16e8ac83c	\N	idp-confirm-link	master	4d1f263c-b8cd-45aa-a26e-da490cf833fe	0	10	f	\N	\N
f0197d3a-ec1f-49aa-88ed-33d760113850	\N	\N	master	4d1f263c-b8cd-45aa-a26e-da490cf833fe	0	20	t	97b73c58-d431-4139-be7f-cd821f8a025b	\N
a50066c4-6e1e-495a-a057-7e93472f374d	\N	idp-email-verification	master	97b73c58-d431-4139-be7f-cd821f8a025b	2	10	f	\N	\N
c9aa0bcd-45cb-411d-a65a-50c79c061b75	\N	\N	master	97b73c58-d431-4139-be7f-cd821f8a025b	2	20	t	692c1349-8131-4192-b55e-5992f1505518	\N
07473e03-1b0c-458a-89f0-c2e5fe7a5604	\N	idp-username-password-form	master	692c1349-8131-4192-b55e-5992f1505518	0	10	f	\N	\N
b084ba9a-b281-4c0b-bf4d-4af7d79e6430	\N	\N	master	692c1349-8131-4192-b55e-5992f1505518	1	20	t	da100472-9713-4e16-b0a1-3c5f3b07d68a	\N
1379f31e-2c6e-4b7b-8db8-ffb507a7dbe1	\N	conditional-user-configured	master	da100472-9713-4e16-b0a1-3c5f3b07d68a	0	10	f	\N	\N
7697d10c-8583-4a92-849e-fd0f1a0750ee	\N	auth-otp-form	master	da100472-9713-4e16-b0a1-3c5f3b07d68a	0	20	f	\N	\N
b10bba98-9db2-48c3-9a95-2486143fc816	\N	http-basic-authenticator	master	e4ed7310-6473-469a-a31f-a3197e86b817	0	10	f	\N	\N
d0a40ac6-52a7-4cce-8138-5b1314dfde6e	\N	docker-http-basic-authenticator	master	bb87c813-8dae-4e5a-ae53-a79d518e6fb9	0	10	f	\N	\N
391e9743-0c44-40e8-971a-da35a3926297	\N	no-cookie-redirect	master	7fa8e045-49f9-4ae0-9afb-f53380483240	0	10	f	\N	\N
68b47663-5551-48f6-9f5a-6024ed221985	\N	\N	master	7fa8e045-49f9-4ae0-9afb-f53380483240	0	20	t	84caeac3-dcd8-43df-acd1-2d031d75eb9e	\N
cd621ae1-827d-4203-8a4b-c3b9b99544e6	\N	basic-auth	master	84caeac3-dcd8-43df-acd1-2d031d75eb9e	0	10	f	\N	\N
7bf66cf9-f128-40bc-8f52-5e2b10133857	\N	basic-auth-otp	master	84caeac3-dcd8-43df-acd1-2d031d75eb9e	3	20	f	\N	\N
cd0eb385-ab59-405b-acd8-1950344aaa6c	\N	auth-spnego	master	84caeac3-dcd8-43df-acd1-2d031d75eb9e	3	30	f	\N	\N
c88cc778-51d4-4268-811b-3dec80c1d16a	\N	auth-cookie	myrealm	a9bf486e-700a-44f2-b48b-b8f53ffeffd6	2	10	f	\N	\N
8a9bfe8e-9b37-4a58-a5ab-423b892f400a	\N	auth-spnego	myrealm	a9bf486e-700a-44f2-b48b-b8f53ffeffd6	3	20	f	\N	\N
3642b517-8724-4c05-9a2b-a66562594bcb	\N	identity-provider-redirector	myrealm	a9bf486e-700a-44f2-b48b-b8f53ffeffd6	2	25	f	\N	\N
3eb088c0-3ba3-4b3f-ab85-92643894bbba	\N	\N	myrealm	a9bf486e-700a-44f2-b48b-b8f53ffeffd6	2	30	t	fae9987c-4a1f-4f39-8842-ccd55c33b9c0	\N
60695aae-122c-4710-bc6e-d1fe62b9312d	\N	auth-username-password-form	myrealm	fae9987c-4a1f-4f39-8842-ccd55c33b9c0	0	10	f	\N	\N
f153eb0b-dfa6-4a99-831c-d0982a60c5ae	\N	\N	myrealm	fae9987c-4a1f-4f39-8842-ccd55c33b9c0	1	20	t	63e5e2cd-2c12-418f-b479-2eebcff40318	\N
72cbfba0-e051-4b23-af9d-a058ba4e921c	\N	conditional-user-configured	myrealm	63e5e2cd-2c12-418f-b479-2eebcff40318	0	10	f	\N	\N
f89f7ce8-95b3-4107-a9c7-f8777632f0f1	\N	auth-otp-form	myrealm	63e5e2cd-2c12-418f-b479-2eebcff40318	0	20	f	\N	\N
ee2bb830-f54f-470c-9c3f-65f2372377fa	\N	direct-grant-validate-username	myrealm	85f769c1-b200-411d-af82-67f2657d9315	0	10	f	\N	\N
7d022dd8-29e8-4876-95b3-c9154b87d74f	\N	direct-grant-validate-password	myrealm	85f769c1-b200-411d-af82-67f2657d9315	0	20	f	\N	\N
6f4303d4-3f5c-4fe1-b834-c35e0645070c	\N	\N	myrealm	85f769c1-b200-411d-af82-67f2657d9315	1	30	t	0e93c244-3dc7-4881-be1c-e6fb7c85dba5	\N
0ca64cb2-1007-4b9b-8bbd-cf33f4a247f5	\N	conditional-user-configured	myrealm	0e93c244-3dc7-4881-be1c-e6fb7c85dba5	0	10	f	\N	\N
85de983a-efe8-4cba-a45f-e9200ec73cb0	\N	direct-grant-validate-otp	myrealm	0e93c244-3dc7-4881-be1c-e6fb7c85dba5	0	20	f	\N	\N
1354018a-b61c-478f-99db-09294f1a00e4	\N	registration-page-form	myrealm	e72ace45-5afa-4707-9d95-dee5c5070cc8	0	10	t	0fc66653-6978-4a00-8ef2-636a818b6a21	\N
79de711e-e3ec-489f-8183-67c8f8b1bccd	\N	registration-user-creation	myrealm	0fc66653-6978-4a00-8ef2-636a818b6a21	0	20	f	\N	\N
9236ad67-0d47-4524-a13b-b45db138414b	\N	registration-profile-action	myrealm	0fc66653-6978-4a00-8ef2-636a818b6a21	0	40	f	\N	\N
1f972558-c0fc-4112-919c-973aee2a044a	\N	registration-password-action	myrealm	0fc66653-6978-4a00-8ef2-636a818b6a21	0	50	f	\N	\N
cb211eaa-ac64-4885-8b21-cc702fe2e3a6	\N	registration-recaptcha-action	myrealm	0fc66653-6978-4a00-8ef2-636a818b6a21	3	60	f	\N	\N
890cf4f2-2380-4ffb-988b-e51f5264d266	\N	reset-credentials-choose-user	myrealm	0f896256-15c0-407f-aa0c-676bb94eebb6	0	10	f	\N	\N
73a086ec-8d07-48be-9e33-41352e18ddb0	\N	reset-credential-email	myrealm	0f896256-15c0-407f-aa0c-676bb94eebb6	0	20	f	\N	\N
63a93974-d6e6-465c-95a7-c928ea9bf50c	\N	reset-password	myrealm	0f896256-15c0-407f-aa0c-676bb94eebb6	0	30	f	\N	\N
f2e7d64b-ab8d-4ad4-88a6-9a4ccad633c9	\N	\N	myrealm	0f896256-15c0-407f-aa0c-676bb94eebb6	1	40	t	cd940acc-186e-4180-b52b-f70772708278	\N
e1ec3fcf-147c-464c-b5b7-c5b9b2908d1e	\N	conditional-user-configured	myrealm	cd940acc-186e-4180-b52b-f70772708278	0	10	f	\N	\N
67c1964b-b29c-4b9c-91f2-ebd9cff4294a	\N	reset-otp	myrealm	cd940acc-186e-4180-b52b-f70772708278	0	20	f	\N	\N
b5d03e87-de4c-4506-afad-3872ea08027f	\N	client-secret	myrealm	31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	2	10	f	\N	\N
8693c644-d4ac-4035-8218-7393c9099465	\N	client-jwt	myrealm	31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	2	20	f	\N	\N
2afdd3a2-6cc5-4218-a41a-822bced7fba6	\N	client-secret-jwt	myrealm	31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	2	30	f	\N	\N
3b893f94-09e6-460a-9917-ece99813388e	\N	client-x509	myrealm	31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	2	40	f	\N	\N
2128da00-f104-41be-8e38-8e37e38906bf	\N	idp-review-profile	myrealm	3fc99a02-a248-48f5-8173-51b8b2eb0abd	0	10	f	\N	c44566ab-3f9c-4f03-9994-1ff389cc8f68
a454da6b-7848-4880-a765-d95b808d374f	\N	\N	myrealm	3fc99a02-a248-48f5-8173-51b8b2eb0abd	0	20	t	dbd65867-5567-4d8b-9d49-e7ee714970fb	\N
30f94b07-5a08-490e-9366-7441dbd744fc	\N	idp-create-user-if-unique	myrealm	dbd65867-5567-4d8b-9d49-e7ee714970fb	2	10	f	\N	afae3278-500f-4bcf-93b5-5f7530ec457d
348f6d3f-583d-42ca-b328-6409ee24a1c3	\N	\N	myrealm	dbd65867-5567-4d8b-9d49-e7ee714970fb	2	20	t	00585cf6-00c7-45a3-840b-ed264f50651e	\N
85ffcf80-37d5-47ef-857b-dee696bd6d71	\N	idp-confirm-link	myrealm	00585cf6-00c7-45a3-840b-ed264f50651e	0	10	f	\N	\N
b6769348-f9e1-466b-9a59-6f4de2d6cafb	\N	\N	myrealm	00585cf6-00c7-45a3-840b-ed264f50651e	0	20	t	fd8a4153-728d-4718-ab03-5ffe790c741d	\N
2b187eb4-339f-4fec-84d0-af7a0956d321	\N	idp-email-verification	myrealm	fd8a4153-728d-4718-ab03-5ffe790c741d	2	10	f	\N	\N
554b105a-3ede-438e-96dc-17712c53a0f5	\N	\N	myrealm	fd8a4153-728d-4718-ab03-5ffe790c741d	2	20	t	aa21570b-9739-4e2c-80b3-dc1d236239bc	\N
c1cfa0a2-77fc-41d6-9ef7-c48f25b1b140	\N	idp-username-password-form	myrealm	aa21570b-9739-4e2c-80b3-dc1d236239bc	0	10	f	\N	\N
d2cf043f-f4d6-41f0-8670-02ee70d91169	\N	\N	myrealm	aa21570b-9739-4e2c-80b3-dc1d236239bc	1	20	t	c83f749c-9ad1-4bb3-b915-8384732500ad	\N
1c35c96b-4e8a-4c92-94f0-6e8047ea268a	\N	conditional-user-configured	myrealm	c83f749c-9ad1-4bb3-b915-8384732500ad	0	10	f	\N	\N
d73c556a-1a6b-42a7-a106-1fb5e2f59cef	\N	auth-otp-form	myrealm	c83f749c-9ad1-4bb3-b915-8384732500ad	0	20	f	\N	\N
a25abf02-0e56-43be-bff1-df78c86c3cb1	\N	http-basic-authenticator	myrealm	60c2e894-9261-4cfc-bbc0-de4c51c3b96e	0	10	f	\N	\N
4e0eaa73-2ba4-4a45-9f83-d38b9b432fe5	\N	docker-http-basic-authenticator	myrealm	79b5e1e5-b995-4902-889c-99306de16483	0	10	f	\N	\N
a70d19de-e1ca-44e9-97b7-ae2d0dfacbe6	\N	no-cookie-redirect	myrealm	cb176b47-3d4c-4487-9629-dec362fb3635	0	10	f	\N	\N
6109df44-0b84-4701-9c55-b94f29797310	\N	\N	myrealm	cb176b47-3d4c-4487-9629-dec362fb3635	0	20	t	1aa2c58c-844c-42ae-9543-02eb12ff6e7e	\N
cfbf7cae-68d0-46de-91a2-66d99f6241b6	\N	basic-auth	myrealm	1aa2c58c-844c-42ae-9543-02eb12ff6e7e	0	10	f	\N	\N
c1cf4056-c300-4694-ba54-3895d2742336	\N	basic-auth-otp	myrealm	1aa2c58c-844c-42ae-9543-02eb12ff6e7e	3	20	f	\N	\N
9df24b2d-06c6-456c-87b9-1584a68cc59b	\N	auth-spnego	myrealm	1aa2c58c-844c-42ae-9543-02eb12ff6e7e	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
7ba5febe-098a-4977-b156-48c315583b84	browser	browser based authentication	master	basic-flow	t	t
51c7b0ba-418a-40a6-a0ac-622723b68a3f	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
b6c62a91-ff1e-4ccc-8556-8132d2d8a8b1	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
5e675127-c8a1-433d-b6c8-5ee2397eb0e7	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
2c6624d0-706c-4c8f-9d12-75da4739d58b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
172fc65a-d71f-446d-af56-397b84ea1bfa	registration	registration flow	master	basic-flow	t	t
f697ac7f-40f0-470e-978e-3c036f919c9c	registration form	registration form	master	form-flow	f	t
f03c51a7-60d5-407d-abd6-b464e3e77274	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
c8f8bfe5-6bfa-41ca-9a00-484e9fa82a43	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
07117dc9-9c2d-4366-a3cc-4c65683bbc39	clients	Base authentication for clients	master	client-flow	t	t
8c936f63-a1fb-4d5c-8846-f5b20b58a248	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
a1d05a37-9814-43f5-972a-78f2d67ef612	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
4d1f263c-b8cd-45aa-a26e-da490cf833fe	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
97b73c58-d431-4139-be7f-cd821f8a025b	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
692c1349-8131-4192-b55e-5992f1505518	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
da100472-9713-4e16-b0a1-3c5f3b07d68a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
e4ed7310-6473-469a-a31f-a3197e86b817	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
bb87c813-8dae-4e5a-ae53-a79d518e6fb9	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
7fa8e045-49f9-4ae0-9afb-f53380483240	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
84caeac3-dcd8-43df-acd1-2d031d75eb9e	Authentication Options	Authentication options.	master	basic-flow	f	t
a9bf486e-700a-44f2-b48b-b8f53ffeffd6	browser	browser based authentication	myrealm	basic-flow	t	t
fae9987c-4a1f-4f39-8842-ccd55c33b9c0	forms	Username, password, otp and other auth forms.	myrealm	basic-flow	f	t
63e5e2cd-2c12-418f-b479-2eebcff40318	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	myrealm	basic-flow	f	t
85f769c1-b200-411d-af82-67f2657d9315	direct grant	OpenID Connect Resource Owner Grant	myrealm	basic-flow	t	t
0e93c244-3dc7-4881-be1c-e6fb7c85dba5	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	myrealm	basic-flow	f	t
e72ace45-5afa-4707-9d95-dee5c5070cc8	registration	registration flow	myrealm	basic-flow	t	t
0fc66653-6978-4a00-8ef2-636a818b6a21	registration form	registration form	myrealm	form-flow	f	t
0f896256-15c0-407f-aa0c-676bb94eebb6	reset credentials	Reset credentials for a user if they forgot their password or something	myrealm	basic-flow	t	t
cd940acc-186e-4180-b52b-f70772708278	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	myrealm	basic-flow	f	t
31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	clients	Base authentication for clients	myrealm	client-flow	t	t
3fc99a02-a248-48f5-8173-51b8b2eb0abd	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	myrealm	basic-flow	t	t
dbd65867-5567-4d8b-9d49-e7ee714970fb	User creation or linking	Flow for the existing/non-existing user alternatives	myrealm	basic-flow	f	t
00585cf6-00c7-45a3-840b-ed264f50651e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	myrealm	basic-flow	f	t
fd8a4153-728d-4718-ab03-5ffe790c741d	Account verification options	Method with which to verity the existing account	myrealm	basic-flow	f	t
aa21570b-9739-4e2c-80b3-dc1d236239bc	Verify Existing Account by Re-authentication	Reauthentication of existing account	myrealm	basic-flow	f	t
c83f749c-9ad1-4bb3-b915-8384732500ad	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	myrealm	basic-flow	f	t
60c2e894-9261-4cfc-bbc0-de4c51c3b96e	saml ecp	SAML ECP Profile Authentication Flow	myrealm	basic-flow	t	t
79b5e1e5-b995-4902-889c-99306de16483	docker auth	Used by Docker clients to authenticate against the IDP	myrealm	basic-flow	t	t
cb176b47-3d4c-4487-9629-dec362fb3635	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	myrealm	basic-flow	t	t
1aa2c58c-844c-42ae-9543-02eb12ff6e7e	Authentication Options	Authentication options.	myrealm	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
5298b32b-44ef-4098-aa1e-06f1849296b3	review profile config	master
64199d84-772b-47bd-b237-e18224852fc5	create unique user config	master
c44566ab-3f9c-4f03-9994-1ff389cc8f68	review profile config	myrealm
afae3278-500f-4bcf-93b5-5f7530ec457d	create unique user config	myrealm
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
5298b32b-44ef-4098-aa1e-06f1849296b3	missing	update.profile.on.first.login
64199d84-772b-47bd-b237-e18224852fc5	false	require.password.update.after.registration
c44566ab-3f9c-4f03-9994-1ff389cc8f68	missing	update.profile.on.first.login
afae3278-500f-4bcf-93b5-5f7530ec457d	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e615a998-ce2e-496e-8d8a-824631ec71bb	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1955c150-4e96-4811-9fc4-f2ed449b775c	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
539e9552-1819-4a73-984d-2eeeea4080e2	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
33733792-52dc-45e2-bfbf-06d9cac73042	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
adc485fb-5671-4264-ab59-ff30a8f0568e	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
0576139e-ee82-4326-b273-2190f13ea9c6	t	f	myrealm-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	myrealm Realm	f	client-secret	\N	\N	\N	t	f	f	f
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	f	realm-management	0	f	\N	\N	t	\N	f	myrealm	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
89cbcac4-beb0-4311-870d-ec381b37ef31	t	f	account	0	t	\N	/realms/myrealm/account/	f	\N	f	myrealm	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	t	f	account-console	0	t	\N	/realms/myrealm/account/	f	\N	f	myrealm	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
fa8f134a-3e18-4bab-baab-de5aaa616c7f	t	f	broker	0	f	\N	\N	t	\N	f	myrealm	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
171b2d4e-1059-4a64-add3-a5ec4eca0e74	t	f	security-admin-console	0	t	\N	/admin/myrealm/console/	f	\N	f	myrealm	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	t	f	admin-cli	0	t	\N	\N	f	\N	f	myrealm	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
f0bd39ff-0349-4c12-ada3-6f33c8106917	t	t	spring	0	t	\N	\N	f	http://localhost:8080/	f	myrealm	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:8080/	\N	\N	t	f	t	f
929cd39d-d1ba-4601-bead-f42caa5d2960	t	t	vaadin	0	t	\N	\N	f	http://localhost:8081/	f	myrealm	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:8081/	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
1955c150-4e96-4811-9fc4-f2ed449b775c	S256	pkce.code.challenge.method
33733792-52dc-45e2-bfbf-06d9cac73042	S256	pkce.code.challenge.method
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	S256	pkce.code.challenge.method
171b2d4e-1059-4a64-add3-a5ec4eca0e74	S256	pkce.code.challenge.method
929cd39d-d1ba-4601-bead-f42caa5d2960	true	backchannel.logout.session.required
929cd39d-d1ba-4601-bead-f42caa5d2960	false	backchannel.logout.revoke.offline.tokens
f0bd39ff-0349-4c12-ada3-6f33c8106917	true	backchannel.logout.session.required
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	backchannel.logout.revoke.offline.tokens
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.artifact.binding
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.server.signature
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.server.signature.keyinfo.ext
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.assertion.signature
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.client.signature
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.encrypt
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.authnstatement
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.onetimeuse.condition
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml_force_name_id_format
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.multivalued.roles
929cd39d-d1ba-4601-bead-f42caa5d2960	false	saml.force.post.binding
929cd39d-d1ba-4601-bead-f42caa5d2960	false	exclude.session.state.from.auth.response
929cd39d-d1ba-4601-bead-f42caa5d2960	false	oidc.ciba.grant.enabled
929cd39d-d1ba-4601-bead-f42caa5d2960	true	use.refresh.tokens
929cd39d-d1ba-4601-bead-f42caa5d2960	false	id.token.as.detached.signature
929cd39d-d1ba-4601-bead-f42caa5d2960	false	tls.client.certificate.bound.access.tokens
929cd39d-d1ba-4601-bead-f42caa5d2960	false	require.pushed.authorization.requests
929cd39d-d1ba-4601-bead-f42caa5d2960	false	client_credentials.use_refresh_token
929cd39d-d1ba-4601-bead-f42caa5d2960	false	display.on.consent.screen
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.artifact.binding
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.server.signature
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.server.signature.keyinfo.ext
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.assertion.signature
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.client.signature
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.encrypt
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.authnstatement
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.onetimeuse.condition
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml_force_name_id_format
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.multivalued.roles
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	saml.force.post.binding
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	exclude.session.state.from.auth.response
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	oauth2.device.authorization.grant.enabled
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	oidc.ciba.grant.enabled
f0bd39ff-0349-4c12-ada3-6f33c8106917	true	use.refresh.tokens
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	id.token.as.detached.signature
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	tls.client.certificate.bound.access.tokens
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	require.pushed.authorization.requests
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	client_credentials.use_refresh_token
f0bd39ff-0349-4c12-ada3-6f33c8106917	false	display.on.consent.screen
929cd39d-d1ba-4601-bead-f42caa5d2960	customnew	login_theme
929cd39d-d1ba-4601-bead-f42caa5d2960	true	oauth2.device.authorization.grant.enabled
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
f66cce05-feef-40f8-893a-aa09663e579e	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
2ceec3af-bebe-45f6-8c38-57c7f537e34f	role_list	master	SAML role list	saml
16b8cc65-e95e-48bd-924c-8376febeace7	profile	master	OpenID Connect built-in scope: profile	openid-connect
fcd34867-0744-4d67-aaef-3835013a9c54	email	master	OpenID Connect built-in scope: email	openid-connect
10d06b92-bfa5-4c87-9c4b-011f55fbd054	address	master	OpenID Connect built-in scope: address	openid-connect
a74bb0d2-61df-4dcc-8a60-2013f3ff986f	phone	master	OpenID Connect built-in scope: phone	openid-connect
020e6593-e82a-455d-97ff-8f32531de638	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
7928f232-1171-4191-b9bc-57d206871c5a	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b75509cb-74eb-4c2c-bf93-71e9f6017127	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
388a29f9-b19c-46b7-a5af-e8bb7ea72e25	offline_access	myrealm	OpenID Connect built-in scope: offline_access	openid-connect
6b696e80-d687-4e20-a557-8cb57f705556	role_list	myrealm	SAML role list	saml
f2186244-b17b-43f3-a8ec-4e73f6ff3449	profile	myrealm	OpenID Connect built-in scope: profile	openid-connect
e71c2b3a-a104-4ac2-b14a-52f81c8fba86	email	myrealm	OpenID Connect built-in scope: email	openid-connect
ff0ed600-bb21-4b37-96d2-9ea203e22026	address	myrealm	OpenID Connect built-in scope: address	openid-connect
f7a17a10-8562-4bf6-87fe-8a195aab2d3c	phone	myrealm	OpenID Connect built-in scope: phone	openid-connect
70e64905-c869-444a-8d32-da8b1b911373	roles	myrealm	OpenID Connect scope for add user roles to the access token	openid-connect
2890129b-f216-4410-924e-01d2f093fd22	web-origins	myrealm	OpenID Connect scope for add allowed web origins to the access token	openid-connect
405a3817-eb1d-4f7b-ba2d-5256e193d50a	microprofile-jwt	myrealm	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
f66cce05-feef-40f8-893a-aa09663e579e	true	display.on.consent.screen
f66cce05-feef-40f8-893a-aa09663e579e	${offlineAccessScopeConsentText}	consent.screen.text
2ceec3af-bebe-45f6-8c38-57c7f537e34f	true	display.on.consent.screen
2ceec3af-bebe-45f6-8c38-57c7f537e34f	${samlRoleListScopeConsentText}	consent.screen.text
16b8cc65-e95e-48bd-924c-8376febeace7	true	display.on.consent.screen
16b8cc65-e95e-48bd-924c-8376febeace7	${profileScopeConsentText}	consent.screen.text
16b8cc65-e95e-48bd-924c-8376febeace7	true	include.in.token.scope
fcd34867-0744-4d67-aaef-3835013a9c54	true	display.on.consent.screen
fcd34867-0744-4d67-aaef-3835013a9c54	${emailScopeConsentText}	consent.screen.text
fcd34867-0744-4d67-aaef-3835013a9c54	true	include.in.token.scope
10d06b92-bfa5-4c87-9c4b-011f55fbd054	true	display.on.consent.screen
10d06b92-bfa5-4c87-9c4b-011f55fbd054	${addressScopeConsentText}	consent.screen.text
10d06b92-bfa5-4c87-9c4b-011f55fbd054	true	include.in.token.scope
a74bb0d2-61df-4dcc-8a60-2013f3ff986f	true	display.on.consent.screen
a74bb0d2-61df-4dcc-8a60-2013f3ff986f	${phoneScopeConsentText}	consent.screen.text
a74bb0d2-61df-4dcc-8a60-2013f3ff986f	true	include.in.token.scope
020e6593-e82a-455d-97ff-8f32531de638	true	display.on.consent.screen
020e6593-e82a-455d-97ff-8f32531de638	${rolesScopeConsentText}	consent.screen.text
020e6593-e82a-455d-97ff-8f32531de638	false	include.in.token.scope
7928f232-1171-4191-b9bc-57d206871c5a	false	display.on.consent.screen
7928f232-1171-4191-b9bc-57d206871c5a		consent.screen.text
7928f232-1171-4191-b9bc-57d206871c5a	false	include.in.token.scope
b75509cb-74eb-4c2c-bf93-71e9f6017127	false	display.on.consent.screen
b75509cb-74eb-4c2c-bf93-71e9f6017127	true	include.in.token.scope
388a29f9-b19c-46b7-a5af-e8bb7ea72e25	true	display.on.consent.screen
388a29f9-b19c-46b7-a5af-e8bb7ea72e25	${offlineAccessScopeConsentText}	consent.screen.text
6b696e80-d687-4e20-a557-8cb57f705556	true	display.on.consent.screen
6b696e80-d687-4e20-a557-8cb57f705556	${samlRoleListScopeConsentText}	consent.screen.text
f2186244-b17b-43f3-a8ec-4e73f6ff3449	true	display.on.consent.screen
f2186244-b17b-43f3-a8ec-4e73f6ff3449	${profileScopeConsentText}	consent.screen.text
f2186244-b17b-43f3-a8ec-4e73f6ff3449	true	include.in.token.scope
e71c2b3a-a104-4ac2-b14a-52f81c8fba86	true	display.on.consent.screen
e71c2b3a-a104-4ac2-b14a-52f81c8fba86	${emailScopeConsentText}	consent.screen.text
e71c2b3a-a104-4ac2-b14a-52f81c8fba86	true	include.in.token.scope
ff0ed600-bb21-4b37-96d2-9ea203e22026	true	display.on.consent.screen
ff0ed600-bb21-4b37-96d2-9ea203e22026	${addressScopeConsentText}	consent.screen.text
ff0ed600-bb21-4b37-96d2-9ea203e22026	true	include.in.token.scope
f7a17a10-8562-4bf6-87fe-8a195aab2d3c	true	display.on.consent.screen
f7a17a10-8562-4bf6-87fe-8a195aab2d3c	${phoneScopeConsentText}	consent.screen.text
f7a17a10-8562-4bf6-87fe-8a195aab2d3c	true	include.in.token.scope
70e64905-c869-444a-8d32-da8b1b911373	true	display.on.consent.screen
70e64905-c869-444a-8d32-da8b1b911373	${rolesScopeConsentText}	consent.screen.text
70e64905-c869-444a-8d32-da8b1b911373	false	include.in.token.scope
2890129b-f216-4410-924e-01d2f093fd22	false	display.on.consent.screen
2890129b-f216-4410-924e-01d2f093fd22		consent.screen.text
2890129b-f216-4410-924e-01d2f093fd22	false	include.in.token.scope
405a3817-eb1d-4f7b-ba2d-5256e193d50a	false	display.on.consent.screen
405a3817-eb1d-4f7b-ba2d-5256e193d50a	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e615a998-ce2e-496e-8d8a-824631ec71bb	16b8cc65-e95e-48bd-924c-8376febeace7	t
e615a998-ce2e-496e-8d8a-824631ec71bb	fcd34867-0744-4d67-aaef-3835013a9c54	t
e615a998-ce2e-496e-8d8a-824631ec71bb	020e6593-e82a-455d-97ff-8f32531de638	t
e615a998-ce2e-496e-8d8a-824631ec71bb	7928f232-1171-4191-b9bc-57d206871c5a	t
e615a998-ce2e-496e-8d8a-824631ec71bb	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
e615a998-ce2e-496e-8d8a-824631ec71bb	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
e615a998-ce2e-496e-8d8a-824631ec71bb	f66cce05-feef-40f8-893a-aa09663e579e	f
e615a998-ce2e-496e-8d8a-824631ec71bb	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
1955c150-4e96-4811-9fc4-f2ed449b775c	16b8cc65-e95e-48bd-924c-8376febeace7	t
1955c150-4e96-4811-9fc4-f2ed449b775c	fcd34867-0744-4d67-aaef-3835013a9c54	t
1955c150-4e96-4811-9fc4-f2ed449b775c	020e6593-e82a-455d-97ff-8f32531de638	t
1955c150-4e96-4811-9fc4-f2ed449b775c	7928f232-1171-4191-b9bc-57d206871c5a	t
1955c150-4e96-4811-9fc4-f2ed449b775c	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
1955c150-4e96-4811-9fc4-f2ed449b775c	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
1955c150-4e96-4811-9fc4-f2ed449b775c	f66cce05-feef-40f8-893a-aa09663e579e	f
1955c150-4e96-4811-9fc4-f2ed449b775c	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
adc485fb-5671-4264-ab59-ff30a8f0568e	16b8cc65-e95e-48bd-924c-8376febeace7	t
adc485fb-5671-4264-ab59-ff30a8f0568e	fcd34867-0744-4d67-aaef-3835013a9c54	t
adc485fb-5671-4264-ab59-ff30a8f0568e	020e6593-e82a-455d-97ff-8f32531de638	t
adc485fb-5671-4264-ab59-ff30a8f0568e	7928f232-1171-4191-b9bc-57d206871c5a	t
adc485fb-5671-4264-ab59-ff30a8f0568e	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
adc485fb-5671-4264-ab59-ff30a8f0568e	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
adc485fb-5671-4264-ab59-ff30a8f0568e	f66cce05-feef-40f8-893a-aa09663e579e	f
adc485fb-5671-4264-ab59-ff30a8f0568e	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
539e9552-1819-4a73-984d-2eeeea4080e2	16b8cc65-e95e-48bd-924c-8376febeace7	t
539e9552-1819-4a73-984d-2eeeea4080e2	fcd34867-0744-4d67-aaef-3835013a9c54	t
539e9552-1819-4a73-984d-2eeeea4080e2	020e6593-e82a-455d-97ff-8f32531de638	t
539e9552-1819-4a73-984d-2eeeea4080e2	7928f232-1171-4191-b9bc-57d206871c5a	t
539e9552-1819-4a73-984d-2eeeea4080e2	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
539e9552-1819-4a73-984d-2eeeea4080e2	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
539e9552-1819-4a73-984d-2eeeea4080e2	f66cce05-feef-40f8-893a-aa09663e579e	f
539e9552-1819-4a73-984d-2eeeea4080e2	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	16b8cc65-e95e-48bd-924c-8376febeace7	t
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	fcd34867-0744-4d67-aaef-3835013a9c54	t
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	020e6593-e82a-455d-97ff-8f32531de638	t
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	7928f232-1171-4191-b9bc-57d206871c5a	t
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	f66cce05-feef-40f8-893a-aa09663e579e	f
21f6af08-726c-4988-ad0f-6f0a58b5bb1e	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
33733792-52dc-45e2-bfbf-06d9cac73042	16b8cc65-e95e-48bd-924c-8376febeace7	t
33733792-52dc-45e2-bfbf-06d9cac73042	fcd34867-0744-4d67-aaef-3835013a9c54	t
33733792-52dc-45e2-bfbf-06d9cac73042	020e6593-e82a-455d-97ff-8f32531de638	t
33733792-52dc-45e2-bfbf-06d9cac73042	7928f232-1171-4191-b9bc-57d206871c5a	t
33733792-52dc-45e2-bfbf-06d9cac73042	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
33733792-52dc-45e2-bfbf-06d9cac73042	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
33733792-52dc-45e2-bfbf-06d9cac73042	f66cce05-feef-40f8-893a-aa09663e579e	f
33733792-52dc-45e2-bfbf-06d9cac73042	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
89cbcac4-beb0-4311-870d-ec381b37ef31	70e64905-c869-444a-8d32-da8b1b911373	t
89cbcac4-beb0-4311-870d-ec381b37ef31	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
89cbcac4-beb0-4311-870d-ec381b37ef31	2890129b-f216-4410-924e-01d2f093fd22	t
89cbcac4-beb0-4311-870d-ec381b37ef31	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
89cbcac4-beb0-4311-870d-ec381b37ef31	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
89cbcac4-beb0-4311-870d-ec381b37ef31	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
89cbcac4-beb0-4311-870d-ec381b37ef31	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
89cbcac4-beb0-4311-870d-ec381b37ef31	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	70e64905-c869-444a-8d32-da8b1b911373	t
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	2890129b-f216-4410-924e-01d2f093fd22	t
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	70e64905-c869-444a-8d32-da8b1b911373	t
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	2890129b-f216-4410-924e-01d2f093fd22	t
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
d35e58a1-eb92-4cc4-943f-8bfe4a7971f6	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
fa8f134a-3e18-4bab-baab-de5aaa616c7f	70e64905-c869-444a-8d32-da8b1b911373	t
fa8f134a-3e18-4bab-baab-de5aaa616c7f	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
fa8f134a-3e18-4bab-baab-de5aaa616c7f	2890129b-f216-4410-924e-01d2f093fd22	t
fa8f134a-3e18-4bab-baab-de5aaa616c7f	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
fa8f134a-3e18-4bab-baab-de5aaa616c7f	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
fa8f134a-3e18-4bab-baab-de5aaa616c7f	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
fa8f134a-3e18-4bab-baab-de5aaa616c7f	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
fa8f134a-3e18-4bab-baab-de5aaa616c7f	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	70e64905-c869-444a-8d32-da8b1b911373	t
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	2890129b-f216-4410-924e-01d2f093fd22	t
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
171b2d4e-1059-4a64-add3-a5ec4eca0e74	70e64905-c869-444a-8d32-da8b1b911373	t
171b2d4e-1059-4a64-add3-a5ec4eca0e74	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
171b2d4e-1059-4a64-add3-a5ec4eca0e74	2890129b-f216-4410-924e-01d2f093fd22	t
171b2d4e-1059-4a64-add3-a5ec4eca0e74	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
171b2d4e-1059-4a64-add3-a5ec4eca0e74	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
171b2d4e-1059-4a64-add3-a5ec4eca0e74	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
171b2d4e-1059-4a64-add3-a5ec4eca0e74	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
171b2d4e-1059-4a64-add3-a5ec4eca0e74	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
929cd39d-d1ba-4601-bead-f42caa5d2960	70e64905-c869-444a-8d32-da8b1b911373	t
929cd39d-d1ba-4601-bead-f42caa5d2960	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
929cd39d-d1ba-4601-bead-f42caa5d2960	2890129b-f216-4410-924e-01d2f093fd22	t
929cd39d-d1ba-4601-bead-f42caa5d2960	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
929cd39d-d1ba-4601-bead-f42caa5d2960	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
929cd39d-d1ba-4601-bead-f42caa5d2960	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
929cd39d-d1ba-4601-bead-f42caa5d2960	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
929cd39d-d1ba-4601-bead-f42caa5d2960	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
f0bd39ff-0349-4c12-ada3-6f33c8106917	70e64905-c869-444a-8d32-da8b1b911373	t
f0bd39ff-0349-4c12-ada3-6f33c8106917	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
f0bd39ff-0349-4c12-ada3-6f33c8106917	2890129b-f216-4410-924e-01d2f093fd22	t
f0bd39ff-0349-4c12-ada3-6f33c8106917	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
f0bd39ff-0349-4c12-ada3-6f33c8106917	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
f0bd39ff-0349-4c12-ada3-6f33c8106917	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
f0bd39ff-0349-4c12-ada3-6f33c8106917	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
f0bd39ff-0349-4c12-ada3-6f33c8106917	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
f66cce05-feef-40f8-893a-aa09663e579e	a9b21537-3edc-46df-9e35-99e78ea3d507
388a29f9-b19c-46b7-a5af-e8bb7ea72e25	7846e664-9f8f-42be-be3c-5958afee0f07
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7fc5e2a0-266e-4b64-b008-e7bae0e394f8	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
539217e3-4eb2-4b15-b62b-aeee86275f4f	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
43ef296d-eab1-442b-93be-42a5167b1d34	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
583c4c88-93d1-46c8-864f-39d6a0f0a8c7	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
95b21fd4-29bd-4993-9b91-38f7410cac7e	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
119d54d3-491f-4bd0-8736-6b5e1ae55d4f	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0e8f5909-2970-4b6a-9d59-521ac65fcf96	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
e01fd24b-4644-4729-b081-f316df0e4acf	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
4c55490e-5d8f-4bab-b7d3-02da65a1aa32	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
bc95b34c-cbee-4007-aee6-85fa1e94c2dc	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
644af0ae-b5e2-4011-b20c-ee07241b30b7	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
539ce8ec-02a0-4502-a40c-ed787c2cd107	rsa-generated	myrealm	rsa-generated	org.keycloak.keys.KeyProvider	myrealm	\N
9ff2d001-0879-4cf6-8179-7325968ebfa5	rsa-enc-generated	myrealm	rsa-enc-generated	org.keycloak.keys.KeyProvider	myrealm	\N
488cc767-2404-4adf-bb91-83ef5ca89c9e	hmac-generated	myrealm	hmac-generated	org.keycloak.keys.KeyProvider	myrealm	\N
15816279-248b-4974-a492-5b721b25ae04	aes-generated	myrealm	aes-generated	org.keycloak.keys.KeyProvider	myrealm	\N
d930f197-99c7-4728-8300-e1a8b48371a3	Trusted Hosts	myrealm	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
4b0d1031-f8b4-437b-bbf4-37926da0bc4a	Consent Required	myrealm	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
000f6fad-fe03-4bc2-8746-3eb17dfe262c	Full Scope Disabled	myrealm	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
59e6c4db-1bb8-49f4-b0ea-f27761897c70	Max Clients Limit	myrealm	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
f1479951-420c-4404-ad2a-7dc0090e4110	Allowed Protocol Mapper Types	myrealm	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
df33bba4-8688-47e0-aca3-5ef2f5d27ddb	Allowed Client Scopes	myrealm	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	anonymous
e6ada015-4741-4265-9c48-d11cf6401f2f	Allowed Protocol Mapper Types	myrealm	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	authenticated
b6f6d239-800c-4ed9-8ac5-04fc99a630c0	Allowed Client Scopes	myrealm	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	myrealm	authenticated
73cd9de8-0307-4072-89ea-fdd30ac02783	\N	myrealm	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	myrealm	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
832338c2-0afd-470f-ab8d-ec9e046c4770	e01fd24b-4644-4729-b081-f316df0e4acf	allow-default-scopes	true
adb66641-4902-4d0a-9614-9106a38ed23a	583c4c88-93d1-46c8-864f-39d6a0f0a8c7	max-clients	200
108bc7a4-da97-4e49-a734-df8cdb6e8749	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	oidc-address-mapper
99d74018-2058-4939-9b92-942799dfe7c4	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	saml-user-attribute-mapper
12fc0fc1-9177-4f26-8578-85ef3418842c	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c13b818b-826b-4446-91a4-b94485f8bd37	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	oidc-full-name-mapper
cbb83e06-d8d5-4e68-9cb5-210afee18a5d	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
af2f93e5-cc61-43dc-8767-88a6f8c3b702	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	saml-role-list-mapper
26b74f26-b7da-4243-8b41-a2bfc97a9815	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	saml-user-property-mapper
3dcb8123-99c8-467c-a1c0-d4dad0d98b84	0e8f5909-2970-4b6a-9d59-521ac65fcf96	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bef32a1f-8a66-416f-aa3b-cc89bb5cb280	7fc5e2a0-266e-4b64-b008-e7bae0e394f8	host-sending-registration-request-must-match	true
2c215437-c33b-400a-9881-3d76db6f6948	7fc5e2a0-266e-4b64-b008-e7bae0e394f8	client-uris-must-match	true
6e4dce9f-c912-4b1b-bab4-dab6b9d666e4	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c873d835-0268-47cc-aabb-2600e300b829	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	saml-user-attribute-mapper
b627183e-daf8-4fc2-8c5f-ab6a2c482185	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	saml-user-property-mapper
61007bfc-0b18-47d8-b811-b6ba7e070589	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
93de84c5-cc71-4bb7-904c-dd1de12ebfc2	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
85d72b1a-00d6-47f9-a6cc-60b86e2bbe40	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	oidc-address-mapper
c00c8e91-4e0a-47a7-a3c9-eaeeb7fd520a	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	oidc-full-name-mapper
321252e9-79fd-4e70-aaf2-b3182765748c	95b21fd4-29bd-4993-9b91-38f7410cac7e	allowed-protocol-mapper-types	saml-role-list-mapper
b3d35c84-528d-486f-988c-9edf383edba5	119d54d3-491f-4bd0-8736-6b5e1ae55d4f	allow-default-scopes	true
3665bd56-8d90-4bb9-a90a-3aacea0c730c	644af0ae-b5e2-4011-b20c-ee07241b30b7	kid	5a828159-07d3-40c8-95b6-67b951585de8
f6ded5c2-c35a-493a-82b2-e76c3ab6cb56	644af0ae-b5e2-4011-b20c-ee07241b30b7	secret	5Q78EewWYc7abOSgPT64Tw
d417f562-8b4b-4cd0-a240-35b3101e852f	644af0ae-b5e2-4011-b20c-ee07241b30b7	priority	100
45da9556-2d6b-4843-acdb-e0544aa6f465	ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	privateKey	MIIEowIBAAKCAQEAkukYwBXi216lLbalVYaKk3zXHGxWNUfzsTx6J6Tq3cqRTmNMHglL0Kk2o0lAIEEp1lzX1uRR3cLV0YJr5zoVGO/+CMuKjW3GpThfLjkoMBj3P+FAihPBSgHDhKwrhUofRymTawtwFV/51rGSJ5eK6cqvmbeB84m6PnUhIdt1jqBNI78tLygCdF3j/tfKPE8DhKWIes2fikv1NtkonBL78gcx1HEMaQCcFsRAXCIS/nYFWEbY2XxS7G63kMOa+dH8eY80NgLjl4NW5dvwYjViftnt9lXvk6851PO5D+fA06gL9GBWonY3F+rj07uwMMkxx0Cp1OPYcAEaO6zy8o7cOQIDAQABAoIBACGSIpXCapS2jAhmNGHW3NPXM1DLcOe8CXP23fMxPHpyT8IZ7sruVOTZxiKKGp1ERss1bB0vD4Ydf77gjsfH/go0zVg1KvQmob4fo6Bsb0KOcfGnB5iF6yV+Qa+PqGJNDdi1J3rOok5AIFdvPHbPqm7CYl4+EPQWBPlAytFx1OtCXN4xd+ZAc72KfdTdSFP9xe0VJcx7TCasCFFCFPni4GhJmvRkkOw/rv6dXIKGh3BsLV4oLkj4gjVS1St50ZNXnvCoRJShHj1mlEoBXRAbjFRS+4KkIXJdcYbdKW/u1VanRLWYTezlVE7ey+YbFwXWEifm6NfHgYiwQhoygyOewgECgYEA3wnbLEb1rqJ0wMLDLMKClV1OM7BeAXFxGx6bOoqf017N+tJGxxc7DggpO8ywSqBtSEA9XucOq+BsEx5qLXEy8XirSC3hniRtyDMfC/PvT0ff+++Dp5JmonILfj+hAvjUI2QlCDvw2MOUnHeAx9C8vQ/pofBQM+PghdFRJotYVrcCgYEAqJ8dm9oa6KP+AMi+yGToboPeqqSsdiG9mrAh7QsGZr5EGYEUTLCq1TJ/NCbp9EhdkBACsxb2Nqx4nelXSkzXEoUkpylmazfsxsGvGKUZ1AmWHoL/nPQsoJyjkzSC0owd1XjC53lWTh7zXBATknqg1QY6TNafPobmaZHwFVLw9I8CgYEAh5hzYejGBmSHvITrqXObdfkiyPPpQtFX5RfnYWDTp+pUKa/bDcDGy1IU12EqsEP2DF3Zsa+hUMcAjWMJRBU01m75GsmiB8W35GWH83lavQVCW+USUjcEJLBW4msGlUr3lYiVpvriArZsy+8vIMt7YymgbS4vZEyevFw0DM3cZ+MCgYBinMNdHP11pkpqvPvOCC1iTF6RH0L4xxyydWUx0qvItGbxH2r2uq79hc2ce1GBGj0VfjeF8tzE9rKHbyoseqmg3BqmY/DQrWEcj7LNz+g99+lCKMxCRw4+U7zZ3vDPH0BnUntxkaVmhHVAFurLVEnwqva3byCsGYpwnPdyERJ3gwKBgBbYJH/ZTzL4XRPaNjpv5Jvo6rXXHewxJlVStC1C3puUObKKmmisF/7kwosgO91zWhEx8HJfmSaccfqKzZyC26+rrTg7viAB/vlJu7cvT/LeRoecMYLsPVRefvzHmEReghMOIHBo0e2lOj4yE9TZV8BssLYiJM1lZIzmshPyE+Fi
bb46e9de-1f4f-430d-962f-6828a039b47f	ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	algorithm	RSA-OAEP
dd85ec70-565a-431c-a537-85783e12130a	ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	priority	100
2fbd791e-a7ce-4313-bcec-cdfe528dbb85	ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	certificate	MIICmzCCAYMCBgF+jKktLDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMTI0MTUxNTA0WhcNMzIwMTI0MTUxNjQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCS6RjAFeLbXqUttqVVhoqTfNccbFY1R/OxPHonpOrdypFOY0weCUvQqTajSUAgQSnWXNfW5FHdwtXRgmvnOhUY7/4Iy4qNbcalOF8uOSgwGPc/4UCKE8FKAcOErCuFSh9HKZNrC3AVX/nWsZInl4rpyq+Zt4Hzibo+dSEh23WOoE0jvy0vKAJ0XeP+18o8TwOEpYh6zZ+KS/U22SicEvvyBzHUcQxpAJwWxEBcIhL+dgVYRtjZfFLsbreQw5r50fx5jzQ2AuOXg1bl2/BiNWJ+2e32Ve+TrznU87kP58DTqAv0YFaidjcX6uPTu7AwyTHHQKnU49hwARo7rPLyjtw5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIqHZqh2EAPlbQUblDorFPBFdQ+eNFTXhBGWKDCIBH1K8Xlu66CD6CsIJX+fBe06wUaF7mTLjzX1t5fZ3GvOFT5m79UKGmliBh4z+7rbc1BV5UxwCtJZISdizQqHki4Jsiu+poF/IhhBaZcVOPPkGUqf2aPdmO9YUXD1g7+tWwNB4r0BpXqu5P8EfK4zo35rSJzig9++/gf0bkk+6mArg5O94roC58piMJSaasAGICr6lXbk+HGwsBIFH3E2edn564GRiHMdsyQAa/p6m0H7p0nTOwZ0vnWLZeSwyCBwPkWBpObGch0Hb+DuxlkpsUBzIuXOCFVdoMOcJZktzhNDMUY=
c761a27c-51a5-4566-8e10-61387de07435	ddce288a-9cb2-4c4e-a6a1-e779ab35ceb4	keyUse	ENC
d1d11db6-f2a1-435a-b37e-0002631a04d5	bc95b34c-cbee-4007-aee6-85fa1e94c2dc	kid	8ac982f6-05ac-407a-96ff-32637bc74ce3
273d7d11-36e8-4e54-b47d-f546bc5356dd	bc95b34c-cbee-4007-aee6-85fa1e94c2dc	priority	100
67b392ce-e0ca-4bff-88a5-8ecc806b4a86	bc95b34c-cbee-4007-aee6-85fa1e94c2dc	algorithm	HS256
378174d2-b199-45fe-b6f9-8a439e890abb	bc95b34c-cbee-4007-aee6-85fa1e94c2dc	secret	okfSOP_sfjRLU7q5Grez2Xv7cXzqnWrJdyQi4zj1NyYbq9uAiPWLYpNO-lGlP28E0TVB8DpWOOvVh8yZkmDWpQ
1068dca4-f1ff-41a7-a245-9174ca1db1e8	4c55490e-5d8f-4bab-b7d3-02da65a1aa32	keyUse	SIG
39d96e0f-1401-437d-9a46-4295ebb86054	4c55490e-5d8f-4bab-b7d3-02da65a1aa32	priority	100
4f7d906e-8d0c-4aba-8316-e1c8bdd124e2	4c55490e-5d8f-4bab-b7d3-02da65a1aa32	privateKey	MIIEowIBAAKCAQEAlIYnVhyksB6Qt5Q296hshH0q5N2j21IXA4su0gtq3vDuczQN6pQOnFAKMmUq6EIXW9p5R1SXib35wBUsmhwhW1lx7Q6BQev7iyRAJWLS7wWahpVjzRH/deCY0/OjGBKqOFNN3VLkwvBX4kdGQum+zU1r/sZFlIs878E2F8htToKkF16sP1Efy92R57KAX9KQJXGB+D9Jez3HDLi/OMxE306d1EM0OSisMDe3eU7bU3kqTKLOGLPvLsRynuRXtQTxSCxx2vbtrNYB/QTG/IBkWoWJlQOCZakf5miAzAolIBSCC6RhBRMxPo1pw7QoxrOoJvh92eDxuk8JSYh9oqLjrQIDAQABAoIBADAJt/1dJFMmf64wzRqLKhYsGcyOd2n/ghwOT2V2demHycgPJRUjMBqUtMeZ+yfGAKIf5qwQizbs8DOVZaiuwoc2RefjkiENP33AitLMxOa0TEeNWAtC7/pjW2rqWWz21IGFSCD2p7D5ZaN1ZB9OVP04Nl7gKC8kXeA6ANHubJRAoGebJnJ0YuNVxAzigup/1exFtda3+R4w4nZcoSiFK898hH5LV2+/m5NvPmkQvDykW6Hi4SYWapaqHaYHL042WtZwiLqnbYd/5xL98jlwYH8yh/Kl4GcLDMyw62bKAhBLzJH4GMH2eHvdugGCJiDQDOJHSANNuXKlIpWBxo8qV80CgYEA/Zo/rkWHQHY9K6vlKlhDwls0RBJUtAupr704Wnzek+VbI3cR+D4gqz+YI6RBonUcjleWDui56f/Fgg6x7bEFyhsSV1mxC7hZf/lCklwRomZU9QN5mUJjatm24Zf6wTsZyjnD9i0Cn5WnRJgmnC9FRyKyFt8Y5STlzkLGziIJ8scCgYEAle2Z6bohutEC3z01VcaZAQUk4Xp0s0nlzCCLWnFJm1N8wnFjKiQ52rcT6CCRiTzYr9VUNQNFrPVzoCnq1CIMf2ofm9M9KSOIqaQksT8YaywhhLJqODVDBypb2T/zgXrYxUz+1Lxq1BSHPoeEz0g9Kwow2mHQpq8asJ04yje/wesCgYEA5z10/4UqdJ7b3CxbQ6dD8b6UA9XrIljYGwSgk/H0SksCNW5nFkIgK8ZLBYTKzEWZCjnW/DU9AJ9WCuc3WpLlwom4yalhBFzOTyCLkUUeV0SUBu1qPVMJr+5hEYcxAGzRcVIG2zvjfnxJDwTlf9iihOCgHrbCzn48hTziZicnhxUCgYAVl+4GAr/e50GRo4AuBXd99R61tuxd8jO9raZEdXKTg3fBjZEpvaPzg1DDqwUrDe9ri78gD4OWgJeRptfii7DfHQrGZ6s0ZKDHRhPez2aV8Po24Xd49vrbaldmN9a7fFUCPa+qNiTwvLAp6lzPeekNbN9SZKonh6rBazOFtHfS1wKBgFQWVUzmNaA04Eju7kKzxYqAMzaFsJl5M4iivqfKQt6psjkdXd8YI94JyPc5jrn5L9we9PvvtalFDrxaw27tpRRwGN7jU0e6wIiLDni1gZQfIkq3L4iSDLZM+F5Q5bifmdl2OHp/knOWBte+lCaGRlI76SBedHgwxWgM/ZRMeMaQ
dbec321a-01cb-4d0d-8202-2e999ed1c888	4c55490e-5d8f-4bab-b7d3-02da65a1aa32	certificate	MIICmzCCAYMCBgF+jKkszjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMTI0MTUxNTA0WhcNMzIwMTI0MTUxNjQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUhidWHKSwHpC3lDb3qGyEfSrk3aPbUhcDiy7SC2re8O5zNA3qlA6cUAoyZSroQhdb2nlHVJeJvfnAFSyaHCFbWXHtDoFB6/uLJEAlYtLvBZqGlWPNEf914JjT86MYEqo4U03dUuTC8FfiR0ZC6b7NTWv+xkWUizzvwTYXyG1OgqQXXqw/UR/L3ZHnsoBf0pAlcYH4P0l7PccMuL84zETfTp3UQzQ5KKwwN7d5TttTeSpMos4Ys+8uxHKe5Fe1BPFILHHa9u2s1gH9BMb8gGRahYmVA4JlqR/maIDMCiUgFIILpGEFEzE+jWnDtCjGs6gm+H3Z4PG6TwlJiH2iouOtAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEwdIRUDUAK5Gg99G7Xigrcmy1XVwEwDzeq99hLlX5TveB3gYPVWRreTz61+/1bpW4VxBM15o6r9bV2eyFPAPOq2cKKI6CETQBjfguYx49MpD7gs1aiixUNWOxSAf81TqJD93S8XumPH4fiIzQ4wDDTasFYPhwzWbMZ0fifdZiGpXQVh8/YUGMO71poUWPbdyDD2Gr1bf1mZh/PeHkWlkwSgKhvzZAVL35eBxn8U1Huo9YKcpWgSlWHyoL5yTP4kqVGRGpbPX3KMJbDaH6TRsZ+9H/zZ4PZLUWqlBkmgEQHNph+HXDmOuIymoeJhxemNsLiem6HVh0wjzJy5tInnLVc=
a46676b1-a1e9-4582-a35e-376bc5fa4cc4	15816279-248b-4974-a492-5b721b25ae04	priority	100
4dfb60ad-0035-4d07-9a84-9b79c289fef3	15816279-248b-4974-a492-5b721b25ae04	kid	549aec50-5172-46e9-941c-17f724cc1cfc
40a3c111-464f-46f0-8426-4cb86fbe78c3	15816279-248b-4974-a492-5b721b25ae04	secret	y3XYYYquVkuvcHsfMj4_Ig
ea73788b-af23-4208-9fc2-987cf1758685	488cc767-2404-4adf-bb91-83ef5ca89c9e	secret	PjJs1-6cF5jFC4AmlVFkeT7mzr1UZ2UK0qNjZKIf7Vgf4uiXzsSZ-kZw5ZvmBLDHShp7HOPC_cSSpL--PYRw1A
d9922032-b93c-4160-8bd8-60dcab1dbd34	488cc767-2404-4adf-bb91-83ef5ca89c9e	priority	100
3dfbf5ae-340d-44fe-97f7-11686019783a	488cc767-2404-4adf-bb91-83ef5ca89c9e	kid	112f989d-0b3b-4e11-9b64-0a5a042422a3
6a00cb21-6780-48db-9898-76eff5ffe137	488cc767-2404-4adf-bb91-83ef5ca89c9e	algorithm	HS256
618899d0-f99d-4e51-b751-cf9a22a9a652	9ff2d001-0879-4cf6-8179-7325968ebfa5	priority	100
2c95141e-b82e-4b19-acca-ba4ff56ea263	9ff2d001-0879-4cf6-8179-7325968ebfa5	privateKey	MIIEpAIBAAKCAQEA4ZAhFMDw5lUkxfUDyUD6orqhHMuE/sNmhcRfWfvvmOs/ukuPHl234o1B0tbGQVgtO3mp3376f5IkRt5G6qDSQM0quLmuf533RS+ZNGFt8aORNUKIlvhwqQfVH+gyjE0iZ+ecd2onz4J3XQ9ZOzGBckHi6+dYvdcO/hBw+88gnfjBePZ20WgxHtLck6bG3d8ahiy6rHtltg4LRWmB8laDUfjall53Ti51qopKI+9+5BUEwowPzgU/E7MeuAg7MmVwOj/Z+wijRwYCcpI5e8iEl+y9oDpbhBa/jD7F5s0a1u4sLtfD4S0NYQ+f2b87Hb0rBytxO+UEsEdHZb1nyBsWXQIDAQABAoIBAEI2ct+Ku6yBdef+QnxDbM90BXNUctfuOBwwRuU9RVoYRH7FS1/YlvAUEyx3C3+HCNAaqLkIpzPnjGqZOSwKxW1sTIwpRYYEst9GV6y+pO133FpMC5h1mWyk9fUFzkDNK7pgjNeo+8K4Q523sbPklmEZ4ijpom0nwijmXqQsayCzpchwFNKcn0vXBK/xN258sS5Ztc9MpjQknV/hwCqWokPvLljpxVI3otuGYRysjRx7wx3QNoI4TSVxo4NYwCy0EjEF41pCw6Uegf35+eRu8PXQBf/qwkbr9gaw+NY1Q2UjlrcPKX3KEW9L7aRgksXj856l7ZyaNnLTBKL/JciQaikCgYEA9joJ5F8sZ1OkjyBSp7mKxv1jKPq+Y+CMa44V4cD2fQryrtSv7AfvA8fTRM+O+UEb221Rog3t49IXIUwnD5uKAQ3i+zAMF17aOCcbd9KMvbzw7m3movjK8kAnFNDvuTUocyZhMNJadChOOgcEk3OXf97S+6owHB0KKeaKB0OcjksCgYEA6oQfTuQECH12vSL7c8ByCC0d7u+wiCTwL1GQ/zoYBbYDBtd6I1H/nDaIVNaTwb5tY9zcsKAkx0Je5eh7l02qWJ3e0khInE19Dfe8l+X0nnjRcT//HMbUFF/hTIx0lKwV4tXD4XoHmOkpVupOZoi119WioQXTa7cRebbTqagZ5PcCgYA0CgIrNP4yfFgMM92kOy+cbNM3Rv9UJpIm7Smsw9aUiOrPjn372ZVnbCU3ptJl1Z/omUsmf+EmRDHFRM4Am3PoUyIEypvTmKVwNru0cFh0hWk6SxnymbhyyKI54Qq5TwXUiGkEI4EgiaA23WLXMxfy24olzEtMtcp/Ho1PibedzwKBgQCVZbHkOhHvrq2z89MofFKorsVA7+UP9igknNu4HDQtfzQSabbfRV+HDp5vHXtnk35wfcUBqCOF5Nw7roz9aHa6mWfXokDPgfXGrimwwsfBJMqYUOKeXHPCvwnyEBA8nhwbM37j5y9r1C2HtyBW5YSiiPBfkCyNlERHu5a/n91PJQKBgQCdFMUs2J1heEltAzKdKnxyJD/ou/FshwTJ20FedvA51a2xQWPQDJ68ptYO34bUBLH37LCeV07PTIbaXPVaPMablcgClo7xOQ0OkHKM5KDJYi1sn1+f3sRtQ65BDfYbtfnnjFLqQuJt03PS5FIm31Iw+eOiWBDqudXdvfSRt+T/oA==
1d43f39a-a47d-44b0-8456-0f06c4e51aed	9ff2d001-0879-4cf6-8179-7325968ebfa5	keyUse	ENC
818d7985-37c7-4ed4-b73f-1179f6fc21d3	9ff2d001-0879-4cf6-8179-7325968ebfa5	certificate	MIICnTCCAYUCBgF+nYllFjANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdteXJlYWxtMB4XDTIyMDEyNzIxNTM1NFoXDTMyMDEyNzIxNTUzNFowEjEQMA4GA1UEAwwHbXlyZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOGQIRTA8OZVJMX1A8lA+qK6oRzLhP7DZoXEX1n775jrP7pLjx5dt+KNQdLWxkFYLTt5qd9++n+SJEbeRuqg0kDNKri5rn+d90UvmTRhbfGjkTVCiJb4cKkH1R/oMoxNImfnnHdqJ8+Cd10PWTsxgXJB4uvnWL3XDv4QcPvPIJ34wXj2dtFoMR7S3JOmxt3fGoYsuqx7ZbYOC0VpgfJWg1H42pZed04udaqKSiPvfuQVBMKMD84FPxOzHrgIOzJlcDo/2fsIo0cGAnKSOXvIhJfsvaA6W4QWv4w+xebNGtbuLC7Xw+EtDWEPn9m/Ox29KwcrcTvlBLBHR2W9Z8gbFl0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAtMKxZJ0ap05p8t4N4OCOA3c+CHWgg4kMfDKvrHkifRHAp6EEoXlm1Khiu5F+q6Os+lSX8zKQArRum9tvnOJZlFjKfnMuDnSnHSWNB3wB33bhKUl36x0VfqGjVNnabEm+SJ579Pmg0sCMHD5jpZxbegKukoGgfQP5TJDQUDGXMppTYA+FDZA7lodwMzPrbiZ7h5nMhs3XtU9V/nYBKcSZiMR6jixeyefVp/kZge7REhYe1ktM2+2IhCkULBPxuV4RcBh2eb0EBm8trqXwMefA0xQeAeodi3v6C9jtkvy+HzMfLT8Tstn44uj6TPF+rUid+oRegVjV9yFFKPvNehiZRw==
aa9ae369-8966-4864-b7b0-d924d693c5ce	9ff2d001-0879-4cf6-8179-7325968ebfa5	algorithm	RSA-OAEP
3b1bba6d-50ec-47d0-8f3e-91290c3f61fe	539ce8ec-02a0-4502-a40c-ed787c2cd107	privateKey	MIIEowIBAAKCAQEAiiNJn667CU5piERs/lrVac5uNfdSxzUjdq6I7ET2E9Aou7rkmYgoI0lb+lp0nUDQwZ0127hxlvLF/jOWsUS8cWjZR30dFgg7/K0FlG6qTh2MO82aA7XsW0Srd1cbeQpjyWNlmQR+oRhqFKN1MEY4BHzQuVzwMzg8FLBz5m9utMlpAe5ZOBoYW5lhy49muD9bvGRGw/2d3Mlku+HRF243UuHfMpf/NWbJo+hQipWClf3r/VoVNVLSjP3ekV9u+oYckF/ll5lxq0EoCuAkv7OO26DoP5OU+tRf0hTQWhNZQv7i6/5XYixfDVGiAH6fIu3i40goN4OmHtF5EmCWvvPR6wIDAQABAoIBAFTLRnVLx6n1xRgNkK4tydTyD3r2/4wi1UsT5h7KUhdlbquWFJ8eEi1e6aPrBKxGzh4bR6VBOhDDo7/foP/dxqMDDmUwqrsMgO4gs00jBU2AG8XV9lWSxaxcobhW8xlAxHIpnoLoXGa82tkiYVwprlcq2uD96MA4I8E7c1mfS2CTXlnXMDraxR8AbNfRIvgWpIHbtA6KYmfGbstAyZb9e1b0H2bdtjRNwxGMCx1uO6BK2hP3Tzwr6nhce849sIWusPvMFD9tdZ5KgX8zGoSE/TlrbqCY/aalY+j4sqgy+E5BC/B/1Cz/dOIVX1J+vLsybTZP6NH8tj8dkihKUPlCSFkCgYEAy24EwqsmDtgF/yIq92hOqYy2aQ++LOez9KCPsi6ZK6qckp4S4aX2Hx9Etf4hoKB89s+hWbo+Tnfey9tjhNUwdMN7pCMmD6/FYrATN+lw15isyA5MoNlT2r0EFD5XAp6UE3J1z7YYZ0i6gN9OiNkMgapwWBkfIzapDHEWg4R7b2UCgYEArdXazHgGA6+3YPRn/K8SWWLFWsDGXkrASizs0fGMwnk3LRZA2l+oAfbdSqapeEuCvLc/o4M0mNNzG/v+LNpOh8g6CuwYElTGuo6+Ewo0BITeoRsAMG2QxNSI8EitdqzO/AkLxjblLWJIyPGz1+NK0+7y0A/mPnLdo1Ak/I7F7w8CgYBpzSWSrXrUu4ua3wVjuY835WQ1jieFqVhRwXQa4tts94YJR0dgrnUsSJHu6WZJ6U40+1Xamd+v5e4tLkQ7ILnb8JOMkW9JN0y8gADu0m2K4+/w+GboPT+8gxPtB2MvjJRM7PnS9s0IYq4FOp7Y07IKej+FwkMMiHAxdVuVOUENdQKBgDcc+DOfUfjVOwSIOHfKYbzpLbzqJXo7pN9fgu3E8WWu3Kl0xrb1YOTOibZjRJOZDSgbyRdkP8a8M2CJ8jnyNLej6ZMQ60jUi/UV0Hlk4L0WCyd00giIlD9zSr8zq5tWioEptQvw15Qd9wmOaABoVY7/0QfaIptl+5MNk8xmz6ZNAoGBAIXqOPt9mapOcnMFeNPffQDxuEDrYHJF68h2Vxryg2UnxNLtv++gir4YBD/JIa7xJqqt/LtsOh3xDe2HBDIegWbm8FocjjoO88LPBjLUjFO3rrVpSSvbQMAoQgnf4Fi4MBfL/0QOkMyW7c5nn8QUgJA/R00OcGnkv+dtrJqHcZ4B
6a5ec203-f4f8-43da-a136-f0a7fa541a5e	539ce8ec-02a0-4502-a40c-ed787c2cd107	certificate	MIICnTCCAYUCBgF+nYljgTANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdteXJlYWxtMB4XDTIyMDEyNzIxNTM1M1oXDTMyMDEyNzIxNTUzM1owEjEQMA4GA1UEAwwHbXlyZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIojSZ+uuwlOaYhEbP5a1WnObjX3Usc1I3auiOxE9hPQKLu65JmIKCNJW/padJ1A0MGdNdu4cZbyxf4zlrFEvHFo2Ud9HRYIO/ytBZRuqk4djDvNmgO17FtEq3dXG3kKY8ljZZkEfqEYahSjdTBGOAR80Llc8DM4PBSwc+ZvbrTJaQHuWTgaGFuZYcuPZrg/W7xkRsP9ndzJZLvh0RduN1Lh3zKX/zVmyaPoUIqVgpX96/1aFTVS0oz93pFfbvqGHJBf5ZeZcatBKArgJL+zjtug6D+TlPrUX9IU0FoTWUL+4uv+V2IsXw1RogB+nyLt4uNIKDeDph7ReRJglr7z0esCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAHpjdyPii/qQ8ylV+P8FTHPH20nG8j9VyFjQ8ucDv8rSDuEJ9RtnG7ej5rBhyxbcUgwrpvY8BBNgPGLhdBmnGTbq6+y9qb8XIkQ3mEYtsHRg/ig8uLjMJNrU4wAbxeZBW5OSU+/9FDiIalNpda7vxdxBL3Lkg04J/wszk9ptXRooX0Lpi9jdvMxu1i3VNtRc3+ONP3C/PvNqca36yScgXe4TGYan+1y/tOCaskwCo5/0v0f4dYKReBT1J4C2vnXL7GkYjcgfZV8M/5Gp9bYE3gEgdpXbXNWP27U9uGWwvo5a4PV7qZaJWZq9Wj6JE/gOY0CktCbhGNr+z26H9Fm+yAA==
4d525d09-b464-43fc-85a2-67697ec09090	539ce8ec-02a0-4502-a40c-ed787c2cd107	priority	100
06c4aeda-9e92-494a-9940-9649f952884b	539ce8ec-02a0-4502-a40c-ed787c2cd107	keyUse	SIG
8b548069-22ba-4268-8f49-e05060a0c598	59e6c4db-1bb8-49f4-b0ea-f27761897c70	max-clients	200
14a07925-110f-44f6-8413-3dd40383c7de	df33bba4-8688-47e0-aca3-5ef2f5d27ddb	allow-default-scopes	true
a9fa5b18-38ae-463f-bab2-5447d56aa679	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5cc7293e-d3f3-4de6-ad5d-7d6f78e808d8	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	oidc-full-name-mapper
516302de-fead-479a-a052-8b79b7b7982c	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	saml-role-list-mapper
a1df02aa-9249-4017-9907-44b4fc20250f	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	saml-user-property-mapper
b9a7e5b8-4a88-4453-b030-e37cb9effe50	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e72e9279-c30e-4feb-a6df-25d9ab8b4a32	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	saml-user-attribute-mapper
a97076c6-1c80-4c35-9072-6ca8ddcd144e	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	oidc-address-mapper
612686b9-6c75-43e0-a442-5021a35f0af9	e6ada015-4741-4265-9c48-d11cf6401f2f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
647f9f7e-a41c-4242-b488-850d3ca167c9	d930f197-99c7-4728-8300-e1a8b48371a3	client-uris-must-match	true
5372afbb-5a7c-4caf-b181-743010deb47e	d930f197-99c7-4728-8300-e1a8b48371a3	host-sending-registration-request-must-match	true
f3b92555-4a9f-4be1-b8e1-309051f2e592	b6f6d239-800c-4ed9-8ac5-04fc99a630c0	allow-default-scopes	true
008aec59-178e-4de2-882e-5ce0ac9edf5c	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c2b83aee-e341-4ba5-8191-b41f6ab0e0c2	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	saml-user-property-mapper
f427cdaa-2465-40d2-bb3f-aa1ffcd6d5d3	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	oidc-address-mapper
ff9b2b6d-3e33-4382-b940-2c89f7208efb	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	saml-user-attribute-mapper
451da38f-def5-4706-a5b7-32142eafce12	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	saml-role-list-mapper
42f37fae-fccf-4406-9d0c-2688fa4facb7	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
12f68f32-1e02-4722-bbef-1bff863525fc	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
752409bb-046e-42cc-b415-e1af4b840d34	f1479951-420c-4404-ad2a-7dc0090e4110	allowed-protocol-mapper-types	oidc-full-name-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.composite_role (composite, child_role) FROM stdin;
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	f5a22de3-c155-415c-a55c-f556c31274c9
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	5157e3d3-14a3-48e6-a1f6-e27ed7a7ebf5
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	f4268f54-126d-4857-8599-190efa147b18
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	e3e4797b-1b61-4da2-b804-81d1964844ac
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c7b28573-2504-497d-9fc7-0d28ab358179
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	2fe68c80-a1eb-421c-a290-341df3acd9d7
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	237289e9-3fe6-4dab-acdf-77cb403cb222
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	5302cd4e-fb43-435d-a151-597fc0832706
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	e64ab02c-e2a7-4aeb-be52-ea3f4e0b9a07
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c301c36e-c193-4bd6-9f27-918fc0237041
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c065c8c3-9248-431a-96b8-43f182f3ae41
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	9fae1ddc-36d3-4621-be86-4422a94c4526
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	d0e9b6f3-b9f7-4186-b10d-3e25450d1706
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	db7cfefb-f032-4695-913b-87884a92c4bb
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	3c1e7595-54bd-4d77-8509-e4e08c794a85
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c80ce4d3-fffe-4d5d-a6aa-e55b0b36f66c
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	fc75bde0-8808-4de8-a34c-e2532468431c
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	b208c8d5-cb7c-4ccf-b6b2-c345089edc21
c7b28573-2504-497d-9fc7-0d28ab358179	c80ce4d3-fffe-4d5d-a6aa-e55b0b36f66c
e3e4797b-1b61-4da2-b804-81d1964844ac	b208c8d5-cb7c-4ccf-b6b2-c345089edc21
e3e4797b-1b61-4da2-b804-81d1964844ac	3c1e7595-54bd-4d77-8509-e4e08c794a85
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	1ef11b5a-896e-4e24-bf09-1b5f767ea187
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	c7f68041-2bfe-4010-9a3f-1010cba231cc
c7f68041-2bfe-4010-9a3f-1010cba231cc	00f65e08-af53-4f0a-95e9-fd3c935ce909
b2039134-f184-4655-9280-28e4038ab95c	7437240e-feb1-4bc0-8088-4a4fad2bfc98
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	846deb85-8c7a-4bc0-b6b2-476849624c17
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	a9b21537-3edc-46df-9e35-99e78ea3d507
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	6d98569b-9078-4cae-a3ea-c44e6c587fd6
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	bf1e33fe-ed0d-49ea-960a-70687ba7d5d0
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c5a36dd0-0471-464c-9eb3-9e98defa8db6
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	d0f548c0-1c13-45c7-9cfc-b302e29325fb
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	c258c8ba-c7f4-4af7-9194-0ac51bc01b2d
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	bb23b648-f6c1-4c64-8f72-a4989e3d99af
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	ef6c7a28-39fe-4b4d-9923-b2a8dde2e39b
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	8c655a2b-ee96-4da8-b4dc-d7d7c24897a9
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	42c1ee4e-bdbf-4932-b700-adb4b9bdbcfc
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	352fa4e8-7dee-4050-8e68-8c6f396a0200
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	58325aa3-abe7-4085-a016-a226ee8670c7
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	3b64843f-8ac9-481a-925c-e93807a85969
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	7e13d445-8b98-477c-a0ca-8d9c3c1a1f07
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	7d84319c-3e17-4f61-9f1f-00bc5da641a8
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	9227fa40-3871-450d-a01f-32be0bfcaa7f
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	6064e9a3-49aa-4098-9e00-61721453b79d
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	d0c96935-f2c1-430b-bf56-15efd3e3c620
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	2915b38e-5573-4607-a450-96b5b3e053a8
c258c8ba-c7f4-4af7-9194-0ac51bc01b2d	6064e9a3-49aa-4098-9e00-61721453b79d
d0f548c0-1c13-45c7-9cfc-b302e29325fb	9227fa40-3871-450d-a01f-32be0bfcaa7f
d0f548c0-1c13-45c7-9cfc-b302e29325fb	2915b38e-5573-4607-a450-96b5b3e053a8
b84db1d5-0590-46d4-9123-bf8a5019f7a9	7ba8218e-595c-4ffa-ae17-4cddc0b6e474
b84db1d5-0590-46d4-9123-bf8a5019f7a9	90fd848f-1451-48b0-8060-be0cad04e603
b84db1d5-0590-46d4-9123-bf8a5019f7a9	0f5c8e0c-b0dc-4b65-91ac-94185eeea047
b84db1d5-0590-46d4-9123-bf8a5019f7a9	0e5a1217-4ad1-40ec-8d0a-7834417deb91
b84db1d5-0590-46d4-9123-bf8a5019f7a9	c748461f-039e-4653-8a0c-a1fdb572da97
b84db1d5-0590-46d4-9123-bf8a5019f7a9	478e93fd-5f2f-4490-bd73-ee0e21cf7ac3
b84db1d5-0590-46d4-9123-bf8a5019f7a9	e5ca0408-33c8-40af-b711-12d7520ef950
b84db1d5-0590-46d4-9123-bf8a5019f7a9	ea362599-8fd7-4d97-b0d8-7c8e605dcbbb
b84db1d5-0590-46d4-9123-bf8a5019f7a9	c00bb6ba-00d8-417c-b7bb-ecd43c039a95
b84db1d5-0590-46d4-9123-bf8a5019f7a9	66eaa664-9d09-49d2-b78a-12b8df54dd97
b84db1d5-0590-46d4-9123-bf8a5019f7a9	bd4a0766-32a4-49ce-b63e-18b06c72adc5
b84db1d5-0590-46d4-9123-bf8a5019f7a9	0a36f1f7-5257-435c-b2cb-3d7a60a3b888
b84db1d5-0590-46d4-9123-bf8a5019f7a9	12c198e5-cd71-4dcf-821e-73183974c8f3
b84db1d5-0590-46d4-9123-bf8a5019f7a9	937d4421-b28f-45b1-8941-e66ec9eff3ab
b84db1d5-0590-46d4-9123-bf8a5019f7a9	ca219240-3367-4056-a750-6d93bd39ed54
b84db1d5-0590-46d4-9123-bf8a5019f7a9	da1169d1-85cd-4976-9710-c2ac6aa7cc15
b84db1d5-0590-46d4-9123-bf8a5019f7a9	35344fc9-2c75-400f-ba0f-df17e9315d74
0e5a1217-4ad1-40ec-8d0a-7834417deb91	ca219240-3367-4056-a750-6d93bd39ed54
0f5c8e0c-b0dc-4b65-91ac-94185eeea047	937d4421-b28f-45b1-8941-e66ec9eff3ab
0f5c8e0c-b0dc-4b65-91ac-94185eeea047	35344fc9-2c75-400f-ba0f-df17e9315d74
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	5b7c9a79-0bcd-48da-a33e-dad2d2caf803
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	092eeb38-8ce6-4c81-a6dc-b314160f4589
092eeb38-8ce6-4c81-a6dc-b314160f4589	90dd1c08-df87-4139-99f8-233f58ff53c5
07cec6b1-dd76-4091-b7b6-5feea67ef3ed	d09ae5c4-755a-41ac-9ef3-bedd92d5c2dc
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	e37a768f-aee6-46e2-a2b0-0ad9be7dad07
b84db1d5-0590-46d4-9123-bf8a5019f7a9	4538ecc4-7df9-4677-843f-baa0e1608429
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	7846e664-9f8f-42be-be3c-5958afee0f07
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	fc9d69d7-9ee2-40c9-9f7c-17f038d3b959
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	a8915039-4fd7-4b1d-9b41-b842a2ec6b8d
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
bcc83ba5-a0c8-4a23-a166-673ad5a7809f	\N	password	3445ba41-b06f-4ded-a86a-776e5bce2ffd	1643320272103	\N	{"value":"q9SUyIUSNjuwaJyAtK9AhdvZhJi/gi3r8kEEV5i2PAwZyXDPH+J3o5MDn4Jp2VzDfMRSIKcxWo0RGm6cGk6oiQ==","salt":"mlATdMIIEU1pXQHpl3Gwhg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
5d7901eb-04de-4365-a9f6-b8da0813d80a	\N	password	fda831f7-6302-46cf-84da-2c9bddfbf521	1643320752070	\N	{"value":"MOw4ucznWrk667kZqekE1vGL10R62vN0uVpaud1H+lkUUOUJQ/UbFlwIlyXUp/OArQN8uX+7xBr6Kw3+T+AW+g==","salt":"2biR/vSgO7iWqNJlRtiiQg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
a68c05a5-df7d-4722-ada9-59626c0cead6	\N	password	34671982-4f06-4637-8d84-ccb7971a5cbe	1643320768236	\N	{"value":"dx3MyPIzhsu52P3c9TmrwEEiHKTTkyvxs2bPTfagHvOzFHv6Qi+S4Bd2Dw1hvBuPPO9nEOkpImcCiPEW4Si3vw==","salt":"O9i/2STJcOY44Nq4tx1PBw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4614b233-b866-414f-854c-9882b5163a34	\N	password	9d2dc972-6f0d-4b0f-beed-4cd6e8d88114	1645374847491	\N	{"value":"TEQQSn8o2IdVGew4mEylNijVLdZn+SeIgcCpqh1lVuqhEmYx0zmeBI40czZLE4j0QsaNOZRrms8EAqtzdnVlYA==","salt":"AKgBLTHv9Px0tXhI2sCvdQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
0c6be017-5acd-4925-a196-d1094d6c4ff1	\N	password	3509465b-fcfe-4f09-91dd-5969da7303ac	1648002770824	\N	{"value":"CV59sp9S4fxgFfecJ5DrD85f0oCjb2TzWXw1eacd0W6CzaThAEU/5M6Nby6DePEUvp4LD4y4bBPlqV/f1+i9Cw==","salt":"Vz9fkKSxhFUp/ph/IJSyOQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
a5727fbf-8e08-4358-b38a-61978d488379	\N	password	23835b53-2d41-4ae9-8625-b633fc3b4d71	1648048291070	\N	{"value":"hn6cDbTv+XmVP7T8xbCWe0y0ofw9nWY5n4RCfUQ08DUKQt/H04AkwRvRJBjHNAJ9Ku3WKKKPBcQZPfFc6atbqg==","salt":"lVquK6Ar5y4LhAGTou+4Dw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-01-24 18:16:40.051719	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3037399858
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-01-24 18:16:40.059304	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3037399858
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-01-24 18:16:40.08632	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3037399858
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-01-24 18:16:40.088019	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3037399858
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-01-24 18:16:40.160733	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3037399858
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-01-24 18:16:40.163072	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3037399858
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-01-24 18:16:40.217392	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3037399858
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-01-24 18:16:40.219758	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3037399858
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-01-24 18:16:40.222745	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3037399858
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-01-24 18:16:40.291874	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3037399858
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-01-24 18:16:40.322534	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3037399858
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-01-24 18:16:40.324144	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3037399858
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-01-24 18:16:40.332383	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3037399858
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-24 18:16:40.344831	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3037399858
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-24 18:16:40.34586	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3037399858
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-24 18:16:40.346879	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3037399858
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-24 18:16:40.347905	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3037399858
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-01-24 18:16:40.378576	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3037399858
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-01-24 18:16:40.4088	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3037399858
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-01-24 18:16:40.411162	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3037399858
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-24 18:16:41.141248	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3037399858
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-01-24 18:16:40.412478	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3037399858
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-01-24 18:16:40.414236	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3037399858
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-01-24 18:16:40.439872	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3037399858
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-01-24 18:16:40.441723	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3037399858
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-01-24 18:16:40.442342	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3037399858
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-01-24 18:16:40.559298	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3037399858
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-01-24 18:16:40.610177	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3037399858
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-01-24 18:16:40.612373	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3037399858
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-01-24 18:16:40.658855	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3037399858
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-01-24 18:16:40.668369	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3037399858
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-01-24 18:16:40.677105	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3037399858
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-01-24 18:16:40.679372	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3037399858
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-24 18:16:40.681111	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3037399858
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-24 18:16:40.682008	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3037399858
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-24 18:16:40.698824	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3037399858
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-01-24 18:16:40.700442	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3037399858
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-24 18:16:40.702798	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3037399858
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-01-24 18:16:40.703939	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3037399858
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-01-24 18:16:40.704863	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3037399858
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-24 18:16:40.705479	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3037399858
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-24 18:16:40.706236	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3037399858
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-01-24 18:16:40.708128	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3037399858
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-24 18:16:41.137735	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3037399858
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-01-24 18:16:41.13972	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3037399858
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-24 18:16:41.143576	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3037399858
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-24 18:16:41.144248	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3037399858
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-24 18:16:41.186835	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3037399858
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-24 18:16:41.188776	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3037399858
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-01-24 18:16:41.21792	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3037399858
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-01-24 18:16:41.314597	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3037399858
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-01-24 18:16:41.316104	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3037399858
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-01-24 18:16:41.31747	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3037399858
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-01-24 18:16:41.318767	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3037399858
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-24 18:16:41.322481	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3037399858
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-24 18:16:41.325884	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3037399858
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-24 18:16:41.346008	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3037399858
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-24 18:16:41.475558	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3037399858
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-01-24 18:16:41.494906	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3037399858
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-01-24 18:16:41.499253	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3037399858
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-01-24 18:16:41.503828	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3037399858
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-01-24 18:16:41.506387	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3037399858
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-01-24 18:16:41.50747	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3037399858
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-01-24 18:16:41.508988	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3037399858
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-01-24 18:16:41.509949	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3037399858
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-01-24 18:16:41.524093	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3037399858
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-01-24 18:16:41.533409	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3037399858
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-01-24 18:16:41.535342	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3037399858
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-01-24 18:16:41.546361	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3037399858
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-01-24 18:16:41.548712	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3037399858
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-01-24 18:16:41.550574	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3037399858
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-24 18:16:41.553291	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3037399858
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-24 18:16:41.55729	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3037399858
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-24 18:16:41.558067	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3037399858
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-24 18:16:41.567527	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3037399858
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-24 18:16:41.577828	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3037399858
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-24 18:16:41.579372	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3037399858
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-24 18:16:41.580028	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3037399858
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-24 18:16:41.590324	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3037399858
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-24 18:16:41.591342	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3037399858
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-24 18:16:41.600475	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	3037399858
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-24 18:16:41.601283	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3037399858
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-24 18:16:41.6032	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3037399858
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-24 18:16:41.603907	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3037399858
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-24 18:16:41.613341	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3037399858
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-01-24 18:16:41.616129	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	3037399858
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-01-24 18:16:41.618667	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	3037399858
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-01-24 18:16:41.624668	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	3037399858
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.627277	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	3037399858
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.6325	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	3037399858
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.642392	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3037399858
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.646425	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	3037399858
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.647335	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3037399858
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.652764	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3037399858
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.654332	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	3037399858
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-24 18:16:41.656964	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	3037399858
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.688434	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3037399858
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.689356	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3037399858
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.698053	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3037399858
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.708617	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3037399858
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.709747	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3037399858
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.720407	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	3037399858
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-24 18:16:41.72287	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	3037399858
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-01-24 18:16:41.726156	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	3037399858
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	f66cce05-feef-40f8-893a-aa09663e579e	f
master	2ceec3af-bebe-45f6-8c38-57c7f537e34f	t
master	16b8cc65-e95e-48bd-924c-8376febeace7	t
master	fcd34867-0744-4d67-aaef-3835013a9c54	t
master	10d06b92-bfa5-4c87-9c4b-011f55fbd054	f
master	a74bb0d2-61df-4dcc-8a60-2013f3ff986f	f
master	020e6593-e82a-455d-97ff-8f32531de638	t
master	7928f232-1171-4191-b9bc-57d206871c5a	t
master	b75509cb-74eb-4c2c-bf93-71e9f6017127	f
myrealm	388a29f9-b19c-46b7-a5af-e8bb7ea72e25	f
myrealm	6b696e80-d687-4e20-a557-8cb57f705556	t
myrealm	f2186244-b17b-43f3-a8ec-4e73f6ff3449	t
myrealm	e71c2b3a-a104-4ac2-b14a-52f81c8fba86	t
myrealm	ff0ed600-bb21-4b37-96d2-9ea203e22026	f
myrealm	f7a17a10-8562-4bf6-87fe-8a195aab2d3c	f
myrealm	70e64905-c869-444a-8d32-da8b1b911373	t
myrealm	2890129b-f216-4410-924e-01d2f093fd22	t
myrealm	405a3817-eb1d-4f7b-ba2d-5256e193d50a	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
google	myrealm	105327828759646491629	sergeyt4444q@gmail.com	\N	591ca72c-5810-4990-bfe2-51f18abe87b1
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
9d39c226-2d2d-48e3-b41d-fc962060d521	t	google	google	f	f	myrealm	f	f	3fc99a02-a248-48f5-8173-51b8b2eb0abd	\N	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
9d39c226-2d2d-48e3-b41d-fc962060d521	626130564155-eclo6sa1m0brihr494vk6jhrpkmq7oem.apps.googleusercontent.com	clientId
9d39c226-2d2d-48e3-b41d-fc962060d521	IMPORT	syncMode
9d39c226-2d2d-48e3-b41d-fc962060d521	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	clientSecret
9d39c226-2d2d-48e3-b41d-fc962060d521	true	useJwksUrl
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	master	f	${role_default-roles}	default-roles-master	master	\N	\N
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	master	f	${role_admin}	admin	master	\N	\N
f5a22de3-c155-415c-a55c-f556c31274c9	master	f	${role_create-realm}	create-realm	master	\N	\N
5157e3d3-14a3-48e6-a1f6-e27ed7a7ebf5	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_create-client}	create-client	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
f4268f54-126d-4857-8599-190efa147b18	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-realm}	view-realm	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
e3e4797b-1b61-4da2-b804-81d1964844ac	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-users}	view-users	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
c7b28573-2504-497d-9fc7-0d28ab358179	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-clients}	view-clients	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
2fe68c80-a1eb-421c-a290-341df3acd9d7	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-events}	view-events	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
237289e9-3fe6-4dab-acdf-77cb403cb222	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-identity-providers}	view-identity-providers	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
5302cd4e-fb43-435d-a151-597fc0832706	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_view-authorization}	view-authorization	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
e64ab02c-e2a7-4aeb-be52-ea3f4e0b9a07	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-realm}	manage-realm	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
c301c36e-c193-4bd6-9f27-918fc0237041	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-users}	manage-users	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
c065c8c3-9248-431a-96b8-43f182f3ae41	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-clients}	manage-clients	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
9fae1ddc-36d3-4621-be86-4422a94c4526	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-events}	manage-events	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
d0e9b6f3-b9f7-4186-b10d-3e25450d1706	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-identity-providers}	manage-identity-providers	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
db7cfefb-f032-4695-913b-87884a92c4bb	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_manage-authorization}	manage-authorization	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
3c1e7595-54bd-4d77-8509-e4e08c794a85	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_query-users}	query-users	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
c80ce4d3-fffe-4d5d-a6aa-e55b0b36f66c	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_query-clients}	query-clients	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
fc75bde0-8808-4de8-a34c-e2532468431c	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_query-realms}	query-realms	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
b208c8d5-cb7c-4ccf-b6b2-c345089edc21	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_query-groups}	query-groups	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
1ef11b5a-896e-4e24-bf09-1b5f767ea187	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_view-profile}	view-profile	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
c7f68041-2bfe-4010-9a3f-1010cba231cc	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_manage-account}	manage-account	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
00f65e08-af53-4f0a-95e9-fd3c935ce909	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_manage-account-links}	manage-account-links	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
330481c7-e7d1-42ec-baa4-c03d45ca7263	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_view-applications}	view-applications	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
7437240e-feb1-4bc0-8088-4a4fad2bfc98	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_view-consent}	view-consent	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
b2039134-f184-4655-9280-28e4038ab95c	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_manage-consent}	manage-consent	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
46aa85c9-07a9-4ec0-8b2d-fa2c26295401	e615a998-ce2e-496e-8d8a-824631ec71bb	t	${role_delete-account}	delete-account	master	e615a998-ce2e-496e-8d8a-824631ec71bb	\N
90878aae-4a87-448e-958e-d74de7c9fead	539e9552-1819-4a73-984d-2eeeea4080e2	t	${role_read-token}	read-token	master	539e9552-1819-4a73-984d-2eeeea4080e2	\N
846deb85-8c7a-4bc0-b6b2-476849624c17	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	t	${role_impersonation}	impersonation	master	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	\N
a9b21537-3edc-46df-9e35-99e78ea3d507	master	f	${role_offline-access}	offline_access	master	\N	\N
6d98569b-9078-4cae-a3ea-c44e6c587fd6	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	myrealm	f	${role_default-roles}	default-roles-myrealm	myrealm	\N	\N
bf1e33fe-ed0d-49ea-960a-70687ba7d5d0	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_create-client}	create-client	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
c5a36dd0-0471-464c-9eb3-9e98defa8db6	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-realm}	view-realm	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
d0f548c0-1c13-45c7-9cfc-b302e29325fb	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-users}	view-users	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
c258c8ba-c7f4-4af7-9194-0ac51bc01b2d	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-clients}	view-clients	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
bb23b648-f6c1-4c64-8f72-a4989e3d99af	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-events}	view-events	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
ef6c7a28-39fe-4b4d-9923-b2a8dde2e39b	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-identity-providers}	view-identity-providers	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
8c655a2b-ee96-4da8-b4dc-d7d7c24897a9	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_view-authorization}	view-authorization	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
42c1ee4e-bdbf-4932-b700-adb4b9bdbcfc	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-realm}	manage-realm	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
352fa4e8-7dee-4050-8e68-8c6f396a0200	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-users}	manage-users	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
58325aa3-abe7-4085-a016-a226ee8670c7	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-clients}	manage-clients	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
3b64843f-8ac9-481a-925c-e93807a85969	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-events}	manage-events	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
7e13d445-8b98-477c-a0ca-8d9c3c1a1f07	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-identity-providers}	manage-identity-providers	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
7d84319c-3e17-4f61-9f1f-00bc5da641a8	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_manage-authorization}	manage-authorization	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
9227fa40-3871-450d-a01f-32be0bfcaa7f	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_query-users}	query-users	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
6064e9a3-49aa-4098-9e00-61721453b79d	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_query-clients}	query-clients	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
d0c96935-f2c1-430b-bf56-15efd3e3c620	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_query-realms}	query-realms	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
2915b38e-5573-4607-a450-96b5b3e053a8	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_query-groups}	query-groups	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
b84db1d5-0590-46d4-9123-bf8a5019f7a9	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_realm-admin}	realm-admin	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
7ba8218e-595c-4ffa-ae17-4cddc0b6e474	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_create-client}	create-client	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
90fd848f-1451-48b0-8060-be0cad04e603	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-realm}	view-realm	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
0f5c8e0c-b0dc-4b65-91ac-94185eeea047	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-users}	view-users	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
0e5a1217-4ad1-40ec-8d0a-7834417deb91	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-clients}	view-clients	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
c748461f-039e-4653-8a0c-a1fdb572da97	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-events}	view-events	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
478e93fd-5f2f-4490-bd73-ee0e21cf7ac3	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-identity-providers}	view-identity-providers	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
e5ca0408-33c8-40af-b711-12d7520ef950	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_view-authorization}	view-authorization	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
ea362599-8fd7-4d97-b0d8-7c8e605dcbbb	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-realm}	manage-realm	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
c00bb6ba-00d8-417c-b7bb-ecd43c039a95	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-users}	manage-users	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
66eaa664-9d09-49d2-b78a-12b8df54dd97	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-clients}	manage-clients	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
bd4a0766-32a4-49ce-b63e-18b06c72adc5	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-events}	manage-events	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
0a36f1f7-5257-435c-b2cb-3d7a60a3b888	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-identity-providers}	manage-identity-providers	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
12c198e5-cd71-4dcf-821e-73183974c8f3	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_manage-authorization}	manage-authorization	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
937d4421-b28f-45b1-8941-e66ec9eff3ab	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_query-users}	query-users	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
ca219240-3367-4056-a750-6d93bd39ed54	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_query-clients}	query-clients	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
da1169d1-85cd-4976-9710-c2ac6aa7cc15	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_query-realms}	query-realms	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
35344fc9-2c75-400f-ba0f-df17e9315d74	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_query-groups}	query-groups	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
5b7c9a79-0bcd-48da-a33e-dad2d2caf803	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_view-profile}	view-profile	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
092eeb38-8ce6-4c81-a6dc-b314160f4589	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_manage-account}	manage-account	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
90dd1c08-df87-4139-99f8-233f58ff53c5	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_manage-account-links}	manage-account-links	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
bd1d4605-223d-4ce0-9dd4-de59fb439280	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_view-applications}	view-applications	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
d09ae5c4-755a-41ac-9ef3-bedd92d5c2dc	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_view-consent}	view-consent	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
07cec6b1-dd76-4091-b7b6-5feea67ef3ed	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_manage-consent}	manage-consent	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
1555d202-9197-4966-8df1-6acf8f2e1fa7	89cbcac4-beb0-4311-870d-ec381b37ef31	t	${role_delete-account}	delete-account	myrealm	89cbcac4-beb0-4311-870d-ec381b37ef31	\N
e37a768f-aee6-46e2-a2b0-0ad9be7dad07	0576139e-ee82-4326-b273-2190f13ea9c6	t	${role_impersonation}	impersonation	master	0576139e-ee82-4326-b273-2190f13ea9c6	\N
4538ecc4-7df9-4677-843f-baa0e1608429	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	t	${role_impersonation}	impersonation	myrealm	03b7824b-7abf-4ec0-9a01-0bc12a1ddaba	\N
20e500de-6db1-4c52-bde8-757107bb7a37	fa8f134a-3e18-4bab-baab-de5aaa616c7f	t	${role_read-token}	read-token	myrealm	fa8f134a-3e18-4bab-baab-de5aaa616c7f	\N
7846e664-9f8f-42be-be3c-5958afee0f07	myrealm	f	${role_offline-access}	offline_access	myrealm	\N	\N
fc9d69d7-9ee2-40c9-9f7c-17f038d3b959	myrealm	f	${role_uma_authorization}	uma_authorization	myrealm	\N	\N
a8915039-4fd7-4b1d-9b41-b842a2ec6b8d	myrealm	f	\N	USER	myrealm	\N	\N
d82a1a77-97fe-4184-8e54-9c020bca3ed8	myrealm	f	\N	ADMIN	myrealm	\N	\N
0dc5ab3f-2641-436f-8313-32969175800c	myrealm	f	\N	MODERATOR	myrealm	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.migration_model (id, version, update_time) FROM stdin;
cbnuc	16.1.0	1643037403
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
eb0538ac-19b5-44c0-99ac-59f402c9c39c	audience resolve	openid-connect	oidc-audience-resolve-mapper	1955c150-4e96-4811-9fc4-f2ed449b775c	\N
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	locale	openid-connect	oidc-usermodel-attribute-mapper	33733792-52dc-45e2-bfbf-06d9cac73042	\N
ed31b27e-c320-434b-8404-b1ea3a729ee4	role list	saml	saml-role-list-mapper	\N	2ceec3af-bebe-45f6-8c38-57c7f537e34f
e89a4ed9-16bc-40bc-9061-c0cafa6553d6	full name	openid-connect	oidc-full-name-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
14f96374-6125-4c80-9920-5ecaaca0142a	family name	openid-connect	oidc-usermodel-property-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
695389b2-307d-45c3-a04b-8cb320b35a9d	given name	openid-connect	oidc-usermodel-property-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
be83c829-43fe-4312-85e8-7700467c7721	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
89b31383-f6c3-4b0d-9063-22d50046c76b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	username	openid-connect	oidc-usermodel-property-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
22104055-6b48-4d56-80d1-eb1d88908c73	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
a348521a-b803-48bc-8342-956129ea2b92	website	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
188f255e-65f2-4adb-852b-64b07813b834	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
066f909c-0f32-4a47-a1a7-d1f6373beb1a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
764eafd5-b98d-4998-be0d-57d1bef1d1af	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
80269e68-cc79-4fa9-8b35-caade0e4a96d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
2c844770-87f8-4fe1-b9be-156e67f1b76d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	16b8cc65-e95e-48bd-924c-8376febeace7
3a48cbef-ae6b-4533-9233-430e386908d3	email	openid-connect	oidc-usermodel-property-mapper	\N	fcd34867-0744-4d67-aaef-3835013a9c54
9eedf05f-f383-4a68-85b6-664f5c8c5776	email verified	openid-connect	oidc-usermodel-property-mapper	\N	fcd34867-0744-4d67-aaef-3835013a9c54
e47c6420-4c73-4168-a192-9d3654e03f5d	address	openid-connect	oidc-address-mapper	\N	10d06b92-bfa5-4c87-9c4b-011f55fbd054
71259659-889a-48b4-b9ed-a7584865e1c4	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a74bb0d2-61df-4dcc-8a60-2013f3ff986f
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a74bb0d2-61df-4dcc-8a60-2013f3ff986f
9d65c519-ecca-4562-a2b4-5e0e3513820c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	020e6593-e82a-455d-97ff-8f32531de638
6e8b43ba-2e1c-45a0-b758-e3976870ec80	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	020e6593-e82a-455d-97ff-8f32531de638
c8b749c1-2b54-4fa9-b649-695e1b2f1a34	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	020e6593-e82a-455d-97ff-8f32531de638
bfb78ec1-c751-45d0-8b4f-8b2cb5245a20	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	7928f232-1171-4191-b9bc-57d206871c5a
65264fe8-dac0-43d3-8e85-e56029b9a4b4	upn	openid-connect	oidc-usermodel-property-mapper	\N	b75509cb-74eb-4c2c-bf93-71e9f6017127
d6ea4207-9f7e-4a29-add2-e0c166f8b295	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b75509cb-74eb-4c2c-bf93-71e9f6017127
484f3ca2-3fe4-4489-a5ad-4f61e4dc2481	audience resolve	openid-connect	oidc-audience-resolve-mapper	6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	\N
361edd82-28dd-4774-a244-18de6fa5b533	role list	saml	saml-role-list-mapper	\N	6b696e80-d687-4e20-a557-8cb57f705556
5d17689d-873e-48af-999c-5c8f5c737f3e	full name	openid-connect	oidc-full-name-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	family name	openid-connect	oidc-usermodel-property-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
726787a4-6fd9-4c7e-8eee-f6f9427c274d	given name	openid-connect	oidc-usermodel-property-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
4540cbd9-38ab-41de-8037-8fda027311f5	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
e7a91a02-8851-47f0-8d90-00dfc63088bf	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
158a80f9-2309-47f9-b134-852590023760	username	openid-connect	oidc-usermodel-property-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
01298819-12d8-487c-9e4e-9ea3b8886bb9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
d75a73c9-f35e-48af-b216-adaf20499187	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
d4324b61-1da1-463c-a585-fdda0594e028	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
135bfcb7-4cc0-49a9-9366-914cc89f424d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
a72d35b1-6e20-4452-b554-b554529ad523	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
d5346eb7-5dd4-40df-852f-25b0a444aa63	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
944290bf-bc44-478e-ab12-93524f4ccc82	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
11cf4ffe-1e0e-481e-994a-95aab9210c81	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f2186244-b17b-43f3-a8ec-4e73f6ff3449
3fca3a67-d50d-4669-b5e1-70074ddc9da6	email	openid-connect	oidc-usermodel-property-mapper	\N	e71c2b3a-a104-4ac2-b14a-52f81c8fba86
6f4fa234-37f1-46db-be73-41915cee8689	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e71c2b3a-a104-4ac2-b14a-52f81c8fba86
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	address	openid-connect	oidc-address-mapper	\N	ff0ed600-bb21-4b37-96d2-9ea203e22026
e92b5e1f-0230-4be7-a539-bf9bb955b63b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f7a17a10-8562-4bf6-87fe-8a195aab2d3c
4a4334f4-0be5-45c7-ac55-749793baf8c3	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f7a17a10-8562-4bf6-87fe-8a195aab2d3c
e1d639fb-1bad-481c-b440-f9d149d3d8e5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	70e64905-c869-444a-8d32-da8b1b911373
b06cbec5-f2f6-4dca-90be-56e25399218f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	70e64905-c869-444a-8d32-da8b1b911373
1f9dcceb-be87-4b2d-8daa-af57e2fe7398	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	70e64905-c869-444a-8d32-da8b1b911373
1e4e8954-4d52-4dde-962d-39d1e42af384	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2890129b-f216-4410-924e-01d2f093fd22
ad81aae6-74a5-4678-8fa3-039c561e6783	upn	openid-connect	oidc-usermodel-property-mapper	\N	405a3817-eb1d-4f7b-ba2d-5256e193d50a
2dfbd27f-a260-4492-a2f3-2ca490677aba	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	405a3817-eb1d-4f7b-ba2d-5256e193d50a
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	locale	openid-connect	oidc-usermodel-attribute-mapper	171b2d4e-1059-4a64-add3-a5ec4eca0e74	\N
54e52133-6cf9-4c6f-b57e-69425d2827e9	email	openid-connect	oidc-usermodel-attribute-mapper	929cd39d-d1ba-4601-bead-f42caa5d2960	\N
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	phone	openid-connect	oidc-usermodel-attribute-mapper	929cd39d-d1ba-4601-bead-f42caa5d2960	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	true	userinfo.token.claim
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	locale	user.attribute
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	true	id.token.claim
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	true	access.token.claim
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	locale	claim.name
1daebeaa-1d2f-4cbc-8bbf-fa1dff8242bc	String	jsonType.label
ed31b27e-c320-434b-8404-b1ea3a729ee4	false	single
ed31b27e-c320-434b-8404-b1ea3a729ee4	Basic	attribute.nameformat
ed31b27e-c320-434b-8404-b1ea3a729ee4	Role	attribute.name
e89a4ed9-16bc-40bc-9061-c0cafa6553d6	true	userinfo.token.claim
e89a4ed9-16bc-40bc-9061-c0cafa6553d6	true	id.token.claim
e89a4ed9-16bc-40bc-9061-c0cafa6553d6	true	access.token.claim
14f96374-6125-4c80-9920-5ecaaca0142a	true	userinfo.token.claim
14f96374-6125-4c80-9920-5ecaaca0142a	lastName	user.attribute
14f96374-6125-4c80-9920-5ecaaca0142a	true	id.token.claim
14f96374-6125-4c80-9920-5ecaaca0142a	true	access.token.claim
14f96374-6125-4c80-9920-5ecaaca0142a	family_name	claim.name
14f96374-6125-4c80-9920-5ecaaca0142a	String	jsonType.label
695389b2-307d-45c3-a04b-8cb320b35a9d	true	userinfo.token.claim
695389b2-307d-45c3-a04b-8cb320b35a9d	firstName	user.attribute
695389b2-307d-45c3-a04b-8cb320b35a9d	true	id.token.claim
695389b2-307d-45c3-a04b-8cb320b35a9d	true	access.token.claim
695389b2-307d-45c3-a04b-8cb320b35a9d	given_name	claim.name
695389b2-307d-45c3-a04b-8cb320b35a9d	String	jsonType.label
be83c829-43fe-4312-85e8-7700467c7721	true	userinfo.token.claim
be83c829-43fe-4312-85e8-7700467c7721	middleName	user.attribute
be83c829-43fe-4312-85e8-7700467c7721	true	id.token.claim
be83c829-43fe-4312-85e8-7700467c7721	true	access.token.claim
be83c829-43fe-4312-85e8-7700467c7721	middle_name	claim.name
be83c829-43fe-4312-85e8-7700467c7721	String	jsonType.label
89b31383-f6c3-4b0d-9063-22d50046c76b	true	userinfo.token.claim
89b31383-f6c3-4b0d-9063-22d50046c76b	nickname	user.attribute
89b31383-f6c3-4b0d-9063-22d50046c76b	true	id.token.claim
89b31383-f6c3-4b0d-9063-22d50046c76b	true	access.token.claim
89b31383-f6c3-4b0d-9063-22d50046c76b	nickname	claim.name
89b31383-f6c3-4b0d-9063-22d50046c76b	String	jsonType.label
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	true	userinfo.token.claim
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	username	user.attribute
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	true	id.token.claim
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	true	access.token.claim
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	preferred_username	claim.name
eb0de7e4-f82b-4ace-bd21-6f3f9c2e2ce1	String	jsonType.label
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	true	userinfo.token.claim
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	profile	user.attribute
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	true	id.token.claim
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	true	access.token.claim
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	profile	claim.name
9ae8caea-a1c6-49f8-bb07-c3c4c4ef8949	String	jsonType.label
22104055-6b48-4d56-80d1-eb1d88908c73	true	userinfo.token.claim
22104055-6b48-4d56-80d1-eb1d88908c73	picture	user.attribute
22104055-6b48-4d56-80d1-eb1d88908c73	true	id.token.claim
22104055-6b48-4d56-80d1-eb1d88908c73	true	access.token.claim
22104055-6b48-4d56-80d1-eb1d88908c73	picture	claim.name
22104055-6b48-4d56-80d1-eb1d88908c73	String	jsonType.label
a348521a-b803-48bc-8342-956129ea2b92	true	userinfo.token.claim
a348521a-b803-48bc-8342-956129ea2b92	website	user.attribute
a348521a-b803-48bc-8342-956129ea2b92	true	id.token.claim
a348521a-b803-48bc-8342-956129ea2b92	true	access.token.claim
a348521a-b803-48bc-8342-956129ea2b92	website	claim.name
a348521a-b803-48bc-8342-956129ea2b92	String	jsonType.label
188f255e-65f2-4adb-852b-64b07813b834	true	userinfo.token.claim
188f255e-65f2-4adb-852b-64b07813b834	gender	user.attribute
188f255e-65f2-4adb-852b-64b07813b834	true	id.token.claim
188f255e-65f2-4adb-852b-64b07813b834	true	access.token.claim
188f255e-65f2-4adb-852b-64b07813b834	gender	claim.name
188f255e-65f2-4adb-852b-64b07813b834	String	jsonType.label
066f909c-0f32-4a47-a1a7-d1f6373beb1a	true	userinfo.token.claim
066f909c-0f32-4a47-a1a7-d1f6373beb1a	birthdate	user.attribute
066f909c-0f32-4a47-a1a7-d1f6373beb1a	true	id.token.claim
066f909c-0f32-4a47-a1a7-d1f6373beb1a	true	access.token.claim
066f909c-0f32-4a47-a1a7-d1f6373beb1a	birthdate	claim.name
066f909c-0f32-4a47-a1a7-d1f6373beb1a	String	jsonType.label
764eafd5-b98d-4998-be0d-57d1bef1d1af	true	userinfo.token.claim
764eafd5-b98d-4998-be0d-57d1bef1d1af	zoneinfo	user.attribute
764eafd5-b98d-4998-be0d-57d1bef1d1af	true	id.token.claim
764eafd5-b98d-4998-be0d-57d1bef1d1af	true	access.token.claim
764eafd5-b98d-4998-be0d-57d1bef1d1af	zoneinfo	claim.name
764eafd5-b98d-4998-be0d-57d1bef1d1af	String	jsonType.label
80269e68-cc79-4fa9-8b35-caade0e4a96d	true	userinfo.token.claim
80269e68-cc79-4fa9-8b35-caade0e4a96d	locale	user.attribute
80269e68-cc79-4fa9-8b35-caade0e4a96d	true	id.token.claim
80269e68-cc79-4fa9-8b35-caade0e4a96d	true	access.token.claim
80269e68-cc79-4fa9-8b35-caade0e4a96d	locale	claim.name
80269e68-cc79-4fa9-8b35-caade0e4a96d	String	jsonType.label
2c844770-87f8-4fe1-b9be-156e67f1b76d	true	userinfo.token.claim
2c844770-87f8-4fe1-b9be-156e67f1b76d	updatedAt	user.attribute
2c844770-87f8-4fe1-b9be-156e67f1b76d	true	id.token.claim
2c844770-87f8-4fe1-b9be-156e67f1b76d	true	access.token.claim
2c844770-87f8-4fe1-b9be-156e67f1b76d	updated_at	claim.name
2c844770-87f8-4fe1-b9be-156e67f1b76d	String	jsonType.label
3a48cbef-ae6b-4533-9233-430e386908d3	true	userinfo.token.claim
3a48cbef-ae6b-4533-9233-430e386908d3	email	user.attribute
3a48cbef-ae6b-4533-9233-430e386908d3	true	id.token.claim
3a48cbef-ae6b-4533-9233-430e386908d3	true	access.token.claim
3a48cbef-ae6b-4533-9233-430e386908d3	email	claim.name
3a48cbef-ae6b-4533-9233-430e386908d3	String	jsonType.label
9eedf05f-f383-4a68-85b6-664f5c8c5776	true	userinfo.token.claim
9eedf05f-f383-4a68-85b6-664f5c8c5776	emailVerified	user.attribute
9eedf05f-f383-4a68-85b6-664f5c8c5776	true	id.token.claim
9eedf05f-f383-4a68-85b6-664f5c8c5776	true	access.token.claim
9eedf05f-f383-4a68-85b6-664f5c8c5776	email_verified	claim.name
9eedf05f-f383-4a68-85b6-664f5c8c5776	boolean	jsonType.label
e47c6420-4c73-4168-a192-9d3654e03f5d	formatted	user.attribute.formatted
e47c6420-4c73-4168-a192-9d3654e03f5d	country	user.attribute.country
e47c6420-4c73-4168-a192-9d3654e03f5d	postal_code	user.attribute.postal_code
e47c6420-4c73-4168-a192-9d3654e03f5d	true	userinfo.token.claim
e47c6420-4c73-4168-a192-9d3654e03f5d	street	user.attribute.street
e47c6420-4c73-4168-a192-9d3654e03f5d	true	id.token.claim
e47c6420-4c73-4168-a192-9d3654e03f5d	region	user.attribute.region
e47c6420-4c73-4168-a192-9d3654e03f5d	true	access.token.claim
e47c6420-4c73-4168-a192-9d3654e03f5d	locality	user.attribute.locality
71259659-889a-48b4-b9ed-a7584865e1c4	true	userinfo.token.claim
71259659-889a-48b4-b9ed-a7584865e1c4	phoneNumber	user.attribute
71259659-889a-48b4-b9ed-a7584865e1c4	true	id.token.claim
71259659-889a-48b4-b9ed-a7584865e1c4	true	access.token.claim
71259659-889a-48b4-b9ed-a7584865e1c4	phone_number	claim.name
71259659-889a-48b4-b9ed-a7584865e1c4	String	jsonType.label
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	true	userinfo.token.claim
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	phoneNumberVerified	user.attribute
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	true	id.token.claim
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	true	access.token.claim
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	phone_number_verified	claim.name
c32cc5e3-a73d-4934-b4f4-43213ab2b8d8	boolean	jsonType.label
9d65c519-ecca-4562-a2b4-5e0e3513820c	true	multivalued
9d65c519-ecca-4562-a2b4-5e0e3513820c	foo	user.attribute
9d65c519-ecca-4562-a2b4-5e0e3513820c	true	access.token.claim
9d65c519-ecca-4562-a2b4-5e0e3513820c	realm_access.roles	claim.name
9d65c519-ecca-4562-a2b4-5e0e3513820c	String	jsonType.label
6e8b43ba-2e1c-45a0-b758-e3976870ec80	true	multivalued
6e8b43ba-2e1c-45a0-b758-e3976870ec80	foo	user.attribute
6e8b43ba-2e1c-45a0-b758-e3976870ec80	true	access.token.claim
6e8b43ba-2e1c-45a0-b758-e3976870ec80	resource_access.${client_id}.roles	claim.name
6e8b43ba-2e1c-45a0-b758-e3976870ec80	String	jsonType.label
65264fe8-dac0-43d3-8e85-e56029b9a4b4	true	userinfo.token.claim
65264fe8-dac0-43d3-8e85-e56029b9a4b4	username	user.attribute
65264fe8-dac0-43d3-8e85-e56029b9a4b4	true	id.token.claim
65264fe8-dac0-43d3-8e85-e56029b9a4b4	true	access.token.claim
65264fe8-dac0-43d3-8e85-e56029b9a4b4	upn	claim.name
65264fe8-dac0-43d3-8e85-e56029b9a4b4	String	jsonType.label
d6ea4207-9f7e-4a29-add2-e0c166f8b295	true	multivalued
d6ea4207-9f7e-4a29-add2-e0c166f8b295	foo	user.attribute
d6ea4207-9f7e-4a29-add2-e0c166f8b295	true	id.token.claim
d6ea4207-9f7e-4a29-add2-e0c166f8b295	true	access.token.claim
d6ea4207-9f7e-4a29-add2-e0c166f8b295	groups	claim.name
d6ea4207-9f7e-4a29-add2-e0c166f8b295	String	jsonType.label
361edd82-28dd-4774-a244-18de6fa5b533	false	single
361edd82-28dd-4774-a244-18de6fa5b533	Basic	attribute.nameformat
361edd82-28dd-4774-a244-18de6fa5b533	Role	attribute.name
5d17689d-873e-48af-999c-5c8f5c737f3e	true	userinfo.token.claim
5d17689d-873e-48af-999c-5c8f5c737f3e	true	id.token.claim
5d17689d-873e-48af-999c-5c8f5c737f3e	true	access.token.claim
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	true	userinfo.token.claim
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	lastName	user.attribute
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	true	id.token.claim
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	true	access.token.claim
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	family_name	claim.name
b2d99165-6c2c-4aab-8b6a-407ee9e968b8	String	jsonType.label
726787a4-6fd9-4c7e-8eee-f6f9427c274d	true	userinfo.token.claim
726787a4-6fd9-4c7e-8eee-f6f9427c274d	firstName	user.attribute
726787a4-6fd9-4c7e-8eee-f6f9427c274d	true	id.token.claim
726787a4-6fd9-4c7e-8eee-f6f9427c274d	true	access.token.claim
726787a4-6fd9-4c7e-8eee-f6f9427c274d	given_name	claim.name
726787a4-6fd9-4c7e-8eee-f6f9427c274d	String	jsonType.label
4540cbd9-38ab-41de-8037-8fda027311f5	true	userinfo.token.claim
4540cbd9-38ab-41de-8037-8fda027311f5	middleName	user.attribute
4540cbd9-38ab-41de-8037-8fda027311f5	true	id.token.claim
4540cbd9-38ab-41de-8037-8fda027311f5	true	access.token.claim
4540cbd9-38ab-41de-8037-8fda027311f5	middle_name	claim.name
4540cbd9-38ab-41de-8037-8fda027311f5	String	jsonType.label
e7a91a02-8851-47f0-8d90-00dfc63088bf	true	userinfo.token.claim
e7a91a02-8851-47f0-8d90-00dfc63088bf	nickname	user.attribute
e7a91a02-8851-47f0-8d90-00dfc63088bf	true	id.token.claim
e7a91a02-8851-47f0-8d90-00dfc63088bf	true	access.token.claim
e7a91a02-8851-47f0-8d90-00dfc63088bf	nickname	claim.name
e7a91a02-8851-47f0-8d90-00dfc63088bf	String	jsonType.label
158a80f9-2309-47f9-b134-852590023760	true	userinfo.token.claim
158a80f9-2309-47f9-b134-852590023760	username	user.attribute
158a80f9-2309-47f9-b134-852590023760	true	id.token.claim
158a80f9-2309-47f9-b134-852590023760	true	access.token.claim
158a80f9-2309-47f9-b134-852590023760	preferred_username	claim.name
158a80f9-2309-47f9-b134-852590023760	String	jsonType.label
01298819-12d8-487c-9e4e-9ea3b8886bb9	true	userinfo.token.claim
01298819-12d8-487c-9e4e-9ea3b8886bb9	profile	user.attribute
01298819-12d8-487c-9e4e-9ea3b8886bb9	true	id.token.claim
01298819-12d8-487c-9e4e-9ea3b8886bb9	true	access.token.claim
01298819-12d8-487c-9e4e-9ea3b8886bb9	profile	claim.name
01298819-12d8-487c-9e4e-9ea3b8886bb9	String	jsonType.label
d75a73c9-f35e-48af-b216-adaf20499187	true	userinfo.token.claim
d75a73c9-f35e-48af-b216-adaf20499187	picture	user.attribute
d75a73c9-f35e-48af-b216-adaf20499187	true	id.token.claim
d75a73c9-f35e-48af-b216-adaf20499187	true	access.token.claim
d75a73c9-f35e-48af-b216-adaf20499187	picture	claim.name
d75a73c9-f35e-48af-b216-adaf20499187	String	jsonType.label
d4324b61-1da1-463c-a585-fdda0594e028	true	userinfo.token.claim
d4324b61-1da1-463c-a585-fdda0594e028	website	user.attribute
d4324b61-1da1-463c-a585-fdda0594e028	true	id.token.claim
d4324b61-1da1-463c-a585-fdda0594e028	true	access.token.claim
d4324b61-1da1-463c-a585-fdda0594e028	website	claim.name
d4324b61-1da1-463c-a585-fdda0594e028	String	jsonType.label
135bfcb7-4cc0-49a9-9366-914cc89f424d	true	userinfo.token.claim
135bfcb7-4cc0-49a9-9366-914cc89f424d	gender	user.attribute
135bfcb7-4cc0-49a9-9366-914cc89f424d	true	id.token.claim
135bfcb7-4cc0-49a9-9366-914cc89f424d	true	access.token.claim
135bfcb7-4cc0-49a9-9366-914cc89f424d	gender	claim.name
135bfcb7-4cc0-49a9-9366-914cc89f424d	String	jsonType.label
a72d35b1-6e20-4452-b554-b554529ad523	true	userinfo.token.claim
a72d35b1-6e20-4452-b554-b554529ad523	birthdate	user.attribute
a72d35b1-6e20-4452-b554-b554529ad523	true	id.token.claim
a72d35b1-6e20-4452-b554-b554529ad523	true	access.token.claim
a72d35b1-6e20-4452-b554-b554529ad523	birthdate	claim.name
a72d35b1-6e20-4452-b554-b554529ad523	String	jsonType.label
d5346eb7-5dd4-40df-852f-25b0a444aa63	true	userinfo.token.claim
d5346eb7-5dd4-40df-852f-25b0a444aa63	zoneinfo	user.attribute
d5346eb7-5dd4-40df-852f-25b0a444aa63	true	id.token.claim
d5346eb7-5dd4-40df-852f-25b0a444aa63	true	access.token.claim
d5346eb7-5dd4-40df-852f-25b0a444aa63	zoneinfo	claim.name
d5346eb7-5dd4-40df-852f-25b0a444aa63	String	jsonType.label
944290bf-bc44-478e-ab12-93524f4ccc82	true	userinfo.token.claim
944290bf-bc44-478e-ab12-93524f4ccc82	locale	user.attribute
944290bf-bc44-478e-ab12-93524f4ccc82	true	id.token.claim
944290bf-bc44-478e-ab12-93524f4ccc82	true	access.token.claim
944290bf-bc44-478e-ab12-93524f4ccc82	locale	claim.name
944290bf-bc44-478e-ab12-93524f4ccc82	String	jsonType.label
11cf4ffe-1e0e-481e-994a-95aab9210c81	true	userinfo.token.claim
11cf4ffe-1e0e-481e-994a-95aab9210c81	updatedAt	user.attribute
11cf4ffe-1e0e-481e-994a-95aab9210c81	true	id.token.claim
11cf4ffe-1e0e-481e-994a-95aab9210c81	true	access.token.claim
11cf4ffe-1e0e-481e-994a-95aab9210c81	updated_at	claim.name
11cf4ffe-1e0e-481e-994a-95aab9210c81	String	jsonType.label
3fca3a67-d50d-4669-b5e1-70074ddc9da6	true	userinfo.token.claim
3fca3a67-d50d-4669-b5e1-70074ddc9da6	email	user.attribute
3fca3a67-d50d-4669-b5e1-70074ddc9da6	true	id.token.claim
3fca3a67-d50d-4669-b5e1-70074ddc9da6	true	access.token.claim
3fca3a67-d50d-4669-b5e1-70074ddc9da6	email	claim.name
3fca3a67-d50d-4669-b5e1-70074ddc9da6	String	jsonType.label
6f4fa234-37f1-46db-be73-41915cee8689	true	userinfo.token.claim
6f4fa234-37f1-46db-be73-41915cee8689	emailVerified	user.attribute
6f4fa234-37f1-46db-be73-41915cee8689	true	id.token.claim
6f4fa234-37f1-46db-be73-41915cee8689	true	access.token.claim
6f4fa234-37f1-46db-be73-41915cee8689	email_verified	claim.name
6f4fa234-37f1-46db-be73-41915cee8689	boolean	jsonType.label
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	formatted	user.attribute.formatted
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	country	user.attribute.country
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	postal_code	user.attribute.postal_code
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	true	userinfo.token.claim
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	street	user.attribute.street
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	true	id.token.claim
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	region	user.attribute.region
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	true	access.token.claim
d30f1d82-898e-4aea-8335-e5bbabf9c2b1	locality	user.attribute.locality
e92b5e1f-0230-4be7-a539-bf9bb955b63b	true	userinfo.token.claim
e92b5e1f-0230-4be7-a539-bf9bb955b63b	phoneNumber	user.attribute
e92b5e1f-0230-4be7-a539-bf9bb955b63b	true	id.token.claim
e92b5e1f-0230-4be7-a539-bf9bb955b63b	true	access.token.claim
e92b5e1f-0230-4be7-a539-bf9bb955b63b	phone_number	claim.name
e92b5e1f-0230-4be7-a539-bf9bb955b63b	String	jsonType.label
4a4334f4-0be5-45c7-ac55-749793baf8c3	true	userinfo.token.claim
4a4334f4-0be5-45c7-ac55-749793baf8c3	phoneNumberVerified	user.attribute
4a4334f4-0be5-45c7-ac55-749793baf8c3	true	id.token.claim
4a4334f4-0be5-45c7-ac55-749793baf8c3	true	access.token.claim
4a4334f4-0be5-45c7-ac55-749793baf8c3	phone_number_verified	claim.name
4a4334f4-0be5-45c7-ac55-749793baf8c3	boolean	jsonType.label
e1d639fb-1bad-481c-b440-f9d149d3d8e5	true	multivalued
e1d639fb-1bad-481c-b440-f9d149d3d8e5	foo	user.attribute
e1d639fb-1bad-481c-b440-f9d149d3d8e5	true	access.token.claim
e1d639fb-1bad-481c-b440-f9d149d3d8e5	realm_access.roles	claim.name
e1d639fb-1bad-481c-b440-f9d149d3d8e5	String	jsonType.label
b06cbec5-f2f6-4dca-90be-56e25399218f	true	multivalued
b06cbec5-f2f6-4dca-90be-56e25399218f	foo	user.attribute
b06cbec5-f2f6-4dca-90be-56e25399218f	true	access.token.claim
b06cbec5-f2f6-4dca-90be-56e25399218f	resource_access.${client_id}.roles	claim.name
b06cbec5-f2f6-4dca-90be-56e25399218f	String	jsonType.label
ad81aae6-74a5-4678-8fa3-039c561e6783	true	userinfo.token.claim
ad81aae6-74a5-4678-8fa3-039c561e6783	username	user.attribute
ad81aae6-74a5-4678-8fa3-039c561e6783	true	id.token.claim
ad81aae6-74a5-4678-8fa3-039c561e6783	true	access.token.claim
ad81aae6-74a5-4678-8fa3-039c561e6783	upn	claim.name
ad81aae6-74a5-4678-8fa3-039c561e6783	String	jsonType.label
2dfbd27f-a260-4492-a2f3-2ca490677aba	true	multivalued
2dfbd27f-a260-4492-a2f3-2ca490677aba	foo	user.attribute
2dfbd27f-a260-4492-a2f3-2ca490677aba	true	id.token.claim
2dfbd27f-a260-4492-a2f3-2ca490677aba	true	access.token.claim
2dfbd27f-a260-4492-a2f3-2ca490677aba	groups	claim.name
2dfbd27f-a260-4492-a2f3-2ca490677aba	String	jsonType.label
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	true	userinfo.token.claim
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	locale	user.attribute
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	true	id.token.claim
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	true	access.token.claim
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	locale	claim.name
06a07bd9-8c3a-4a72-9a09-8e7d390d2331	String	jsonType.label
54e52133-6cf9-4c6f-b57e-69425d2827e9	true	userinfo.token.claim
54e52133-6cf9-4c6f-b57e-69425d2827e9	email	user.attribute
54e52133-6cf9-4c6f-b57e-69425d2827e9	true	id.token.claim
54e52133-6cf9-4c6f-b57e-69425d2827e9	false	access.token.claim
54e52133-6cf9-4c6f-b57e-69425d2827e9	email	claim.name
54e52133-6cf9-4c6f-b57e-69425d2827e9	String	jsonType.label
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	true	userinfo.token.claim
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	phone	user.attribute
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	true	id.token.claim
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	false	access.token.claim
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	phone	claim.name
bdc9e8e2-cc35-44a8-8887-71ae2fff3105	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
myrealm	60	300	300	\N	\N	\N	t	f	0	customfixed	myrealm	0	\N	t	f	f	f	NONE	1800	36000	f	f	0576139e-ee82-4326-b273-2190f13ea9c6	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a9bf486e-700a-44f2-b48b-b8f53ffeffd6	e72ace45-5afa-4707-9d95-dee5c5070cc8	85f769c1-b200-411d-af82-67f2657d9315	0f896256-15c0-407f-aa0c-676bb94eebb6	31d13fd9-c17e-4d6e-afbf-0fe2a6c2ad80	2592000	f	900	t	f	79b5e1e5-b995-4902-889c-99306de16483	0	f	0	0	931f5230-d52f-46a5-9d4f-d525e2a2d3b0
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	21f6af08-726c-4988-ad0f-6f0a58b5bb1e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7ba5febe-098a-4977-b156-48c315583b84	172fc65a-d71f-446d-af56-397b84ea1bfa	5e675127-c8a1-433d-b6c8-5ee2397eb0e7	f03c51a7-60d5-407d-abd6-b464e3e77274	07117dc9-9c2d-4366-a3cc-4c65683bbc39	2592000	f	900	t	f	bb87c813-8dae-4e5a-ae53-a79d518e6fb9	0	f	0	0	5e7381a7-9ab1-4237-b8f1-a9f2c3514847
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
bruteForceProtected	myrealm	false
permanentLockout	myrealm	false
maxFailureWaitSeconds	myrealm	900
minimumQuickLoginWaitSeconds	myrealm	60
waitIncrementSeconds	myrealm	60
quickLoginCheckMilliSeconds	myrealm	1000
maxDeltaTimeSeconds	myrealm	43200
failureFactor	myrealm	30
actionTokenGeneratedByAdminLifespan	myrealm	43200
actionTokenGeneratedByUserLifespan	myrealm	300
defaultSignatureAlgorithm	myrealm	RS256
offlineSessionMaxLifespanEnabled	myrealm	false
offlineSessionMaxLifespan	myrealm	5184000
webAuthnPolicyRpEntityName	myrealm	keycloak
webAuthnPolicySignatureAlgorithms	myrealm	ES256
webAuthnPolicyRpId	myrealm	
webAuthnPolicyAttestationConveyancePreference	myrealm	not specified
webAuthnPolicyAuthenticatorAttachment	myrealm	not specified
webAuthnPolicyRequireResidentKey	myrealm	not specified
webAuthnPolicyUserVerificationRequirement	myrealm	not specified
oauth2DeviceCodeLifespan	myrealm	600
oauth2DevicePollingInterval	myrealm	5
webAuthnPolicyCreateTimeout	myrealm	0
webAuthnPolicyAvoidSameAuthenticatorRegister	myrealm	false
webAuthnPolicyRpEntityNamePasswordless	myrealm	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	myrealm	ES256
webAuthnPolicyRpIdPasswordless	myrealm	
webAuthnPolicyAttestationConveyancePreferencePasswordless	myrealm	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	myrealm	not specified
webAuthnPolicyRequireResidentKeyPasswordless	myrealm	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	myrealm	not specified
webAuthnPolicyCreateTimeoutPasswordless	myrealm	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	myrealm	false
client-policies.profiles	myrealm	{"profiles":[]}
client-policies.policies	myrealm	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	myrealm	
_browser_header.xContentTypeOptions	myrealm	nosniff
_browser_header.xRobotsTag	myrealm	none
_browser_header.xFrameOptions	myrealm	SAMEORIGIN
_browser_header.contentSecurityPolicy	myrealm	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
cibaBackchannelTokenDeliveryMode	myrealm	poll
cibaExpiresIn	myrealm	120
cibaInterval	myrealm	5
cibaAuthRequestedUserHint	myrealm	login_hint
parRequestUriLifespan	myrealm	60
_browser_header.xXSSProtection	myrealm	1; mode=block
_browser_header.strictTransportSecurity	myrealm	max-age=31536000; includeSubDomains
clientSessionIdleTimeout	myrealm	0
clientSessionMaxLifespan	myrealm	0
clientOfflineSessionIdleTimeout	myrealm	0
clientOfflineSessionMaxLifespan	myrealm	0
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
myrealm	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	myrealm
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
myrealm	
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e615a998-ce2e-496e-8d8a-824631ec71bb	/realms/master/account/*
1955c150-4e96-4811-9fc4-f2ed449b775c	/realms/master/account/*
33733792-52dc-45e2-bfbf-06d9cac73042	/admin/master/console/*
89cbcac4-beb0-4311-870d-ec381b37ef31	/realms/myrealm/account/*
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	/realms/myrealm/account/*
171b2d4e-1059-4a64-add3-a5ec4eca0e74	/admin/myrealm/console/*
f0bd39ff-0349-4c12-ada3-6f33c8106917	http://localhost:8080/*
929cd39d-d1ba-4601-bead-f42caa5d2960	
929cd39d-d1ba-4601-bead-f42caa5d2960	http://localhost:8081/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
5446d434-40c1-406b-af3d-2b915c263ebd	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
c022f497-e47e-4c0a-9859-e7078dbe583e	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
0e048e97-abf9-4bbc-8774-b13cb3bbba0a	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
9d26f666-f3f3-4d49-8f4d-e73f6c8adb94	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
61e7a490-b088-4a61-882b-6e23a15d7fe4	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
4582fbe2-cf0e-4b32-bc57-f981c7fa94bc	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
4e58b754-aeb0-4a2e-9425-4e74afaff14e	delete_account	Delete Account	master	f	f	delete_account	60
28a54294-a81b-45ee-95fd-6c223c623670	VERIFY_EMAIL	Verify Email	myrealm	t	f	VERIFY_EMAIL	50
5b29d98a-c8e7-466c-b5e6-5a82d3e36b37	UPDATE_PROFILE	Update Profile	myrealm	t	f	UPDATE_PROFILE	40
3874f638-6328-4c24-b923-56c65c0ad537	CONFIGURE_TOTP	Configure OTP	myrealm	t	f	CONFIGURE_TOTP	10
61df4531-e3d0-4d4d-8b1b-430775f8df5e	UPDATE_PASSWORD	Update Password	myrealm	t	f	UPDATE_PASSWORD	30
b0fb5e96-8c19-4b53-94b0-c4f67ef453db	terms_and_conditions	Terms and Conditions	myrealm	f	f	terms_and_conditions	20
426f3274-0a8d-4521-918f-af7cbba32b64	update_user_locale	Update User Locale	myrealm	t	f	update_user_locale	1000
40a9add7-6b99-4395-9328-fa1a44a82967	delete_account	Delete Account	myrealm	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
1955c150-4e96-4811-9fc4-f2ed449b775c	c7f68041-2bfe-4010-9a3f-1010cba231cc
6a62b2c8-d7ca-495f-b292-97cf8dc42ed9	092eeb38-8ce6-4c81-a6dc-b314160f4589
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
phone	8(999)888-7777	fda831f7-6302-46cf-84da-2c9bddfbf521	8b36dd4c-dcc6-40cc-8fd9-9b55d906dea8
phone	8(111)222-3333	34671982-4f06-4637-8d84-ccb7971a5cbe	f53a25ca-8b8e-4e9d-a74d-2c393635fcb0
phone	8(555)444-6673	9d2dc972-6f0d-4b0f-beed-4cd6e8d88114	f062811d-7ce3-437b-9587-30e689e2a26d
phone	8(987)654-3211	3509465b-fcfe-4f09-91dd-5969da7303ac	dd62377b-1f1c-4e6b-883b-d24e73c76b3a
phone	89876543211	23835b53-2d41-4ae9-8625-b633fc3b4d71	7afb9869-ce76-4235-ba50-6da29595fd6b
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
3445ba41-b06f-4ded-a86a-776e5bce2ffd	\N	231dfff0-d226-4848-b306-c92d2de2dd95	f	t	\N	\N	\N	master	admin	1643320271917	\N	0
9d2dc972-6f0d-4b0f-beed-4cd6e8d88114	moderator@mail.ru	moderator@mail.ru	f	t	\N	Egor	Ivanov	myrealm	moderator	1645374831395	\N	0
fda831f7-6302-46cf-84da-2c9bddfbf521	myuser@mail.ru	myuser@mail.ru	f	t	\N	Вася	Пупкин	myrealm	myuser	1643320701293	\N	0
34671982-4f06-4637-8d84-ccb7971a5cbe	administrator@mail.ru	administrator@mail.ru	f	t	\N	Иван	Сидоров	myrealm	administrator	1643320714255	\N	0
3509465b-fcfe-4f09-91dd-5969da7303ac	popov@mail.ru	popov@mail.ru	f	t	\N	Anatoly	Popov	myrealm	anotheruser	1648002770735	\N	0
23835b53-2d41-4ae9-8625-b633fc3b4d71	random@mail.ru	random@mail.ru	f	t	\N	reguser	last name	myrealm	reguser	1648048290975	\N	0
591ca72c-5810-4990-bfe2-51f18abe87b1	sergeyt4444q@gmail.com	sergeyt4444q@gmail.com	f	t	\N	sergeyt4444	q	myrealm	sergeyt4444q@gmail.com	1648689616797	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
5e7381a7-9ab1-4237-b8f1-a9f2c3514847	3445ba41-b06f-4ded-a86a-776e5bce2ffd
073a1c75-18e6-4f02-a3c7-cecd30dcf25b	3445ba41-b06f-4ded-a86a-776e5bce2ffd
bf1e33fe-ed0d-49ea-960a-70687ba7d5d0	3445ba41-b06f-4ded-a86a-776e5bce2ffd
c5a36dd0-0471-464c-9eb3-9e98defa8db6	3445ba41-b06f-4ded-a86a-776e5bce2ffd
d0f548c0-1c13-45c7-9cfc-b302e29325fb	3445ba41-b06f-4ded-a86a-776e5bce2ffd
c258c8ba-c7f4-4af7-9194-0ac51bc01b2d	3445ba41-b06f-4ded-a86a-776e5bce2ffd
bb23b648-f6c1-4c64-8f72-a4989e3d99af	3445ba41-b06f-4ded-a86a-776e5bce2ffd
ef6c7a28-39fe-4b4d-9923-b2a8dde2e39b	3445ba41-b06f-4ded-a86a-776e5bce2ffd
8c655a2b-ee96-4da8-b4dc-d7d7c24897a9	3445ba41-b06f-4ded-a86a-776e5bce2ffd
42c1ee4e-bdbf-4932-b700-adb4b9bdbcfc	3445ba41-b06f-4ded-a86a-776e5bce2ffd
352fa4e8-7dee-4050-8e68-8c6f396a0200	3445ba41-b06f-4ded-a86a-776e5bce2ffd
58325aa3-abe7-4085-a016-a226ee8670c7	3445ba41-b06f-4ded-a86a-776e5bce2ffd
3b64843f-8ac9-481a-925c-e93807a85969	3445ba41-b06f-4ded-a86a-776e5bce2ffd
7e13d445-8b98-477c-a0ca-8d9c3c1a1f07	3445ba41-b06f-4ded-a86a-776e5bce2ffd
7d84319c-3e17-4f61-9f1f-00bc5da641a8	3445ba41-b06f-4ded-a86a-776e5bce2ffd
9227fa40-3871-450d-a01f-32be0bfcaa7f	3445ba41-b06f-4ded-a86a-776e5bce2ffd
6064e9a3-49aa-4098-9e00-61721453b79d	3445ba41-b06f-4ded-a86a-776e5bce2ffd
d0c96935-f2c1-430b-bf56-15efd3e3c620	3445ba41-b06f-4ded-a86a-776e5bce2ffd
2915b38e-5573-4607-a450-96b5b3e053a8	3445ba41-b06f-4ded-a86a-776e5bce2ffd
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	fda831f7-6302-46cf-84da-2c9bddfbf521
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	34671982-4f06-4637-8d84-ccb7971a5cbe
a8915039-4fd7-4b1d-9b41-b842a2ec6b8d	fda831f7-6302-46cf-84da-2c9bddfbf521
d82a1a77-97fe-4184-8e54-9c020bca3ed8	34671982-4f06-4637-8d84-ccb7971a5cbe
a8915039-4fd7-4b1d-9b41-b842a2ec6b8d	34671982-4f06-4637-8d84-ccb7971a5cbe
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	9d2dc972-6f0d-4b0f-beed-4cd6e8d88114
0dc5ab3f-2641-436f-8313-32969175800c	9d2dc972-6f0d-4b0f-beed-4cd6e8d88114
a8915039-4fd7-4b1d-9b41-b842a2ec6b8d	9d2dc972-6f0d-4b0f-beed-4cd6e8d88114
0dc5ab3f-2641-436f-8313-32969175800c	34671982-4f06-4637-8d84-ccb7971a5cbe
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	3509465b-fcfe-4f09-91dd-5969da7303ac
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	23835b53-2d41-4ae9-8625-b633fc3b4d71
931f5230-d52f-46a5-9d4f-d525e2a2d3b0	591ca72c-5810-4990-bfe2-51f18abe87b1
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloakusers
--

COPY public.web_origins (client_id, value) FROM stdin;
33733792-52dc-45e2-bfbf-06d9cac73042	+
171b2d4e-1059-4a64-add3-a5ec4eca0e74	+
f0bd39ff-0349-4c12-ada3-6f33c8106917	http://localhost:8080
929cd39d-d1ba-4601-bead-f42caa5d2960	http://localhost:8081
929cd39d-d1ba-4601-bead-f42caa5d2960	http://localhost:8081/vaadin_project/login
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloakusers
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloakusers
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

