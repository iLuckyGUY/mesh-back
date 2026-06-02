--
-- PostgreSQL database dump
--

\restrict LU3dkba5Jr1zabBFBI1DDXuJzKlJrhRyx3tJK9KolQMf5kttVgkDKlwPkHfCucA

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    role text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_tokens (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    token text NOT NULL,
    token_name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.api_tokens OWNER TO postgres;

--
-- Name: config_profile_inbounds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config_profile_inbounds (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    profile_uuid uuid NOT NULL,
    tag text NOT NULL,
    type text NOT NULL,
    network text,
    security text,
    port integer,
    raw_inbound jsonb
);


ALTER TABLE public.config_profile_inbounds OWNER TO postgres;

--
-- Name: config_profile_inbounds_to_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config_profile_inbounds_to_nodes (
    config_profile_inbound_uuid uuid CONSTRAINT config_profile_inbounds_to__config_profile_inbound_uui_not_null NOT NULL,
    node_uuid uuid NOT NULL
);


ALTER TABLE public.config_profile_inbounds_to_nodes OWNER TO postgres;

--
-- Name: config_profile_snippets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config_profile_snippets (
    name character varying(255) NOT NULL,
    snippet jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.config_profile_snippets OWNER TO postgres;

--
-- Name: config_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config_profiles (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    config jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    view_position integer NOT NULL
);


ALTER TABLE public.config_profiles OWNER TO postgres;

--
-- Name: config_profiles_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.config_profiles_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_profiles_view_position_seq OWNER TO postgres;

--
-- Name: config_profiles_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.config_profiles_view_position_seq OWNED BY public.config_profiles.view_position;


--
-- Name: external_squads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_squads (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(30) NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    subscription_settings jsonb,
    host_overrides jsonb,
    response_headers jsonb,
    hwid_settings jsonb,
    view_position integer NOT NULL,
    custom_remarks jsonb,
    subpage_config_uuid uuid
);


ALTER TABLE public.external_squads OWNER TO postgres;

--
-- Name: external_squads_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_squads_templates (
    external_squad_uuid uuid NOT NULL,
    template_uuid uuid NOT NULL,
    template_type text NOT NULL
);


ALTER TABLE public.external_squads_templates OWNER TO postgres;

--
-- Name: external_squads_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.external_squads_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.external_squads_view_position_seq OWNER TO postgres;

--
-- Name: external_squads_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.external_squads_view_position_seq OWNED BY public.external_squads.view_position;


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hosts (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    view_position integer NOT NULL,
    remark character varying(50) NOT NULL,
    address text NOT NULL,
    port integer NOT NULL,
    path text,
    sni text,
    host text,
    alpn text,
    fingerprint text,
    is_disabled boolean DEFAULT false NOT NULL,
    security_layer text DEFAULT 'DEFAULT'::text NOT NULL,
    xhttp_extra_params jsonb,
    config_profile_inbound_uuid uuid,
    config_profile_uuid uuid,
    server_description character varying(30),
    mux_params jsonb,
    sockopt_params jsonb,
    is_hidden boolean DEFAULT false NOT NULL,
    tag text,
    override_sni_from_address boolean DEFAULT false NOT NULL,
    vless_route_id integer,
    allow_insecure boolean DEFAULT false NOT NULL,
    mihomo_x25519 boolean DEFAULT false NOT NULL,
    shuffle_host boolean DEFAULT false NOT NULL,
    xray_json_template_uuid uuid,
    keep_sni_blank boolean DEFAULT false NOT NULL,
    exclude_from_subscription_types text[] DEFAULT ARRAY[]::text[],
    final_mask jsonb
);


ALTER TABLE public.hosts OWNER TO postgres;

--
-- Name: hosts_to_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hosts_to_nodes (
    host_uuid uuid NOT NULL,
    node_uuid uuid NOT NULL
);


ALTER TABLE public.hosts_to_nodes OWNER TO postgres;

--
-- Name: hosts_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hosts_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hosts_view_position_seq OWNER TO postgres;

--
-- Name: hosts_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hosts_view_position_seq OWNED BY public.hosts.view_position;


--
-- Name: hwid_user_devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hwid_user_devices (
    hwid text NOT NULL,
    user_uuid uuid NOT NULL,
    platform text,
    os_version text,
    device_model text,
    user_agent text,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.hwid_user_devices OWNER TO postgres;

--
-- Name: infra_billing_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_billing_history (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_uuid uuid NOT NULL,
    amount double precision NOT NULL,
    billed_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.infra_billing_history OWNER TO postgres;

--
-- Name: infra_billing_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_billing_nodes (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    node_uuid uuid NOT NULL,
    provider_uuid uuid NOT NULL,
    next_billing_at timestamp(3) without time zone NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.infra_billing_nodes OWNER TO postgres;

--
-- Name: infra_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_providers (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    favicon_link text,
    login_url text,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.infra_providers OWNER TO postgres;

--
-- Name: internal_squad_host_exclusions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_squad_host_exclusions (
    host_uuid uuid NOT NULL,
    squad_uuid uuid NOT NULL
);


ALTER TABLE public.internal_squad_host_exclusions OWNER TO postgres;

--
-- Name: internal_squad_inbounds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_squad_inbounds (
    internal_squad_uuid uuid NOT NULL,
    inbound_uuid uuid NOT NULL
);


ALTER TABLE public.internal_squad_inbounds OWNER TO postgres;

--
-- Name: internal_squad_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_squad_members (
    internal_squad_uuid uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.internal_squad_members OWNER TO postgres;

--
-- Name: internal_squads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_squads (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    view_position integer NOT NULL
);


ALTER TABLE public.internal_squads OWNER TO postgres;

--
-- Name: internal_squads_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.internal_squads_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.internal_squads_view_position_seq OWNER TO postgres;

--
-- Name: internal_squads_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.internal_squads_view_position_seq OWNED BY public.internal_squads.view_position;


--
-- Name: keygen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keygen (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    priv_key text NOT NULL,
    pub_key text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    ca_cert text,
    ca_key text,
    client_cert text,
    client_key text
);


ALTER TABLE public.keygen OWNER TO postgres;

--
-- Name: node_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.node_meta (
    node_id bigint NOT NULL,
    metadata jsonb NOT NULL
);


ALTER TABLE public.node_meta OWNER TO postgres;

--
-- Name: node_plugin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.node_plugin (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    view_position integer NOT NULL,
    name character varying(255) NOT NULL,
    plugin_config jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.node_plugin OWNER TO postgres;

--
-- Name: node_plugin_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.node_plugin_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.node_plugin_view_position_seq OWNER TO postgres;

--
-- Name: node_plugin_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.node_plugin_view_position_seq OWNED BY public.node_plugin.view_position;


--
-- Name: nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nodes (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    port integer,
    is_connected boolean DEFAULT false NOT NULL,
    is_connecting boolean DEFAULT false NOT NULL,
    is_disabled boolean DEFAULT false NOT NULL,
    last_status_change timestamp(3) without time zone,
    last_status_message text,
    is_traffic_tracking_active boolean DEFAULT false NOT NULL,
    traffic_reset_day integer DEFAULT 1,
    traffic_limit_bytes bigint DEFAULT 0,
    traffic_used_bytes bigint DEFAULT 0,
    notify_percent integer DEFAULT 0,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    view_position integer NOT NULL,
    country_code text DEFAULT 'XX'::text NOT NULL,
    consumption_multiplier bigint DEFAULT 1000000000 NOT NULL,
    active_config_profile_uuid uuid,
    provider_uuid uuid,
    id bigint NOT NULL,
    tags text[] DEFAULT ARRAY[]::text[],
    active_plugin_uuid uuid
);


ALTER TABLE public.nodes OWNER TO postgres;

--
-- Name: nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nodes_id_seq OWNER TO postgres;

--
-- Name: nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nodes_id_seq OWNED BY public.nodes.id;


--
-- Name: nodes_traffic_usage_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nodes_traffic_usage_history (
    node_uuid uuid NOT NULL,
    traffic_bytes bigint NOT NULL,
    reset_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.nodes_traffic_usage_history OWNER TO postgres;

--
-- Name: nodes_traffic_usage_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nodes_traffic_usage_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nodes_traffic_usage_history_id_seq OWNER TO postgres;

--
-- Name: nodes_traffic_usage_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nodes_traffic_usage_history_id_seq OWNED BY public.nodes_traffic_usage_history.id;


--
-- Name: nodes_usage_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nodes_usage_history (
    node_uuid uuid NOT NULL,
    download_bytes bigint NOT NULL,
    upload_bytes bigint NOT NULL,
    total_bytes bigint NOT NULL,
    created_at timestamp(3) without time zone DEFAULT date_trunc('hour'::text, now()) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.nodes_usage_history OWNER TO postgres;

--
-- Name: nodes_user_usage_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nodes_user_usage_history (
    node_id bigint CONSTRAINT nodes_user_usage_history_new_node_id_not_null NOT NULL,
    user_id bigint CONSTRAINT nodes_user_usage_history_new_user_id_not_null NOT NULL,
    total_bytes bigint CONSTRAINT nodes_user_usage_history_new_total_bytes_not_null1 NOT NULL,
    created_at date DEFAULT CURRENT_DATE CONSTRAINT nodes_user_usage_history_new_created_at_not_null1 NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() CONSTRAINT nodes_user_usage_history_new_updated_at_not_null1 NOT NULL
);


ALTER TABLE public.nodes_user_usage_history OWNER TO postgres;

--
-- Name: nodes_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nodes_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nodes_view_position_seq OWNER TO postgres;

--
-- Name: nodes_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nodes_view_position_seq OWNED BY public.nodes.view_position;


--
-- Name: passkeys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passkeys (
    id text NOT NULL,
    admin_uuid uuid NOT NULL,
    public_key bytea NOT NULL,
    counter bigint NOT NULL,
    device_type text NOT NULL,
    backed_up boolean NOT NULL,
    transports text,
    passkey_provider text,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.passkeys OWNER TO postgres;

--
-- Name: remnawave_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.remnawave_settings (
    id integer DEFAULT 1 NOT NULL,
    passkey_settings jsonb,
    oauth2_settings jsonb,
    password_settings jsonb,
    branding_settings jsonb
);


ALTER TABLE public.remnawave_settings OWNER TO postgres;

--
-- Name: subscription_page_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_page_config (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    view_position integer NOT NULL,
    name character varying(30) NOT NULL,
    config jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.subscription_page_config OWNER TO postgres;

--
-- Name: subscription_page_config_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_page_config_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_page_config_view_position_seq OWNER TO postgres;

--
-- Name: subscription_page_config_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_page_config_view_position_seq OWNED BY public.subscription_page_config.view_position;


--
-- Name: subscription_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_settings (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    profile_title text NOT NULL,
    support_link text NOT NULL,
    profile_update_interval integer NOT NULL,
    happ_announce text,
    happ_routing text,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    is_profile_webpage_url_enabled boolean DEFAULT true NOT NULL,
    serve_json_at_base_subscription boolean DEFAULT false NOT NULL,
    is_show_custom_remarks boolean DEFAULT true NOT NULL,
    custom_response_headers jsonb,
    randomize_hosts boolean DEFAULT false NOT NULL,
    response_rules jsonb,
    hwid_settings jsonb,
    custom_remarks jsonb NOT NULL
);


ALTER TABLE public.subscription_settings OWNER TO postgres;

--
-- Name: subscription_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_templates (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    template_type text NOT NULL,
    template_yaml text,
    template_json jsonb,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    name character varying(255) DEFAULT 'Default'::character varying NOT NULL,
    view_position integer NOT NULL
);


ALTER TABLE public.subscription_templates OWNER TO postgres;

--
-- Name: subscription_templates_view_position_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_templates_view_position_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_templates_view_position_seq OWNER TO postgres;

--
-- Name: subscription_templates_view_position_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_templates_view_position_seq OWNED BY public.subscription_templates.view_position;


--
-- Name: torrent_blocker_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.torrent_blocker_reports (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    node_id bigint NOT NULL,
    report jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.torrent_blocker_reports OWNER TO postgres;

--
-- Name: torrent_blocker_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.torrent_blocker_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.torrent_blocker_reports_id_seq OWNER TO postgres;

--
-- Name: torrent_blocker_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.torrent_blocker_reports_id_seq OWNED BY public.torrent_blocker_reports.id;


--
-- Name: user_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_meta (
    user_id bigint NOT NULL,
    metadata jsonb NOT NULL
);


ALTER TABLE public.user_meta OWNER TO postgres;

--
-- Name: user_subscription_request_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_subscription_request_history (
    id bigint NOT NULL,
    user_uuid uuid NOT NULL,
    request_ip text,
    user_agent text,
    request_at timestamp(3) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_subscription_request_history OWNER TO postgres;

--
-- Name: user_subscription_request_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_subscription_request_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_subscription_request_history_id_seq OWNER TO postgres;

--
-- Name: user_subscription_request_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_subscription_request_history_id_seq OWNED BY public.user_subscription_request_history.id;


--
-- Name: user_traffic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_traffic (
    t_id bigint NOT NULL,
    used_traffic_bytes bigint DEFAULT 0 NOT NULL,
    lifetime_used_traffic_bytes bigint DEFAULT 0 NOT NULL,
    online_at timestamp(3) without time zone,
    last_connected_node_uuid uuid,
    first_connected_at timestamp(3) without time zone
);


ALTER TABLE public.user_traffic OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    short_uuid text NOT NULL,
    username text NOT NULL,
    status character varying(10) DEFAULT 'ACTIVE'::text NOT NULL,
    traffic_limit_bytes bigint DEFAULT 0 NOT NULL,
    traffic_limit_strategy text DEFAULT 'NO_RESET'::text NOT NULL,
    expire_at timestamp(3) without time zone NOT NULL,
    sub_revoked_at timestamp(3) without time zone,
    last_traffic_reset_at timestamp(3) without time zone,
    trojan_password text NOT NULL,
    vless_uuid uuid NOT NULL,
    ss_password text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT now() NOT NULL,
    description text,
    email text,
    telegram_id bigint,
    hwid_device_limit integer,
    tag text,
    last_triggered_threshold integer DEFAULT 0 NOT NULL,
    t_id bigint NOT NULL,
    external_squad_uuid uuid
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_t_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_t_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_t_id_seq OWNER TO postgres;

--
-- Name: users_t_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_t_id_seq OWNED BY public.users.t_id;


--
-- Name: config_profiles view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profiles ALTER COLUMN view_position SET DEFAULT nextval('public.config_profiles_view_position_seq'::regclass);


--
-- Name: external_squads view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads ALTER COLUMN view_position SET DEFAULT nextval('public.external_squads_view_position_seq'::regclass);


--
-- Name: hosts view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts ALTER COLUMN view_position SET DEFAULT nextval('public.hosts_view_position_seq'::regclass);


--
-- Name: internal_squads view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squads ALTER COLUMN view_position SET DEFAULT nextval('public.internal_squads_view_position_seq'::regclass);


--
-- Name: node_plugin view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_plugin ALTER COLUMN view_position SET DEFAULT nextval('public.node_plugin_view_position_seq'::regclass);


--
-- Name: nodes view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes ALTER COLUMN view_position SET DEFAULT nextval('public.nodes_view_position_seq'::regclass);


--
-- Name: nodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes ALTER COLUMN id SET DEFAULT nextval('public.nodes_id_seq'::regclass);


--
-- Name: nodes_traffic_usage_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_traffic_usage_history ALTER COLUMN id SET DEFAULT nextval('public.nodes_traffic_usage_history_id_seq'::regclass);


--
-- Name: subscription_page_config view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_page_config ALTER COLUMN view_position SET DEFAULT nextval('public.subscription_page_config_view_position_seq'::regclass);


--
-- Name: subscription_templates view_position; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_templates ALTER COLUMN view_position SET DEFAULT nextval('public.subscription_templates_view_position_seq'::regclass);


--
-- Name: torrent_blocker_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.torrent_blocker_reports ALTER COLUMN id SET DEFAULT nextval('public.torrent_blocker_reports_id_seq'::regclass);


--
-- Name: user_subscription_request_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_subscription_request_history ALTER COLUMN id SET DEFAULT nextval('public.user_subscription_request_history_id_seq'::regclass);


--
-- Name: users t_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN t_id SET DEFAULT nextval('public.users_t_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
bbb8c6dd-025d-486f-93ec-22341449e924	f0b4ced1bb2de44dbea371da2a742af806c419f40753ce621f89e1d8ab051426	2026-05-15 01:34:54.952773+00	20250404230114_replace_uuid_with_id_in_a_few_tables_drop_uuid_for_active_user_inbounds	\N	\N	2026-05-15 01:34:54.943185+00	1
991b41b8-0bd4-4477-991f-c7370a1c8c10	168d6ede9151b54e3ad8c9efcad18d9c7b191c70689306dd8e4bbddd3b12973e	2026-05-15 01:34:54.791094+00	20241129132625_init	\N	\N	2026-05-15 01:34:54.770763+00	1
2aaba389-b135-4be1-b612-2c45d88f5043	7a3d32ea969ba21c1405df563e06dcd927213f02d3070de56e6d8f5de29fcca2	2026-05-15 01:34:54.866516+00	20250301181855_add_telegram_id_and_email_fields	\N	\N	2026-05-15 01:34:54.862071+00	1
6b14c1cb-bd9d-483d-8b59-db2ef7956118	3c5471d46533544d1c9b3aae718bbcc71455f2a9d5e98ecce8cc7fb3e5f647c2	2026-05-15 01:34:54.797089+00	20241205203645_	\N	\N	2026-05-15 01:34:54.791683+00	1
ec80b5d1-c3df-4d0e-8052-c3c390b4bf41	ec9d49568220e5b3032a14afa0a99ddb7bbca5b04120a7a2ca18141c81dde609	2026-05-15 01:34:54.803377+00	20241216003610_add_new_field	\N	\N	2026-05-15 01:34:54.797652+00	1
c74065c9-0183-4328-94da-3aaacbf3acb0	47af2705aa25ec6111b9edb27366e939b073a00502c3ac18418eb1e5705bf4a2	2026-05-15 01:34:54.911477+00	20250314191018_add_username_to_base_subscription	\N	\N	2026-05-15 01:34:54.906825+00	1
1ab9e10b-4085-4f24-badb-f55dfb835681	972566a03a062b0a94776755ce4a1288b5f379cfc7eacafeb9df814530848a86	2026-05-15 01:34:54.808177+00	20241222053036_add_users_online_stat	\N	\N	2026-05-15 01:34:54.803992+00	1
cff80e12-00a2-4f4a-9f96-1b4d4c27c7ad	73044d8fe1bf0173de9d55602a1ee0022f9d769f647b69f54524ee0472bb0e06	2026-05-15 01:34:54.87112+00	20250301203122_upgrade_to_v6	\N	\N	2026-05-15 01:34:54.867218+00	1
5a6d1045-0f95-4265-8a38-bf60a4da0dea	41f4fa933f25c5b1bfda88f4f4166be454ab41c2bc8cc8c5deaa90d0bc9ffa23	2026-05-15 01:34:54.814764+00	20241225185207_add_node_inbound_exclusions	\N	\N	2026-05-15 01:34:54.808813+00	1
dabd80a0-8a90-440e-ad89-e9fecca82c06	50c0b7fee06093fbca68385d18a9e037962f26afebc2486c5f1c93dc187ba9b7	2026-05-15 01:34:54.822534+00	20250113213322_add_updated_at_to_nodes_user_usage_history	\N	\N	2026-05-15 01:34:54.815389+00	1
9e6e1da2-4117-4b21-9eb3-2034c7b51d0e	c45595ce009efd41960dd916e6ed3d957ab481db2b81c1f3278bb8d8b619c5e4	2026-05-15 01:34:54.830093+00	20250113231728_add_view_position_for_nodes	\N	\N	2026-05-15 01:34:54.823253+00	1
e39a33fb-1b17-49d5-8785-eaed8a81c726	e3d0ddc309bb0cdbd4987316b77d7cae63d3c1bd0552a49175c981e5ebe991cb	2026-05-15 01:34:54.878239+00	20250302162049_new_auth_system	\N	\N	2026-05-15 01:34:54.871703+00	1
0c4567a2-2274-44b2-a0c3-2adbe54b6a42	477be6d8c523347cf2086107504c6c2fa73f7bf7478ba9606f7886d018a01d2f	2026-05-15 01:34:54.83488+00	20250114013223_add_country_code	\N	\N	2026-05-15 01:34:54.830764+00	1
792d0f43-710f-4870-96e8-aec9faab3fa5	63890abd176a2d690163a7bee1ab474b9b0b583d17c52c7d66088c38ef3b038d	2026-05-15 01:34:54.840512+00	20250126164718_add_description_field_and_fix_default_values	\N	\N	2026-05-15 01:34:54.835782+00	1
9a3f662a-2dfc-4d87-b1fd-16701639cf85	a93cfd960a6a8f49e0a1a1cf0e7b92dd98f1cda6fe732c408bc73bb5adc13231	2026-05-15 01:34:54.845561+00	20250211135916_add_consumption_multiplier	\N	\N	2026-05-15 01:34:54.841177+00	1
9d3eacfe-fc3f-4d3e-ad85-aaf5b2cf1921	4b675d986cfa98cfe7c3713cd624c6a40fb3d9ab87ecf2962a29080f9174cfcf	2026-05-15 01:34:54.883594+00	20250307025906_add_xray_uptime	\N	\N	2026-05-15 01:34:54.879292+00	1
f53fb4e7-1be2-4c55-bbb7-ba5e2464b071	a4058f9c3e62fc3f6a6f9445f97d56b211915bac65f279e7639da4d38a56e104	2026-05-15 01:34:54.85112+00	20250219012541_remove	\N	\N	2026-05-15 01:34:54.846395+00	1
b7b4912a-6fea-46bf-bf07-ae59c5febb8c	73044d8fe1bf0173de9d55602a1ee0022f9d769f647b69f54524ee0472bb0e06	2026-05-15 01:34:54.856367+00	20250219013001_remove_depreacted_limit_strategies	\N	\N	2026-05-15 01:34:54.851988+00	1
0390f2a7-ec25-4416-b1d5-40539ada07ce	258ab5797e54945ba12ab72f1ca5b70646d638fdb488b3e6c774854dbc11f1de	2026-05-15 01:34:54.919469+00	20250315164331_add_security_layer	\N	\N	2026-05-15 01:34:54.912771+00	1
10abe691-467d-44b7-a4db-2e99a75d6545	b6c0361f925c749fb93b06606393e8933c577947a70cfab2782164c2a1806699	2026-05-15 01:34:54.861364+00	20250225115627_add_network_and_security_to_inbounds	\N	\N	2026-05-15 01:34:54.857233+00	1
24c88a99-b76c-4a49-8fea-1cc7c2eabb2d	22ca100418ba8f0ba3c3b7fefd8c330074170ec2dcda5dc194c8dc26f8dd8810	2026-05-15 01:34:54.88952+00	20250308020443_add_subscription_templates	\N	\N	2026-05-15 01:34:54.884189+00	1
2c2a29fb-5593-4d4e-881a-bfe1725f9520	1db88521cf8f3929f61e5c2c829a0ffbeab2ff5dde414ebf44a5ac988477ca38	2026-05-15 01:34:54.895761+00	20250311232029_add_subscription_settings	\N	\N	2026-05-15 01:34:54.890132+00	1
6f1d46d6-bc80-47c1-a26e-250b64f21527	9985ea8051b50bbb8dfe4151c5641adf86066dbcacda9d4c134b45ed51d5ffcf	2026-05-15 01:34:55.009885+00	20250518181139_add_first_connected_at_and_notification_threshold	\N	\N	2026-05-15 01:34:55.002058+00	1
f46ab2f3-df67-4481-9c29-826c7b6d092d	7f3fb574f4d494c434a500bfaec3bb6da9e782a2321f6379470180d0d2e74b54	2026-05-15 01:34:54.901169+00	20250312014652_add_boolean_value_for_webpage_url	\N	\N	2026-05-15 01:34:54.896698+00	1
aef228ec-6d24-4d00-b0e1-2fcd3d2130f9	7ae97e77538791538dd3b98a86145dab7fa9a2522b7e74502903fdb64349cca2	2026-05-15 01:34:54.925069+00	20250321173808_add_extra_xhttp	\N	\N	2026-05-15 01:34:54.920189+00	1
518cc9fb-7fe2-45d5-95f7-0aa0b7f729a4	509075676829c9a9d4ce86885e9cada4bd347098e710fc74736b52202c0f9a73	2026-05-15 01:34:54.906139+00	20250314164711_add_serve_json_at_base_subscription	\N	\N	2026-05-15 01:34:54.90171+00	1
a21e08f9-c1dd-43b4-9f8f-81701980d5d0	cddba5a4104ee87a0ec4b3307a1cd6d68a165967aad3b70f75c0f449b5abae91	2026-05-15 01:34:54.960667+00	20250409201313_add_hwid	\N	\N	2026-05-15 01:34:54.953416+00	1
ae760750-e9dd-4b6d-9956-d4ab761a2acf	7c49c5dc0395f7df303eed620df9a0f63e39b106a71352c67ee18848cfee4039	2026-05-15 01:34:54.933239+00	20250326125917_add_ca_certs	\N	\N	2026-05-15 01:34:54.925601+00	1
70d0009b-67b3-4060-9ec9-5d5356a0caa5	af9deb8ea11463470f7f1ce21a6233f0a10267af612cb4e2c6606ca3e6a290cc	2026-05-15 01:34:54.942111+00	20250403121347_add_is_show_custom_remarks	\N	\N	2026-05-15 01:34:54.934346+00	1
f8ddc169-d7c9-433f-88e0-d99f4c84b3eb	a4d3d2958ab302f26a57c3f67226a34c6df175dfce5d2ed642e5fd912e58a929	2026-05-15 01:34:54.986212+00	20250505151503_add_user_tag	\N	\N	2026-05-15 01:34:54.979851+00	1
aabda94a-8413-4837-9033-21834642beba	9d39180a9e150cad11426302de87f0a34680e36799764707a2eeb862bf89fd6d	2026-05-15 01:34:54.968602+00	20250410180959_add_custom_response_headers	\N	\N	2026-05-15 01:34:54.961677+00	1
33713a9b-f5ce-4f27-a3bd-53aeb3d79350	93948ab00acaf683c7c0ee3c1d33ed751afd3458de416b66058409ebeef94aab	2026-05-15 01:34:55.000967+00	20250506224824_add_indexes	\N	\N	2026-05-15 01:34:54.993829+00	1
7b2cee00-f24d-43b0-a3c9-6906231f468b	4b27cd0bd2541da2b8b3c55f138971bc07bf60ae399b1f2724a17d99dd581f72	2026-05-15 01:34:54.978536+00	20250415192807_change_primary_key_on_hwid_user_devices	\N	\N	2026-05-15 01:34:54.969324+00	1
e0174ad6-a807-4f02-b6cc-8782c1c92e16	d07f83766da64f9a52fdda109d6c72e28af74b4898125a30a3a367db0fa9f187	2026-05-15 01:34:54.992967+00	20250506222812_add_index_to_nodes_user_usage_history	\N	\N	2026-05-15 01:34:54.98697+00	1
d85953ba-1556-44c1-b073-89cb85851f40	d9f766cccdf04e9fe3d14d55c2b91da35ae9c617b2e8da55bf00e039ab222d98	2026-05-15 01:34:55.016309+00	20250519185746_add_randomize_hosts	\N	\N	2026-05-15 01:34:55.010595+00	1
03421f14-a489-4d18-b49c-d1f33a322c65	c3c27673a325e63c48b6dbd1d414f38efc2ee40fc12b915de3c120c0447eb8f8	2026-05-15 01:34:55.026903+00	20250612160411_add_last_connected_node_uuid	\N	\N	2026-05-15 01:34:55.017008+00	1
3b641b23-df1e-4b6b-b56d-c712a7dc7f1c	83e7584463e8f1b4d718af14fb3de9d61606f4fdbdb1c70121d25e59353923d4	2026-05-15 01:34:55.034527+00	20250613022955_add_index_to_user_traffic_history	\N	\N	2026-05-15 01:34:55.027639+00	1
c302a711-98a1-4202-a3e0-a48324b84d00	8bba41151e07bac630fb736cf5397f9747ba406c3eaa8737bcedd74d07087b25	2026-05-15 01:34:55.057801+00	20250619032009_add_squads_and_config_profiles_drop_old_tables	\N	\N	2026-05-15 01:34:55.035535+00	1
feaafcc5-84de-4920-9226-00847ceb6a4c	4f0042715c4208f091c17e889181c1ce8836cec7fa6c23915a3caffa76e5ecf2	2026-05-15 01:34:55.173306+00	20250821172409_add_indexes	\N	\N	2026-05-15 01:34:55.166559+00	1
e16f5379-927c-4aa4-a075-fc1e4e8b4a03	a86f20835a04dd4427ea889b6bebcca9e0c13725d07f0f8634d941996132ee77	2026-05-15 01:34:55.066031+00	20250619033003_add_raw_json_to_config_profile_inbounds	\N	\N	2026-05-15 01:34:55.058785+00	1
fade557b-e302-427f-aaf8-e49b5a23063c	a87d9b1beeeea45ad76dbe2760b20b8103fb4b3f1bc438212d10e4a632e18833	2026-05-15 01:34:55.079701+00	20250620182607_add_infra_related_tables	\N	\N	2026-05-15 01:34:55.06685+00	1
a0ceac92-f017-4cc2-bd22-db864b5ea76c	e37bcd50d34206b47f3c5be3ec7dd92b1da3695d157f2ffc19883375882d0d0d	2026-05-15 01:34:55.275616+00	20251109162118_hwid_settings	\N	\N	2026-05-15 01:34:55.272013+00	1
71693f93-52e5-4bfb-b6dc-8804bc74ea9c	e04d2d8e8a3ff64307fca35485118c5cac425e8594fa963d3e81f24e3f87b0ab	2026-05-15 01:34:55.089773+00	20250625141235_add_server_description_to_hosts	\N	\N	2026-05-15 01:34:55.080692+00	1
4e74d148-d8b7-4e50-af1a-a3a2a33420fc	650c47ab960ed73efaf0b1fa7dd484f94b0d626d0c00944a2832431e1ee0a78b	2026-05-15 01:34:55.178631+00	20250822011918_add_tid	\N	\N	2026-05-15 01:34:55.173997+00	1
2e24f220-ff61-4cb8-a43e-8689b9118256	8a8ea1ca94fe2a9f88cc70d8d6846ac9c88b43cc1724227210dcaf05dc002049	2026-05-15 01:34:55.101624+00	20250626184020_change_created_at_in_nodes_user_usage_history	\N	\N	2026-05-15 01:34:55.090551+00	1
17a55633-8bcf-4168-9823-1a6258b30002	ec2875355a84e7c321284a8c63fd1a37d7560249221451064c3b253de1bc6fc2	2026-05-15 01:34:55.113078+00	20250706204810_add_node_version_to_nodes	\N	\N	2026-05-15 01:34:55.102333+00	1
c6399882-7b17-41b5-a0b4-182c1aac413f	b2db776c53eedcb92d7128292f4409af5af767dfe21be0d46e2458094d6d661b	2026-05-15 01:34:55.249007+00	20251020051722_add_external_squads	\N	\N	2026-05-15 01:34:55.2418+00	1
2b024e17-e181-4ec2-9f4f-66c52df6bcfa	4fd6543843dcee74a62be34e830b32a45d4c2ab78cf90d0c9ece4ee8ef3689ff	2026-05-15 01:34:55.120567+00	20250713201057_remove_api_token_description	\N	\N	2026-05-15 01:34:55.113898+00	1
b5486130-7bcf-49b5-86c1-d660ce97511f	ba1460697e44d615a6d29fcaa549bf3e213b86c9148d938001691c5ddce0dc5c	2026-05-15 01:34:55.197121+00	20250913131958_add_subscription_request_history	\N	\N	2026-05-15 01:34:55.179674+00	1
b60e2019-aa90-4cc7-b2b3-af4f864834dd	d8c37c0171cc011da2afdaa5075a547ffec63f96c1dc4d83eb7b2149d8f131fe	2026-05-15 01:34:55.127018+00	20250730131220_add_mux_to_host	\N	\N	2026-05-15 01:34:55.121281+00	1
41322c09-1219-4b6b-b71b-392557420153	123cadabfbacb7b23411794bacd85264a4e0f1151c8a05b9c0c6b0fb36383d5e	2026-05-15 01:34:55.134331+00	20250730140727_add_sockopt_params_to_host	\N	\N	2026-05-15 01:34:55.127942+00	1
4fa9d907-f054-4a1e-ac84-c34200bf014d	2c25b5553257aa23366b0d3383b1bec4fca9913d318c9f0ff1514e50aba7c887	2026-05-15 01:34:55.142102+00	20250807224235_remove_unique_from_host	\N	\N	2026-05-15 01:34:55.135216+00	1
9a4eeea6-98bf-47f3-9e48-177e0c1fd279	ec9965d31a57c7919ea59d84c38c66af35712dd4233aa8f655c0cb170b9b0f6b	2026-05-15 01:34:55.205792+00	20250914181427_add_ais	\N	\N	2026-05-15 01:34:55.197884+00	1
3abdd1df-7a9f-4311-b442-1b794786cafa	4944acbc125bf0b189da2a5119e208dedac026b99e013805b641ab323cde5bd8	2026-05-15 01:34:55.15067+00	20250807234256_add_tag_and_is_hidden_properties_to_host	\N	\N	2026-05-15 01:34:55.142933+00	1
8021c65f-f59c-4994-9bfb-8bee2f9b0427	7b83532970ce700353f3801f502931d3c5e49e2615b9c85c6091f1f2ce2bc867	2026-05-15 01:34:55.158772+00	20250810143307_override_sni_from_address	\N	\N	2026-05-15 01:34:55.151558+00	1
a8c53430-7840-40d0-99db-c6944f6ebae8	0444c01787261934f66c7f34aeb599005a247bc1e98569e6a626ac15c31f69b8	2026-05-15 01:34:55.165888+00	20250817155235_add_vless_route_id	\N	\N	2026-05-15 01:34:55.159403+00	1
4def2ac4-9cf9-4d30-9adb-9d0e6d721651	e827d3fcf398136e238bca2f9851810042bd6cd30c5d0b8be8b73a73ee6ee6ef	2026-05-15 01:34:55.253315+00	20251021150742_add_subscription_settings_to_es	\N	\N	2026-05-15 01:34:55.249794+00	1
f80a65be-719b-4b7c-a7c2-9f36b19b4b79	af328d09219089bc90d7b7ba6da97574888c202b137713c99ed52bfa6dd4927d	2026-05-15 01:34:55.214152+00	20250925101912_add_shuffle_host_and_mihomo_x25519	\N	\N	2026-05-15 01:34:55.206689+00	1
0a493fb0-e95c-460e-a1fb-1b0ae187a3db	f28ff98812f7edbac9b1473547edfa89b1f2dff093ec008a61fc7ec6c50b1055	2026-05-15 01:34:55.226105+00	20251008222202_add_hosts_to_nodes	\N	\N	2026-05-15 01:34:55.215152+00	1
6b5c16b9-a413-415e-8795-0f5e758da210	b7bbd0df7549ad18397d9d6792d8ac5dc76928912ade3dda92b50c0028b0c1de	2026-05-15 01:34:55.323605+00	20251118004805_node_tags	\N	\N	2026-05-15 01:34:55.320869+00	1
84825a02-d14b-41fd-a224-b15834ada6d6	004835af7ee3d3775f2a528f8cb277262dd55047df44d7d125278b8f5ef2f28e	2026-05-15 01:34:55.232372+00	20251016013423_add_snippets	\N	\N	2026-05-15 01:34:55.227215+00	1
ab19ba9c-8e5a-4b2d-8d44-33203dbb6fd1	8fa3d72051f52f35f1703e2c4411d9fa451ee13bf53bacd2694c8e04f6b7e8a0	2026-05-15 01:34:55.260863+00	20251023203325_settings_and_passkeys	\N	\N	2026-05-15 01:34:55.25399+00	1
4dd0116c-7717-4e0e-8377-7098cd6429c4	79a6905313b78082e33d88a2cbd3221645c0713ddc758a9e120044015545d2d8	2026-05-15 01:34:55.236757+00	20251017011159_add_response_rules	\N	\N	2026-05-15 01:34:55.23322+00	1
474a2af7-f840-4a89-b81d-400c783ce764	fa8b72406c4637f79cfc85f19368d556ec0cc1fe6bb622ba07c49737eb0f1c02	2026-05-15 01:34:55.241171+00	20251019220002_allow_multiple_sub_templates	\N	\N	2026-05-15 01:34:55.237789+00	1
3b81a307-8abb-49fe-9ab3-2964a82f75a1	b314c8b86de3ccae6b96147987b8111594cb0a498b28c79981af716e51a3db0c	2026-05-15 01:34:55.28276+00	20251111012403_nuu_index_drop	\N	\N	2026-05-15 01:34:55.276252+00	1
b8361250-b4bd-4e23-ad45-25aaea2950b2	e8465fefa2b0cafb7e1d3247d808317a22dc087b2027cdbde878ae272762c2e0	2026-05-15 01:34:55.265645+00	20251028234406_add_hosts_override_to_es	\N	\N	2026-05-15 01:34:55.262193+00	1
db713680-3532-41e7-8706-5fbca79f21db	97287b324ff9807c8b670bb04396516b8f82278f141cd2b940b58168263087f9	2026-05-15 01:34:55.271213+00	20251105201518_response_headers_es	\N	\N	2026-05-15 01:34:55.266471+00	1
22821821-aea5-46e9-8bca-b715f3f0d42d	095d4596edaffb0fe86d463eff3259066b552d76a1d1ec3e547a09bc24c54fc6	2026-05-15 01:34:55.309845+00	20251116151032_add_xray_json_to_host	\N	\N	2026-05-15 01:34:55.305469+00	1
c9dee94b-26c6-4707-80f5-0ff68829d584	53dce50c45e7de8fcc603af38e71705bb0591c17ad6c334766ec5f96d169ba19	2026-05-15 01:34:55.296604+00	20251111214604_refactor_user_usage_history	\N	\N	2026-05-15 01:34:55.283667+00	1
af083318-e50d-4c47-b7fc-506769dfb738	5522758157d3fa4bbe7868a34e11fc2a9d0a8e6e3307b560f6547dec5b01ffcd	2026-05-15 01:34:55.304833+00	20251112020636_user_traffic	\N	\N	2026-05-15 01:34:55.297556+00	1
6b589a7b-3ddf-4ddc-a88f-2b0cc48656e2	855bc8721a1dbe98e86f17b47c5b7514fa5e8efbeaaaff0f1469c07b57b93985	2026-05-15 01:34:55.320194+00	20251117153032_dnd	\N	\N	2026-05-15 01:34:55.310531+00	1
9fcfbcb5-5a4a-4edb-9d1f-9098686df305	c987a9a62b5104ef10fe47cb77380abf0ede65a806cddfcb072493770942412d	2026-05-15 01:34:55.333022+00	20251120225934_es_custom_remarks	\N	\N	2026-05-15 01:34:55.330526+00	1
d2308d1c-cd67-4cde-b712-1a68c56cad52	4cc6a40a517408ac3ce4a96ecde7b03df5defab9118b85e7ac61f83861333909	2026-05-15 01:34:55.329866+00	20251118174347_internal_squad_host_exclusions	\N	\N	2026-05-15 01:34:55.324355+00	1
d2d9f1e3-69f0-4c16-aa2f-f17bcd14a402	5c38adec7ed69e644170a87298e3562f144be37cc4277366d39b5c89ef1f9a84	2026-05-15 01:34:55.336929+00	20251121001611_unify_custom_remarks	\N	\N	2026-05-15 01:34:55.333803+00	1
33be910f-30f5-4ebc-aa0f-653f8fec2111	4cfa94962253ad5daf9e726a0d82996d504d79b685a958e1e821830fad249b23	2026-05-15 01:34:55.341096+00	20251126082042_drop_add_username_to_base_subscription	\N	\N	2026-05-15 01:34:55.337874+00	1
fa884a35-64fd-4482-8a0c-f065e0d0fc34	d4bf9cea13b211dac8b81011f3453a420edb6627b4a6a969837db7eb282c50bf	2026-05-15 01:34:55.347868+00	20251129171418_change_status	\N	\N	2026-05-15 01:34:55.341756+00	1
fdf5c913-105d-481c-8dcc-3507dd87ebc6	84e0ec6bd3ab157f611534da39cab00faf9e805ef4fcc0efefc8fc861373aa3b	2026-05-15 01:34:55.359333+00	20251129171707_change_pk	\N	\N	2026-05-15 01:34:55.348773+00	1
4b6e8bb1-d6a4-4ab3-97e6-8960a9909816	c52a1e9b69c91416757555cab27681ae4ddb2cf79dc3c2f3b774d1842fcdfb1f	2026-05-15 01:34:55.36787+00	20251129180538_stricter_host_columns	\N	\N	2026-05-15 01:34:55.360308+00	1
eaa4103f-03b5-4ff1-98dc-0b3356a6e822	3e3c78197625f158d55491f30930587a7d2a09b009d76552c3ba598a6a9e9281	2026-05-15 01:34:55.426989+00	20260301142020_tg_oauth2	\N	\N	2026-05-15 01:34:55.424308+00	1
2f0cb9de-d4c4-4294-b4e5-9fbe420d72f0	e04b5a43230bd270679a8d808e746c337875eb06c6dc9dc65d9c08b292416042	2026-05-15 01:34:55.372254+00	20251201172156_drop_unused_columns_in_nodes	\N	\N	2026-05-15 01:34:55.368892+00	1
2ae8e731-a901-48ec-bb71-7286451b9567	ef348cd302207da1b58705ca03217cf4ca6d29b1ddac761ace07e2ae810a6c1a	2026-05-15 01:34:55.376593+00	20251201232425_drop_user_traffic_history	\N	\N	2026-05-15 01:34:55.372958+00	1
cf111271-ad1f-49cb-83f2-8531ab92bb57	9287e13ff7775e5b8a88f162705bda6c4ed44daa58ee6ac83e5900035649af0d	2026-05-15 01:34:55.383413+00	20251202213233_change_uuid_to_id_in_is_memers	\N	\N	2026-05-15 01:34:55.377386+00	1
de973b5b-b950-479c-bcc8-e95c90352613	0853387b5409242131d8930e59858f2736f3ec5cb01678e204da0863e0add755	2026-05-15 01:34:55.434071+00	20260305150610_user_node_metadata	\N	\N	2026-05-15 01:34:55.427985+00	1
1fe58f4b-4273-4569-935b-ed1b5ed7b2ca	43cb1aef5286dafa9e4498cde36039c3e1cccc00a774a1f79844bcb519b8e5c6	2026-05-15 01:34:55.387402+00	20251207150402_blank_sni	\N	\N	2026-05-15 01:34:55.384467+00	1
0a37d78e-289e-483d-b777-e31525981fdb	f66ee9c02e5b359cf36d48bed0eeac86b6a2b24ed9b86494f73ce8388dbc5d18	2026-05-15 01:34:55.39345+00	20251214002858_subpage_configs	\N	\N	2026-05-15 01:34:55.388084+00	1
b469006a-2346-4ce6-b9e6-e26ac3b3f87e	bb82d4dfd8ae1d05b74a8308f163afd1b7ee464cd2021ad74b5b40dc1e8f71a4	2026-05-15 01:34:55.399146+00	20251214163118_truncate_configs	\N	\N	2026-05-15 01:34:55.394205+00	1
776254c0-ac02-47ab-9206-c21087855623	a75ad6dfaba4465514066cb1868e817cd11954575fe5b7fd66477c0d47daf985	2026-05-15 01:34:55.442418+00	20260307201721_torrent_blocker_reports	\N	\N	2026-05-15 01:34:55.434991+00	1
7a57e065-bcec-4168-b522-c44b3a0170ec	0b052b802f9d9852e9f88ff4785f408ef8161dfeb035f046a4d7a89d1ba8cc2b	2026-05-15 01:34:55.403711+00	20251214213514_add_subpage_to_es	\N	\N	2026-05-15 01:34:55.399942+00	1
8aefed74-6a21-4a78-b772-e650d0519908	7b16aba6e3bdebb108f18536d20a305c50a5ce0569883e925c6c493c6c45982a	2026-05-15 01:34:55.406599+00	20251215222247_subpage_tr	\N	\N	2026-05-15 01:34:55.404319+00	1
5cac00c8-425b-4cef-bd7f-b071c28554bc	5f2f9bb5a13872c6306dd3e6a98541afb45252fded6abbea84fb68dfbda30624	2026-05-15 01:34:55.41039+00	20251218145003_nodes_index	\N	\N	2026-05-15 01:34:55.407284+00	1
076ab6d3-a881-448b-a52d-f33c4bfbaa42	373501753da10f69987e4ac166337e4a0dc328ce3b74eed0e2be966ed9d2f512	2026-05-15 01:34:55.446691+00	20260312215357_drop_unused_columns	\N	\N	2026-05-15 01:34:55.44323+00	1
a6493f52-a1b5-4151-a534-5d7a23f55cac	985101427cb1905de4f0d0defa9f8c72fc9b5b7ff4f8cef094d0d1be34815077	2026-05-15 01:34:55.414196+00	20260107203202_es_custom_remarks	\N	\N	2026-05-15 01:34:55.411524+00	1
61130f45-15ad-49be-af03-6db29d75a381	4b7c1e19694c20d22df72e9a61597fdc5103e4213eb683bab7e631d57a88da40	2026-05-15 01:34:55.418184+00	20260225000503_exclude_host_from_subtype	\N	\N	2026-05-15 01:34:55.415444+00	1
15142e77-08ca-4d60-9b4a-c830c5933328	6edc9c1687f41162bcd6de2f56378ffac48a981a6d60907deca5570f0c87de4b	2026-05-15 01:34:55.423776+00	20260225202645_node_plugins	\N	\N	2026-05-15 01:34:55.418768+00	1
a78d295a-50e0-4181-96ee-4ae44bdfacb8	ade6e20bff11af66d0cfdbe8972fc9b99ad66a7f0ba2383ebcd193392dbab45a	2026-05-15 01:34:55.451202+00	20260315172145_drop_legacy_columns	\N	\N	2026-05-15 01:34:55.447307+00	1
29c2a6e7-f5d6-4254-a102-a767604e4463	de8947602d8005824616fed2e3d0575091e30bfd9466a3b1ee484f8068bd0fd1	2026-05-15 01:34:55.456656+00	20260327170528_drop_node_columns	\N	\N	2026-05-15 01:34:55.451928+00	1
5bab942b-58b7-4c00-89de-e5e13c936f0b	9f8c754362f1ebdf7fe4f31d58abdf33ac6f89508e1d9a16319fec205bdd9080	2026-05-15 01:34:55.462969+00	20260328174929_final_mask_in_host	\N	\N	2026-05-15 01:34:55.457596+00	1
\.


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (uuid, username, password_hash, role, created_at, updated_at) FROM stdin;
80f45d56-c9e8-4ca5-b341-fb7d2946963f	LuckyGUY	41a5f54dc17765f4c816bffc926d5fcf:8635f4dacb4418d54e24b640aff06074776ed2693866e242339f0de1e6ed612428b66a9084f88aaafea9e87e6e6fa7915a4907a1bf577d00f35a8288e9ffa182	ADMIN	2026-05-15 01:42:47.092	2026-05-15 01:42:47.09
\.


--
-- Data for Name: api_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_tokens (uuid, token, token_name, created_at, updated_at) FROM stdin;
9c4fb89d-1cf0-45ad-a118-47057a87adba	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWM0ZmI4OWQtMWNmMC00NWFkLWExMTgtNDcwNTdhODdhZGJhIiwidXNlcm5hbWUiOm51bGwsInJvbGUiOiJBUEkiLCJpYXQiOjE3Nzg4MTAyMDAsImV4cCI6MTA0MTg3MjM4MDB9.ZV3yLHnfR894F_8KXmXdNe2m_b2_cj0UrnaIxKQDKco	Page Join	2026-05-15 01:56:40.887	2026-05-15 01:56:40.886
d8eba8a4-99bf-4bc4-bc1f-0e1b9d646326	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDhlYmE4YTQtOTliZi00YmM0LWJjMWYtMGUxYjlkNjQ2MzI2IiwidXNlcm5hbWUiOm51bGwsInJvbGUiOiJBUEkiLCJpYXQiOjE3Nzg4MDk4MjcsImV4cCI6MTA0MTg3MjM0Mjd9.toYTd8oWPcf6ZE8Knun2Eia9q13SUD98Eg70dN_TW68	Bot TG	2026-05-15 01:50:27.066	2026-05-15 01:50:27.066
\.


--
-- Data for Name: config_profile_inbounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.config_profile_inbounds (uuid, profile_uuid, tag, type, network, security, port, raw_inbound) FROM stdin;
28f183f0-5b3a-4f0a-b826-e341ec2b0129	00000000-0000-0000-0000-000000000000	VLESS_XHTTP_REALITY	vless	xhttp	reality	443	{"tag": "VLESS_XHTTP_REALITY", "port": 443, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "streamSettings": {"network": "xhttp", "security": "reality", "xhttpSettings": {"host": "", "mode": "auto", "path": "/", "xPaddingBytes": "100-1000", "scMaxBufferedPosts": 30, "scMaxEachPostBytes": "1000000", "scStreamUpServerSecs": "20-80"}, "realitySettings": {"show": false, "xver": 0, "target": "www.icloud.com:443", "shortIds": ["c6", "b9526fc05cee5f", "96be80cd", "5038c1c7ad59c190", "ad0cfb2a47f2", "1c64", "081489cb8d", "5b7ee1"], "privateKey": "CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A", "serverNames": ["www.icloud.com"]}}}
71166f34-5ff8-49b9-80a5-3755d1e1035e	b359f29d-b9b7-497c-9ead-c8a9d36866c8	CW_VLESS_XHTTP_REALITY	vless	xhttp	reality	443	{"tag": "CW_VLESS_XHTTP_REALITY", "port": 443, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "streamSettings": {"network": "xhttp", "security": "reality", "xhttpSettings": {"host": "", "mode": "auto", "path": "/", "xPaddingBytes": "100-1000", "scMaxBufferedPosts": 30, "scMaxEachPostBytes": "1000000", "scStreamUpServerSecs": "20-80"}, "realitySettings": {"show": false, "xver": 0, "target": "www.icloud.com:443", "shortIds": ["c6", "b9526fc05cee5f", "96be80cd", "5038c1c7ad59c190", "ad0cfb2a47f2", "1c64", "081489cb8d", "5b7ee1"], "privateKey": "CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A", "serverNames": ["www.icloud.com"]}}}
\.


--
-- Data for Name: config_profile_inbounds_to_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.config_profile_inbounds_to_nodes (config_profile_inbound_uuid, node_uuid) FROM stdin;
28f183f0-5b3a-4f0a-b826-e341ec2b0129	780aca89-03c4-4e8d-af79-c17c889341cb
28f183f0-5b3a-4f0a-b826-e341ec2b0129	9176215e-75da-4080-964c-bf91f2f58197
28f183f0-5b3a-4f0a-b826-e341ec2b0129	a3de4fe1-da79-447a-b8a3-1552846c7441
\.


--
-- Data for Name: config_profile_snippets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.config_profile_snippets (name, snippet, created_at) FROM stdin;
\.


--
-- Data for Name: config_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.config_profiles (uuid, name, config, created_at, updated_at, view_position) FROM stdin;
d084519c-a127-48b0-90a4-4b3b95e10944	CW XHTTP TLS	{"log": {"loglevel": "none"}, "routing": {"rules": [{"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"}, {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}]}, "inbounds": [{"tag": "VLESS_XHTTP_TLS", "port": 443, "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "sniffing": {"enabled": true, "destOverride": ["http", "tls", "quic"]}, "streamSettings": {"network": "xhttp", "security": "tls", "tlsSettings": {"alpn": ["h2", "http/1.1"], "serverName": "#REPLACE_WITH_YOUR_SERVER_NAME, EXAMPLE: example.com", "certificates": [{"keyFile": "#PLACE YOUR SSL CERTIFICATE KEY FILE", "certificateFile": "#PLACE YOUR SSL CERTIFICATE FILE"}]}, "xhttpSettings": {"host": "#REPLACE_WITH_YOUR_SERVER_NAME, EXAMPLE: example.com", "path": "/"}}}], "outbounds": [{"tag": "DIRECT", "protocol": "freedom"}, {"tag": "BLOCK", "protocol": "blackhole"}]}	2026-05-23 15:30:19.044	2026-05-23 15:30:19.044	5
18057db4-c47e-4bad-9206-433666a2e6f0	CW TCP REALITY SELFSTEAL	{"log": {"loglevel": "none"}, "routing": {"rules": [{"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"}, {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}]}, "inbounds": [{"tag": "VLESS_TCP_REALITY_SELFSTEAL", "port": 443, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "sniffing": {"enabled": true, "routeOnly": true, "destOverride": ["http", "tls"]}, "streamSettings": {"network": "grpc", "security": "reality", "grpcSettings": {"serviceName": "#REPLACE_WITH_YOUR_serviceName, EXAMPLE: xyz"}, "realitySettings": {"show": false, "xver": 0, "target": "127.0.0.1:9443", "spiderX": "/", "shortIds": [""], "privateKey": "#REPLACE_WITH_YOUR_PRIVATE_KEY, GENERATE BELOW", "fingerprint": "chrome", "serverNames": ["#REPLACE_WITH_YOUR_SERVER_NAMES, EXAMPLE: example.com"]}}}], "outbounds": [{"tag": "DIRECT", "protocol": "freedom"}, {"tag": "BLOCK", "protocol": "blackhole"}]}	2026-05-23 15:30:19.044	2026-05-23 15:30:19.044	7
79c846e2-70a1-4887-a98a-d28b40689f02	CW GRPC REALITY SELFSTEAL	{"log": {"loglevel": "none"}, "routing": {"rules": [{"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"}, {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}]}, "inbounds": [{"tag": "VLESS_GRPC_REALITY_SELFSTEAL", "port": 443, "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "sniffing": {"enabled": true, "destOverride": ["http", "tls"]}, "streamSettings": {"network": "grpc", "security": "reality", "grpcSettings": {"authority": "127.0.0.1:9443", "multiMode": false, "serviceName": "#REPLACE_WITH_YOUR_serviceName, EXAMPLE: xyz"}, "realitySettings": {"show": false, "xver": 0, "target": "127.0.0.1:9443", "shortIds": [""], "privateKey": "#REPLACE_WITH_YOUR_PRIVATE_KEY, GENERATE BELOW", "fingerprint": "chrome", "serverNames": ["#REPLACE_WITH_YOUR_SERVER_NAMES, EXAMPLE: example.com"]}}}], "outbounds": [{"tag": "DIRECT", "protocol": "freedom"}, {"tag": "BLOCK", "protocol": "blackhole"}]}	2026-05-23 15:30:19.044	2026-05-23 15:30:19.044	8
98345ae2-9a80-4e22-9cbc-0f104795d8ed	CW GRPC REALITY SELFSTEAL WARP	{"log": {"loglevel": "none"}, "routing": {"rules": [{"type": "field", "protocol": ["bittorrent"], "outboundTag": "blocked"}, {"ip": ["geoip:private"], "type": "field", "outboundTag": "blocked"}, {"domain": ["#REPLACE_WITH_YOUR_DOMAIN. EXAMPLE: geosite:google-gemini"], "outboundTag": "warp-out"}], "domainStrategy": "IPIfNonMatch"}, "inbounds": [{"tag": "VLESS_GRPC_REALITY_SELFSTEAL_WARP", "port": 443, "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "sniffing": {"enabled": true, "destOverride": ["http", "tls"]}, "streamSettings": {"network": "grpc", "security": "reality", "grpcSettings": {"authority": "127.0.0.1:9443", "multiMode": false, "serviceName": "#REPLACE_WITH_YOUR_SERVICENAME, EXAMPLE: xyz"}, "realitySettings": {"show": false, "xver": 0, "target": "127.0.0.1:9443", "shortIds": [""], "privateKey": "#REPLACE_WITH_YOUR_PRIVATE_KEY, GENERATE BELOW", "fingerprint": "chrome", "serverNames": ["#REPLACE_WITH_YOUR_SERVER_NAMES, EXAMPLE: example.com"]}}}], "outbounds": [{"tag": "direct", "protocol": "freedom", "settings": {"domainStrategy": "UseIPv4"}}, {"tag": "warp-out", "protocol": "wireguard", "settings": {"peers": [{"endpoint": "162.159.195.1:500", "publicKey": "#REPLACE_WITH_YOUR_PUBLICKEY_FROM_WARP"}], "address": ["#REPLACE_WITH_YOUR_ADRESS_FROM_WARP. EXAMPLE: 172.16.0.2/32"], "reserved": [0, 0, 0], "secretKey": "#REPLACE_WITH_YOUR_SECRETKEY_FROM_WARP"}}, {"tag": "blocked", "protocol": "blackhole", "settings": {}}]}	2026-05-23 15:30:19.044	2026-05-23 15:30:19.044	9
00000000-0000-0000-0000-000000000000	CW Default	{"log": {"loglevel": "warning"}, "routing": {"rules": [{"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"}, {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:netflix", "geosite:disney", "geosite:apple", "geosite:spotify", "geosite:youtube"], "outboundTag": "DIRECT"}, {"type": "field", "domain": ["max.com", "hbomax.com", "hbo.com", "hboasia.com", "hbonow.com", "hbogo.com", "discoveryplus.com", "discovery.com", "dplus.com"], "outboundTag": "DIRECT"}, {"type": "field", "domain": ["cloudflare.com", "cloudflareaccess.com", "cfargotunnel.com", "argotunnel.com", "cloudflaretunnel.net", "sberbank.ru", "sber.ru", "sberpay.ru", "sbrf.ru", "tinkoff.ru", "t-bank.ru", "raiffeisen.ru", "raiffeisenbank.ru", "vtb.ru", "vtbonline.ru", "alfabank.ru", "alfa.ru", "gazprombank.ru", "rshb.ru", "pochtabank.ru", "rosbank.ru", "uralsib.ru", "sovcombank.ru", "gosuslugi.ru", "mos.ru", "nalog.ru", "nalog.gov.ru", "pfr.gov.ru", "sfr.gov.ru", "cbr.ru", "government.ru", "kremlin.ru", "rkn.gov.ru", "mil.ru", "mvd.ru", "fsb.ru", "fas.gov.ru", "minzdrav.gov.ru", "edu.ru", "minobrnauki.gov.ru", "yandex.ru", "yandex.net", "ya.ru", "yastatic.net", "yandexcloud.net", "vk.com", "vk.me", "vkontakte.ru", "vk.ru", "userapi.com", "vk-cdn.net", "ok.ru", "odnoklassniki.ru", "mail.ru", "list.ru", "bk.ru", "max.ru", "inbox.ru", "myteam.mail.ru", "mcs.mail.ru", "avito.ru", "avito.st", "wildberries.ru", "wbx-ru.com", "wb.ru", "ozon.ru", "ozon.st", "dns-shop.ru", "dns-home.ru", "citilink.ru", "eldorado.ru", "mvideo.ru", "svyaznoy.ru", "beeline.ru", "megafon.ru", "mts.ru", "tele2.ru", "rostelecom.ru", "1c.ru", "1c-dn.com", "kaspersky.ru", "drweb.ru", "2gis.ru", "2gis.com", "hh.ru", "headhunter.ru", "superjob.ru", "ivi.ru", "okko.tv", "more.tv", "kion.ru", "kinopoisk.ru", "premier.one", "rutube.ru", "rbc.ru", "ria.ru", "tass.ru", "kommersant.ru", "iz.ru", "rt.com", "gazeta.ru", "lenta.ru", "fontanka.ru", "sbis.ru", "kontur.ru", "diadoc.ru", "mos-reg.ru", "goskey.ru", "epgu.ru", "pfdo.ru", "gosbar.ru", "gostech.ru", "gosteh.ru", "sbermarket.ru", "sbermegamarket.ru", "samokat.ru", "kuper.ru", "cdek.ru", "boxberry.ru", "pochta.ru", "online.sberbank.ru"], "outboundTag": "DIRECT"}], "domainMatcher": "hybrid", "domainStrategy": "AsIs"}, "inbounds": [{"tag": "VLESS_XHTTP_REALITY", "port": 443, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "streamSettings": {"network": "xhttp", "security": "reality", "xhttpSettings": {"host": "", "mode": "auto", "path": "/", "xPaddingBytes": "100-1000", "scMaxBufferedPosts": 30, "scMaxEachPostBytes": "1000000", "scStreamUpServerSecs": "20-80"}, "realitySettings": {"show": false, "xver": 0, "target": "www.icloud.com:443", "shortIds": ["c6", "b9526fc05cee5f", "96be80cd", "5038c1c7ad59c190", "ad0cfb2a47f2", "1c64", "081489cb8d", "5b7ee1"], "privateKey": "CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A", "serverNames": ["www.icloud.com"]}}}], "outbounds": [{"tag": "DIRECT", "protocol": "freedom"}, {"tag": "BLOCK", "protocol": "blackhole"}]}	2026-05-15 01:34:58.94	2026-05-25 14:53:49.41	1
b359f29d-b9b7-497c-9ead-c8a9d36866c8	CW XHTTP REALITY	{"log": {"loglevel": "warning"}, "routing": {"rules": [{"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"}, {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}, {"type": "field", "domain": ["geosite:netflix", "geosite:disney", "geosite:apple", "geosite:spotify", "geosite:youtube"], "outboundTag": "DIRECT"}, {"type": "field", "domain": ["max.com", "hbomax.com", "hbo.com", "hboasia.com", "hbonow.com", "hbogo.com", "discoveryplus.com", "discovery.com", "dplus.com"], "outboundTag": "DIRECT"}, {"type": "field", "domain": ["cloudflare.com", "cloudflareaccess.com", "cfargotunnel.com", "argotunnel.com", "cloudflaretunnel.net", "sberbank.ru", "sber.ru", "sberpay.ru", "sbrf.ru", "tinkoff.ru", "t-bank.ru", "raiffeisen.ru", "raiffeisenbank.ru", "vtb.ru", "vtbonline.ru", "alfabank.ru", "alfa.ru", "gazprombank.ru", "rshb.ru", "pochtabank.ru", "rosbank.ru", "uralsib.ru", "sovcombank.ru", "gosuslugi.ru", "mos.ru", "nalog.ru", "nalog.gov.ru", "pfr.gov.ru", "sfr.gov.ru", "cbr.ru", "government.ru", "kremlin.ru", "rkn.gov.ru", "mil.ru", "mvd.ru", "fsb.ru", "fas.gov.ru", "minzdrav.gov.ru", "edu.ru", "minobrnauki.gov.ru", "yandex.ru", "yandex.net", "ya.ru", "yastatic.net", "yandexcloud.net", "vk.com", "vk.me", "vkontakte.ru", "vk.ru", "userapi.com", "vk-cdn.net", "ok.ru", "odnoklassniki.ru", "mail.ru", "list.ru", "bk.ru", "max.ru", "inbox.ru", "myteam.mail.ru", "mcs.mail.ru", "avito.ru", "avito.st", "wildberries.ru", "wbx-ru.com", "wb.ru", "ozon.ru", "ozon.st", "dns-shop.ru", "dns-home.ru", "citilink.ru", "eldorado.ru", "mvideo.ru", "svyaznoy.ru", "beeline.ru", "megafon.ru", "mts.ru", "tele2.ru", "rostelecom.ru", "1c.ru", "1c-dn.com", "kaspersky.ru", "drweb.ru", "2gis.ru", "2gis.com", "hh.ru", "headhunter.ru", "superjob.ru", "ivi.ru", "okko.tv", "more.tv", "kion.ru", "kinopoisk.ru", "premier.one", "rutube.ru", "rbc.ru", "ria.ru", "tass.ru", "kommersant.ru", "iz.ru", "rt.com", "gazeta.ru", "lenta.ru", "fontanka.ru", "sbis.ru", "kontur.ru", "diadoc.ru", "mos-reg.ru", "goskey.ru", "epgu.ru", "pfdo.ru", "gosbar.ru", "gostech.ru", "gosteh.ru", "sbermarket.ru", "sbermegamarket.ru", "samokat.ru", "kuper.ru", "cdek.ru", "boxberry.ru", "pochta.ru", "online.sberbank.ru"], "outboundTag": "DIRECT"}], "domainMatcher": "hybrid", "domainStrategy": "AsIs"}, "inbounds": [{"tag": "CW_VLESS_XHTTP_REALITY", "port": 443, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [], "decryption": "none"}, "streamSettings": {"network": "xhttp", "security": "reality", "xhttpSettings": {"host": "", "mode": "auto", "path": "/", "xPaddingBytes": "100-1000", "scMaxBufferedPosts": 30, "scMaxEachPostBytes": "1000000", "scStreamUpServerSecs": "20-80"}, "realitySettings": {"show": false, "xver": 0, "target": "www.icloud.com:443", "shortIds": ["c6", "b9526fc05cee5f", "96be80cd", "5038c1c7ad59c190", "ad0cfb2a47f2", "1c64", "081489cb8d", "5b7ee1"], "privateKey": "CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A", "serverNames": ["www.icloud.com"]}}}], "outbounds": [{"tag": "DIRECT", "protocol": "freedom"}, {"tag": "BLOCK", "protocol": "blackhole"}]}	2026-05-23 15:30:19.044	2026-05-25 14:54:41.473	4
\.


--
-- Data for Name: external_squads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_squads (uuid, name, created_at, updated_at, subscription_settings, host_overrides, response_headers, hwid_settings, view_position, custom_remarks, subpage_config_uuid) FROM stdin;
23fe3e60-3c12-48a0-bc09-e5b1488290fc	VIP	2026-05-21 06:37:04.838	2026-05-21 06:37:20.906	\N	\N	\N	\N	0	\N	\N
c70033be-d256-403a-b3ff-87404be0dc8e	ArredoCarisma	2026-05-21 06:30:26.637	2026-05-21 06:37:20.907	\N	\N	\N	\N	1	\N	\N
\.


--
-- Data for Name: external_squads_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_squads_templates (external_squad_uuid, template_uuid, template_type) FROM stdin;
\.


--
-- Data for Name: hosts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hosts (uuid, view_position, remark, address, port, path, sni, host, alpn, fingerprint, is_disabled, security_layer, xhttp_extra_params, config_profile_inbound_uuid, config_profile_uuid, server_description, mux_params, sockopt_params, is_hidden, tag, override_sni_from_address, vless_route_id, allow_insecure, mihomo_x25519, shuffle_host, xray_json_template_uuid, keep_sni_blank, exclude_from_subscription_types, final_mask) FROM stdin;
678f1abf-c14b-45cf-baf7-a1be6ee63948	2	🇩🇪 Arredo Carisma	mesh-arredo.cloudweb.name	443	\N	\N	\N	\N	\N	f	DEFAULT	null	28f183f0-5b3a-4f0a-b826-e341ec2b0129	00000000-0000-0000-0000-000000000000	\N	null	null	f	\N	f	\N	f	f	f	a3f48ed6-ca30-4c9a-aa20-402fbe72da8c	f	{}	null
bfdd086b-2e98-41de-9ce2-9bef37173819	9	🇩🇪 FRA Public 01	mesh-8040046.cloudweb.name	443	\N	\N	\N	\N	\N	f	DEFAULT	null	28f183f0-5b3a-4f0a-b826-e341ec2b0129	00000000-0000-0000-0000-000000000000	\N	null	null	f	\N	f	\N	f	f	f	a3f48ed6-ca30-4c9a-aa20-402fbe72da8c	f	{}	null
f0b2b4f4-4220-4cb8-b04b-8d967139dd66	10	🇷🇺 Arredo Carisma MSK-01	mesh-7205300.cloudweb.name	443	\N	\N	\N	\N	\N	f	DEFAULT	null	28f183f0-5b3a-4f0a-b826-e341ec2b0129	00000000-0000-0000-0000-000000000000	\N	null	null	f	\N	f	\N	f	f	f	\N	f	{}	null
8ccee319-a75c-4c0e-adf4-e022be450db4	1	🇺🇸 NYC Public 01	mesh-7205355.cloudweb.name	443	\N	\N		\N	\N	t	DEFAULT	{"xmux": {"cMaxReuseTimes": 0, "maxConcurrency": "16-32", "maxConnections": 0, "hKeepAlivePeriod": 0, "hMaxRequestTimes": "600-900", "hMaxReusableSecs": "1800-3000"}, "headers": {}, "noGRPCHeader": false, "xPaddingBytes": "100-1000", "scMaxEachPostBytes": 1000000, "scMinPostsIntervalMs": 30, "scStreamUpServerSecs": "20-80"}	28f183f0-5b3a-4f0a-b826-e341ec2b0129	00000000-0000-0000-0000-000000000000	\N	null	null	f	\N	f	\N	f	f	f	a3f48ed6-ca30-4c9a-aa20-402fbe72da8c	f	{}	null
\.


--
-- Data for Name: hosts_to_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hosts_to_nodes (host_uuid, node_uuid) FROM stdin;
678f1abf-c14b-45cf-baf7-a1be6ee63948	780aca89-03c4-4e8d-af79-c17c889341cb
bfdd086b-2e98-41de-9ce2-9bef37173819	9176215e-75da-4080-964c-bf91f2f58197
f0b2b4f4-4220-4cb8-b04b-8d967139dd66	a3de4fe1-da79-447a-b8a3-1552846c7441
\.


--
-- Data for Name: hwid_user_devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hwid_user_devices (hwid, user_uuid, platform, os_version, device_model, user_agent, created_at, updated_at) FROM stdin;
jn8okvm87k7j4jz2	0638818d-b9e3-48a3-a62f-875b4a463a0a	iOS	26.3.1	iPhone 14	Happ/4.9.0/ios/2605051739663	2026-05-17 12:23:12.621	2026-05-20 14:04:46.977
5fb2065048677d94	515c5cab-bd05-4cf7-bafb-4438091434b6	Android	13	V2058	Happ/3.21.1/Android/17790979898951821678	2026-05-22 15:44:42.514	2026-05-22 15:44:42.511
5f677f6c8b6e5f8a	53780d13-5737-4463-af47-ce48752f4a94	Android	14	SM-A525F	Happ/3.21.1/Android/17790979898951821578	2026-05-22 08:49:56.338	2026-05-23 21:39:34.289
qelj0gasgrkssh6i	217ce3e3-42e5-44a1-8733-5a235dbb09d0	macOS	26.5	Mac	Happ/4.9.0/macos catalyst/2605051741620	2026-05-24 06:17:23.859	2026-05-30 19:41:40.453
qelj0gasgrkssh6i	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	macOS	26.5	Mac	Happ/4.9.0/macos catalyst/2605051741620	2026-05-25 15:12:10.354	2026-05-30 19:41:40.451
chhpiui67fq2muac	dea17874-4b3b-46b1-9e54-e5d2eddb254c	macOS	26.1	Mac	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:44:54.363	2026-05-30 20:35:47.572
st7uo8uwb7svk6nz	36ce2026-597f-43d7-8704-95ec02ff8a41	iOS	15.8.8	iPhone SE	Happ/4.10.2/ios/2605221355612	2026-05-30 07:28:22.678	2026-05-30 07:28:22.677
7hjxjyitlnr8zgvb	217ce3e3-42e5-44a1-8733-5a235dbb09d0	iOS	26.5	iPhone 12 Pro	Happ/4.10.2/ios/2605221402566	2026-05-24 02:32:18.82	2026-05-29 14:49:12.174
30293cd9c13e1577	c217198d-b61a-4def-973f-63a8ea575e7b	Android	13	SM-A536E	Happ/3.21.1/Android/17790979898951821678	2026-05-22 07:59:43.481	2026-05-30 16:53:44.16
b709816b8134ba61	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	Android	16	SM-S9180	Happ/3.21.1/Android/17790979898951821678	2026-05-26 13:01:08.552	2026-05-30 17:16:16.641
a1244be39e3c083e	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	Android	16	SM-S938B	Happ/3.21.1/Android/17790979898951821678	2026-05-19 08:37:38.87	2026-05-30 18:01:13.052
9c635de2106f5eaa	1364078b-a5b8-4866-95c5-b9f5a8666e7c	Android	15	TECNO LI7	Happ/3.21.1/Android/17790979898951821678	2026-05-28 14:58:09.865	2026-05-30 19:02:31.353
7ed735fa-b356-43bc-ab17-67790bdce8c7	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	Windows	11_10.0.22000	DESKTOP-5RKG96A_x86_64	Happ/2.16.2/Windows/2605221224603	2026-05-26 18:20:52.146	2026-05-30 19:05:22.068
e56sg6d2361evm0n	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	macOS	26.5	Mac	Happ/4.9.0/macos catalyst/2605051741520	2026-05-19 08:28:23.968	2026-05-29 10:27:39.65
lypkwzpaa9ocj9lv	c217198d-b61a-4def-973f-63a8ea575e7b	iOS	18.7.8	iPhone 13 Pro	Happ/4.10.2/ios/2605221402666	2026-05-22 08:05:39.618	2026-05-30 03:46:51.557
\.


--
-- Data for Name: infra_billing_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_billing_history (uuid, provider_uuid, amount, billed_at) FROM stdin;
b27be493-c50a-4a07-95b8-6a9d7e793d24	96306fb5-1b66-444d-89ec-512201a4b210	5	2026-04-02 21:00:00
29ca867d-0f67-4d16-902d-841763e39110	96306fb5-1b66-444d-89ec-512201a4b210	12	2026-04-15 21:00:00
de3d231e-962a-4b55-b23d-65e2c37ceac5	96306fb5-1b66-444d-89ec-512201a4b210	5	2026-05-15 21:00:00
560dec19-64c6-4a43-b9e1-2417a799be4e	a729cdae-7b30-45d0-8275-575222d17269	10	2026-02-08 21:00:00
5667462e-ede7-40cd-bf04-c031a4e46228	f7286aae-c16f-47f2-ad6f-6ff7a54c4577	7.06	2026-05-27 21:00:00
\.


--
-- Data for Name: infra_billing_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_billing_nodes (uuid, node_uuid, provider_uuid, next_billing_at, created_at, updated_at) FROM stdin;
e794474c-8448-46f7-8c55-d0dbc44df360	780aca89-03c4-4e8d-af79-c17c889341cb	96306fb5-1b66-444d-89ec-512201a4b210	2026-06-03 21:00:00	2026-05-21 07:03:59.178	2026-05-21 07:03:59.175
768f67e2-aa32-4269-a895-0aa720876fe1	a3de4fe1-da79-447a-b8a3-1552846c7441	f7286aae-c16f-47f2-ad6f-6ff7a54c4577	2026-06-27 21:00:00	2026-05-28 16:04:00.162	2026-05-28 16:04:07.608
\.


--
-- Data for Name: infra_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_providers (uuid, name, favicon_link, login_url, created_at, updated_at) FROM stdin;
330d7d98-de85-4510-8667-295a78522909	TimeWEB	https://timeweb.cloud/my/favicon.ico	https://timeweb.cloud/my/login	2026-05-21 06:42:34.196	2026-05-21 06:42:34.196
96306fb5-1b66-444d-89ec-512201a4b210	HostMan	https://hostman.com/my/favicon.ico	https://hostman.com/my/login	2026-05-21 06:43:49.612	2026-05-21 06:43:49.611
29d613f0-9689-4162-80a0-a654cacca564	DigitalOcean	https://cloud.digitalocean.com/favicon.png	https://cloud.digitalocean.com/login	2026-05-21 06:45:04.61	2026-05-21 06:45:04.609
a729cdae-7b30-45d0-8275-575222d17269	Vultr	https://www.vultr.com/favicon/favicon-16x16.png	https://console.vultr.com	2026-05-21 06:47:42.881	2026-05-21 06:49:29.596
68305f80-633f-4907-aa67-774b1906b418	Hostinger	https://www.hostinger.com/favicon.ico	https://auth.hostinger.com/login	2026-05-21 06:52:12.552	2026-05-21 06:52:12.552
2d2b8127-96a2-4ab3-a56f-d8475246f8e8	Google	https://www.gstatic.com/cgc/supercloud_favicon.ico	https://accounts.google.com/	2026-05-21 06:55:54.812	2026-05-21 06:56:26.398
dabdeb9a-160f-409f-8168-98fcf604296a	Zomro	https://zomro.com/static/site/favicon.ico	https://cp.zomro.com/login	2026-05-22 10:40:19.795	2026-05-22 10:40:19.777
5add3b88-fd47-4a33-9ec0-77ae1e42a675	Alibaba	https://img.alicdn.com/tfs/TB1ugg7M9zqK1RjSZPxXXc4tVXa-32-32.png_.webp	https://account.alibabacloud.com/login/login.htm	2026-05-22 11:01:03.452	2026-05-22 11:01:03.451
f7286aae-c16f-47f2-ad6f-6ff7a54c4577	Beget	https://beget.com/favicon.ico	https://cp.beget.com/login	2026-05-28 16:02:39.696	2026-05-28 16:02:39.695
\.


--
-- Data for Name: internal_squad_host_exclusions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_squad_host_exclusions (host_uuid, squad_uuid) FROM stdin;
678f1abf-c14b-45cf-baf7-a1be6ee63948	a4d53819-8d21-4594-b85c-08e5425293ad
678f1abf-c14b-45cf-baf7-a1be6ee63948	32eb5185-c698-4bdd-bc41-7630a5065531
bfdd086b-2e98-41de-9ce2-9bef37173819	0ab61a31-3380-407f-93ed-ee707cc63495
f0b2b4f4-4220-4cb8-b04b-8d967139dd66	32eb5185-c698-4bdd-bc41-7630a5065531
8ccee319-a75c-4c0e-adf4-e022be450db4	0ab61a31-3380-407f-93ed-ee707cc63495
8ccee319-a75c-4c0e-adf4-e022be450db4	32eb5185-c698-4bdd-bc41-7630a5065531
\.


--
-- Data for Name: internal_squad_inbounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_squad_inbounds (internal_squad_uuid, inbound_uuid) FROM stdin;
32eb5185-c698-4bdd-bc41-7630a5065531	28f183f0-5b3a-4f0a-b826-e341ec2b0129
0ab61a31-3380-407f-93ed-ee707cc63495	28f183f0-5b3a-4f0a-b826-e341ec2b0129
a4d53819-8d21-4594-b85c-08e5425293ad	28f183f0-5b3a-4f0a-b826-e341ec2b0129
\.


--
-- Data for Name: internal_squad_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_squad_members (internal_squad_uuid, user_id) FROM stdin;
32eb5185-c698-4bdd-bc41-7630a5065531	5
0ab61a31-3380-407f-93ed-ee707cc63495	8
32eb5185-c698-4bdd-bc41-7630a5065531	4
32eb5185-c698-4bdd-bc41-7630a5065531	7
0ab61a31-3380-407f-93ed-ee707cc63495	12
0ab61a31-3380-407f-93ed-ee707cc63495	11
0ab61a31-3380-407f-93ed-ee707cc63495	10
32eb5185-c698-4bdd-bc41-7630a5065531	9
0ab61a31-3380-407f-93ed-ee707cc63495	6
a4d53819-8d21-4594-b85c-08e5425293ad	2
32eb5185-c698-4bdd-bc41-7630a5065531	2
0ab61a31-3380-407f-93ed-ee707cc63495	2
0ab61a31-3380-407f-93ed-ee707cc63495	14
32eb5185-c698-4bdd-bc41-7630a5065531	15
0ab61a31-3380-407f-93ed-ee707cc63495	3
0ab61a31-3380-407f-93ed-ee707cc63495	16
32eb5185-c698-4bdd-bc41-7630a5065531	17
\.


--
-- Data for Name: internal_squads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_squads (uuid, name, created_at, updated_at, view_position) FROM stdin;
32eb5185-c698-4bdd-bc41-7630a5065531	Default-CloudWEB	2026-05-15 01:34:55.037	2026-05-21 06:05:42.592	1
a4d53819-8d21-4594-b85c-08e5425293ad	VIP-CloudWEB	2026-05-21 06:06:19.471	2026-05-21 06:06:19.469	2
0ab61a31-3380-407f-93ed-ee707cc63495	ArredoCarisma-CloudWEB	2026-05-21 06:10:13.345	2026-05-21 06:32:03.911	3
\.


--
-- Data for Name: keygen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keygen (uuid, priv_key, pub_key, created_at, updated_at, ca_cert, ca_key, client_cert, client_key) FROM stdin;
311fd4d0-cf71-4937-afb2-b706c8672054	-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCLD+zvDtXJD9Fc\nIYmkiVFr7u7T1nA3anDNqLplFK1B2rhSDZnE6Y4GOpv9zTjmdzPrGIVurRSR3l5+\nn6osJzM2GEt0JsBG16poC3p06/z6WZi6BA4o3Nn9oLhs9At6I8Or5W8sCIBjQC1y\nesPYDOi2CDbfPKMjPGAVx4w0w3CVfZoI0pTKa+O/3QI0+KHuAf9sgWySpDLnj1wr\ns2EfytXv4GZopDRfTJ6eFmr+cIQn9Q8mm0xIj69unWxtj6omoQelGjzgpXq7/6pG\nx2QjyGjDpr/deQN7l/Di3wqzRKn63rWPGdKlmYhf6Op1r/e3U4fCQ+25SJ1sab76\nfuQQuEJRAgMBAAECggEAB3ZUhy2EZ32ZctPWwGChKhwQShn2Fy13ZuCvg+c4ElI9\n+bU5jxlxD4nLdiDpB4ofSb74U8Nvxn86yVBFW4kM+RrLpJpWTzJQNmvP1Vvx8a6n\nSeuFpZD88MpUKzUkfM8vgFcgtuCL6XVA0e6fQnzK2X3OWkfsOFB5KOstbYn6cmw8\nZs/C32Hyi+c6EE2lduDybJuU72OLFt4k04vsoQFsnTc33NVLT+WMPuOciKOjeC72\n1z3mNjUX+1+xTuCuZueY13XR5Btxu+kfnU9XcTvj3FyYHiHphKd1Glszu3T4mdCT\n77R2snsWg1hBlLptPIg9miNKDU2QSQNxcM+eJrqgIwKBgQDEEys3gobi9jMgb6I/\nG4AkSBhoqEUROMa1m4nj7xJMzHVxorwsDUwQdutiXXedKCLfQ+CRSGwZNxst64Gp\npz06Y0+KpJJbDQ7jCdR9rxxQsUawgtnzQqQCxXfNqKApD4wNXE0P044GLwg94qGm\nhSf5nnCB4FPBdWCqPYM9Hi91YwKBgQC1kBrj5wOTj6svKKeIFJmbOFryh8TTdkIR\nHotCUNBV8u8LixqGcpUV9E5azMVrOfudhieaIwV5CLs1J3QIgP3LbC6wc4o4fuwy\nFVYtfzf/KHIGo32r2HDGA4y4hPZ/EB9pqeMlowfX48D8/eqlRpcnyQIK0S4QQaiP\nUeot3xFhuwKBgHlzLie6D/bxbQXAYA0a6aqPhZ7965oZQuwmpair4vfzBSQYGtpm\neiEQqAhLwNV1kPQeRTF4XIzZ11oAMFZ3orNR5GkKOyVu1zPGWPpoxu8sf47B3mKR\neqnEysp2ko4cdTGpZIpTDfvCkiZTBLHydKpne2TXIMoJ/JA2fd4Tnm3lAoGBAIu3\nWPoHy7jB1fl0T3doYswPke0QjWYsmqqR1pgxmCCL0WgQo1jS0+cRGTrGWSUqeXW+\nxrrWOF/rWCSPN7tTh/oCReuC/dp70Ua5JJfeTjkL5rM1HIAhDqdSE/fqWcVtor6s\n/R75Vg/MM7Z7rxWAPNFg3TF1xvy7ifrADnU+MyIBAoGAFbEVEIWrvme0ugZ/83uK\nCiQaz1H6Sl5FadBr0yGw318RuE8zIsuA19lzPtOLsJvXsmqfJq+zFPNBFtUI616v\naJ8iXLC3wJq+G5iqA2bDqmjikJtzikjEzhQPx6KG2ihx7YiTZubgqkX2xkMKKsj5\naNwuwcU+h5mSiKi2u8Ab7u4=\n-----END PRIVATE KEY-----\n	-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiw/s7w7VyQ/RXCGJpIlR\na+7u09ZwN2pwzai6ZRStQdq4Ug2ZxOmOBjqb/c045ncz6xiFbq0Ukd5efp+qLCcz\nNhhLdCbARteqaAt6dOv8+lmYugQOKNzZ/aC4bPQLeiPDq+VvLAiAY0AtcnrD2Azo\ntgg23zyjIzxgFceMNMNwlX2aCNKUymvjv90CNPih7gH/bIFskqQy549cK7NhH8rV\n7+BmaKQ0X0yenhZq/nCEJ/UPJptMSI+vbp1sbY+qJqEHpRo84KV6u/+qRsdkI8ho\nw6a/3XkDe5fw4t8Ks0Sp+t61jxnSpZmIX+jqda/3t1OHwkPtuUidbGm++n7kELhC\nUQIDAQAB\n-----END PUBLIC KEY-----\n	2026-05-15 01:34:58.962	2026-05-15 01:34:59.068	-----BEGIN CERTIFICATE-----\nMIIBVDCB+qADAgECAgEBMAoGCCqGSM49BAMCMCExHzAdBgNVBAMTFlhqZDRwYVZ6\nbzFBU2FibzhDdGpRd0swHhcNMjYwNTE1MDEzNDU5WhcNMzYwNTE1MDEzNDU5WjAh\nMR8wHQYDVQQDExZYamQ0cGFWem8xQVNhYm84Q3RqUXdLMFkwEwYHKoZIzj0CAQYI\nKoZIzj0DAQcDQgAEqZN+JaJqoYDmTiC08/QQXzAZ5T7gGZ5k3I7oMmcuzwssetQX\nq/R2AntV1XT17CB6yX+gZdytqgnJhY6HuUkRDaMjMCEwDwYDVR0TAQH/BAUwAwEB\n/zAOBgNVHQ8BAf8EBAMCAoQwCgYIKoZIzj0EAwIDSQAwRgIhALIwY+lMg9OZi7RE\nO2GD78x6AQ7FwDUFY1v4bfLVj0G7AiEA6ee1lW4Ok4X3342e1I3jNq5BokwOEaZi\nkRj8jbjxqG4=\n-----END CERTIFICATE-----	-----BEGIN PRIVATE KEY-----\nMIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgdIA198WUdjB22vfp\nnS2t8EuO+mO9lMYGkygOxoNjiAqhRANCAASpk34lomqhgOZOILTz9BBfMBnlPuAZ\nnmTcjugyZy7PCyx61Ber9HYCe1XVdPXsIHrJf6Bl3K2qCcmFjoe5SREN\n-----END PRIVATE KEY-----	-----BEGIN CERTIFICATE-----\nMIIBdDCCARqgAwIBAgIBAjAKBggqhkjOPQQDAjAhMR8wHQYDVQQDExZYamQ0cGFW\nem8xQVNhYm84Q3RqUXdLMB4XDTI2MDUxNTAxMzQ1OVoXDTM2MDUxNTAxMzQ1OVow\nLDEqMCgGA1UEAwwhUVlFWVBvdWdvMUpQamtGZ0pfNk14S2hqWHoyWlA2YUctMFkw\nEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEYey92SK45znPsmCNn+WsW+daKARA4IRi\nBVjp/GfgIUJ6dlcXzOkeVbSJzm0uwjbTvTrQLS85fG7q5ixifV3U6aM4MDYwDAYD\nVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUH\nAwIwCgYIKoZIzj0EAwIDSAAwRQIhAOLzShd0J62fckuRk13CmAuRez+YwVBWboBC\nJhckvQzyAiBs0gqSjyAowi3uozRXmA3BladO289zVH0f5Q/hwtzedQ==\n-----END CERTIFICATE-----	-----BEGIN PRIVATE KEY-----\nMIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgUcVlWRqptOKkHyEW\nAkzApPXE3ZITqp6NX1hHa8eYvyKhRANCAARh7L3ZIrjnOc+yYI2f5axb51ooBEDg\nhGIFWOn8Z+AhQnp2VxfM6R5VtInObS7CNtO9OtAtLzl8burmLGJ9XdTp\n-----END PRIVATE KEY-----
\.


--
-- Data for Name: node_meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.node_meta (node_id, metadata) FROM stdin;
\.


--
-- Data for Name: node_plugin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.node_plugin (uuid, view_position, name, plugin_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nodes (uuid, name, address, port, is_connected, is_connecting, is_disabled, last_status_change, last_status_message, is_traffic_tracking_active, traffic_reset_day, traffic_limit_bytes, traffic_used_bytes, notify_percent, created_at, updated_at, view_position, country_code, consumption_multiplier, active_config_profile_uuid, provider_uuid, id, tags, active_plugin_uuid) FROM stdin;
a3de4fe1-da79-447a-b8a3-1552846c7441	MSK 01-7205300	85.198.101.23	2222	t	f	f	2026-05-29 14:15:21.991	\N	t	1	0	6824560695	0	2026-05-28 15:56:20.31	2026-05-30 20:12:00.268	15	RU	1000000000	00000000-0000-0000-0000-000000000000	f7286aae-c16f-47f2-ad6f-6ff7a54c4577	15	{}	\N
780aca89-03c4-4e8d-af79-c17c889341cb	FRA 01-7768912	213.182.213.22	2222	t	f	f	2026-05-29 14:15:21.902	\N	t	1	0	132597713181	0	2026-05-16 08:40:55.794	2026-05-30 20:37:00.075	2	DE	1000000000	00000000-0000-0000-0000-000000000000	96306fb5-1b66-444d-89ec-512201a4b210	2	{}	\N
9176215e-75da-4080-964c-bf91f2f58197	FRA 01-8040046	213.182.213.214	2222	t	f	f	2026-05-29 14:15:21.903	\N	t	1	0	32705902962	0	2026-05-23 09:37:17.478	2026-05-30 20:37:00.077	14	DE	1000000000	00000000-0000-0000-0000-000000000000	96306fb5-1b66-444d-89ec-512201a4b210	14	{}	\N
\.


--
-- Data for Name: nodes_traffic_usage_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nodes_traffic_usage_history (node_uuid, traffic_bytes, reset_at, id) FROM stdin;
\.


--
-- Data for Name: nodes_usage_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nodes_usage_history (node_uuid, download_bytes, upload_bytes, total_bytes, created_at, updated_at) FROM stdin;
780aca89-03c4-4e8d-af79-c17c889341cb	139699629	89328741	229028370	2026-05-19 05:00:00	2026-05-19 05:59:30.146
780aca89-03c4-4e8d-af79-c17c889341cb	15725594	2180013	17905607	2026-05-17 12:00:00	2026-05-17 12:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	20670	8720	29390	2026-05-16 09:00:00	2026-05-16 09:18:00.088
780aca89-03c4-4e8d-af79-c17c889341cb	89512796	14223915	103736711	2026-05-16 20:00:00	2026-05-16 20:59:30.06
780aca89-03c4-4e8d-af79-c17c889341cb	244771087	19808155	264579242	2026-05-16 15:00:00	2026-05-16 15:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	76118	23341	99459	2026-05-16 10:00:00	2026-05-16 10:49:30.086
780aca89-03c4-4e8d-af79-c17c889341cb	37323239	16553830	53877069	2026-05-16 19:00:00	2026-05-16 19:59:30.083
780aca89-03c4-4e8d-af79-c17c889341cb	8296143	523452	8819595	2026-05-17 11:00:00	2026-05-17 11:54:30.081
780aca89-03c4-4e8d-af79-c17c889341cb	14688841	4488555	19177396	2026-05-17 04:00:00	2026-05-17 04:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	47596081	352600659	400196740	2026-05-17 18:00:00	2026-05-17 18:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	6029104	1866518	7895622	2026-05-17 00:00:00	2026-05-17 00:57:00.101
780aca89-03c4-4e8d-af79-c17c889341cb	23887571	8076493	31964064	2026-05-17 13:00:00	2026-05-17 13:55:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	225559947	137910987	363470934	2026-05-16 11:00:00	2026-05-16 11:59:30.075
780aca89-03c4-4e8d-af79-c17c889341cb	196638399	32351189	228989588	2026-05-19 10:00:00	2026-05-19 10:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	33690258	16673900	50364158	2026-05-16 16:00:00	2026-05-16 16:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	432715326	29386671	462101997	2026-05-16 21:00:00	2026-05-16 21:59:30.06
780aca89-03c4-4e8d-af79-c17c889341cb	3340131	169355591	172695722	2026-05-17 22:00:00	2026-05-17 22:57:30.062
780aca89-03c4-4e8d-af79-c17c889341cb	13202543	1255955	14458498	2026-05-17 08:00:00	2026-05-17 08:52:30.11
780aca89-03c4-4e8d-af79-c17c889341cb	313746886	36875550	350622436	2026-05-19 02:00:00	2026-05-19 02:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	183610811	19131979	202742790	2026-05-18 09:00:00	2026-05-18 09:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	97548733	1622683676	1720232409	2026-05-17 17:00:00	2026-05-17 17:59:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	969358960	12116978	981475938	2026-05-17 07:00:00	2026-05-17 07:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	205786357	32938211	238724568	2026-05-16 22:00:00	2026-05-16 22:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	112147138	383347223	495494361	2026-05-16 12:00:00	2026-05-16 12:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	36595046	15910281	52505327	2026-05-16 17:00:00	2026-05-16 17:59:30.09
780aca89-03c4-4e8d-af79-c17c889341cb	10158194	489590	10647784	2026-05-17 03:00:00	2026-05-17 03:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	66936531	24665891	91602422	2026-05-16 13:00:00	2026-05-16 13:56:00.102
780aca89-03c4-4e8d-af79-c17c889341cb	44935361	18339591	63274952	2026-05-16 23:00:00	2026-05-16 23:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	37516361	15531028	53047389	2026-05-18 23:00:00	2026-05-18 23:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	171529473	33327765	204857238	2026-05-18 18:00:00	2026-05-18 18:59:30.087
780aca89-03c4-4e8d-af79-c17c889341cb	3016325	779386	3795711	2026-05-18 15:00:00	2026-05-18 15:56:00.105
780aca89-03c4-4e8d-af79-c17c889341cb	1046763	340820	1387583	2026-05-18 00:00:00	2026-05-18 00:58:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	136498486	19471039	155969525	2026-05-16 14:00:00	2026-05-16 14:59:30.076
780aca89-03c4-4e8d-af79-c17c889341cb	34940562	16007941	50948503	2026-05-16 18:00:00	2026-05-16 18:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	5888693	2738897	8627590	2026-05-17 14:00:00	2026-05-17 14:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	6848511	663076	7511587	2026-05-17 10:00:00	2026-05-17 10:55:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	31031451	1968848	33000299	2026-05-17 01:00:00	2026-05-17 01:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	13041481	3188648	16230129	2026-05-18 10:00:00	2026-05-18 10:57:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	85467397	22590767	108058164	2026-05-18 06:00:00	2026-05-18 06:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	1638279696	21245552	1659525248	2026-05-18 05:00:00	2026-05-18 05:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	9121028	951979546	961100574	2026-05-17 19:00:00	2026-05-17 19:59:30.082
780aca89-03c4-4e8d-af79-c17c889341cb	7541069	2029808	9570877	2026-05-17 15:00:00	2026-05-17 15:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	50992637	1257882	52250519	2026-05-17 02:00:00	2026-05-17 02:59:30.061
780aca89-03c4-4e8d-af79-c17c889341cb	1332651	447447	1780098	2026-05-18 02:00:00	2026-05-18 02:59:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	4091367	1488550	5579917	2026-05-18 13:00:00	2026-05-18 13:59:00.079
780aca89-03c4-4e8d-af79-c17c889341cb	5022285	995029	6017314	2026-05-17 09:00:00	2026-05-17 09:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	1998480854	16519551	2015000405	2026-05-18 04:00:00	2026-05-18 04:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	21834236	6000675	27834911	2026-05-17 05:00:00	2026-05-17 05:59:00.096
780aca89-03c4-4e8d-af79-c17c889341cb	955377	323458	1278835	2026-05-18 11:00:00	2026-05-18 11:59:00.111
780aca89-03c4-4e8d-af79-c17c889341cb	155226458	19834828	175061286	2026-05-18 07:00:00	2026-05-18 07:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	318402754	7749125	326151879	2026-05-17 06:00:00	2026-05-17 06:59:30.081
780aca89-03c4-4e8d-af79-c17c889341cb	356153900	1701599560	2057753460	2026-05-17 20:00:00	2026-05-17 20:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	76609776	172356901	248966677	2026-05-17 21:00:00	2026-05-17 21:58:00.07
780aca89-03c4-4e8d-af79-c17c889341cb	391317590	55305610	446623200	2026-05-19 09:00:00	2026-05-19 09:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	2939465	1174940902	1177880367	2026-05-17 23:00:00	2026-05-17 23:57:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	65883527	355092803	420976330	2026-05-17 16:00:00	2026-05-17 16:57:00.111
780aca89-03c4-4e8d-af79-c17c889341cb	188311539	63506517	251818056	2026-05-19 07:00:00	2026-05-19 07:59:30.496
780aca89-03c4-4e8d-af79-c17c889341cb	4058739	966152	5024891	2026-05-18 14:00:00	2026-05-18 14:57:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	1061642	328854	1390496	2026-05-18 01:00:00	2026-05-18 01:59:00.08
780aca89-03c4-4e8d-af79-c17c889341cb	217564951	103051512	320616463	2026-05-19 14:00:00	2026-05-19 14:59:30.082
780aca89-03c4-4e8d-af79-c17c889341cb	85688563	1201710	86890273	2026-05-18 03:00:00	2026-05-18 03:58:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	11972961	2303342	14276303	2026-05-18 12:00:00	2026-05-18 12:58:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	37608848	15625886	53234734	2026-05-18 21:00:00	2026-05-18 21:59:30.078
780aca89-03c4-4e8d-af79-c17c889341cb	56710632	16436459	73147091	2026-05-18 20:00:00	2026-05-18 20:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	9952176	6325886	16278062	2026-05-18 16:00:00	2026-05-18 16:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	747250761	64335491	811586252	2026-05-19 12:00:00	2026-05-19 12:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	29411318	3840260	33251578	2026-05-18 08:00:00	2026-05-18 08:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	2279304603	44452724	2323757327	2026-05-19 11:00:00	2026-05-19 11:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	781758131	11865677	793623808	2026-05-18 17:00:00	2026-05-18 17:59:30.085
780aca89-03c4-4e8d-af79-c17c889341cb	115166702	32359498	147526200	2026-05-18 19:00:00	2026-05-18 19:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	35971469	17233119	53204588	2026-05-18 22:00:00	2026-05-18 22:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	297202590	75916113	373118703	2026-05-19 04:00:00	2026-05-19 04:59:30.09
780aca89-03c4-4e8d-af79-c17c889341cb	293937412	85985194	379922606	2026-05-19 03:00:00	2026-05-19 03:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	583123623	40660877	623784500	2026-05-19 01:00:00	2026-05-19 01:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	65367605	16470971	81838576	2026-05-19 00:00:00	2026-05-19 00:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	80311572	123116391	203427963	2026-05-19 06:00:00	2026-05-19 06:59:30.081
780aca89-03c4-4e8d-af79-c17c889341cb	295429048	23245737	318674785	2026-05-19 13:00:00	2026-05-19 13:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	903250618	25930484	929181102	2026-05-19 08:00:00	2026-05-19 08:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	77285576	37088724	114374300	2026-05-19 16:00:00	2026-05-19 16:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	203780734	170136107	373916841	2026-05-19 19:00:00	2026-05-19 19:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	108456526	29011611	137468137	2026-05-19 15:00:00	2026-05-19 15:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	82561529	10424086	92985615	2026-05-19 17:00:00	2026-05-19 17:59:30.071
780aca89-03c4-4e8d-af79-c17c889341cb	14517459	2579820	17097279	2026-05-19 18:00:00	2026-05-19 18:58:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	801407250	251759018	1053166268	2026-05-19 20:00:00	2026-05-19 20:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	246590168	170524917	417115085	2026-05-19 21:00:00	2026-05-19 21:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	644664015	32054634	676718649	2026-05-19 22:00:00	2026-05-19 22:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	37117226	22779808	59897034	2026-05-19 23:00:00	2026-05-19 23:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	525164027	30308683	555472710	2026-05-20 00:00:00	2026-05-20 00:59:30.057
780aca89-03c4-4e8d-af79-c17c889341cb	131894954	20587932	152482886	2026-05-20 01:00:00	2026-05-20 01:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	41177468	31777448	72954916	2026-05-20 02:00:00	2026-05-20 02:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	1733745812	17800828	1751546640	2026-05-20 03:00:00	2026-05-20 03:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	521218344	24691841	545910185	2026-05-21 16:00:00	2026-05-21 16:59:30.079
780aca89-03c4-4e8d-af79-c17c889341cb	91565784	20003901	111569685	2026-05-22 05:00:00	2026-05-22 05:59:30.061
780aca89-03c4-4e8d-af79-c17c889341cb	122608704	14727549	137336253	2026-05-20 22:00:00	2026-05-20 22:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	26480170	3666765	30146935	2026-05-21 12:00:00	2026-05-21 12:12:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	32965801	16989049	49954850	2026-05-22 04:00:00	2026-05-22 04:58:00.072
780aca89-03c4-4e8d-af79-c17c889341cb	269114630	31330290	300444920	2026-05-21 06:00:00	2026-05-21 06:59:30.078
780aca89-03c4-4e8d-af79-c17c889341cb	182657011	20858318	203515329	2026-05-20 06:00:00	2026-05-20 06:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	668752941	39536674	708289615	2026-05-21 05:00:00	2026-05-21 05:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	511429169	31787326	543216495	2026-05-21 04:00:00	2026-05-21 04:59:30.059
780aca89-03c4-4e8d-af79-c17c889341cb	227614832	65291416	292906248	2026-05-20 09:00:00	2026-05-20 09:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	37593579	14354387	51947966	2026-05-22 02:00:00	2026-05-22 02:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	821549199	146588914	968138113	2026-05-20 12:00:00	2026-05-20 12:59:30.082
780aca89-03c4-4e8d-af79-c17c889341cb	289747606	90647726	380395332	2026-05-20 15:00:00	2026-05-20 15:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	717943337	96560857	814504194	2026-05-20 18:00:00	2026-05-20 18:59:30.079
780aca89-03c4-4e8d-af79-c17c889341cb	114162354	25537235	139699589	2026-05-21 07:00:00	2026-05-21 07:59:30.069
780aca89-03c4-4e8d-af79-c17c889341cb	56982577	14920630	71903207	2026-05-21 03:00:00	2026-05-21 03:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	256318202	27365646	283683848	2026-05-20 05:00:00	2026-05-20 05:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	332783539	2092278371	2425061910	2026-05-20 21:00:00	2026-05-20 21:59:30.059
780aca89-03c4-4e8d-af79-c17c889341cb	159793166	27181491	186974657	2026-05-21 08:00:00	2026-05-21 08:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	32895777	13397044	46292821	2026-05-21 02:00:00	2026-05-21 02:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	500484207	29722781	530206988	2026-05-20 08:00:00	2026-05-20 08:59:30.076
780aca89-03c4-4e8d-af79-c17c889341cb	33324616	13616682	46941298	2026-05-22 01:00:00	2026-05-22 01:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	217535190	88292006	305827196	2026-05-21 14:00:00	2026-05-21 14:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	99951402	15115556	115066958	2026-05-21 21:00:00	2026-05-21 21:59:30.058
780aca89-03c4-4e8d-af79-c17c889341cb	106586801	58520327	165107128	2026-05-20 11:00:00	2026-05-20 11:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	243425363	20141945	263567308	2026-05-20 04:00:00	2026-05-20 04:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	287444903	31915525	319360428	2026-05-21 09:00:00	2026-05-21 09:59:30.083
780aca89-03c4-4e8d-af79-c17c889341cb	80875892	24005894	104881786	2026-05-20 14:00:00	2026-05-20 14:59:30.078
780aca89-03c4-4e8d-af79-c17c889341cb	33356413	13335144	46691557	2026-05-21 01:00:00	2026-05-21 01:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	821389457	95109480	916498937	2026-05-20 17:00:00	2026-05-20 17:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	118860326	15975434	134835760	2026-05-20 07:00:00	2026-05-20 07:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	613048300	519571277	1132619577	2026-05-20 20:00:00	2026-05-20 20:59:30.069
780aca89-03c4-4e8d-af79-c17c889341cb	494312183	57715989	552028172	2026-05-22 10:00:00	2026-05-22 10:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	197273542	276294684	473568226	2026-05-21 17:00:00	2026-05-21 17:56:00.106
780aca89-03c4-4e8d-af79-c17c889341cb	31532571	13321950	44854521	2026-05-22 00:00:00	2026-05-22 00:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	31060606	12946803	44007409	2026-05-21 00:00:00	2026-05-21 00:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	150949292	108680444	259629736	2026-05-20 10:00:00	2026-05-20 10:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	123598853	20418034	144016887	2026-05-21 10:00:00	2026-05-21 10:59:30.089
780aca89-03c4-4e8d-af79-c17c889341cb	687084177	23188877	710273054	2026-05-20 13:00:00	2026-05-20 13:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	322439611	31420198	353859809	2026-05-22 06:00:00	2026-05-22 06:59:30.173
780aca89-03c4-4e8d-af79-c17c889341cb	366551473	57102775	423654248	2026-05-20 16:00:00	2026-05-20 16:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	962946893	84745157	1047692050	2026-05-21 15:00:00	2026-05-21 15:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	30621855	12479856	43101711	2026-05-20 23:00:00	2026-05-20 23:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	1888175856	136696113	2024871969	2026-05-20 19:00:00	2026-05-20 19:59:30.087
780aca89-03c4-4e8d-af79-c17c889341cb	72661954	18084440	90746394	2026-05-21 11:00:00	2026-05-21 11:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	35567148	13441904	49009052	2026-05-22 13:00:00	2026-05-22 13:19:00.068
780aca89-03c4-4e8d-af79-c17c889341cb	32735656	13300493	46036149	2026-05-21 23:00:00	2026-05-21 23:59:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	473036862	16406717	489443579	2026-05-21 20:00:00	2026-05-21 20:59:30.075
780aca89-03c4-4e8d-af79-c17c889341cb	549867436	20403560	570270996	2026-05-22 07:00:00	2026-05-22 07:59:30.161
780aca89-03c4-4e8d-af79-c17c889341cb	146704365	52637382	199341747	2026-05-22 09:00:00	2026-05-22 09:59:30.139
780aca89-03c4-4e8d-af79-c17c889341cb	64420910	24720002	89140912	2026-05-21 13:00:00	2026-05-21 13:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	32549727	13417850	45967577	2026-05-21 22:00:00	2026-05-21 22:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	639215845	91613352	730829197	2026-05-22 08:00:00	2026-05-22 08:59:30.16
780aca89-03c4-4e8d-af79-c17c889341cb	360865468	21147789	382013257	2026-05-22 03:00:00	2026-05-22 03:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	166637712	39645805	206283517	2026-05-22 12:00:00	2026-05-22 12:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	88627461	63835124	152462585	2026-05-22 11:00:00	2026-05-22 11:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	773148468	76036916	849185384	2026-05-23 03:00:00	2026-05-23 03:59:30.051
780aca89-03c4-4e8d-af79-c17c889341cb	950701028	37002826	987703854	2026-05-23 04:00:00	2026-05-23 04:59:30.051
780aca89-03c4-4e8d-af79-c17c889341cb	1149642969	208545048	1358188017	2026-05-23 08:00:00	2026-05-23 08:59:30.038
780aca89-03c4-4e8d-af79-c17c889341cb	175983396	151646765	327630161	2026-05-23 07:00:00	2026-05-23 07:59:30.053
780aca89-03c4-4e8d-af79-c17c889341cb	169545455	45448969	214994424	2026-05-23 02:00:00	2026-05-23 02:59:30.084
780aca89-03c4-4e8d-af79-c17c889341cb	315643072	27567022	343210094	2026-05-23 06:00:00	2026-05-23 06:59:30.049
780aca89-03c4-4e8d-af79-c17c889341cb	958297	559198	1517495	2026-05-22 16:00:00	2026-05-22 16:59:30.117
780aca89-03c4-4e8d-af79-c17c889341cb	697080731	183561349	880642080	2026-05-22 18:00:00	2026-05-22 18:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	110201468	23251160	133452628	2026-05-22 22:00:00	2026-05-22 22:59:30.057
780aca89-03c4-4e8d-af79-c17c889341cb	633083870	117109171	750193041	2026-05-22 21:00:00	2026-05-22 21:59:30.082
780aca89-03c4-4e8d-af79-c17c889341cb	39184011	16144096	55328107	2026-05-23 01:00:00	2026-05-23 01:59:30.22
780aca89-03c4-4e8d-af79-c17c889341cb	312738705	644255410	956994115	2026-05-22 20:00:00	2026-05-22 20:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	39281805	16119896	55401701	2026-05-22 23:00:00	2026-05-22 23:59:30.037
780aca89-03c4-4e8d-af79-c17c889341cb	4072852	2137890	6210742	2026-05-22 17:00:00	2026-05-22 17:52:00.359
9176215e-75da-4080-964c-bf91f2f58197	46227073	1179340	47406413	2026-05-23 13:00:00	2026-05-23 13:54:00.283
780aca89-03c4-4e8d-af79-c17c889341cb	541793894	32266788	574060682	2026-05-23 05:00:00	2026-05-23 05:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	42598966	1347818	43946784	2026-05-23 11:00:00	2026-05-23 11:59:30.055
780aca89-03c4-4e8d-af79-c17c889341cb	321706355	104549868	426256223	2026-05-22 19:00:00	2026-05-22 19:59:30.03
9176215e-75da-4080-964c-bf91f2f58197	195117992	26719884	221837876	2026-05-23 11:00:00	2026-05-23 11:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	42477108	17022058	59499166	2026-05-23 00:00:00	2026-05-23 00:59:30.043
9176215e-75da-4080-964c-bf91f2f58197	44788635	18542808	63331443	2026-05-23 12:00:00	2026-05-23 12:30:00.129
780aca89-03c4-4e8d-af79-c17c889341cb	225977432	1249551	227226983	2026-05-23 12:00:00	2026-05-23 12:30:00.136
780aca89-03c4-4e8d-af79-c17c889341cb	8264	3488	11752	2026-05-23 13:00:00	2026-05-23 13:54:00.303
780aca89-03c4-4e8d-af79-c17c889341cb	193999951	289054270	483054221	2026-05-23 10:00:00	2026-05-23 10:59:30.034
9176215e-75da-4080-964c-bf91f2f58197	47590412	27317972	74908384	2026-05-23 10:00:00	2026-05-23 10:59:30.04
780aca89-03c4-4e8d-af79-c17c889341cb	219215652	32999487	252215139	2026-05-23 09:00:00	2026-05-23 09:59:30.038
9176215e-75da-4080-964c-bf91f2f58197	64972204	1230609	66202813	2026-05-23 09:00:00	2026-05-23 09:59:30.057
780aca89-03c4-4e8d-af79-c17c889341cb	279824327	12595801	292420128	2026-05-23 16:00:00	2026-05-23 16:59:30.094
780aca89-03c4-4e8d-af79-c17c889341cb	11281853	690664	11972517	2026-05-23 15:00:00	2026-05-23 15:59:30.057
9176215e-75da-4080-964c-bf91f2f58197	6984170	2780439	9764609	2026-05-23 14:00:00	2026-05-23 14:47:00.08
780aca89-03c4-4e8d-af79-c17c889341cb	101173126	11347053	112520179	2026-05-23 14:00:00	2026-05-23 14:59:30.072
9176215e-75da-4080-964c-bf91f2f58197	75490425	55531490	131021915	2026-05-23 15:00:00	2026-05-23 15:59:30.063
9176215e-75da-4080-964c-bf91f2f58197	835180	279114	1114294	2026-05-23 17:00:00	2026-05-23 17:18:30.059
9176215e-75da-4080-964c-bf91f2f58197	41447176	31941633	73388809	2026-05-23 16:00:00	2026-05-23 16:57:00.078
780aca89-03c4-4e8d-af79-c17c889341cb	177688430	21045076	198733506	2026-05-23 17:00:00	2026-05-23 17:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	164135377	18274580	182409957	2026-05-23 18:00:00	2026-05-23 18:59:30.056
9176215e-75da-4080-964c-bf91f2f58197	108526	77274	185800	2026-05-23 18:00:00	2026-05-23 18:35:00.08
9176215e-75da-4080-964c-bf91f2f58197	65200804	27472679	92673483	2026-05-23 19:00:00	2026-05-23 19:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	222357430	10951484	233308914	2026-05-23 19:00:00	2026-05-23 19:59:30.07
780aca89-03c4-4e8d-af79-c17c889341cb	142032820	4371791	146404611	2026-05-23 20:00:00	2026-05-23 20:59:30.04
9176215e-75da-4080-964c-bf91f2f58197	422946889	17961116	440908005	2026-05-23 20:00:00	2026-05-23 20:59:30.047
780aca89-03c4-4e8d-af79-c17c889341cb	722978274	8439872	731418146	2026-05-23 21:00:00	2026-05-23 21:59:30.034
9176215e-75da-4080-964c-bf91f2f58197	33448867	13605586	47054453	2026-05-23 21:00:00	2026-05-23 21:59:30.037
9176215e-75da-4080-964c-bf91f2f58197	33013621	13701875	46715496	2026-05-23 22:00:00	2026-05-23 22:59:30.046
9176215e-75da-4080-964c-bf91f2f58197	141269291	148937173	290206464	2026-05-24 06:00:00	2026-05-24 06:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	122303556	7739803	130043359	2026-05-24 13:00:00	2026-05-24 13:59:30.063
9176215e-75da-4080-964c-bf91f2f58197	74663398	13925049	88588447	2026-05-24 01:00:00	2026-05-24 01:59:30.128
780aca89-03c4-4e8d-af79-c17c889341cb	9226030	784794	10010824	2026-05-24 01:00:00	2026-05-24 01:59:30.138
780aca89-03c4-4e8d-af79-c17c889341cb	1357865654	5417698	1363283352	2026-05-23 22:00:00	2026-05-23 22:59:00.135
780aca89-03c4-4e8d-af79-c17c889341cb	2478929	670820	3149749	2026-05-24 11:00:00	2026-05-24 11:58:30.077
9176215e-75da-4080-964c-bf91f2f58197	112685941	17218959	129904900	2026-05-24 11:00:00	2026-05-24 11:59:30.053
780aca89-03c4-4e8d-af79-c17c889341cb	42583672	5094866	47678538	2026-05-24 07:00:00	2026-05-24 07:59:00.104
780aca89-03c4-4e8d-af79-c17c889341cb	1069494	577221	1646715	2026-05-24 00:00:00	2026-05-24 00:59:30.041
9176215e-75da-4080-964c-bf91f2f58197	34245318	14383999	48629317	2026-05-24 00:00:00	2026-05-24 00:59:30.043
780aca89-03c4-4e8d-af79-c17c889341cb	511453650	33863881	545317531	2026-05-24 09:00:00	2026-05-24 09:59:30.052
9176215e-75da-4080-964c-bf91f2f58197	210216165	48424448	258640613	2026-05-24 07:00:00	2026-05-24 07:59:30.094
9176215e-75da-4080-964c-bf91f2f58197	115929035	18912252	134841287	2026-05-24 09:00:00	2026-05-24 09:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	101110	37707	138817	2026-05-24 12:00:00	2026-05-24 12:54:00.086
780aca89-03c4-4e8d-af79-c17c889341cb	8147633	2035809	10183442	2026-05-24 14:00:00	2026-05-24 14:12:30.065
9176215e-75da-4080-964c-bf91f2f58197	215343576	19297270	234640846	2026-05-24 12:00:00	2026-05-24 12:59:30.07
9176215e-75da-4080-964c-bf91f2f58197	42217378	5592546	47809924	2026-05-24 08:00:00	2026-05-24 08:59:30.054
780aca89-03c4-4e8d-af79-c17c889341cb	1481635078	20117898	1501752976	2026-05-24 08:00:00	2026-05-24 08:59:30.057
9176215e-75da-4080-964c-bf91f2f58197	11556740	7188223	18744963	2026-05-24 14:00:00	2026-05-24 14:13:00.083
780aca89-03c4-4e8d-af79-c17c889341cb	1731646	1166446	2898092	2026-05-24 02:00:00	2026-05-24 02:59:30.105
780aca89-03c4-4e8d-af79-c17c889341cb	4778166	961014	5739180	2026-05-23 23:00:00	2026-05-23 23:59:30.068
9176215e-75da-4080-964c-bf91f2f58197	32582008	13768376	46350384	2026-05-23 23:00:00	2026-05-23 23:59:30.072
9176215e-75da-4080-964c-bf91f2f58197	87355604	33238963	120594567	2026-05-24 02:00:00	2026-05-24 02:59:30.113
9176215e-75da-4080-964c-bf91f2f58197	33573237	14021923	47595160	2026-05-24 04:00:00	2026-05-24 04:59:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	51797531	6999221	58796752	2026-05-24 03:00:00	2026-05-24 03:59:30.053
9176215e-75da-4080-964c-bf91f2f58197	38134852	14438069	52572921	2026-05-24 03:00:00	2026-05-24 03:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	49390127	6863851	56253978	2026-05-24 04:00:00	2026-05-24 04:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	265137038	13228010	278365048	2026-05-24 10:00:00	2026-05-24 10:59:30.058
9176215e-75da-4080-964c-bf91f2f58197	171552251	18170458	189722709	2026-05-24 10:00:00	2026-05-24 10:59:30.064
9176215e-75da-4080-964c-bf91f2f58197	63828028	15844080	79672108	2026-05-24 05:00:00	2026-05-24 05:59:30.042
780aca89-03c4-4e8d-af79-c17c889341cb	83814718	1053247	84867965	2026-05-24 05:00:00	2026-05-24 05:59:30.044
780aca89-03c4-4e8d-af79-c17c889341cb	56222853	1589539	57812392	2026-05-24 06:00:00	2026-05-24 06:59:30.061
9176215e-75da-4080-964c-bf91f2f58197	48449099	23694328	72143427	2026-05-24 13:00:00	2026-05-24 13:59:30.059
9176215e-75da-4080-964c-bf91f2f58197	33570088	13698534	47268622	2026-05-25 17:00:00	2026-05-25 17:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	45806639	9047518	54854157	2026-05-25 17:00:00	2026-05-25 17:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	27474956	3037630	30512586	2026-05-25 15:00:00	2026-05-25 15:58:30.038
9176215e-75da-4080-964c-bf91f2f58197	199729315	27291701	227021016	2026-05-25 15:00:00	2026-05-25 15:59:30.062
780aca89-03c4-4e8d-af79-c17c889341cb	2115059	28958	2144017	2026-05-25 20:00:00	2026-05-25 20:57:00.106
9176215e-75da-4080-964c-bf91f2f58197	294912353	24495907	319408260	2026-05-25 22:00:00	2026-05-25 22:59:30.06
780aca89-03c4-4e8d-af79-c17c889341cb	37715672	3787887	41503559	2026-05-25 16:00:00	2026-05-25 16:59:30.08
9176215e-75da-4080-964c-bf91f2f58197	55577804	14425174	70002978	2026-05-25 16:00:00	2026-05-25 16:59:30.086
9176215e-75da-4080-964c-bf91f2f58197	33425798	13392615	46818413	2026-05-25 19:00:00	2026-05-25 19:59:30.095
780aca89-03c4-4e8d-af79-c17c889341cb	20253	8045	28298	2026-05-26 02:00:00	2026-05-26 02:56:00.153
9176215e-75da-4080-964c-bf91f2f58197	34602755	14216028	48818783	2026-05-25 20:00:00	2026-05-25 20:59:30.055
9176215e-75da-4080-964c-bf91f2f58197	1657287	353515	2010802	2026-05-26 12:00:00	2026-05-26 12:58:30.057
9176215e-75da-4080-964c-bf91f2f58197	112173350	25264281	137437631	2026-05-26 04:00:00	2026-05-26 04:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	20214	19716	39930	2026-05-25 14:00:00	2026-05-25 14:57:00.154
9176215e-75da-4080-964c-bf91f2f58197	192985189	2343193	195328382	2026-05-26 11:00:00	2026-05-26 11:59:30.074
9176215e-75da-4080-964c-bf91f2f58197	14030743	5685555	19716298	2026-05-25 14:00:00	2026-05-25 14:59:30.08
9176215e-75da-4080-964c-bf91f2f58197	299585815	73903530	373489345	2026-05-26 02:00:00	2026-05-26 02:59:30.042
780aca89-03c4-4e8d-af79-c17c889341cb	184747990	49543707	234291697	2026-05-26 11:00:00	2026-05-26 11:59:30.082
780aca89-03c4-4e8d-af79-c17c889341cb	727806	418957	1146763	2026-05-25 21:00:00	2026-05-25 21:55:00.094
9176215e-75da-4080-964c-bf91f2f58197	1600086	334261	1934347	2026-05-26 10:00:00	2026-05-26 10:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	392606676	75817912	468424588	2026-05-26 10:00:00	2026-05-26 10:59:30.067
9176215e-75da-4080-964c-bf91f2f58197	10364605	376069	10740674	2026-05-26 09:00:00	2026-05-26 09:58:30.056
9176215e-75da-4080-964c-bf91f2f58197	132785580	4710125	137495705	2026-05-26 07:00:00	2026-05-26 07:59:30.047
780aca89-03c4-4e8d-af79-c17c889341cb	1073971562	359849598	1433821160	2026-05-26 07:00:00	2026-05-26 07:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	16782	9990	26772	2026-05-25 23:00:00	2026-05-25 23:58:00.066
9176215e-75da-4080-964c-bf91f2f58197	30129786	11004719	41134505	2026-05-26 05:00:00	2026-05-26 05:59:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	45785409	379367488	425152897	2026-05-25 19:00:00	2026-05-25 19:51:30.051
9176215e-75da-4080-964c-bf91f2f58197	240379873	17664655	258044528	2026-05-25 21:00:00	2026-05-25 21:59:30.036
780aca89-03c4-4e8d-af79-c17c889341cb	45141135	10694511	55835646	2026-05-26 05:00:00	2026-05-26 05:59:30.053
9176215e-75da-4080-964c-bf91f2f58197	78621734	18873847	97495581	2026-05-26 00:00:00	2026-05-26 00:59:30.04
9176215e-75da-4080-964c-bf91f2f58197	128446782	15891762	144338544	2026-05-25 23:00:00	2026-05-25 23:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	36553	12425	48978	2026-05-26 00:00:00	2026-05-26 00:59:30.043
780aca89-03c4-4e8d-af79-c17c889341cb	43111693	43678296	86789989	2026-05-25 18:00:00	2026-05-25 18:59:30.068
9176215e-75da-4080-964c-bf91f2f58197	51324078	15203999	66528077	2026-05-25 18:00:00	2026-05-25 18:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	19823	10033	29856	2026-05-25 22:00:00	2026-05-25 22:56:00.084
780aca89-03c4-4e8d-af79-c17c889341cb	6024019	133298	6157317	2026-05-26 01:00:00	2026-05-26 01:58:00.098
9176215e-75da-4080-964c-bf91f2f58197	23532174	8045926	31578100	2026-05-26 06:00:00	2026-05-26 06:59:30.037
780aca89-03c4-4e8d-af79-c17c889341cb	401381854	47405188	448787042	2026-05-26 06:00:00	2026-05-26 06:59:30.043
9176215e-75da-4080-964c-bf91f2f58197	769662249	100774197	870436446	2026-05-26 01:00:00	2026-05-26 01:59:30.06
780aca89-03c4-4e8d-af79-c17c889341cb	34781	21397	56178	2026-05-26 04:00:00	2026-05-26 04:57:00.078
780aca89-03c4-4e8d-af79-c17c889341cb	13815	7263	21078	2026-05-26 03:00:00	2026-05-26 03:58:30.16
9176215e-75da-4080-964c-bf91f2f58197	187169640	66924082	254093722	2026-05-26 03:00:00	2026-05-26 03:59:30.051
780aca89-03c4-4e8d-af79-c17c889341cb	366357439	58071531	424428970	2026-05-26 09:00:00	2026-05-26 09:59:30.042
780aca89-03c4-4e8d-af79-c17c889341cb	113198117	30855981	144054098	2026-05-26 08:00:00	2026-05-26 08:59:30.05
9176215e-75da-4080-964c-bf91f2f58197	10844277	966264	11810541	2026-05-26 08:00:00	2026-05-26 08:59:30.058
780aca89-03c4-4e8d-af79-c17c889341cb	185671342	36120380	221791722	2026-05-26 12:00:00	2026-05-26 12:59:30.058
9176215e-75da-4080-964c-bf91f2f58197	91380548	1813298	93193846	2026-05-26 16:00:00	2026-05-26 16:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	156265074	34985723	191250797	2026-05-26 15:00:00	2026-05-26 15:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	279062602	208724467	487787069	2026-05-26 13:00:00	2026-05-26 13:59:30.055
9176215e-75da-4080-964c-bf91f2f58197	817417	389990	1207407	2026-05-26 13:00:00	2026-05-26 13:59:30.062
780aca89-03c4-4e8d-af79-c17c889341cb	3649456397	224972423	3874428820	2026-05-26 14:00:00	2026-05-26 14:59:30.063
9176215e-75da-4080-964c-bf91f2f58197	74237356	2077605	76314961	2026-05-26 15:00:00	2026-05-26 15:47:30.055
9176215e-75da-4080-964c-bf91f2f58197	727779269	1858078	729637347	2026-05-26 14:00:00	2026-05-26 14:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	177951248	21373079	199324327	2026-05-26 16:00:00	2026-05-26 16:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	440472600	139785731	580258331	2026-05-26 17:00:00	2026-05-26 17:59:30.069
9176215e-75da-4080-964c-bf91f2f58197	53478052	4897222	58375274	2026-05-26 17:00:00	2026-05-26 17:59:30.051
780aca89-03c4-4e8d-af79-c17c889341cb	602318483	111857513	714175996	2026-05-26 18:00:00	2026-05-26 18:59:30.069
9176215e-75da-4080-964c-bf91f2f58197	35889980	6929246	42819226	2026-05-26 18:00:00	2026-05-26 18:59:30.062
780aca89-03c4-4e8d-af79-c17c889341cb	173901733	193891618	367793351	2026-05-26 19:00:00	2026-05-26 19:59:30.123
9176215e-75da-4080-964c-bf91f2f58197	144848647	1866647	146715294	2026-05-26 19:00:00	2026-05-26 19:58:00.123
780aca89-03c4-4e8d-af79-c17c889341cb	8460627858	66258721	8526886579	2026-05-26 20:00:00	2026-05-26 20:59:30.055
9176215e-75da-4080-964c-bf91f2f58197	1454582	233361	1687943	2026-05-26 20:00:00	2026-05-26 20:54:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	766615368	116892853	883508221	2026-05-26 21:00:00	2026-05-26 21:59:30.053
9176215e-75da-4080-964c-bf91f2f58197	30067938	932206	31000144	2026-05-28 08:00:00	2026-05-28 08:58:00.223
9176215e-75da-4080-964c-bf91f2f58197	4134	1744	5878	2026-05-27 14:00:00	2026-05-27 14:21:00.082
780aca89-03c4-4e8d-af79-c17c889341cb	5200735126	50420296	5251155422	2026-05-28 13:00:00	2026-05-28 13:59:30.062
9176215e-75da-4080-964c-bf91f2f58197	92288402	1721143	94009545	2026-05-27 22:00:00	2026-05-27 22:56:30.052
9176215e-75da-4080-964c-bf91f2f58197	423671	180224	603895	2026-05-28 00:00:00	2026-05-28 00:54:00.151
780aca89-03c4-4e8d-af79-c17c889341cb	70830772	40286342	111117114	2026-05-27 03:00:00	2026-05-27 03:59:30.051
9176215e-75da-4080-964c-bf91f2f58197	133914747	2852213	136766960	2026-05-27 03:00:00	2026-05-27 03:59:30.054
780aca89-03c4-4e8d-af79-c17c889341cb	258364214	58527891	316892105	2026-05-26 22:00:00	2026-05-26 22:59:30.11
9176215e-75da-4080-964c-bf91f2f58197	1495556006	1753419	1497309425	2026-05-27 10:00:00	2026-05-27 10:27:00.088
780aca89-03c4-4e8d-af79-c17c889341cb	100196649	7160922	107357571	2026-05-27 17:00:00	2026-05-27 17:59:30.078
9176215e-75da-4080-964c-bf91f2f58197	56893682	846783	57740465	2026-05-28 13:00:00	2026-05-28 13:59:30.066
9176215e-75da-4080-964c-bf91f2f58197	337541	214801	552342	2026-05-27 05:00:00	2026-05-27 05:59:00.149
780aca89-03c4-4e8d-af79-c17c889341cb	172058214	20657618	192715832	2026-05-27 05:00:00	2026-05-27 05:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	327585613	27371531	354957144	2026-05-27 04:00:00	2026-05-27 04:59:30.049
9176215e-75da-4080-964c-bf91f2f58197	1091883	256304	1348187	2026-05-27 01:00:00	2026-05-27 01:56:30.043
780aca89-03c4-4e8d-af79-c17c889341cb	426629557	72070143	498699700	2026-05-27 01:00:00	2026-05-27 01:59:30.033
9176215e-75da-4080-964c-bf91f2f58197	745989	363903	1109892	2026-05-27 06:00:00	2026-05-27 06:53:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	307067967	64957587	372025554	2026-05-28 08:00:00	2026-05-28 08:59:30.069
780aca89-03c4-4e8d-af79-c17c889341cb	289264613	20932077	310196690	2026-05-27 10:00:00	2026-05-27 10:59:30.044
9176215e-75da-4080-964c-bf91f2f58197	2131743	317720	2449463	2026-05-26 21:00:00	2026-05-26 21:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	696156908	23250487	719407395	2026-05-27 14:00:00	2026-05-27 14:53:30.045
780aca89-03c4-4e8d-af79-c17c889341cb	339427418	52534497	391961915	2026-05-27 11:00:00	2026-05-27 11:59:30.03
9176215e-75da-4080-964c-bf91f2f58197	5180907	126491	5307398	2026-05-27 00:00:00	2026-05-27 00:55:00.145
780aca89-03c4-4e8d-af79-c17c889341cb	107045106	38079199	145124305	2026-05-27 13:00:00	2026-05-27 13:59:30.099
780aca89-03c4-4e8d-af79-c17c889341cb	85737743	76739224	162476967	2026-05-27 02:00:00	2026-05-27 02:59:30.054
9176215e-75da-4080-964c-bf91f2f58197	31323543	1477805	32801348	2026-05-27 02:00:00	2026-05-27 02:59:30.062
780aca89-03c4-4e8d-af79-c17c889341cb	31499400	6267304	37766704	2026-05-27 22:00:00	2026-05-27 22:59:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	718541475	140159777	858701252	2026-05-27 00:00:00	2026-05-27 00:59:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	304594522	30332288	334926810	2026-05-27 06:00:00	2026-05-27 06:59:30.057
9176215e-75da-4080-964c-bf91f2f58197	8267	3488	11755	2026-05-27 15:00:00	2026-05-27 15:30:00.088
780aca89-03c4-4e8d-af79-c17c889341cb	2328089543	47430870	2375520413	2026-05-28 07:00:00	2026-05-28 07:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	33634758	19239962	52874720	2026-05-27 12:00:00	2026-05-27 12:33:30.087
9176215e-75da-4080-964c-bf91f2f58197	32224137	1296269	33520406	2026-05-27 20:00:00	2026-05-27 20:59:30.046
780aca89-03c4-4e8d-af79-c17c889341cb	415272093	14444018	429716111	2026-05-27 19:00:00	2026-05-27 19:59:30.077
9176215e-75da-4080-964c-bf91f2f58197	77176729	1773876	78950605	2026-05-27 19:00:00	2026-05-27 19:59:30.106
9176215e-75da-4080-964c-bf91f2f58197	568359	189871	758230	2026-05-27 07:00:00	2026-05-27 07:58:30.12
780aca89-03c4-4e8d-af79-c17c889341cb	1604651904	35680249	1640332153	2026-05-27 15:00:00	2026-05-27 15:59:30.032
780aca89-03c4-4e8d-af79-c17c889341cb	259831725	21343006	281174731	2026-05-27 07:00:00	2026-05-27 07:59:30.041
780aca89-03c4-4e8d-af79-c17c889341cb	265538559	14845775	280384334	2026-05-27 20:00:00	2026-05-27 20:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	63404819	58426827	121831646	2026-05-26 23:00:00	2026-05-26 23:59:30.038
9176215e-75da-4080-964c-bf91f2f58197	443165	157039	600204	2026-05-26 23:00:00	2026-05-26 23:59:30.041
780aca89-03c4-4e8d-af79-c17c889341cb	235588315	38226352	273814667	2026-05-28 15:00:00	2026-05-28 15:59:30.068
9176215e-75da-4080-964c-bf91f2f58197	11211017	967352	12178369	2026-05-27 09:00:00	2026-05-27 09:58:00.105
780aca89-03c4-4e8d-af79-c17c889341cb	14143041	7154644	21297685	2026-05-28 00:00:00	2026-05-28 00:59:30.057
780aca89-03c4-4e8d-af79-c17c889341cb	877529725	33508805	911038530	2026-05-27 09:00:00	2026-05-27 09:59:30.054
9176215e-75da-4080-964c-bf91f2f58197	798204	329946	1128150	2026-05-26 22:00:00	2026-05-26 22:53:30.037
780aca89-03c4-4e8d-af79-c17c889341cb	395852278	13840301	409692579	2026-05-27 18:00:00	2026-05-27 18:59:30.051
780aca89-03c4-4e8d-af79-c17c889341cb	829967639	28015303	857982942	2026-05-28 04:00:00	2026-05-28 04:59:30.03
9176215e-75da-4080-964c-bf91f2f58197	208569	146366	354935	2026-05-28 02:00:00	2026-05-28 02:55:00.164
9176215e-75da-4080-964c-bf91f2f58197	955519	315311	1270830	2026-05-27 04:00:00	2026-05-27 04:50:30.068
9176215e-75da-4080-964c-bf91f2f58197	3733966	450848	4184814	2026-05-27 08:00:00	2026-05-27 08:59:30.042
780aca89-03c4-4e8d-af79-c17c889341cb	355026351	39029543	394055894	2026-05-27 08:00:00	2026-05-27 08:59:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	782941407	33835008	816776415	2026-05-28 06:00:00	2026-05-28 06:59:30.043
780aca89-03c4-4e8d-af79-c17c889341cb	136772514	11600582	148373096	2026-05-27 16:00:00	2026-05-27 16:59:30.064
9176215e-75da-4080-964c-bf91f2f58197	252688	98541	351229	2026-05-27 23:00:00	2026-05-27 23:56:30.057
9176215e-75da-4080-964c-bf91f2f58197	140100636	6715816	146816452	2026-05-28 15:00:00	2026-05-28 15:59:30.073
780aca89-03c4-4e8d-af79-c17c889341cb	18549738	7234451	25784189	2026-05-28 01:00:00	2026-05-28 01:59:30.041
9176215e-75da-4080-964c-bf91f2f58197	2137276	417023	2554299	2026-05-28 01:00:00	2026-05-28 01:59:30.047
780aca89-03c4-4e8d-af79-c17c889341cb	15502448	6268602	21771050	2026-05-27 23:00:00	2026-05-27 23:59:30.039
780aca89-03c4-4e8d-af79-c17c889341cb	225082751	63370655	288453406	2026-05-28 11:00:00	2026-05-28 11:59:30.034
9176215e-75da-4080-964c-bf91f2f58197	13867725	851648	14719373	2026-05-28 11:00:00	2026-05-28 11:59:30.046
780aca89-03c4-4e8d-af79-c17c889341cb	1464270754	27169588	1491440342	2026-05-28 03:00:00	2026-05-28 03:59:30.035
9176215e-75da-4080-964c-bf91f2f58197	3436808	481321	3918129	2026-05-28 03:00:00	2026-05-28 03:59:30.039
9176215e-75da-4080-964c-bf91f2f58197	20886902	1498229	22385131	2026-05-27 21:00:00	2026-05-27 21:59:30.223
780aca89-03c4-4e8d-af79-c17c889341cb	125746342	8995092	134741434	2026-05-28 02:00:00	2026-05-28 02:59:30.063
780aca89-03c4-4e8d-af79-c17c889341cb	18590988	7145326	25736314	2026-05-27 21:00:00	2026-05-27 21:59:30.229
9176215e-75da-4080-964c-bf91f2f58197	366757164	2114690	368871854	2026-05-28 10:00:00	2026-05-28 10:58:00.071
9176215e-75da-4080-964c-bf91f2f58197	2622488	764696	3387184	2026-05-28 09:00:00	2026-05-28 09:57:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	2195453318	37173740	2232627058	2026-05-28 14:00:00	2026-05-28 14:59:30.09
780aca89-03c4-4e8d-af79-c17c889341cb	509490874	39728199	549219073	2026-05-28 05:00:00	2026-05-28 05:59:30.054
9176215e-75da-4080-964c-bf91f2f58197	15473395	1254169	16727564	2026-05-28 14:00:00	2026-05-28 14:59:30.098
9176215e-75da-4080-964c-bf91f2f58197	87326968	1924963	89251931	2026-05-28 04:00:00	2026-05-28 04:39:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	3003125217	76526983	3079652200	2026-05-28 09:00:00	2026-05-28 09:59:30.035
780aca89-03c4-4e8d-af79-c17c889341cb	222242857	121644318	343887175	2026-05-28 10:00:00	2026-05-28 10:59:30.042
9176215e-75da-4080-964c-bf91f2f58197	5756204	528709	6284913	2026-05-28 12:00:00	2026-05-28 12:59:30.064
780aca89-03c4-4e8d-af79-c17c889341cb	534644502	35506211	570150713	2026-05-28 12:00:00	2026-05-28 12:59:30.068
780aca89-03c4-4e8d-af79-c17c889341cb	118869334	17949927	136819261	2026-05-28 16:00:00	2026-05-28 16:59:30.039
9176215e-75da-4080-964c-bf91f2f58197	87581182	5072049	92653231	2026-05-28 16:00:00	2026-05-28 16:59:30.041
780aca89-03c4-4e8d-af79-c17c889341cb	773665327	125299225	898964552	2026-05-28 17:00:00	2026-05-28 17:59:30.1
a3de4fe1-da79-447a-b8a3-1552846c7441	42256042	2726790	44982832	2026-05-28 16:00:00	2026-05-28 16:59:30.117
9176215e-75da-4080-964c-bf91f2f58197	233873105	5156111	239029216	2026-05-28 17:00:00	2026-05-28 17:59:30.114
a3de4fe1-da79-447a-b8a3-1552846c7441	472246793	75013584	547260377	2026-05-28 17:00:00	2026-05-28 17:48:00.124
780aca89-03c4-4e8d-af79-c17c889341cb	961860126	560350334	1522210460	2026-05-28 18:00:00	2026-05-28 18:59:30.138
a3de4fe1-da79-447a-b8a3-1552846c7441	95489007	11570313	107059320	2026-05-28 18:00:00	2026-05-28 18:59:30.168
9176215e-75da-4080-964c-bf91f2f58197	37066017	1912922	38978939	2026-05-28 18:00:00	2026-05-28 18:17:30.087
9176215e-75da-4080-964c-bf91f2f58197	131491045	6353567	137844612	2026-05-28 19:00:00	2026-05-28 19:59:30.109
780aca89-03c4-4e8d-af79-c17c889341cb	482111976	514376481	996488457	2026-05-28 19:00:00	2026-05-28 19:59:30.105
a3de4fe1-da79-447a-b8a3-1552846c7441	931837875	12763308	944601183	2026-05-28 19:00:00	2026-05-28 19:59:30.145
a3de4fe1-da79-447a-b8a3-1552846c7441	109614739	912327	110527066	2026-05-28 20:00:00	2026-05-28 20:56:00.109
780aca89-03c4-4e8d-af79-c17c889341cb	468270249	28405746	496675995	2026-05-28 20:00:00	2026-05-28 20:59:30.046
780aca89-03c4-4e8d-af79-c17c889341cb	330122529	28432515	358555044	2026-05-29 05:00:00	2026-05-29 05:59:30.133
9176215e-75da-4080-964c-bf91f2f58197	757582664	5162770	762745434	2026-05-29 05:00:00	2026-05-29 05:59:30.142
a3de4fe1-da79-447a-b8a3-1552846c7441	33704500	1766274	35470774	2026-05-29 05:00:00	2026-05-29 05:59:30.178
780aca89-03c4-4e8d-af79-c17c889341cb	3118861	906911	4025772	2026-05-30 01:00:00	2026-05-30 01:59:30.07
a3de4fe1-da79-447a-b8a3-1552846c7441	38963090	5291401	44254491	2026-05-28 21:00:00	2026-05-28 21:35:00.143
9176215e-75da-4080-964c-bf91f2f58197	226482838	9904372	236387210	2026-05-29 16:00:00	2026-05-29 16:57:00.234
780aca89-03c4-4e8d-af79-c17c889341cb	240905529	2539520139	2780425668	2026-05-29 18:00:00	2026-05-29 18:59:30.067
9176215e-75da-4080-964c-bf91f2f58197	343173966	24871979	368045945	2026-05-29 18:00:00	2026-05-29 18:59:30.071
a3de4fe1-da79-447a-b8a3-1552846c7441	27175	8720	35895	2026-05-29 13:00:00	2026-05-29 13:45:00.14
780aca89-03c4-4e8d-af79-c17c889341cb	555720224	24499399	580219623	2026-05-29 10:00:00	2026-05-29 10:59:30.059
9176215e-75da-4080-964c-bf91f2f58197	159140574	51679223	210819797	2026-05-29 10:00:00	2026-05-29 10:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	60627246	13887211	74514457	2026-05-28 22:00:00	2026-05-28 22:59:30.064
9176215e-75da-4080-964c-bf91f2f58197	163876101	3298290	167174391	2026-05-28 22:00:00	2026-05-28 22:59:30.067
780aca89-03c4-4e8d-af79-c17c889341cb	831892618	29732109	861624727	2026-05-28 21:00:00	2026-05-28 21:59:30.037
9176215e-75da-4080-964c-bf91f2f58197	207919732	3844846	211764578	2026-05-28 21:00:00	2026-05-28 21:59:30.055
a3de4fe1-da79-447a-b8a3-1552846c7441	797547	427585	1225132	2026-05-29 06:00:00	2026-05-29 06:55:30.119
a3de4fe1-da79-447a-b8a3-1552846c7441	85001	57933	142934	2026-05-29 07:00:00	2026-05-29 07:09:30.13
9176215e-75da-4080-964c-bf91f2f58197	255850097	4998156	260848253	2026-05-28 20:00:00	2026-05-28 20:59:30.048
9176215e-75da-4080-964c-bf91f2f58197	154699107	3877848	158576955	2026-05-28 23:00:00	2026-05-28 23:59:30.048
780aca89-03c4-4e8d-af79-c17c889341cb	62103758	13201328	75305086	2026-05-28 23:00:00	2026-05-28 23:59:30.051
9176215e-75da-4080-964c-bf91f2f58197	34127170	12911325	47038495	2026-05-30 01:00:00	2026-05-30 01:59:30.091
780aca89-03c4-4e8d-af79-c17c889341cb	167678952	11207773	178886725	2026-05-29 19:00:00	2026-05-29 19:59:30.072
780aca89-03c4-4e8d-af79-c17c889341cb	63741322	19101025	82842347	2026-05-29 03:00:00	2026-05-29 03:59:30.031
9176215e-75da-4080-964c-bf91f2f58197	11594915	425115	12020030	2026-05-29 03:00:00	2026-05-29 03:59:30.034
9176215e-75da-4080-964c-bf91f2f58197	483529538	92364609	575894147	2026-05-29 19:00:00	2026-05-29 19:59:30.079
780aca89-03c4-4e8d-af79-c17c889341cb	59597669	43170204	102767873	2026-05-29 16:00:00	2026-05-29 16:59:30.068
a3de4fe1-da79-447a-b8a3-1552846c7441	382126713	17793105	399919818	2026-05-29 16:00:00	2026-05-29 16:59:30.103
9176215e-75da-4080-964c-bf91f2f58197	126353896	3285894	129639790	2026-05-29 00:00:00	2026-05-29 00:59:30.158
780aca89-03c4-4e8d-af79-c17c889341cb	198905580	13859502	212765082	2026-05-29 00:00:00	2026-05-29 00:59:30.179
780aca89-03c4-4e8d-af79-c17c889341cb	151724928	18510305	170235233	2026-05-29 13:00:00	2026-05-29 13:59:30.08
9176215e-75da-4080-964c-bf91f2f58197	415241422	14597626	429839048	2026-05-29 13:00:00	2026-05-29 13:59:30.086
780aca89-03c4-4e8d-af79-c17c889341cb	321961580	24826612	346788192	2026-05-29 06:00:00	2026-05-29 06:59:30.033
9176215e-75da-4080-964c-bf91f2f58197	482413150	5524697	487937847	2026-05-29 06:00:00	2026-05-29 06:59:30.039
780aca89-03c4-4e8d-af79-c17c889341cb	163415931	15519990	178935921	2026-05-29 11:00:00	2026-05-29 11:59:30.055
780aca89-03c4-4e8d-af79-c17c889341cb	284734885	11642398	296377283	2026-05-29 09:00:00	2026-05-29 09:59:30.097
9176215e-75da-4080-964c-bf91f2f58197	338018252	31220081	369238333	2026-05-29 09:00:00	2026-05-29 09:59:30.113
9176215e-75da-4080-964c-bf91f2f58197	374332844	18033896	392366740	2026-05-29 11:00:00	2026-05-29 11:59:30.057
9176215e-75da-4080-964c-bf91f2f58197	118099790	4582750	122682540	2026-05-29 01:00:00	2026-05-29 01:59:30.036
780aca89-03c4-4e8d-af79-c17c889341cb	435866404	35101992	470968396	2026-05-29 01:00:00	2026-05-29 01:59:30.046
780aca89-03c4-4e8d-af79-c17c889341cb	332737104	29957133	362694237	2026-05-29 12:00:00	2026-05-29 12:59:30.086
9176215e-75da-4080-964c-bf91f2f58197	420046583	10859457	430906040	2026-05-29 12:00:00	2026-05-29 12:59:30.094
9176215e-75da-4080-964c-bf91f2f58197	224833944	6114801	230948745	2026-05-29 07:00:00	2026-05-29 07:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	520277174	108484672	628761846	2026-05-29 07:00:00	2026-05-29 07:59:30.085
a3de4fe1-da79-447a-b8a3-1552846c7441	25093837	1456698	26550535	2026-05-28 22:00:00	2026-05-28 22:53:00.121
9176215e-75da-4080-964c-bf91f2f58197	9811652	1167174	10978826	2026-05-29 04:00:00	2026-05-29 04:59:30.074
780aca89-03c4-4e8d-af79-c17c889341cb	197014271	24165830	221180101	2026-05-29 04:00:00	2026-05-29 04:59:30.078
9176215e-75da-4080-964c-bf91f2f58197	363990435	15513910	379504345	2026-05-29 17:00:00	2026-05-29 17:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	102732885	349149190	451882075	2026-05-29 17:00:00	2026-05-29 17:59:30.072
9176215e-75da-4080-964c-bf91f2f58197	43520661	3362486	46883147	2026-05-29 15:00:00	2026-05-29 15:59:00.09
a3de4fe1-da79-447a-b8a3-1552846c7441	19365141	2053941	21419082	2026-05-29 14:00:00	2026-05-29 14:56:30.238
9176215e-75da-4080-964c-bf91f2f58197	116573563	3932502	120506065	2026-05-29 02:00:00	2026-05-29 02:59:30.078
780aca89-03c4-4e8d-af79-c17c889341cb	63496944	27958537	91455481	2026-05-29 02:00:00	2026-05-29 02:59:30.083
a3de4fe1-da79-447a-b8a3-1552846c7441	4096207	1297196	5393403	2026-05-29 08:00:00	2026-05-29 08:43:30.083
780aca89-03c4-4e8d-af79-c17c889341cb	404821113	49804253	454625366	2026-05-29 15:00:00	2026-05-29 15:59:30.074
a3de4fe1-da79-447a-b8a3-1552846c7441	1085261849	23652208	1108914057	2026-05-29 15:00:00	2026-05-29 15:59:30.117
a3de4fe1-da79-447a-b8a3-1552846c7441	5434	1744	7178	2026-05-29 12:00:00	2026-05-29 12:51:30.107
9176215e-75da-4080-964c-bf91f2f58197	876937109	22692769	899629878	2026-05-29 08:00:00	2026-05-29 08:59:30.05
780aca89-03c4-4e8d-af79-c17c889341cb	126090498	6285061	132375559	2026-05-29 08:00:00	2026-05-29 08:59:30.265
9176215e-75da-4080-964c-bf91f2f58197	367367363	5236311	372603674	2026-05-29 14:00:00	2026-05-29 14:59:30.093
780aca89-03c4-4e8d-af79-c17c889341cb	1158426523	239631086	1398057609	2026-05-29 14:00:00	2026-05-29 14:59:30.104
780aca89-03c4-4e8d-af79-c17c889341cb	2469236	1677515	4146751	2026-05-30 00:00:00	2026-05-30 00:59:00.169
9176215e-75da-4080-964c-bf91f2f58197	31878386	12140469	44018855	2026-05-30 00:00:00	2026-05-30 00:59:30.065
780aca89-03c4-4e8d-af79-c17c889341cb	98859965	1699968	100559933	2026-05-29 23:00:00	2026-05-29 23:59:30.054
9176215e-75da-4080-964c-bf91f2f58197	36422137	12909253	49331390	2026-05-29 23:00:00	2026-05-29 23:59:30.057
780aca89-03c4-4e8d-af79-c17c889341cb	42457805	3938595	46396400	2026-05-29 21:00:00	2026-05-29 21:59:30.108
9176215e-75da-4080-964c-bf91f2f58197	36197726	12407788	48605514	2026-05-29 21:00:00	2026-05-29 21:59:30.115
a3de4fe1-da79-447a-b8a3-1552846c7441	16306	5232	21538	2026-05-29 18:00:00	2026-05-29 18:16:30.264
780aca89-03c4-4e8d-af79-c17c889341cb	27423744	7834815	35258559	2026-05-29 20:00:00	2026-05-29 20:59:30.048
a3de4fe1-da79-447a-b8a3-1552846c7441	154878408	2757513	157635921	2026-05-29 19:00:00	2026-05-29 19:03:00.131
9176215e-75da-4080-964c-bf91f2f58197	187235258	14584432	201819690	2026-05-29 20:00:00	2026-05-29 20:59:30.054
a3de4fe1-da79-447a-b8a3-1552846c7441	738975920	27676219	766652139	2026-05-29 17:00:00	2026-05-29 17:49:00.142
a3de4fe1-da79-447a-b8a3-1552846c7441	398339913	7385326	405725239	2026-05-29 20:00:00	2026-05-29 20:44:30.098
9176215e-75da-4080-964c-bf91f2f58197	36183922	12706826	48890748	2026-05-29 22:00:00	2026-05-29 22:59:30.035
780aca89-03c4-4e8d-af79-c17c889341cb	108313564	10532127	118845691	2026-05-29 22:00:00	2026-05-29 22:59:30.038
780aca89-03c4-4e8d-af79-c17c889341cb	37517721	2464749	39982470	2026-05-30 04:00:00	2026-05-30 04:59:30.069
9176215e-75da-4080-964c-bf91f2f58197	34298505	13171431	47469936	2026-05-30 02:00:00	2026-05-30 02:59:30.077
780aca89-03c4-4e8d-af79-c17c889341cb	1671140	866064	2537204	2026-05-30 02:00:00	2026-05-30 02:59:30.08
780aca89-03c4-4e8d-af79-c17c889341cb	1512117	701807	2213924	2026-05-30 03:00:00	2026-05-30 03:59:30.05
9176215e-75da-4080-964c-bf91f2f58197	97563647	14342799	111906446	2026-05-30 03:00:00	2026-05-30 03:59:30.06
9176215e-75da-4080-964c-bf91f2f58197	2059393917	33084331	2092478248	2026-05-30 04:00:00	2026-05-30 04:59:30.064
a3de4fe1-da79-447a-b8a3-1552846c7441	10869	3488	14357	2026-05-30 04:00:00	2026-05-30 04:06:30.101
9176215e-75da-4080-964c-bf91f2f58197	42359296	26419583	68778879	2026-05-30 05:00:00	2026-05-30 05:59:30.049
780aca89-03c4-4e8d-af79-c17c889341cb	977685985	14204512	991890497	2026-05-30 05:00:00	2026-05-30 05:59:30.051
a3de4fe1-da79-447a-b8a3-1552846c7441	10870	3488	14358	2026-05-30 05:00:00	2026-05-30 05:48:00.204
780aca89-03c4-4e8d-af79-c17c889341cb	110597705	4871119	115468824	2026-05-30 06:00:00	2026-05-30 06:58:30.048
9176215e-75da-4080-964c-bf91f2f58197	96135095	51366751	147501846	2026-05-30 06:00:00	2026-05-30 06:59:30.052
780aca89-03c4-4e8d-af79-c17c889341cb	110707008	42753317	153460325	2026-05-30 07:00:00	2026-05-30 07:59:30.056
9176215e-75da-4080-964c-bf91f2f58197	313763602	5038536	318802138	2026-05-30 07:00:00	2026-05-30 07:59:30.06
780aca89-03c4-4e8d-af79-c17c889341cb	12218091	334126	12552217	2026-05-30 09:00:00	2026-05-30 09:59:00.082
780aca89-03c4-4e8d-af79-c17c889341cb	229484539	10708956	240193495	2026-05-30 08:00:00	2026-05-30 08:59:30.053
9176215e-75da-4080-964c-bf91f2f58197	666003807	7134349	673138156	2026-05-30 08:00:00	2026-05-30 08:59:30.056
780aca89-03c4-4e8d-af79-c17c889341cb	23279053	4613013	27892066	2026-05-30 14:00:00	2026-05-30 14:47:00.101
780aca89-03c4-4e8d-af79-c17c889341cb	269144715	14568131	283712846	2026-05-30 16:00:00	2026-05-30 16:59:30.049
9176215e-75da-4080-964c-bf91f2f58197	791811427	11574234	803385661	2026-05-30 09:00:00	2026-05-30 09:59:30.049
9176215e-75da-4080-964c-bf91f2f58197	239029832	28678067	267707899	2026-05-30 16:00:00	2026-05-30 16:59:30.055
9176215e-75da-4080-964c-bf91f2f58197	1479660753	31442041	1511102794	2026-05-30 15:00:00	2026-05-30 15:59:30.066
780aca89-03c4-4e8d-af79-c17c889341cb	94034702	7068233	101102935	2026-05-30 15:00:00	2026-05-30 15:59:30.069
9176215e-75da-4080-964c-bf91f2f58197	2481898991	20476679	2502375670	2026-05-30 10:00:00	2026-05-30 10:59:30.047
780aca89-03c4-4e8d-af79-c17c889341cb	35651508	2782909	38434417	2026-05-30 10:00:00	2026-05-30 10:59:30.045
9176215e-75da-4080-964c-bf91f2f58197	1473595257	27481315	1501076572	2026-05-30 14:00:00	2026-05-30 14:59:30.047
a3de4fe1-da79-447a-b8a3-1552846c7441	24884282	814972	25699254	2026-05-30 10:00:00	2026-05-30 10:38:30.128
780aca89-03c4-4e8d-af79-c17c889341cb	20473834	9467611	29941445	2026-05-30 19:00:00	2026-05-30 19:59:30.053
9176215e-75da-4080-964c-bf91f2f58197	192658529	57556181	250214710	2026-05-30 19:00:00	2026-05-30 19:59:30.057
a3de4fe1-da79-447a-b8a3-1552846c7441	1406504261	20071930	1426576191	2026-05-30 19:00:00	2026-05-30 19:59:30.096
9176215e-75da-4080-964c-bf91f2f58197	1314235843	30343226	1344579069	2026-05-30 13:00:00	2026-05-30 13:59:30.054
780aca89-03c4-4e8d-af79-c17c889341cb	15826321	2598724	18425045	2026-05-30 13:00:00	2026-05-30 13:59:30.061
a3de4fe1-da79-447a-b8a3-1552846c7441	181309510	5967766	187277276	2026-05-30 17:00:00	2026-05-30 17:59:00.114
780aca89-03c4-4e8d-af79-c17c889341cb	360678082	21106245	381784327	2026-05-30 17:00:00	2026-05-30 17:59:30.034
9176215e-75da-4080-964c-bf91f2f58197	189154142	18667895	207822037	2026-05-30 17:00:00	2026-05-30 17:59:30.042
780aca89-03c4-4e8d-af79-c17c889341cb	155312659	7190506	162503165	2026-05-30 12:00:00	2026-05-30 12:59:30.037
9176215e-75da-4080-964c-bf91f2f58197	520921250	28095040	549016290	2026-05-30 12:00:00	2026-05-30 12:59:30.039
780aca89-03c4-4e8d-af79-c17c889341cb	235807557	37966110	273773667	2026-05-30 11:00:00	2026-05-30 11:59:30.067
9176215e-75da-4080-964c-bf91f2f58197	729854383	55395455	785249838	2026-05-30 11:00:00	2026-05-30 11:59:30.08
a3de4fe1-da79-447a-b8a3-1552846c7441	280831110	2260499	283091609	2026-05-30 20:00:00	2026-05-30 20:12:00.259
9176215e-75da-4080-964c-bf91f2f58197	228112441	25253843	253366284	2026-05-30 18:00:00	2026-05-30 18:59:30.043
780aca89-03c4-4e8d-af79-c17c889341cb	52075409	26788324	78863733	2026-05-30 18:00:00	2026-05-30 18:59:30.05
a3de4fe1-da79-447a-b8a3-1552846c7441	163766671	10322065	174088736	2026-05-30 18:00:00	2026-05-30 18:59:30.087
780aca89-03c4-4e8d-af79-c17c889341cb	73858871	2395038	76253909	2026-05-30 20:00:00	2026-05-30 20:37:00.064
9176215e-75da-4080-964c-bf91f2f58197	495986189	28486125	524472314	2026-05-30 20:00:00	2026-05-30 20:37:00.07
\.


--
-- Data for Name: nodes_user_usage_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nodes_user_usage_history (node_id, user_id, total_bytes, created_at, updated_at) FROM stdin;
2	2	5634652395	2026-05-19	2026-05-19 23:59:45.062
2	6	5229075926	2026-05-20	2026-05-20 22:28:45.091
2	2	4334616552	2026-05-21	2026-05-21 23:59:30.071
2	6	1465981838	2026-05-21	2026-05-21 20:06:30.54
2	5	42777270	2026-05-17	2026-05-17 21:38:15.073
2	2	8680422933	2026-05-17	2026-05-17 23:58:15.091
2	2	2443784112	2026-05-16	2026-05-16 23:58:15.06
2	2	9516721061	2026-05-20	2026-05-20 23:58:30.067
2	2	5725610975	2026-05-18	2026-05-18 23:58:45.066
2	11	488596750	2026-05-22	2026-05-22 10:49:15.401
2	6	5182274548	2026-05-19	2026-05-19 23:57:30.075
2	2	35395443	2026-05-24	2026-05-24 13:20:30.059
14	2	1351243803	2026-05-23	2026-05-23 23:58:00.117
2	10	2090360542	2026-05-23	2026-05-23 23:59:30.136
2	6	2451842565	2026-05-23	2026-05-23 23:59:30.136
2	2	4239918759	2026-05-23	2026-05-23 19:54:30.28
2	10	133478863	2026-05-24	2026-05-24 06:50:00.235
2	6	3815821401	2026-05-22	2026-05-22 23:58:15.053
2	2	2576574709	2026-05-22	2026-05-22 23:58:15.053
2	11	256860981	2026-05-23	2026-05-23 17:09:30.139
14	2	1789542367	2026-05-24	2026-05-24 14:11:15.284
2	11	2081762496	2026-05-24	2026-05-24 14:11:15.285
2	6	535742828	2026-05-24	2026-05-24 14:11:15.285
15	14	1085529110	2026-05-28	2026-05-28 20:15:45.098
14	15	3586323141	2026-05-29	2026-05-29 19:07:45.083
15	16	231375755	2026-05-30	2026-05-30 20:03:45.376
2	3	3763154593	2026-05-27	2026-05-27 14:30:00.136
15	2	14357	2026-05-28	2026-05-28 20:57:45.113
2	11	405310498	2026-05-26	2026-05-26 23:52:15.034
15	3	19493038	2026-05-28	2026-05-28 17:26:15.092
14	2	3174970460	2026-05-26	2026-05-26 23:57:00.169
2	6	7096782573	2026-05-26	2026-05-26 23:59:00.184
2	3	11589045789	2026-05-26	2026-05-26 23:59:00.184
15	2	41544393	2026-05-30	2026-05-30 17:08:45.1
2	2	23507	2026-05-30	2026-05-30 05:48:30.189
14	2	1237704064	2026-05-25	2026-05-25 23:59:00.192
2	11	166156539	2026-05-25	2026-05-25 23:59:45.064
14	9	11019024	2026-05-30	2026-05-30 18:04:45.042
14	3	5877	2026-05-25	2026-05-25 15:32:00.551
2	6	11796954883	2026-05-28	2026-05-28 19:56:00.363
2	3	41139	2026-05-28	2026-05-28 17:07:30.097
14	11	10562874	2026-05-25	2026-05-25 18:43:00.136
2	3	11755	2026-05-25	2026-05-25 15:34:15.113
2	14	900294655	2026-05-30	2026-05-30 19:05:30.07
2	14	608510385	2026-05-26	2026-05-26 20:06:15.062
2	6	476624010	2026-05-25	2026-05-25 19:39:30.074
2	2	70526	2026-05-25	2026-05-25 21:19:00.124
2	6	846988793	2026-05-30	2026-05-30 20:23:15.036
14	11	144429082	2026-05-26	2026-05-26 08:45:15.04
14	16	1434145	2026-05-28	2026-05-28 16:47:30.288
14	15	1139556744	2026-05-28	2026-05-28 23:58:30.22
14	2	905399649	2026-05-28	2026-05-28 23:58:30.22
2	14	937463958	2026-05-27	2026-05-27 19:49:45.108
2	11	885276140	2026-05-28	2026-05-28 23:59:00.158
15	16	720271437	2026-05-28	2026-05-28 22:54:00.38
14	2	1922822504	2026-05-27	2026-05-27 23:58:00.133
2	11	336867255	2026-05-27	2026-05-27 23:58:45.041
2	6	991255952	2026-05-27	2026-05-27 23:58:45.041
2	2	2794268644	2026-05-27	2026-05-27 23:58:45.041
2	2	10304017167	2026-05-28	2026-05-28 23:59:00.158
2	5	10111034	2026-05-29	2026-05-29 15:55:00.173
15	14	1265619873	2026-05-29	2026-05-29 20:44:30.385
15	14	1823848003	2026-05-30	2026-05-30 20:12:45.109
15	16	179056851	2026-05-29	2026-05-29 19:04:00.397
2	11	1794006899	2026-05-29	2026-05-29 23:56:15.044
14	15	6753612461	2026-05-30	2026-05-30 20:35:00.134
2	2	1934736464	2026-05-29	2026-05-29 18:18:15.051
2	14	760462893	2026-05-28	2026-05-28 19:00:00.447
15	2	1457908897	2026-05-29	2026-05-29 18:18:30.228
14	2	3347285041	2026-05-29	2026-05-29 23:58:15.045
14	2	7260849282	2026-05-30	2026-05-30 20:35:00.134
2	11	1291852411	2026-05-30	2026-05-30 20:35:45.071
2	14	777673361	2026-05-29	2026-05-29 19:58:00.125
2	6	5285078668	2026-05-29	2026-05-29 23:58:45.052
\.


--
-- Data for Name: passkeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passkeys (id, admin_uuid, public_key, counter, device_type, backed_up, transports, passkey_provider, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: remnawave_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.remnawave_settings (id, passkey_settings, oauth2_settings, password_settings, branding_settings) FROM stdin;
1	{"rpId": null, "origin": null, "enabled": false}	{"github": {"enabled": false, "clientId": null, "clientSecret": null, "allowedEmails": []}, "yandex": {"enabled": false, "clientId": null, "clientSecret": null, "allowedEmails": []}, "generic": {"enabled": false, "clientId": null, "tokenUrl": null, "withPkce": false, "clientSecret": null, "allowedEmails": [], "frontendDomain": null, "authorizationUrl": null}, "keycloak": {"realm": null, "enabled": false, "clientId": null, "clientSecret": null, "allowedEmails": [], "frontendDomain": null, "keycloakDomain": null}, "pocketid": {"enabled": false, "clientId": null, "plainDomain": null, "clientSecret": null, "allowedEmails": []}, "telegram": {"enabled": false, "clientId": null, "allowedIds": [], "clientSecret": null, "frontendDomain": null}}	{"enabled": true}	{"title": "Mesh 🗽 CloudWEB", "logoUrl": "https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp"}
\.


--
-- Data for Name: subscription_page_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_page_config (uuid, view_position, name, config, created_at, updated_at) FROM stdin;
00000000-0000-0000-0000-000000000000	1	Join CW	{"locales": ["en", "ru", "zh", "fa", "fr"], "version": "1", "uiConfig": {"subscriptionInfoBlockType": "expanded", "installationGuidesBlockType": "cards"}, "platforms": {"ios": {"apps": [{"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/ru/app/happ-proxy-utility-plus/id6746188973", "text": {"en": "App Store (RU)", "fa": "اپ استور (RU)", "fr": "App Store (RU)", "ru": "App Store (RU)", "zh": "App Store (RU)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://apps.apple.com/us/app/happ-proxy-utility/id6504287215", "text": {"en": "App Store (Global)", "fa": "اپ استور (جهانی)", "fr": "App Store (Global)", "ru": "App Store (Global)", "zh": "App Store (Global)"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in App Store and install the app. Launch it, in the VPN configuration permission window click Allow and enter your passcode.", "fa": "صفحه را در App Store باز کنید و برنامه را نصب کنید. آن را اجرا کنید، در پنجره مجوز پیکربندی VPN روی Allow کلیک کنید و رمز عبور خود را وارد کنید.", "fr": "Ouvre la page de l’App Store et installe l’app. Lance-la ; dans la fenêtre d’autorisation de configuration VPN, appuie sur « Allow » puis entre ton code.", "ru": "Откройте страницу в App Store и установите приложение. Запустите его, в окне разрешения VPN-конфигурации нажмите Allow и введите свой пароль.", "zh": "在 App Store 打开页面并安装应用。启动应用后，在 VPN 配置权限窗口点击“允许”，并输入您的密码。"}, "svgIconColor": "violet"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮，应用将会打开，并自动添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "Happ"}, {"name": "Stash", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/us/app/stash-rule-based-proxy/id1596063349", "text": {"en": "Open in App Store", "fa": "باز کردن در App Store", "fr": "Ouvre dans l’App Store", "ru": "Открыть в App Store", "zh": "在 App Store 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the App Store page and install the app.", "fa": "صفحه App Store را باز کرده و برنامه را نصب کنید.", "fr": "Ouvre la page de l’App Store et installe l’app.", "ru": "Откройте страницу в App Store и установите приложение.", "zh": "打开 App Store 页面并安装应用。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "stash://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Tap the button below — Stash will open and the configuration will be added automatically.", "fa": "روی دکمه زیر ضربه بزنید — برنامه Stash باز می‌شود و پیکربندی به‌صورت خودکار اضافه خواهد شد.", "fr": "Appuie sur le bouton ci-dessous — Stash s’ouvrira et la configuration sera ajoutée automatiquement.", "ru": "Нажмите кнопку ниже — приложение Stash откроется, и конфигурация будет добавлена автоматически.", "zh": "点击下方按钮，Stash 将会打开并自动添加配置。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "On the main screen, tap the Start button. When prompted, allow adding VPN configurations. After the profile is activated, open the Policy section and select the country you want to connect through.", "fa": "در صفحه اصلی روی دکمه Start بزنید. در صورت نمایش درخواست، مجوز افزودن پیکربندی VPN را تأیید کنید. پس از فعال شدن پروفایل، وارد بخش Policy شوید و کشور موردنظر برای اتصال را انتخاب کنید.", "fr": "Sur l’écran principal, appuie sur le bouton « Start ». Autorise ensuite l’ajout de la configuration VPN. Une fois le profil activé, ouvre la section « Policy » et choisis le pays de connexion.", "ru": "На главном экране нажмите кнопку «Запуск». В появившемся окне разрешите добавление конфигураций VPN. После активации профиля перейдите в раздел «Политика» и выберите страну подключения.", "zh": "在主界面点击「Start」按钮。在提示时允许添加 VPN 配置。配置启用后，进入「Policy（策略）」部分并选择要连接的国家。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Stash"}, {"name": "Shadowrocket", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/ru/app/shadowrocket/id932747118", "text": {"en": "Open in App Store", "fa": "باز کردن در App Store", "fr": "Ouvre dans l’App Store", "ru": "Открыть в App Store", "zh": "在 App Store 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in App Store and install the app. Launch it, in the VPN configuration permission window click Allow and enter your passcode.", "fa": "صفحه را در App Store باز کنید و برنامه را نصب کنید. آن را اجرا کنید، در پنجره مجوز پیکربندی VPN روی Allow کلیک کنید و رمز عبور خود را وارد کنید.", "fr": "Ouvre la page de l’App Store et installe l’app. Lance-la ; dans la fenêtre d’autorisation de configuration VPN, appuie sur « Allow » puis entre ton code.", "ru": "Откройте страницу в App Store и установите приложение. Запустите его, в окне разрешения VPN-конфигурации нажмите Allow и введите свой пароль.", "zh": "在 App Store 打开页面并安装应用。启动应用后，在 VPN 配置权限窗口点击“允许”，并输入您的密码。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "shadowrocket://add/{{SUBSCRIPTION_LINK}}#{{USERNAME}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮，应用将会打开，并自动添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Shadowrocket"}, {"name": "Streisand", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/ru/app/streisand/id6450534064", "text": {"en": "Open in App Store", "fa": "باز کردن در App Store", "fr": "Ouvre dans l’App Store", "ru": "Открыть в App Store", "zh": "在 App Store 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in App Store and install the app. Launch it, in the VPN configuration permission window click Allow and enter your passcode.", "fa": "صفحه را در App Store باز کنید و برنامه را نصب کنید. آن را اجرا کنید، در پنجره مجوز پیکربندی VPN روی Allow کلیک کنید و رمز عبور خود را وارد کنید.", "fr": "Ouvre la page de l’App Store et installe l’app. Lance-la ; dans la fenêtre d’autorisation de configuration VPN, appuie sur « Allow » puis entre ton code.", "ru": "Откройте страницу в App Store и установите приложение. Запустите его, в окне разрешения VPN-конфигурации нажмите Allow и введите свой пароль.", "zh": "在 App Store 打开页面并安装应用。启动应用后，在 VPN 配置权限窗口点击“允许”，并输入您的密码。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "streisand://import/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮，应用将会打开，并自动添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Streisand"}], "svgIconKey": "AppleIcon", "displayName": {"en": "iOS", "fa": "iOS", "fr": "iOS", "ru": "iOS", "zh": "iOS"}}, "linux": {"apps": [{"name": "FlClashX", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-linux-amd64.deb", "text": {"en": "amd64 (.deb)", "fa": "amd64 (.deb)", "fr": "amd64 (.deb)", "ru": "amd64 (.deb)", "zh": "amd64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-linux-amd64.AppImage", "text": {"en": "amd64 (AppImage)", "fa": "amd64 (AppImage)", "fr": "amd64 (AppImage)", "ru": "amd64 (AppImage)", "zh": "amd64 (AppImage)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-linux-amd64.rpm", "text": {"en": "amd64 (.rpm)", "fa": "amd64 (.rpm)", "fr": "amd64 (.rpm)", "ru": "amd64 (.rpm)", "zh": "amd64 (.rpm)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-linux-arm64.deb", "text": {"en": "arm64 (.deb)", "fa": "arm64 (.deb)", "fr": "arm64 (.deb)", "ru": "arm64 (.deb)", "zh": "arm64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "flclashx://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the Profiles section, click the + button, select the URL, paste your copied link and click Send", "fa": "اگر بعد از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراکی را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در این صفحه در گوشه سمت راست بالا کلیک کنید، لینک را کپی کنید. در FlClashX به بخش Profiles بروید، دکمه + را کلیک کنید، URL را انتخاب کنید، پیوند کپی شده خود را جایگذاری کنید و روی ارسال کلیک کنید.", "fr": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the « Profiles » section, click the + button, select the « URL », paste your copied link and click Send.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой страницу кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В FlClashX перейдите в раздел Профили, нажмите кнопку +, выберите URL, вставьте вашу скопированную ссылку и нажмите Отправить", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 FlClashX 的“配置文件”部分，点击 + 按钮，选择 URL，粘贴你复制的链接并点击发送。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added profile in the Profiles section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the TUN item. After launching, in the Proxy section, you can change the choice of the server to which you will be connected.", "fa": "نمایه اضافه شده را در قسمت پروفایل ها انتخاب کنید. در داشبورد، روی دکمه فعال کردن در گوشه پایین سمت راست کلیک کنید و سپس سوئیچ کنار مورد TUN را روشن کنید. پس از راه اندازی در قسمت Proxy می توانید انتخاب سروری که به آن متصل خواهید شد را تغییر دهید.", "fr": "Select the added profile in the « Profiles » section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the « TUN » item. After launching, in the « Proxy » section, you can change the choice of the server to which you will be connected.", "ru": "Выберите добавленный профиль в разделе Профили. В Панели управления нажмите кнопку включить в правом нижнем углу, а затем включите переключатель у пункта TUN. После запуска в разделе Прокси вы можете изменить выбор сервера к которому вас подключит.", "zh": "在“配置文件”部分选择已添加的配置文件。在控制面板右下角点击启用按钮，然后打开 TUN 项旁边的开关。启动后，在代理部分可以更改所连接的服务器。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "FlClashX"}, {"name": "Koala Clash", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash_amd64.deb", "text": {"en": "amd64 (.deb)", "fa": "amd64 (.deb)", "fr": "amd64 (.deb)", "ru": "amd64 (.deb)", "zh": "amd64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash.x86_64.rpm", "text": {"en": "amd64 (.rpm)", "fa": "amd64 (.rpm)", "fr": "amd64 (.rpm)", "ru": "amd64 (.rpm)", "zh": "amd64 (.rpm)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash_arm64.deb", "text": {"en": "arm64 (.deb)", "fa": "arm64 (.deb)", "fr": "arm64 (.deb)", "ru": "arm64 (.deb)", "zh": "arm64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash.aarch64.rpm", "text": {"en": "arm64 (.rpm)", "fa": "arm64 (.rpm)", "fr": "arm64 (.rpm)", "ru": "arm64 (.rpm)", "zh": "arm64 (.rpm)"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Warning", "fa": "هشدار", "fr": "Avertissement", "ru": "Предупреждение", "zh": "警告"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash.", "fa": "اگر قبلاً از Clash Verge Rev استفاده کرده‌اید، باید قبل از نصب Koala Clash آن را حذف کنید.", "fr": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash.", "ru": "Если вы ранее использовали Clash Verge Rev, то его требуется удалить перед установкой Koala Clash.", "zh": "如果您之前用过 Clash Verge Rev，请在安装 Koala Clash 前先卸载它。"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "koala-clash://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک اضافه نشد", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. Click the Get Link button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the Add Profile button, paste the link into the text field, and then click the Import button.", "fa": "اگر پس از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در گوشه بالا سمت راست این صفحه کلیک کنید و لینک را کپی کنید. در برنامه Koala Clash به صفحه اصلی بروید، روی دکمه افزودن پروفایل کلیک کنید، لینک را در فیلد متنی قرار دهید و سپس روی دکمه وارد کردن کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. Click the « Get Link » button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the « Add Profile » button, paste the link into the text field, and then click the « Import » button.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой странице кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В Koala Clash перейдите на главную страницу, нажмите кнопку Добавить профиль и вставьте ссылку в текстовое поле, затем нажмите на кнопку Импорт.", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 Koala Clash 主页面点击“添加配置文件”按钮，将链接粘贴到文本框中，然后点击“导入”按钮。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "fa": "می‌توانید سرور را در پایین صفحه اصلی انتخاب کنید و با کلیک روی دکمه بزرگ در مرکز صفحه اصلی، VPN را فعال کنید.", "fr": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "ru": "Выбрать сервер можно внизу на главной странице, включить VPN можно нажав на главной странице на большую кнопку по центру.", "zh": "您可以在主页面底部选择服务器，并通过点击主页面中央的大按钮来启用 VPN。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "KoalaClash"}, {"name": "Prizrak-Box", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/linux-amd64.deb", "text": {"en": "amd64 (.deb)", "fa": "amd64 (.deb)", "fr": "amd64 (.deb)", "ru": "amd64 (.deb)", "zh": "amd64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/linux-amd64.rpm", "text": {"en": "amd64 (.rpm)", "fa": "amd64 (.rpm)", "fr": "amd64 (.rpm)", "ru": "amd64 (.rpm)", "zh": "amd64 (.rpm)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/linux-arm64.deb", "text": {"en": "arm64 (.deb)", "fa": "arm64 (.deb)", "fr": "arm64 (.deb)", "ru": "arm64 (.deb)", "zh": "arm64 (.deb)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/linux-arm64.rpm", "text": {"en": "arm64 (.rpm)", "fa": "arm64 (.rpm)", "fr": "arm64 (.rpm)", "ru": "arm64 (.rpm)", "zh": "arm64 (.rpm)"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the package matching your architecture and install Prizrak-Box.", "fa": "بسته مناسب معماری خود را انتخاب کرده و Prizrak-Box را نصب کنید.", "fr": "Choose the package matching your architecture and install Prizrak-Box.", "ru": "Выберите пакет под вашу архитектуру и установите Prizrak-Box.", "zh": "选择适合您架构的安装包并安装 Prizrak-Box。"}, "svgIconColor": "cyan"}, {"title": {"en": "Warning", "fa": "هشدار", "fr": "Avertissement", "ru": "Предупреждение", "zh": "警告"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "Run the program.", "fa": "برنامه را اجرا کنید.", "fr": "Run the program.", "ru": "Запустите программу.", "zh": "运行程序。"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "prizrak-box://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add the subscription automatically.", "fa": "روی دکمه زیر کلیک کنید تا اشتراک به صورت خودکار افزوده شود.", "fr": "Click the button below to add the subscription automatically.", "ru": "Нажмите кнопку ниже, чтобы автоматически добавить подписку.", "zh": "点击下方按钮即可自动添加订阅。"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. On this page, click the Get Link button in the upper right corner, copy the link. In Prizrak-Box, go to the Profiles section, click the + button, paste your copied link, and click Confirm.", "fa": "اگر پس از کلیک بر روی دکمه اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. در این صفحه، روی دکمه «دریافت پیوند» در گوشه بالا سمت راست کلیک کنید، پیوند را کپی کنید. در Prizrak-Box، به بخش «پروفایل‌ها» بروید، روی دکمه + کلیک کنید، پیوند کپی شده خود را جای‌گذاری کنید و روی «تأیید» کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. On this page, click the « Get Link » button in the upper right corner, copy the link. In Prizrak-Box, go to the « Profiles » section, click the + button, paste your copied link, and click « Confirm ».", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой странице кнопку «Получить ссылку» в правом верхнем углу, скопируйте ссылку. В Prizrak-Box перейдите в раздел «Профили», нажмите кнопку «+», вставьте скопированную ссылку и нажмите «Подтвердить».", "zh": "如果点击按钮后没有任何反应，请手动添加订阅。在此页面上，点击右上角的“获取链接”按钮，复制链接。在 Prizrak-Box 中，转到“配置文件”部分，点击 + 按钮，粘贴您复制的链接，然后点击“确认”。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added subscription in the Profiles section. You can choose the server country in the Proxy (🚀) section. Set the TUN switch to ON.", "fa": "اشتراک افزوده‌شده را در بخش پروفایل‌ها انتخاب کنید. می‌توانید کشور سرور را در بخش Proxy (🚀) انتخاب کنید. سوئیچ TUN را روی حالت روشن قرار دهید.", "fr": "Select the added subscription in the « Profiles » section. You can choose the server country in the « Proxy » (🚀) section. Set the « TUN » switch to ON.", "ru": "Выберите добавленную подписку в разделе Профили. Выбрать страну сервера можно в разделе Прокси (🚀). Установите переключатель TUN в положение ВКЛ.", "zh": "在“配置文件”部分选择已添加的订阅。可在“代理 (🚀)”部分选择服务器国家。将 TUN 开关切换到开启。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "PrizrakBox"}], "svgIconKey": "Ubuntu", "displayName": {"en": "Linux", "fa": "Linux", "fr": "Linux", "ru": "Linux", "zh": "Linux"}}, "macos": {"apps": [{"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/ru/app/happ-proxy-utility-plus/id6746188973", "text": {"en": "App Store (RU)", "fa": "اپ استور (RU)", "fr": "App Store (RU)", "ru": "App Store (RU)", "zh": "App Store (RU)"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://apps.apple.com/us/app/happ-proxy-utility/id6504287215", "text": {"en": "App Store (Global)", "fa": "اپ استور (جهانی)", "fr": "App Store (Global)", "ru": "App Store (Global)", "zh": "App Store (Global)"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮——应用将会打开，订阅会自动添加。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "Happ"}, {"name": "FlClashX", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-macos-arm64.dmg", "text": {"en": "macOS (Apple Silicon)", "fa": "مک (Apple Silicon)", "fr": "macOS (Apple Silicon)", "ru": "macOS (Apple Silicon)", "zh": "macOS（Apple Silicon）"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-macos-amd64.dmg", "text": {"en": "macOS (Intel)", "fa": "مک (اینتل)", "fr": "macOS (Intel)", "ru": "macOS (Intel)", "zh": "macOS（Intel）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "flclashx://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the Profiles section, click the + button, select the URL, paste your copied link and click Send", "fa": "اگر بعد از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراکی را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در این صفحه در گوشه سمت راست بالا کلیک کنید، لینک را کپی کنید. در FlClashX به بخش Profiles بروید، دکمه + را کلیک کنید، URL را انتخاب کنید، پیوند کپی شده خود را جایگذاری کنید و روی ارسال کلیک کنید.", "fr": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the « Profiles » section, click the + button, select the « URL », paste your copied link and click Send.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой страницу кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В FlClashX перейдите в раздел Профили, нажмите кнопку +, выберите URL, вставьте вашу скопированную ссылку и нажмите Отправить", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 FlClashX 的“配置文件”部分，点击 + 按钮，选择 URL，粘贴你复制的链接并点击发送。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added profile in the Profiles section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the TUN item. After launching, in the Proxy section, you can change the choice of the server to which you will be connected.", "fa": "نمایه اضافه شده را در قسمت پروفایل ها انتخاب کنید. در داشبورد، روی دکمه فعال کردن در گوشه پایین سمت راست کلیک کنید و سپس سوئیچ کنار مورد TUN را روشن کنید. پس از راه اندازی در قسمت Proxy می توانید انتخاب سروری که به آن متصل خواهید شد را تغییر دهید.", "fr": "Select the added profile in the « Profiles » section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the « TUN » item. After launching, in the « Proxy » section, you can change the choice of the server to which you will be connected.", "ru": "Выберите добавленный профиль в разделе Профили. В Панели управления нажмите кнопку включить в правом нижнем углу, а затем включите переключатель у пункта TUN. После запуска в разделе Прокси вы можете изменить выбор сервера к которому вас подключит.", "zh": "在“配置文件”部分选择已添加的配置文件。在控制面板右下角点击启用按钮，然后打开 TUN 项旁边的开关。启动后，在代理部分可以更改所连接的服务器。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "FlClashX"}, {"name": "Koala Clash", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash_aarch64.dmg", "text": {"en": "macOS (Apple Silicon)", "fa": "مک (Apple Silicon)", "fr": "macOS (Apple Silicon)", "ru": "macOS (Apple Silicon)", "zh": "macOS（Apple Silicon）"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash_x64.dmg", "text": {"en": "macOS (Intel)", "fa": "مک (اینتل)", "fr": "macOS (Intel)", "ru": "macOS (Intel)", "zh": "macOS（Intel）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Warning", "fa": "هشدار", "fr": "Avertissement", "ru": "Предупреждение", "zh": "警告"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash. ⚠️ Warning: If you get a notification that the application is corrupted when you run it on macOS, run this command in Terminal: sudo xattr -r -c /Applications/Koala\\\\ Clash.app", "fa": "اگر قبلاً از Clash Verge Rev استفاده کرده‌اید، باید قبل از نصب Koala Clash آن را حذف کنید. ⚠️ هشدار: اگر هنگام اجرای برنامه در macOS پیامی مبنی بر خراب بودن برنامه دریافت کردید، این دستور را در ترمینال اجرا کنید: sudo xattr -r -c /Applications/Koala\\\\ Clash.app", "fr": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash. ⚠️ Warning : If you get a notification that the application is corrupted when you run it on macOS, run this command in Terminal : sudo xattr -r -c /Applications/Koala\\\\ Clash.app.", "ru": "Если вы ранее использовали Clash Verge Rev, то его требуется удалить перед установкой Koala Clash. ⚠️ Предупреждение: Если при запуске приложения на macOS появляется уведомление, что приложение повреждено, выполните эту команду в терминале: sudo xattr -r -c /Applications/Koala\\\\ Clash.app", "zh": "如果您之前用过 Clash Verge Rev，请在安装 Koala Clash 前先卸载它。⚠️ 警告：如果在 macOS 上运行应用时收到应用已损坏的提示，请在终端运行以下命令：sudo xattr -r -c /Applications/Koala\\\\ Clash.app"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "koala-clash://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک اضافه نشد", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. Click the Get Link button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the Add Profile button, paste the link into the text field, and then click the Import button.", "fa": "اگر پس از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در گوشه بالا سمت راست این صفحه کلیک کنید و لینک را کپی کنید. در برنامه Koala Clash به صفحه اصلی بروید، روی دکمه افزودن پروفایل کلیک کنید، لینک را در فیلد متنی قرار دهید و سپس روی دکمه وارد کردن کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. Click the « Get Link » button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the « Add Profile » button, paste the link into the text field, and then click the « Import » button.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой странице кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В Koala Clash перейдите на главную страницу, нажмите кнопку Добавить профиль и вставьте ссылку в текстовое поле, затем нажмите на кнопку Импорт.", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 Koala Clash 主页面点击“添加配置文件”按钮，将链接粘贴到文本框中，然后点击“导入”按钮。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "fa": "می‌توانید سرور را در پایین صفحه اصلی انتخاب کنید و با کلیک روی دکمه بزرگ در مرکز صفحه اصلی، VPN را فعال کنید.", "fr": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "ru": "Выбрать сервер можно внизу на главной странице, включить VPN можно нажав на главной странице на большую кнопку по центру.", "zh": "您可以在主页面底部选择服务器，并通过点击主页面中央的大按钮来启用 VPN。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "KoalaClash"}, {"name": "Prizrak-Box", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/macos-arm64-dmg.zip", "text": {"en": "macOS (Apple Silicon)", "fa": "macOS (Apple Silicon)", "fr": "macOS (Apple Silicon)", "ru": "macOS (Apple Silicon)", "zh": "macOS（Apple Silicon）"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/macos-amd64-dmg.zip", "text": {"en": "macOS (Intel)", "fa": "macOS (Intel)", "fr": "macOS (Intel)", "ru": "macOS (Intel)", "zh": "macOS（Intel）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Download the archive for your chip (Apple Silicon or Intel), unzip and move Prizrak-Box.app to Applications.", "fa": "فایل مناسب (Apple Silicon یا Intel) را دانلود کرده، از حالت فشرده خارج و برنامه را به Applications منتقل کنید.", "fr": "Download the archive for your chip (Apple Silicon or Intel), unzip and move Prizrak-Box.app to Applications.", "ru": "Скачайте архив под ваш чип (Apple Silicon или Intel), распакуйте и переместите Prizrak-Box.app в Applications.", "zh": "下载适合您芯片（Apple Silicon 或 Intel）的压缩包，解压后将 Prizrak-Box.app 移入 Applications。"}, "svgIconColor": "cyan"}, {"title": {"en": "Read before first launch", "fa": "قبل از اولین اجرا بخوانید", "fr": "Read before first launch", "ru": "Прочти перед первым запуском", "zh": "首次启动前阅读"}, "buttons": [{"link": "https://github.com/legiz-ru/Prizrak-Box/blob/v3/doc/mac/mac.md", "text": {"en": "Mac Guide", "fa": "راهنمای مک", "fr": "Mac Guide", "ru": "Инструкция для Mac", "zh": "Mac 使用指南"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "Gear", "description": {"en": "If macOS shows security warnings, follow this guide.", "fa": "اگر macOS هشدار امنیتی نشان داد، این راهنما را دنبال کنید.", "fr": "If macOS shows security warnings, follow this guide.", "ru": "Если macOS показывает предупреждения безопасности — следуйте инструкции.", "zh": "若 macOS 显示安全警告，请按指南操作。"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "prizrak-box://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add the subscription automatically.", "fa": "روی دکمه زیر کلیک کنید تا اشتراک به صورت خودکار افزوده شود.", "fr": "Click the button below to add the subscription automatically.", "ru": "Нажмите кнопку ниже, чтобы автоматически добавить подписку.", "zh": "点击下方按钮即可自动添加订阅。"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. On this page, click the Get Link button in the upper right corner, copy the link. In Prizrak-Box, go to the Profiles section, click the + button, paste your copied link, and click Confirm.", "fa": "اگر پس از کلیک بر روی دکمه اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. در این صفحه، روی دکمه «دریافت پیوند» در گوشه بالا سمت راست کلیک کنید، پیوند را کپی کنید. در Prizrak-Box، به بخش «پروفایل‌ها» بروید، روی دکمه + کلیک کنید، پیوند کپی شده خود را جای‌گذاری کنید و روی «تأیید» کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. On this page, click the « Get Link » button in the upper right corner, copy the link. In Prizrak-Box, go to the « Profiles » section, click the + button, paste your copied link, and click « Confirm ».", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой странице кнопку «Получить ссылку» в правом верхнем углу, скопируйте ссылку. В Prizrak-Box перейдите в раздел «Профили», нажмите кнопку «+», вставьте скопированную ссылку и нажмите «Подтвердить».", "zh": "如果点击按钮后没有任何反应，请手动添加订阅。在此页面上，点击右上角的“获取链接”按钮，复制链接。在 Prizrak-Box 中，转到“配置文件”部分，点击 + 按钮，粘贴您复制的链接，然后点击“确认”。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added subscription in the Profiles section. You can choose the server country in the Proxy (🚀) section. Set the TUN switch to ON.", "fa": "اشتراک افزوده‌شده را در بخش پروفایل‌ها انتخاب کنید. می‌توانید کشور سرور را در بخش Proxy (🚀) انتخاب کنید. سوئیچ TUN را روی حالت روشن قرار دهید.", "fr": "Select the added subscription in the « Profiles » section. You can choose the server country in the « Proxy » (🚀) section. Set the « TUN » switch to ON.", "ru": "Выберите добавленную подписку в разделе Профили. Выбрать страну сервера можно в разделе Прокси (🚀). Установите переключатель TUN в положение ВКЛ.", "zh": "在“配置文件”部分选择已添加的订阅。可在“代理 (🚀)”部分选择服务器国家。将 TUN 开关切换到开启。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "PrizrakBox"}], "svgIconKey": "macOS", "displayName": {"en": "macOS", "fa": "macOS", "fr": "macOS", "ru": "macOS", "zh": "macOS"}}, "android": {"apps": [{"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://play.google.com/store/apps/details?id=com.happproxy", "text": {"en": "Open in Google Play", "fa": "باز کردن در Google Play", "fr": "Ouvre dans Google Play", "ru": "Открыть в Google Play", "zh": "在 Google Play 打开"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/Happ-proxy/happ-android/releases/latest/download/Happ.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in Google Play and install the app. Or install the app directly from the APK file if Google Play is not working.", "fa": "صفحه را در Google Play باز کنید و برنامه را نصب کنید. یا برنامه را مستقیماً از فایل APK نصب کنید، اگر Google Play کار نمی کند.", "fr": "Ouvre la page dans Google Play et installe l’app. Si Google Play ne fonctionne pas, installe‑la directement via l’APK.", "ru": "Откройте страницу в Google Play и установите приложение. Или установите приложение из APK файла напрямую, если Google Play не работает.", "zh": "在 Google Play 打开页面并安装应用。如果 Google Play 无法使用，也可以直接通过 APK 文件安装此应用。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Open the app and connect to the server", "fa": "برنامه را باز کنید و به سرور متصل شوید", "fr": "Ouvre l’app et connecte‑toi au serveur.", "ru": "Откройте приложение и подключитесь к серверу", "zh": "打开应用并连接到服务器"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "Happ"}, {"name": "FlClashX", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-android-universal.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Download and install FlClashX APK", "fa": "دانلود و نصب FlClashX APK", "fr": "Télécharge et installe l’APK FlClashX.", "ru": "Скачайте и установите FlClashX APK", "zh": "下载并安装 FlClashX APK"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "flclashx://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the Profiles section, click the + button, select the URL, paste your copied link and click Send", "fa": "اگر بعد از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراکی را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در این صفحه در گوشه سمت راست بالا کلیک کنید، لینک را کپی کنید. در FlClashX به بخش Profiles بروید، دکمه + را کلیک کنید، URL را انتخاب کنید، پیوند کپی شده خود را جایگذاری کنید و روی ارسال کلیک کنید.", "fr": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the « Profiles » section, click the + button, select the « URL », paste your copied link and click Send.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой страницу кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В FlClashX перейдите в раздел Профили, нажмите кнопку +, выберите URL, вставьте вашу скопированную ссылку и нажмите Отправить", "zh": "如果点击按钮后没有反应，请手动添加订阅。在本页右上角点击获取链接按钮，复制链接。在 FlClashX 的 Profiles 部分点击 + 按钮，选择 URL，粘贴你复制的链接并点击发送。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added profile in the Profiles section. In the Control Panel, click the Enable button in the bottom right corner. Once it's running, you can change the server you're connected to in the Proxy section.", "fa": "پروفایل افزوده‌شده را در بخش پروفایل‌ها انتخاب کنید. در پنل کنترل، روی دکمه فعال‌سازی در گوشه پایین سمت راست کلیک کنید. پس از اجرا، می‌توانید در بخش پروکسی، سروری را که به آن متصل می‌شوید تغییر دهید.", "fr": "Select the added profile in the « Profiles » section. In the Control Panel, click the « Enable » button in the bottom right corner. Once it's running, you can change the server you're connected to in the « Proxy » section.", "ru": "Выберите добавленный профиль в разделе Профили. В Панели управления нажмите кнопку включить в правом нижнем углу. После запуска в разделе Прокси вы можете изменить выбор сервера к которому вас подключит.", "zh": "在 Profiles 部分选择已添加的配置文件。在控制面板右下角点击启用按钮。启动后，你可以在 Proxy 部分更换连接的服务器。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "FlClashX"}, {"name": "Clash Meta", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/MetaCubeX/ClashMetaForAndroid/releases/download/v2.11.20/cmfa-2.11.20-meta-universal-release.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://f-droid.org/packages/com.github.metacubex.clash.meta/", "text": {"en": "Open in F-Droid", "fa": "در F-Droid باز کنید", "fr": "Ouvre dans F‑Droid", "ru": "Открыть в F-Droid", "zh": "在 F-Droid 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Download and install Clash Meta APK", "fa": "دانلود و نصب Clash Meta APK", "fr": "Télécharge et installe l’APK Clash Meta.", "ru": "Скачайте и установите Clash Meta APK", "zh": "下载并安装 Clash Meta APK"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "clashmeta://install-config?name={{USERNAME}}&url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to open the profile creation window. You will need to specify the auto-update period, for example, 720 minutes. Click the Save button in the top right corner.", "fa": "دکمه زیر را بزنید تا پنجره ایجاد پروفایل باز شود. شما باید دوره به‌روزرسانی خودکار را مشخص کنید، مثلاً ۷۲۰ دقیقه. دکمه ذخیره را در بالا سمت راست بزنید.", "fr": "Clique sur le bouton ci‑dessous pour ouvrir la fenêtre de création de profil. Indique la période d’actualisation automatique, par exemple 720 minutes. Appuie sur « « Save » » en haut à droite.", "ru": "Нажми кнопку ниже — откроется окно создания профиля. Тебе потребуется указать период автообновления, например, 720 минут. Справа вверху нажми на кнопку Сохранить.", "zh": "点击下方按钮打开配置文件创建窗口。你需要指定自动更新周期，例如 720 分钟。点击右上角的保存按钮。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Go to the Profiles section and select the created profile, then return to the main page. Now you can connect by clicking the Stopped button.", "fa": "به بخش پروفایل‌ها بروید و پروفایل ایجاد شده را انتخاب کنید، سپس به صفحه اصلی بازگردید. اکنون می‌توانید با زدن دکمه «متوقف شده» متصل شوید.", "fr": "Va dans « Profiles » et sélectionne le profil créé, puis reviens à la page principale. Tu peux maintenant te connecter en appuyant sur « Stopped ».", "ru": "Перейди в пункт Профили и выбери созданный профиль, затем вернись на главную страницу. Теперь ты можешь подключиться, нажав на кнопку Остановлен", "zh": "进入“配置文件”部分并选择已创建的配置文件，然后返回主页面。现在你可以点击“已停止”按钮连接。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "ClashMeta"}, {"name": "v2rayNG", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/2dust/v2rayNG/releases/download/1.10.31/v2rayNG_1.10.31_universal.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Download and install v2rayNG APK", "fa": "دانلود و نصب v2rayNG APK", "fr": "Télécharge et installe l’APK v2rayNG.", "ru": "Скачайте и установите v2rayNG APK", "zh": "下载并安装 v2rayNG APK"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "v2rayng://install-config?name={{USERNAME}}&url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮，应用将会打开，并自动添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Update subscriptions", "fa": "به‌روزرسانی اشتراک‌ها", "fr": "Mettre à jour les abonnements", "ru": "Обновление подписки", "zh": "更新订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "Tap the three dots in the top-right corner and select Update subscription. After that, the available servers will appear in the list.", "fa": "روی سه نقطه در گوشه بالا سمت راست کلیک کنید و گزینه به‌روزرسانی اشتراک را انتخاب کنید. سپس سرورهای موجود در لیست ظاهر می‌شوند.", "fr": "Appuie sur les trois points en haut à droite et sélectionne « Update subscription ». Les serveurs disponibles apparaîtront alors dans la liste.", "ru": "Нажмите на три точечки справа сверху и выберите Обновить подписку. После этого в списке появятся доступные серверы", "zh": "点击右上角的三个点，选择“更新订阅”。之后，列表中会显示可用服务器。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the required server and click the Enable button in the bottom right corner.", "fa": "سرور موردنظر را انتخاب کنید و روی دکمه فعال‌سازی در گوشه پایین سمت راست کلیک کنید.", "fr": "Sélectionne le serveur souhaité puis appuie sur « Enable » en bas à droite.", "ru": "Выберите требуемый сервер и нажмите кнопку Включить в правом нижнем углу", "zh": "选择所需服务器并点击右下角的启用按钮。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "VRayNG"}], "svgIconKey": "Android", "displayName": {"en": "Android", "fa": "Android", "fr": "Android", "ru": "Android", "zh": "Android"}}, "appleTV": {"apps": [{"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/us/app/happ-proxy-utility-for-tv/id6748297274", "text": {"en": "App Store", "fa": "App Store", "fr": "App Store", "ru": "App Store", "zh": "App Store"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in the App Store on your Apple TV and install the app. Launch it, allow VPN configuration if prompted, and enter your passcode if required.", "fa": "صفحه را در App Store بر روی Apple TV باز کنید و برنامه را نصب کنید. آن را اجرا کنید، در صورت درخواست مجوز پیکربندی VPN را بدهید و در صورت نیاز رمز عبور خود را وارد کنید.", "fr": "Open the page in the App Store on your Apple TV and install the app. Launch it, allow VPN configuration if prompted, and enter your passcode if required.", "ru": "Откройте страницу в App Store на Apple TV и установите приложение. Запустите его, предоставьте разрешение на VPN-конфигурацию, если потребуется, и введите свой пароль.", "zh": "在 Apple TV 的 App Store 打开页面并安装应用。启动后，如有提示请允许 VPN 配置，并在需要时输入您的密码。"}, "svgIconColor": "cyan"}, {"title": {"en": "Installation instructions", "fa": "دستورالعمل نصب", "fr": "Installation instructions", "ru": "Инструкции по установке", "zh": "安装说明"}, "buttons": [{"link": "https://www.happ.su/main/ru/faq/android-tv", "text": {"en": "In Russian", "fa": "به زبان روسی", "fr": "In Russian", "ru": "На русском", "zh": "俄语"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://www.happ.su/main/faq/android-tv", "text": {"en": "In English", "fa": "به زبان انگلیسی", "fr": "In English", "ru": "На английском", "zh": "英语"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "Gear", "description": {"en": "Detailed instructions to help you set up Happ on your device.", "fa": "راهنمای دقیق برای کمک به تنظیم Happ روی دستگاه شما.", "fr": "Detailed instructions to help you set up Happ on your device.", "ru": "Подробные инструкции, чтобы помочь вам настроить Happ на вашем устройстве.", "zh": "详细说明，帮助您在设备上设置 Happ。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription, if you opened the subscription page on your TV", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید، اگر صفحه اشتراک را روی تلویزیون باز کرده‌اید", "fr": "Click the button below to add subscription, if you opened the subscription page on your TV.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку, если вы открыли страницу подписки на телевизоре", "zh": "如果你已在电视上打开订阅页面，点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Open the app and connect to the server", "fa": "برنامه را باز کنید و به سرور متصل شوید", "fr": "Ouvre l’app et connecte‑toi au serveur.", "ru": "Откройте приложение и подключитесь к серверу", "zh": "打开应用并连接到服务器"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "Happ"}, {"name": "Shadowrocket", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/ru/app/shadowrocket/id932747118", "text": {"en": "Open in App Store", "fa": "باز کردن در App Store", "fr": "Ouvre dans l’App Store", "ru": "Открыть в App Store", "zh": "在 App Store 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in App Store and install the app. Launch it, in the VPN configuration permission window click Allow and enter your passcode.", "fa": "صفحه را در App Store باز کنید و برنامه را نصب کنید. آن را اجرا کنید، در پنجره مجوز پیکربندی VPN روی Allow کلیک کنید و رمز عبور خود را وارد کنید.", "fr": "Ouvre la page de l’App Store et installe l’app. Lance-la ; dans la fenêtre d’autorisation de configuration VPN, appuie sur « Allow » puis entre ton code.", "ru": "Откройте страницу в App Store и установите приложение. Запустите его, в окне разрешения VPN-конфигурации нажмите Allow и введите свой пароль.", "zh": "在 App Store 打开页面并安装应用。启动应用后，在 VPN 配置权限窗口点击“允许”，并输入您的密码。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "shadowrocket://add/{{SUBSCRIPTION_LINK}}#{{USERNAME}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮，应用将会打开，并自动添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Shadowrocket"}, {"name": "Stash", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://apps.apple.com/us/app/stash-rule-based-proxy/id1596063349", "text": {"en": "Open in App Store", "fa": "باز کردن در App Store", "fr": "Ouvre dans l’App Store", "ru": "Открыть в App Store", "zh": "在 App Store 打开"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the App Store page and install the app.", "fa": "صفحه App Store را باز کرده و برنامه را نصب کنید.", "fr": "Ouvre la page de l’App Store et installe l’app.", "ru": "Откройте страницу в App Store и установите приложение.", "zh": "打开 App Store 页面并安装应用。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "stash://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Tap the button below — Stash will open and the configuration will be added automatically.", "fa": "روی دکمه زیر ضربه بزنید — برنامه Stash باز می‌شود و پیکربندی به‌صورت خودکار اضافه خواهد شد.", "fr": "Appuie sur le bouton ci-dessous — Stash s’ouvrira et la configuration sera ajoutée automatiquement.", "ru": "Нажмите кнопку ниже — приложение Stash откроется, и конфигурация будет добавлена автоматически.", "zh": "点击下方按钮，Stash 将会打开并自动添加配置。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "On the main screen, tap the Start button. When prompted, allow adding VPN configurations. After the profile is activated, open the Policy section and select the country you want to connect through.", "fa": "در صفحه اصلی روی دکمه Start بزنید. در صورت نمایش درخواست، مجوز افزودن پیکربندی VPN را تأیید کنید. پس از فعال شدن پروفایل، وارد بخش Policy شوید و کشور موردنظر برای اتصال را انتخاب کنید.", "fr": "Sur l’écran principal, appuie sur le bouton « Start ». Autorise ensuite l’ajout de la configuration VPN. Une fois le profil activé, ouvre la section « Policy » et choisis le pays de connexion.", "ru": "На главном экране нажмите кнопку «Запуск». В появившемся окне разрешите добавление конфигураций VPN. После активации профиля перейдите в раздел «Политика» и выберите страну подключения.", "zh": "在主界面点击「Start」按钮。在提示时允许添加 VPN 配置。配置启用后，进入「Policy（策略）」部分并选择要连接的国家。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Stash"}], "svgIconKey": "TV", "displayName": {"en": "Apple TV", "fa": "Apple TV", "fr": "Apple TV", "ru": "Apple TV", "zh": "Apple TV"}}, "windows": {"apps": [{"name": "FlClashX", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-windows-amd64-setup.exe", "text": {"en": "Windows (Setup)", "fa": "ویندوز (نصب)", "fr": "Windows (Setup)", "ru": "Windows (Установщик)", "zh": "Windows（安装程序）"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/pluralplay/FlClashX/releases/latest/download/FlClashX-windows-arm64-setup.exe", "text": {"en": "Windows on ARM (Setup)", "fa": "ویندوز ARM (نصب)", "fr": "Windows on ARM (Setup)", "ru": "Windows на ARM (Установщик)", "zh": "Windows on ARM（安装程序）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "flclashx://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the Profiles section, click the + button, select the URL, paste your copied link and click Send", "fa": "اگر بعد از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراکی را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در این صفحه در گوشه سمت راست بالا کلیک کنید، لینک را کپی کنید. در FlClashX به بخش Profiles بروید، دکمه + را کلیک کنید، URL را انتخاب کنید، پیوند کپی شده خود را جایگذاری کنید و روی ارسال کلیک کنید.", "fr": "If nothing happens after clicking the button, add a subscription manually. Click the Get link button on this page in the upper right corner, copy the link. In FlClashX, go to the « Profiles » section, click the + button, select the « URL », paste your copied link and click Send.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой страницу кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В FlClashX перейдите в раздел Профили, нажмите кнопку +, выберите URL, вставьте вашу скопированную ссылку и нажмите Отправить", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 FlClashX 的“配置文件”部分，点击 + 按钮，选择 URL，粘贴你复制的链接并点击发送。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added profile in the Profiles section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the TUN item. After launching, in the Proxy section, you can change the choice of the server to which you will be connected.", "fa": "نمایه اضافه شده را در قسمت پروفایل ها انتخاب کنید. در داشبورد، روی دکمه فعال کردن در گوشه پایین سمت راست کلیک کنید و سپس سوئیچ کنار مورد TUN را روشن کنید. پس از راه اندازی در قسمت Proxy می توانید انتخاب سروری که به آن متصل خواهید شد را تغییر دهید.", "fr": "Select the added profile in the « Profiles » section. In the Dashboard, click the enable button in the lower right corner, and then turn on the switch next to the « TUN » item. After launching, in the « Proxy » section, you can change the choice of the server to which you will be connected.", "ru": "Выберите добавленный профиль в разделе Профили. В Панели управления нажмите кнопку включить в правом нижнем углу, а затем включите переключатель у пункта TUN. После запуска в разделе Прокси вы можете изменить выбор сервера к которому вас подключит.", "zh": "在“配置文件”部分选择已添加的配置文件。在控制面板右下角点击启用按钮，然后打开 TUN 项旁边的开关。启动后，在代理部分可以更改所连接的服务器。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "FlClashX"}, {"name": "Koala Clash", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/coolcoala/clash-verge-rev-lite/releases/latest/download/Koala.Clash_x64-setup.exe", "text": {"en": "Windows (Setup)", "fa": "ویندوز (نصب)", "fr": "Windows (Setup)", "ru": "Windows (Установщик)", "zh": "Windows（安装程序）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Warning", "fa": "هشدار", "fr": "Avertissement", "ru": "Предупреждение", "zh": "警告"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash.", "fa": "اگر قبلاً از Clash Verge Rev استفاده کرده‌اید، باید قبل از نصب Koala Clash آن را حذف کنید.", "fr": "If you have previously used Clash Verge Rev, you need to uninstall it before installing Koala Clash.", "ru": "Если вы ранее использовали Clash Verge Rev, то его требуется удалить перед установкой Koala Clash.", "zh": "如果您之前用过 Clash Verge Rev，请在安装 Koala Clash 前先卸载它。"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "koala-clash://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید", "fr": "Clique sur le bouton ci‑dessous pour ajouter l’abonnement.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку", "zh": "点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک اضافه نشد", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. Click the Get Link button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the Add Profile button, paste the link into the text field, and then click the Import button.", "fa": "اگر پس از کلیک روی دکمه هیچ اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. روی دکمه دریافت لینک در گوشه بالا سمت راست این صفحه کلیک کنید و لینک را کپی کنید. در برنامه Koala Clash به صفحه اصلی بروید، روی دکمه افزودن پروفایل کلیک کنید، لینک را در فیلد متنی قرار دهید و سپس روی دکمه وارد کردن کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. Click the « Get Link » button in the top right corner of this page, copy the link. In Koala Clash, go to the main page, click the « Add Profile » button, paste the link into the text field, and then click the « Import » button.", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой странице кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В Koala Clash перейдите на главную страницу, нажмите кнопку Добавить профиль и вставьте ссылку в текстовое поле, затем нажмите на кнопку Импорт.", "zh": "如果点击按钮后没有反应，请手动添加订阅。在此页面右上角点击“获取链接”按钮，复制链接。在 Koala Clash 主页面点击“添加配置文件”按钮，将链接粘贴到文本框中，然后点击“导入”按钮。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "fa": "می‌توانید سرور را در پایین صفحه اصلی انتخاب کنید و با کلیک روی دکمه بزرگ در مرکز صفحه اصلی، VPN را فعال کنید.", "fr": "You can select a server at the bottom of the main page, and enable VPN by clicking on the large button in the center of the main page.", "ru": "Выбрать сервер можно внизу на главной странице, включить VPN можно нажав на главной странице на большую кнопку по центру.", "zh": "您可以在主页面底部选择服务器，并通过点击主页面中央的大按钮来启用 VPN。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "KoalaClash"}, {"name": "Prizrak-Box", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/windows-amd64.msi", "text": {"en": "Windows (Setup)", "fa": "ویندوز (نصب)", "fr": "Windows (Setup)", "ru": "Windows (Установщик)", "zh": "Windows（安装程序）"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/legiz-ru/Prizrak-Box/releases/latest/download/windows-arm64.msi", "text": {"en": "Windows on ARM (Setup)", "fa": "ویندوز ARM (نصب)", "fr": "Windows on ARM (Setup)", "ru": "Windows на ARM (Установщик)", "zh": "Windows on ARM（安装程序）"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose your architecture (installer preferred for automatic integration) and install or unzip Prizrak-Box.", "fa": "معماری مناسب را انتخاب کنید (نصب‌کننده ترجیح دارد) و Prizrak-Box را نصب یا از حالت فشرده خارج کنید.", "fr": "Choose your architecture (installer preferred for automatic integration) and install or unzip Prizrak-Box.", "ru": "Выберите архитектуру (предпочтительно установщик) и установите или распакуйте Prizrak-Box.", "zh": "选择适合的架构（建议使用安装程序）并安装或解压 Prizrak-Box。"}, "svgIconColor": "cyan"}, {"title": {"en": "Warning", "fa": "هشدار", "fr": "Avertissement", "ru": "Предупреждение", "zh": "警告"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "Run the program as an administrator.", "fa": "برنامه را به عنوان مدیر اجرا کنید.", "fr": "Run the program as an administrator.", "ru": "Запустите программу от имени администратора.", "zh": "以管理员身份运行程序。"}, "svgIconColor": "red"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "prizrak-box://install-config?url={{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add the subscription automatically.", "fa": "روی دکمه زیر کلیک کنید تا اشتراک به صورت خودکار افزوده شود.", "fr": "Click the button below to add the subscription automatically.", "ru": "Нажмите кнопку ниже, чтобы автоматически добавить подписку.", "zh": "点击下方按钮即可自动添加订阅。"}, "svgIconColor": "cyan"}, {"title": {"en": "If the subscription is not added", "fa": "اگر اشتراک در برنامه نصب نشده است", "fr": "Si l’abonnement ne s’ajoute pas", "ru": "Если подписка не добавилась", "zh": "如果未添加订阅"}, "buttons": [], "svgIconKey": "Gear", "description": {"en": "If nothing happens after clicking the button, add the subscription manually. On this page, click the Get Link button in the upper right corner, copy the link. In Prizrak-Box, go to the Profiles section, click the + button, paste your copied link, and click Confirm.", "fa": "اگر پس از کلیک بر روی دکمه اتفاقی نیفتاد، اشتراک را به صورت دستی اضافه کنید. در این صفحه، روی دکمه «دریافت پیوند» در گوشه بالا سمت راست کلیک کنید، پیوند را کپی کنید. در Prizrak-Box، به بخش «پروفایل‌ها» بروید، روی دکمه + کلیک کنید، پیوند کپی شده خود را جای‌گذاری کنید و روی «تأیید» کلیک کنید.", "fr": "If nothing happens after clicking the button, add the subscription manually. On this page, click the « Get Link » button in the upper right corner, copy the link. In Prizrak-Box, go to the « Profiles » section, click the + button, paste your copied link, and click « Confirm ».", "ru": "Если после нажатия на кнопку ничего не произошло, добавьте подписку вручную. Нажмите на этой страницу кнопку Получить ссылку в правом верхнем углу, скопируйте ссылку. В Prizrak-Box перейдите в раздел Профили, нажмите кнопку +, вставьте вашу скопированную ссылку и нажмите Потдвердить.", "zh": "如果点击按钮后没有任何反应，请手动添加订阅。在此页面上，点击右上角的“获取链接”按钮，复制链接。在 Prizrak-Box 中，转到“配置文件”部分，点击 + 按钮，粘贴您复制的链接，然后点击“确认”。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Select the added subscription in the Profiles section. You can choose the server country in the Proxy (🚀) section. Set the TUN switch to ON.", "fa": "اشتراک افزوده‌شده را در بخش پروفایل‌ها انتخاب کنید. می‌توانید کشور سرور را در بخش Proxy (🚀) انتخاب کنید. سوئیچ TUN را روی حالت روشن قرار دهید.", "fr": "Select the added subscription in the « Profiles » section. You can choose the server country in the « Proxy » (🚀) section. Set the « TUN » switch to ON.", "ru": "Выберите добавленную подписку в разделе Профили. Выбрать страну сервера можно в разделе Прокси (🚀). Установите переключатель TUN в положение ВКЛ.", "zh": "在“配置文件”部分选择已添加的订阅。可在“代理 (🚀)”部分选择服务器国家。将 TUN 开关切换到开启。"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "PrizrakBox"}, {"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://github.com/Happ-proxy/happ-desktop/releases/latest/download/setup-Happ.x64.exe", "text": {"en": "Windows", "fa": "ویندوز", "fr": "Windows", "ru": "Windows", "zh": "Windows"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Choose the version for your device, click the button below and install the app.", "fa": "نسخه مناسب برای دستگاه خود را انتخاب کنید، دکمه زیر را فشار دهید و برنامه را نصب کنید", "fr": "Choisis la version pour ton appareil, clique sur le bouton ci‑dessous et installe l’app.", "ru": "Выберите подходящую версию для вашего устройства, нажмите на кнопку ниже и установите приложение.", "zh": "选择适合您设备的版本，点击下方按钮并安装应用程序。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below — the app will open and the subscription will be added automatically", "fa": "برای افزودن خودکار اشتراک روی دکمه زیر کلیک کنید - برنامه باز خواهد شد", "fr": "Clique sur le bouton ci‑dessous — l’app s’ouvrira et l’abonnement sera ajouté automatiquement.", "ru": "Нажмите кнопку ниже — приложение откроется, и подписка добавится автоматически.", "zh": "点击下方按钮——应用将会打开，订阅会自动添加。"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "In the main section, click the large power button in the center to connect to VPN. Don't forget to select a server from the server list. If needed, choose another server from the server list.", "fa": "در بخش اصلی، دکمه بزرگ روشن/خاموش در مرکز را برای اتصال به VPN کلیک کنید. فراموش نکنید که یک سرور را از لیست سرورها انتخاب کنید. در صورت نیاز، سرور دیگری را از لیست سرورها انتخاب کنید.", "fr": "Dans la section principale, appuie sur le grand bouton central pour te connecter au VPN. N’oublie pas de choisir un serveur dans la liste ; si besoin, choisis‑en un autre.", "ru": "В главном разделе нажмите большую кнопку включения в центре для подключения к VPN. Не забудьте выбрать сервер в списке серверов. При необходимости выберите другой сервер из списка серверов.", "zh": "在主界面，点击中央的大电源按钮以连接 VPN。不要忘记从服务器列表中选择服务器。如有需要，可选择其它服务器。"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "Happ"}], "svgIconKey": "Windows", "displayName": {"en": "Windows", "fa": "Windows", "fr": "Windows", "ru": "Windows", "zh": "Windows"}}, "androidTV": {"apps": [{"name": "Happ", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://play.google.com/store/apps/details?id=com.happproxy", "text": {"en": "Open in Google Play", "fa": "باز کردن در Google Play", "fr": "Ouvre dans Google Play", "ru": "Открыть в Google Play", "zh": "在 Google Play 打开"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://github.com/Happ-proxy/happ-android/releases/latest/download/Happ.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in Google Play and install the app. Or install the app directly from the APK file if Google Play is not working.", "fa": "صفحه را در Google Play باز کنید و برنامه را نصب کنید. یا برنامه را مستقیماً از فایل APK نصب کنید، اگر Google Play کار نمی کند.", "fr": "Ouvre la page dans Google Play et installe l’app. Si Google Play ne fonctionne pas, installe‑la directement via l’APK.", "ru": "Откройте страницу в Google Play и установите приложение. Или установите приложение из APK файла напрямую, если Google Play не работает.", "zh": "在 Google Play 打开页面并安装应用。如果 Google Play 无法使用，可直接通过 APK 文件安装应用。"}, "svgIconColor": "cyan"}, {"title": {"en": "Installation instructions", "fa": "دستورالعمل نصب", "fr": "Installation instructions", "ru": "Инструкции по установке", "zh": "安装说明"}, "buttons": [{"link": "https://www.happ.su/main/ru/faq/android-tv", "text": {"en": "In Russian", "fa": "به زبان روسی", "fr": "In Russian", "ru": "На русском", "zh": "俄语"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://www.happ.su/main/faq/android-tv", "text": {"en": "In English", "fa": "به زبان انگلیسی", "fr": "In English", "ru": "На английском", "zh": "英语"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "Gear", "description": {"en": "Detailed instructions to help you set up Happ on your device.", "fa": "راهنمای دقیق برای کمک به تنظیم Happ روی دستگاه شما.", "fr": "Detailed instructions to help you set up Happ on your device.", "ru": "Подробные инструкции, чтобы помочь вам настроить Happ на вашем устройстве.", "zh": "详细说明，帮助您在设备上设置 Happ。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "happ://add/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription, if you opened the subscription page on your TV", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید، اگر صفحه اشتراک را روی تلویزیون باز کرده‌اید", "fr": "Click the button below to add subscription, if you opened the subscription page on your TV.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку, если вы открыли страницу подписки на телевизоре", "zh": "如果你已在电视上打开订阅页面，点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Open the app and connect to the server", "fa": "برنامه را باز کنید و به سرور متصل شوید", "fr": "Ouvre l’app et connecte‑toi au serveur.", "ru": "Откройте приложение и подключитесь к серверу", "zh": "打开应用并连接到服务器"}, "svgIconColor": "teal"}], "featured": true, "svgIconKey": "Happ"}, {"name": "vpn4tv", "blocks": [{"title": {"en": "App Installation", "fa": "نصب برنامه", "fr": "Installation de l'application", "ru": "Установка приложения", "zh": "应用安装"}, "buttons": [{"link": "https://play.google.com/store/apps/details?id=com.vpn4tv.hiddify", "text": {"en": "Open in Google Play", "fa": "باز کردن در Google Play", "fr": "Ouvre dans Google Play", "ru": "Открыть в Google Play", "zh": "在 Google Play 打开"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://vpn4tv.com/download/vpn4tv.apk", "text": {"en": "Download APK", "fa": "دانلود APK", "fr": "Télécharge l’APK", "ru": "Скачать APK", "zh": "下载 APK"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "DownloadIcon", "description": {"en": "Open the page in Google Play and install the app. Or install the app directly from the APK file if Google Play is not working.", "fa": "صفحه را در Google Play باز کنید و برنامه را نصب کنید. یا برنامه را مستقیماً از فایل APK نصب کنید، اگر Google Play کار نمی کند.", "fr": "Ouvre la page dans Google Play et installe l’app. Si Google Play ne fonctionne pas, installe‑la directement via l’APK.", "ru": "Откройте страницу в Google Play и установите приложение. Или установите приложение из APK файла напрямую, если Google Play не работает.", "zh": "在 Google Play 打开页面并安装应用。如果 Google Play 无法使用，也可以直接通过 APK 文件安装此应用。"}, "svgIconColor": "cyan"}, {"title": {"en": "Installation instructions", "fa": "دستورالعمل نصب", "fr": "Installation instructions", "ru": "Инструкции по установке", "zh": "安装说明"}, "buttons": [{"link": "https://vpn4tv.com/quick-guide.html", "text": {"en": "Quick Guide", "fa": "راهنمای سریع", "fr": "Quick Guide", "ru": "Краткое руководство", "zh": "快速指南"}, "type": "external", "svgIconKey": "ExternalLink"}, {"link": "https://vpn4tv.com/sber.html", "text": {"en": "Sber Box Guide", "fa": "راهنمای Sber Box", "fr": "Sber Box Guide", "ru": "Инструкция для Sber Box", "zh": "Sber Box 指南"}, "type": "external", "svgIconKey": "ExternalLink"}], "svgIconKey": "Gear", "description": {"en": "Detailed instructions to help you set up VPN4TV on your device.", "fa": "راهنمای دقیق برای کمک به تنظیم VPN4TV روی دستگاه شما.", "fr": "Detailed instructions to help you set up VPN4TV on your device.", "ru": "Подробные инструкции, чтобы помочь вам настроить VPN4TV на вашем устройстве.", "zh": "详细说明，帮助您在设备上设置 VPN4TV。"}, "svgIconColor": "cyan"}, {"title": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавление подписки", "zh": "添加订阅"}, "buttons": [{"link": "hiddify://import/{{SUBSCRIPTION_LINK}}", "text": {"en": "Add Subscription", "fa": "اضافه کردن اشتراک", "fr": "Ajouter une souscription", "ru": "Добавить подписку", "zh": "添加订阅"}, "type": "subscriptionLink", "svgIconKey": "Plus"}], "svgIconKey": "CloudDownload", "description": {"en": "Click the button below to add subscription, if you opened the subscription page on your TV", "fa": "برای افزودن اشتراک روی دکمه زیر کلیک کنید، اگر صفحه اشتراک را روی تلویزیون باز کرده‌اید", "fr": "Click the button below to add subscription, if you opened the subscription page on your TV.", "ru": "Нажмите кнопку ниже, чтобы добавить подписку, если вы открыли страницу подписки на телевизоре", "zh": "如果你已在电视上打开订阅页面，点击下方按钮以添加订阅"}, "svgIconColor": "cyan"}, {"title": {"en": "Connect and use", "fa": "متصل شوید و استفاده کنید", "fr": "Se connecter et utiliser", "ru": "Подключение и использование", "zh": "连接并使用"}, "buttons": [], "svgIconKey": "Check", "description": {"en": "Open the app and connect to the server", "fa": "برنامه را باز کنید و به سرور متصل شوید", "fr": "Ouvre l’app et connecte‑toi au serveur.", "ru": "Откройте приложение и подключитесь к серверу", "zh": "打开应用并连接到服务器"}, "svgIconColor": "teal"}], "featured": false, "svgIconKey": "VpnForTV"}], "svgIconKey": "TV", "displayName": {"en": "Android TV", "fa": "Android TV", "fr": "Android TV", "ru": "Android TV", "zh": "Android TV"}}}, "svgLibrary": {"TV": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n      0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n      stroke-linejoin=\\"round\\"><path\\n      stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M3 7m0 2a2 2 0 0 1 2 -2h14a2\\n      2 0 0 1 2 2v9a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z\\" /><path d=\\"M16 3l-4 4l-4\\n      -4\\" /></svg>", "Gear": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n          0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n          stroke-linejoin=\\"round\\"><path\\n          stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M10.325 4.317c.426\\n          -1.756 2.924 -1.756 3.35 0a1.724 1.724 0 0 0 2.573 1.066c1.543 -.94 3.31\\n          .826 2.37 2.37a1.724 1.724 0 0 0 1.065 2.572c1.756 .426 1.756 2.924 0 3.35a1.724\\n          1.724 0 0 0 -1.066 2.573c.94 1.543 -.826 3.31 -2.37 2.37a1.724 1.724 0 0\\n          0 -2.572 1.065c-.426 1.756 -2.924 1.756 -3.35 0a1.724 1.724 0 0 0 -2.573\\n          -1.066c-1.543 .94 -3.31 -.826 -2.37 -2.37a1.724 1.724 0 0 0 -1.065 -2.572c-1.756\\n          -.426 -1.756 -2.924 0 -3.35a1.724 1.724 0 0 0 1.066 -2.573c-.94 -1.543 .826\\n          -3.31 2.37 -2.37c1 .608 2.296 .07 2.572 -1.065z\\" /><path d=\\"M9 12a3 3 0\\n          1 0 6 0a3 3 0 0 0 -6 0\\" /></svg>", "Happ": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M22.3264 3H12.3611L9.44444 20.1525L21.3542 8.22034L22.3264 3Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M10.9028 20.1525L22.8125 8.22034L20.8681 21.1469H28.4028L27.9167 21.6441L20.8681 28.8531H19.4097V30.5932L7.5 42.5254L10.9028 20.1525Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M41.0417 8.22034L28.8889 20.1525L31.684 3H41.7708L41.0417 8.22034Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M30.3472 20.1525L42.5 8.22034L38.6111 30.3446L26.9444 42.5254L29.0104 28.8531H22.3264L29.6181 21.1469H30.3472V20.1525Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M40.0694 30.3446L28.4028 42.5254L27.9167 47H37.8819L40.0694 30.3446Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M18.6806 47H8.47222L8.95833 42.5254L20.8681 30.5932L18.6806 47Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Husi": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M3.41174 29.0078C4.58506 33.8287 7.33566 38.1192 11.2266 41.1979C15.1175 44.2766 19.9256 45.9668 24.8871 46C29.8486 46.0333 34.6789 44.4077 38.6107 41.3814C42.5426 38.3552 45.3504 34.1019 46.5883 29.2972\\" stroke=\\"#FAFAFA\\" stroke-width=\\"3\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M10.6001 35.1992C13.6001 38.7992 18.3755 41.4631 23.8001 39.9992C29.2247 38.5353 33.4 34.5992 38.8 36.9992\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M10.6001 29.8008C13.6001 33.4008 18.3755 36.0646 23.8001 34.6008C29.2247 33.1369 33.4 29.2008 38.8 31.6008\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M25.6002 30.4004C21.4002 32.2004 23.5277 36.8942 24.9039 38.2004C26.8004 40.0004 25.504 44.2004 23.1039 45.4004\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M17.6424 24.1575L24.517 6.34402C24.8426 5.50028 26.0319 5.48783 26.3751 6.32455L33.6771 24.1258C33.8754 24.6092 33.6681 25.1639 33.2012 25.3987L25.885 29.0784C25.5944 29.2245 25.251 29.2203 24.9642 29.0669L18.1039 25.3995C17.6585 25.1614 17.4606 24.6286 17.6424 24.1575Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Loon": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M9.92017 18.2865C9.92017 28.4087 23.9672 39.5637 25.0001 38.944C26.0329 39.5637 40.08 28.4087 40.08 18.2865C40.08 8.99066 34.0894 3 25.0001 3C15.9108 3 9.92017 8.99066 9.92017 18.2865Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M25.9465 46.9997H23.6407C23.203 46.9997 22.8162 46.7151 22.686 46.2973L21.8928 43.7526C21.6922 43.1089 22.1732 42.4551 22.8475 42.4551H26.7396C27.414 42.4551 27.895 43.1089 27.6943 43.7526L26.9012 46.2973C26.771 46.7151 26.3842 46.9997 25.9465 46.9997Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Plus": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\"\\n            viewBox=\\"0 0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\"\\n            stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"><path stroke=\\"none\\" d=\\"M0 0h24v24H0z\\"\\n            fill=\\"none\\"/><path d=\\"M12 5v14\\" /><path d=\\"M5 12h14\\" /></svg>", "Star": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0 0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"><path stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z\\" /></svg>", "Xray": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M23.9314 22.3507L23.759 4.49701C23.7482 3.38439 22.2015 3.11843 21.8197 4.16356L17.2573 16.6537C17.1678 16.8988 16.986 17.0992 16.7507 17.2122L7.90294 21.4588C6.9437 21.9192 7.27164 23.3604 8.33565 23.3604H22.9315C23.4875 23.3604 23.9368 22.9067 23.9314 22.3507Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M26.5294 22.3604V8.17765C26.5294 7.13507 27.9251 6.78827 28.4131 7.70959L33.1715 16.6935C33.2882 16.9139 33.4831 17.0827 33.7178 17.1668L45.5829 21.419C46.6388 21.7974 46.3671 23.3604 45.2455 23.3604H27.5294C26.9771 23.3604 26.5294 22.9126 26.5294 22.3604Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M26.5294 45.4643V27.1712C26.5294 26.6189 26.9771 26.1712 27.5294 26.1712H42.1088C43.1611 26.1712 43.4995 27.5875 42.5609 28.0632L33.7011 32.5533C33.4772 32.6667 33.3042 32.8603 33.2164 33.0954L28.4662 45.8141C28.0764 46.8578 26.5294 46.5783 26.5294 45.4643Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M23.9412 41.8161V27.1712C23.9412 26.6189 23.4935 26.1712 22.9412 26.1712H4.83963C3.71522 26.1712 3.44655 27.7401 4.5069 28.1142L17.1928 32.5902C17.4457 32.6795 17.6522 32.8666 17.7659 33.1096L22.0353 42.2397C22.4884 43.2085 23.9412 42.8856 23.9412 41.8161Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Check": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n          0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n          stroke-linejoin=\\"round\\"><path\\n          stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M5 12l5 5l10 -10\\"\\n          /></svg>", "Stash": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M24.4948 3.02051C33.172 2.52485 37.945 10.8183 37.7565 20.8945C42.3238 22.5003 51.8349 31.9328 47.3727 39.9775C43.0858 47.7061 35.3051 49.1534 24.9977 43.3711C21.2267 46.1366 8.15345 51.0387 2.81116 40.7939C-1.1406 33.2151 4.13135 24.7049 11.9244 20.8945C11.673 16.4661 13.4331 3.65239 24.4948 3.02051ZM12.6158 27.5371C10.3533 29.0455 6.77107 32.9426 8.21643 37.2793C9.63059 41.5219 15.6954 41.4901 19.4664 39.416C15.6328 35.5193 13.6717 31.2075 12.6158 27.5371ZM37.0651 27.5371C36.2606 33.1181 32.2045 37.7818 30.277 39.416C33.9223 41.2387 39.7858 41.396 41.653 37.2793C43.3898 33.4495 38.1545 28.1028 37.0651 27.5371ZM31.4088 24.584C29.2091 23.725 23.5022 22.5226 18.2731 24.584C18.5456 26.8888 20.0326 32.3148 24.8717 36.1484C27.239 34.263 31.1572 29.2349 31.4088 24.584ZM24.8717 9.43652C21.1637 9.43663 19.0896 13.208 18.0211 18.1729C21.0379 17.293 25.6894 16.7901 31.5973 18.1729C31.5973 15.2819 28.8313 9.43657 24.8717 9.43652Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "macOS": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n      0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n      stroke-linejoin=\\"round\\"><path\\n      stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M3 4m0 1a1 1 0 0 1 1 -1h16a1\\n      1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1z\\" /><path d=\\"M7 8v1\\" /><path\\n      d=\\"M17 8v1\\" /><path d=\\"M12.5 4c-.654 1.486 -1.26 3.443 -1.5 9h2.5c-.19 2.867\\n      .094 5.024 .5 7\\" /><path d=\\"M7 15.5c3.667 2 6.333 2 10 0\\" /></svg>", "Karing": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M20.1587 31.9985C20.1587 31.9985 11.6426 31.9986 11.176 31.9985C10.7093 31.9984 4.64307 31.9986 4.64307 25.1157C4.64307 18.2329 10.3594 18 11.176 18C11.9926 18 16.7756 18 21.9086 18C27.0416 18 27.275 25.1159 27.275 25.1159\\" stroke=\\"#FAFAFA\\" stroke-width=\\"3\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M29.8413 18.0015C29.8413 18.0015 38.3574 18.0014 38.824 18.0015C39.2907 18.0016 45.3569 18.0014 45.3569 24.8843C45.3569 31.7671 39.6406 32 38.824 32C38.0074 32 33.2244 32 28.0914 32C22.9584 32 22.725 24.8841 22.725 24.8841\\" stroke=\\"#FAFAFA\\" stroke-width=\\"3\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M12.6929 24.8848H17.2426\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2.5\\" stroke-linecap=\\"round\\"/>\\n<path d=\\"M32.7581 24.8848H37.3078\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2.5\\" stroke-linecap=\\"round\\"/>\\n</svg>\\n", "Throne": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M10.0418 45.1448C14.86 40.3651 23.8702 33.8918 23.8588 23.1928C23.8584 22.8041 23.9567 22.4206 24.1477 22.082C26.2965 18.2717 29.3747 10.3342 29.3747 19.8306C29.3747 39.8323 34.0654 41.8361 37.777 44.4404C39.0797 45.3544 38.3103 46.9995 36.7189 46.9995H10.8246C10.3526 46.9995 9.93354 46.6974 9.78427 46.2496C9.6549 45.8615 9.75137 45.433 10.0418 45.1448Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M20.165 11.2551C19.3301 12.925 20.7206 14.5249 22.1124 15.5383C22.8304 16.0612 23.8053 15.8757 24.3901 15.2072C26.4539 12.8479 29.2273 9.28495 28.9139 8.03165C28.4534 6.1897 23.3885 1.58483 24.7695 3.42678C26.1506 5.26872 21.5465 8.49213 20.165 11.2551Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Ubuntu": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0 0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"><path stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M12 5m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0\\" /><path d=\\"M17.723 7.41a7.992 7.992 0 0 0 -3.74 -2.162m-3.971 0a7.993 7.993 0 0 0 -3.789 2.216m-1.881 3.215a8 8 0 0 0 -.342 2.32c0 .738 .1 1.453 .287 2.132m1.96 3.428a7.993 7.993 0 0 0 3.759 2.19m4 0a7.993 7.993 0 0 0 3.747 -2.186m1.962 -3.43a8.008 8.008 0 0 0 .287 -2.131c0 -.764 -.107 -1.503 -.307 -2.203\\" /><path d=\\"M5 17m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0\\" /><path d=\\"M19 17m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0\\" /></svg>", "VRayNG": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M7.17 8.24503H2V3H15.16V20.9497L34.5475 3H49L7.17 47V8.24503Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Android": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n      0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n      stroke-linejoin=\\"round\\"><path\\n      stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M4 10l0 6\\" /><path d=\\"M20\\n      10l0 6\\" /><path d=\\"M7 9h10v8a1 1 0 0 1 -1 1h-8a1 1 0 0 1 -1 -1v-8a5 5 0 0 1\\n      10 0\\" /><path d=\\"M8 3l1 2\\" /><path d=\\"M16 3l-1 2\\" /><path d=\\"M9 18l0 3\\" /><path\\n      d=\\"M15 18l0 3\\" /></svg>", "ClashMi": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M12.9098 3L13.6759 2.35734C13.4411 2.07735 13.0722 1.94777 12.7138 2.01939C12.3554 2.091 12.0647 2.3524 11.9555 2.70115L12.9098 3ZM36.8957 3L37.8545 2.71603C37.7474 2.35425 37.4457 2.08358 37.0745 2.01611C36.7033 1.94865 36.3257 2.09588 36.0981 2.39684L36.8957 3ZM42.9644 44.9329L43.1858 45.9081L43.941 45.7366L43.9639 44.9625L42.9644 44.9329ZM7.12996 44.9329L6.13166 44.9912L6.16506 45.5629L6.67498 45.8234L7.12996 44.9329ZM25.0472 8.02013L25.0274 9.01994L25.0472 8.02013ZM18.1115 9.20134L17.3454 9.844C17.601 10.1487 18.0129 10.273 18.3944 10.1605L18.1115 9.20134ZM31.9829 9.49664L31.6602 10.4431C32.0686 10.5824 32.5203 10.444 32.7805 10.0998L31.9829 9.49664ZM19.0746 27.9007C19.6165 28.0072 20.1422 27.6542 20.2487 27.1123C20.3551 26.5704 20.0022 26.0447 19.4602 25.9382L19.2674 26.9195L19.0746 27.9007ZM11.9466 24.4617C11.4047 24.3552 10.879 24.7082 10.7725 25.2501C10.666 25.7921 11.019 26.3177 11.5609 26.4242L11.7538 25.443L11.9466 24.4617ZM30.6341 25.9382C30.0922 26.0447 29.7392 26.5704 29.8457 27.1123C29.9522 27.6542 30.4778 28.0072 31.0197 27.9007L30.8269 26.9195L30.6341 25.9382ZM38.5334 26.4242C39.0753 26.3177 39.4283 25.7921 39.3218 25.2501C39.2153 24.7082 38.6897 24.3552 38.1478 24.4617L38.3406 25.443L38.5334 26.4242ZM19.2674 30.5772C19.8197 30.5772 20.2674 30.1295 20.2674 29.5772C20.2674 29.0249 19.8197 28.5772 19.2674 28.5772V29.5772V30.5772ZM11.7538 28.5772C11.2015 28.5772 10.7538 29.0249 10.7538 29.5772C10.7538 30.1295 11.2015 30.5772 11.7538 30.5772V29.5772V28.5772ZM30.8269 28.5772C30.2746 28.5772 29.8269 29.0249 29.8269 29.5772C29.8269 30.1295 30.2746 30.5772 30.8269 30.5772V29.5772V28.5772ZM38.3406 30.5772C38.8929 30.5772 39.3406 30.1295 39.3406 29.5772C39.3406 29.0249 38.8929 28.5772 38.3406 28.5772V29.5772V30.5772ZM19.4969 32.9129C20.0345 32.7861 20.3675 32.2476 20.2407 31.7101C20.114 31.1725 19.5754 30.8395 19.0379 30.9663L19.2674 31.9396L19.4969 32.9129ZM11.5242 32.7381C10.9867 32.8649 10.6537 33.4034 10.7805 33.9409C10.9072 34.4785 11.4457 34.8115 11.9833 34.6847L11.7538 33.7114L11.5242 32.7381ZM31.0564 30.9663C30.5189 30.8395 29.9804 31.1725 29.8536 31.7101C29.7268 32.2476 30.0599 32.7861 30.5974 32.9129L30.8269 31.9396L31.0564 30.9663ZM38.1111 34.6847C38.6486 34.8115 39.1871 34.4785 39.3139 33.9409C39.4406 33.4034 39.1076 32.8649 38.5701 32.7381L38.3406 33.7114L38.1111 34.6847ZM26.0747 24.4094L26.0747 23.4094H26.0747V24.4094ZM26.5612 25.3189L25.7143 24.7872L25.7143 24.7872L26.5612 25.3189ZM22.6978 25.3189L23.5447 24.7872L23.5447 24.7872L22.6978 25.3189ZM23.1842 24.4094L23.1842 25.4094H23.1842V24.4094ZM24.143 27.6211L23.2961 28.1527L23.2961 28.1527L24.143 27.6211ZM25.116 27.6211L25.9629 28.1528L25.9629 28.1527L25.116 27.6211ZM16.3776 21.1946C15.8253 21.1946 15.3776 21.6423 15.3776 22.1946C15.3776 22.7469 15.8253 23.1946 16.3776 23.1946V22.1946V21.1946ZM20.4234 23.1946C20.9757 23.1946 21.4234 22.7469 21.4234 22.1946C21.4234 21.6423 20.9757 21.1946 20.4234 21.1946V22.1946V23.1946ZM28.963 21.1946C28.4107 21.1946 27.963 21.6423 27.963 22.1946C27.963 22.7469 28.4107 23.1946 28.963 23.1946V22.1946V21.1946ZM33.0089 23.1946C33.5611 23.1946 34.0089 22.7469 34.0089 22.1946C34.0089 21.6423 33.5611 21.1946 33.0089 21.1946V22.1946V23.1946ZM36.8957 3C35.9369 3.28397 35.9369 3.28393 35.9369 3.28398C35.9369 3.28411 35.937 3.28424 35.937 3.2845C35.9372 3.28502 35.9374 3.28588 35.9378 3.28708C35.9385 3.28948 35.9396 3.29324 35.9411 3.29834C35.9441 3.30854 35.9487 3.32411 35.9548 3.34497C35.9669 3.38667 35.9851 3.4495 36.009 3.53266C36.0567 3.69898 36.127 3.94665 36.2165 4.26947C36.3954 4.91514 36.651 5.86126 36.9562 7.0583C37.5667 9.45276 38.3752 12.8491 39.1657 16.8515C40.749 24.8675 42.2506 35.2668 41.9648 44.9032L42.9644 44.9329L43.9639 44.9625C44.2561 35.109 42.7234 24.5419 41.1278 16.4639C40.329 12.4193 39.5119 8.98684 38.8942 6.56418C38.5853 5.35267 38.3262 4.39317 38.1439 3.73535C38.0527 3.40643 37.9808 3.15289 37.9314 2.98095C37.9067 2.89497 37.8877 2.82939 37.8748 2.78498C37.8683 2.76278 37.8633 2.74587 37.8599 2.73434C37.8582 2.72858 37.8569 2.72417 37.856 2.72111C37.8556 2.71958 37.8552 2.7184 37.855 2.71755C37.8549 2.71713 37.8548 2.71675 37.8547 2.71653C37.8546 2.71624 37.8545 2.71603 36.8957 3ZM7.12996 44.9329L8.12826 44.8746C7.55738 35.1035 8.98515 24.7147 10.5673 16.7416C11.3571 12.761 12.1829 9.39504 12.8107 7.02588C13.1246 5.84151 13.3889 4.90681 13.5742 4.2696C13.6669 3.951 13.7398 3.70682 13.7893 3.54303C13.8141 3.46113 13.833 3.39934 13.8456 3.35839C13.8519 3.33792 13.8567 3.32266 13.8598 3.3127C13.8613 3.30772 13.8624 3.30407 13.8632 3.30176C13.8635 3.3006 13.8638 3.29978 13.8639 3.2993C13.864 3.29905 13.864 3.29894 13.8641 3.29882C13.8641 3.29879 13.8641 3.29885 12.9098 3C11.9555 2.70115 11.9554 2.70138 11.9553 2.70169C11.9552 2.7019 11.9551 2.7023 11.955 2.70273C11.9547 2.70359 11.9543 2.70479 11.9538 2.70633C11.9529 2.7094 11.9515 2.71381 11.9497 2.71956C11.9462 2.73104 11.941 2.74785 11.9342 2.76989C11.9206 2.81396 11.9007 2.87894 11.875 2.96409C11.8235 3.13439 11.7485 3.38535 11.6538 3.711C11.4644 4.36227 11.1958 5.31244 10.8775 6.51355C10.241 8.91536 9.40506 12.3229 8.6055 16.3523C7.00872 24.3994 5.54658 34.9771 6.13166 44.9912L7.12996 44.9329ZM42.9644 44.9329L42.7429 43.9577C35.0111 45.7134 32.1936 46 25.0472 46V47V48C32.3464 48 35.3123 47.696 43.1858 45.9081L42.9644 44.9329ZM25.0472 47V46C21.459 46 17.7381 45.8531 14.5665 45.5254C11.3424 45.1923 8.84377 44.6856 7.58494 44.0424L7.12996 44.9329L6.67498 45.8234C8.30602 46.6567 11.1546 47.1835 14.3609 47.5148C17.6198 47.8516 21.4126 48 25.0472 48V47ZM12.9098 3L12.1436 3.64266L17.3454 9.844L18.1115 9.20134L18.8777 8.55868L13.6759 2.35734L12.9098 3ZM18.1115 9.20134C18.3944 10.1605 18.3943 10.1605 18.3943 10.1605C18.3943 10.1605 18.3942 10.1606 18.3942 10.1606C18.3942 10.1606 18.3943 10.1605 18.3944 10.1605C18.3947 10.1604 18.3952 10.1603 18.396 10.16C18.3975 10.1596 18.4001 10.1588 18.4036 10.1578C18.4106 10.1558 18.4215 10.1526 18.4362 10.1484C18.4655 10.1399 18.5096 10.1273 18.5673 10.1111C18.6827 10.0787 18.852 10.032 19.0643 9.97601C19.4894 9.86384 20.0843 9.71476 20.7621 9.56752C22.1398 9.26825 23.7781 8.99515 25.0274 9.01994L25.0472 8.02013L25.0671 7.02033C23.571 6.99064 21.7414 7.30814 20.3376 7.6131C19.6247 7.76797 19.0004 7.92441 18.554 8.04222C18.3306 8.10119 18.1511 8.15064 18.0266 8.18559C17.9643 8.20308 17.9158 8.21694 17.8824 8.22658C17.8656 8.2314 17.8527 8.23516 17.8437 8.23778C17.8392 8.2391 17.8357 8.24012 17.8332 8.24086C17.8319 8.24123 17.8309 8.24152 17.8302 8.24174C17.8298 8.24185 17.8295 8.24194 17.8292 8.24202C17.8291 8.24205 17.829 8.24209 17.8289 8.24211C17.8288 8.24215 17.8287 8.24218 18.1115 9.20134ZM25.0472 8.02013L25.0274 9.01994C26.2862 9.04492 27.9248 9.3877 29.2999 9.74657C29.9765 9.92313 30.5695 10.0982 30.993 10.2291C31.2045 10.2944 31.3731 10.3486 31.4881 10.3861C31.5455 10.4048 31.5895 10.4194 31.6186 10.4292C31.6332 10.434 31.6441 10.4377 31.6511 10.44C31.6546 10.4412 31.6571 10.4421 31.6586 10.4426C31.6594 10.4429 31.6599 10.443 31.6602 10.4431C31.6603 10.4432 31.6604 10.4432 31.6604 10.4432C31.6604 10.4432 31.6603 10.4432 31.6603 10.4432C31.6603 10.4432 31.6602 10.4431 31.9829 9.49664C32.3056 8.55015 32.3055 8.55011 32.3054 8.55007C32.3054 8.55005 32.3052 8.55 32.3051 8.54996C32.3049 8.54988 32.3045 8.54977 32.3042 8.54965C32.3034 8.54939 32.3024 8.54906 32.3012 8.54863C32.2987 8.54779 32.2952 8.5466 32.2907 8.54509C32.2818 8.54207 32.2689 8.53773 32.2522 8.53218C32.219 8.52106 32.1707 8.50505 32.1087 8.48482C31.9848 8.44437 31.806 8.38701 31.5834 8.31823C31.1387 8.18081 30.5165 7.99708 29.8049 7.81138C28.4037 7.44572 26.5745 7.05024 25.0671 7.02033L25.0472 8.02013ZM31.9829 9.49664L32.7805 10.0998L37.6933 3.60316L36.8957 3L36.0981 2.39684L31.1853 8.89348L31.9829 9.49664ZM19.2674 26.9195L19.4602 25.9382L11.9466 24.4617L11.7538 25.443L11.5609 26.4242L19.0746 27.9007L19.2674 26.9195ZM30.8269 26.9195L31.0197 27.9007L38.5334 26.4242L38.3406 25.443L38.1478 24.4617L30.6341 25.9382L30.8269 26.9195ZM19.2674 29.5772V28.5772H11.7538V29.5772V30.5772H19.2674V29.5772ZM30.8269 29.5772V30.5772H38.3406V29.5772V28.5772H30.8269V29.5772ZM19.2674 31.9396L19.0379 30.9663L11.5242 32.7381L11.7538 33.7114L11.9833 34.6847L19.4969 32.9129L19.2674 31.9396ZM30.8269 31.9396L30.5974 32.9129L38.1111 34.6847L38.3406 33.7114L38.5701 32.7381L31.0564 30.9663L30.8269 31.9396ZM24.143 27.6211L24.9899 27.0894L23.5447 24.7872L22.6978 25.3189L21.8508 25.8506L23.2961 28.1527L24.143 27.6211ZM23.1842 24.4094V25.4094H26.0747V24.4094V23.4094H23.1842V24.4094ZM26.5612 25.3189L25.7143 24.7872L24.269 27.0894L25.116 27.6211L25.9629 28.1527L27.4082 25.8506L26.5612 25.3189ZM26.0747 24.4094L26.0747 25.4094C25.7072 25.4094 25.5635 25.0275 25.7143 24.7872L26.5612 25.3189L27.4082 25.8506C28.0525 24.8242 27.3563 23.4094 26.0747 23.4094L26.0747 24.4094ZM22.6978 25.3189L23.5447 24.7872C23.6955 25.0275 23.5518 25.4094 23.1842 25.4094L23.1842 24.4094L23.1842 23.4094C21.9026 23.4094 21.2064 24.8242 21.8508 25.8506L22.6978 25.3189ZM24.143 27.6211L23.2961 28.1527C23.9155 29.1394 25.3435 29.1394 25.9629 28.1528L25.116 27.6211L24.269 27.0894C24.4336 26.8272 24.8254 26.8272 24.9899 27.0894L24.143 27.6211ZM16.3776 22.1946V23.1946H20.4234V22.1946V21.1946H16.3776V22.1946ZM28.963 22.1946V23.1946H33.0089V22.1946V21.1946H28.963V22.1946Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Exclave": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M20.4659 7.13501C17.2448 7.59207 12.3696 9.15216 11.7579 9.92164L11.5063 10.2381V12.2215C11.5063 13.3124 11.5431 14.2049 11.5879 14.2049C11.6329 14.2049 12.3318 13.8132 13.1411 13.3344C14.9399 12.2702 15.7345 11.9159 17.089 11.5737C24.462 9.71111 33.1869 12.276 37.429 17.5531L38.1607 18.4633L38.234 18.1745C38.2743 18.0156 38.29 16.5548 38.269 14.9281L38.2307 11.9704L37.8516 11.5706C37.313 11.0023 35.3963 9.77362 34.0609 9.14066C32.4826 8.39243 30.562 7.75384 28.7627 7.37879L27.2377 7.061L24.4579 7.01199C22.5256 6.97799 21.3084 7.01549 20.4659 7.13501ZM7.23546 13.1088C4.57629 15.7457 3.10082 19.3414 2.64973 24.2841L2.5 25.9247L2.65137 27.5346C2.97851 31.0149 3.91026 33.7949 5.57501 36.2574C6.26214 37.2738 7.94925 39.0833 8.20992 39.0833H8.36446L8.3244 36.2373L8.28422 33.3913L7.49462 31.8304C6.99955 30.8518 6.58081 29.8033 6.37219 29.0194L6.03937 27.7692L6.03634 25.894L6.03318 24.0187L6.24533 23.0917C6.57677 21.6429 7.13324 20.1174 7.76654 18.9213L8.3474 17.8242L8.33855 15.2332C8.33363 13.8081 8.28978 12.5425 8.24113 12.4207L8.15268 12.1993L7.23546 13.1088ZM41.4772 19.8408L41.516 24.5188L42.1148 26.0552C42.4442 26.9004 42.8326 28.1662 42.9779 28.8681L43.2423 30.1446L43.253 32.0823L43.2639 34.0201L42.9919 34.8327C42.8425 35.2796 42.6198 35.7908 42.4971 35.9687C42.3744 36.1466 42.0894 36.5656 41.8635 36.8996L41.4528 37.5071V39.9204V42.3337L41.6739 42.3322C42.0919 42.3295 43.1595 41.9958 43.8315 41.6581C45.706 40.7159 47.0259 38.1604 47.4018 34.7457C47.6047 32.9024 47.4806 29.4297 47.1449 27.5543C46.6707 24.906 45.827 22.3484 44.6899 20.1123C43.684 18.1342 42.1786 15.7703 41.6466 15.3335L41.4385 15.1626L41.4772 19.8408ZM19.2038 19.1997C15.9086 19.7921 14.0094 21.0308 12.8171 23.3652C11.8769 25.2062 11.5924 27.9455 12.1286 29.9945C12.8514 32.7569 14.5969 34.4479 17.5004 35.1985C19.803 35.7937 22.7251 35.28 24.1226 34.0345C25.0651 33.1943 25.3991 31.0117 24.9633 28.5392C24.5232 26.0425 23.3646 24.7603 21.1613 24.3314L20.4038 24.184L19.6893 24.3146C17.8235 24.6559 16.5745 25.9495 16.5175 27.5996L16.4974 28.18L16.7381 28.4434C17.2528 29.0066 17.8013 28.7286 18.6457 27.4764C19.6633 25.9676 20.7734 25.8053 21.8419 27.0094C22.4546 27.6997 22.6554 28.7145 22.3536 29.5946C22.1168 30.285 21.3955 31.2753 20.8636 31.64L20.3686 31.9794L19.6021 32.0482L18.8357 32.117L18.0239 31.7216C17.0975 31.2703 16.1217 30.2997 15.658 29.3677L15.3602 28.7694V27.6442V26.5191L15.7087 25.783C16.3568 24.4139 18.1796 22.9581 19.8458 22.4785C21.2868 22.0638 22.5775 22.2116 24.142 22.9703L25.216 23.4913L26.2923 24.5675C27.4456 25.7207 28.1042 26.7807 28.515 28.1443C28.8151 29.14 28.8144 31.1022 28.5135 32.2073C27.5519 35.7395 24.1067 38.8676 20.3851 39.5876C19.3766 39.7828 17.0251 39.6801 15.9288 39.393C14.8771 39.1177 13.5102 38.499 12.5649 37.8704C12.1564 37.5988 11.7512 37.3353 11.6643 37.2849L11.5063 37.1933V39.148V41.1028L11.8624 41.4551C12.0997 41.6899 12.6174 41.9338 13.4148 42.1865C15.3808 42.8096 16.6636 43.0067 18.7086 42.9998L20.5408 42.9937L21.9612 42.6708C27.4023 41.434 31.0878 37.8402 32.1147 32.7699C32.3353 31.6808 32.3388 28.7849 32.1209 27.7692C31.56 25.1562 30.5007 23.225 28.7134 21.5567C27.6808 20.5931 26.2673 19.8468 24.7106 19.4432L23.6997 19.1813L21.7412 19.1384C20.664 19.1149 19.5222 19.1425 19.2038 19.1997ZM33.0351 38.2284C32.8879 38.2991 32.6403 38.5803 32.485 38.8536L32.2027 39.3506L32.248 40.3336L32.2931 41.3167L32.5541 41.6689C32.6978 41.8627 33.0103 42.1196 33.2486 42.2397L33.6819 42.4584L35.7036 42.4569C36.8155 42.456 37.8532 42.4214 38.0096 42.38L38.2939 42.3046V40.1938V38.0831L35.7983 38.0917C34.3686 38.0964 33.1885 38.1549 33.0351 38.2284Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "FlClash": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M12 20.0704L38 6M17.5152 32.739L32.0909 25M25 44H26.0833\\" stroke=\\"#FAFAFA\\" stroke-width=\\"8\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"/>\\n</svg>\\n", "Hiddify": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M40.3188 7.90106C37.7445 9.49672 35.5377 10.9133 35.4148 11.0492L35.1913 11.2963L35.1634 13.6341C35.1322 16.2532 35.172 16.4895 35.6999 16.8221C35.9871 17.003 36.1385 17.0085 40.8233 17.0083C46.1369 17.008 45.8591 17.0368 46.3147 16.4383C46.4972 16.1985 46.5 16.1164 46.5 10.9875V5.78023L46.2365 5.48203C45.9446 5.15178 45.6345 5 45.2522 5C45.0794 5 43.5173 5.91861 40.3188 7.90106ZM24.4549 17.269C20.8634 19.5008 19.6772 20.2819 19.5244 20.5159L19.3233 20.8241V28.3718V35.9195L19.1195 36.2321C18.7953 36.7291 18.6226 36.7754 17.0884 36.7766C15.8549 36.7774 15.6703 36.7571 15.4068 36.5911C14.8486 36.2395 14.8535 36.2914 14.8528 30.7073C14.8523 25.8605 14.8449 25.6352 14.6795 25.3757C14.284 24.7557 13.6781 24.699 12.8059 25.2003C12.4815 25.3867 10.9088 26.3582 9.31081 27.3592C7.71284 28.3603 5.95976 29.4522 5.41515 29.7857C4.87055 30.1191 4.21687 30.5619 3.96245 30.7697L3.5 31.1475L3.50456 37.173C3.50715 40.4871 3.53996 43.485 3.5776 43.8352C3.63731 44.391 3.68237 44.5054 3.93197 44.7359L4.21804 45H9.1886H14.1593L14.5064 44.6414L14.8534 44.2826L14.8536 42.2164C14.8537 40.4342 14.8752 40.1056 15.0101 39.8268C15.2737 39.2814 15.5982 39.1804 17.0884 39.1804C19.2745 39.1804 19.3229 39.2441 19.3231 42.1177C19.3233 44.2491 19.3563 44.4258 19.8252 44.8071C20.0593 44.9973 20.1294 45 24.9271 45C30.2954 45 30.1492 45.0152 30.5015 44.4181C30.6727 44.1281 30.6761 43.8413 30.6761 29.6651C30.6761 15.3271 30.6746 15.2053 30.4956 14.9021C30.3012 14.5724 29.8548 14.3302 29.4417 14.3302C29.2626 14.3302 27.7455 15.2244 24.4549 17.269ZM36.0592 19.321C35.7201 19.3997 35.45 19.627 35.2715 19.9836C35.0962 20.3338 35.086 43.9932 35.2609 44.3505C35.3224 44.476 35.5088 44.6735 35.6751 44.7893L35.9776 45H40.7963C46.0666 45 45.93 45.0135 46.3141 44.4559L46.5 44.1862V32.0939V20.0016L46.1948 19.6959C45.9647 19.4655 45.794 19.3821 45.502 19.3572C44.6882 19.2879 36.3392 19.256 36.0592 19.321Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "OneXray": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M7.56292 44.0653C6.31812 42.8205 6.31812 40.8023 7.56292 39.5575L37.8888 9.23163C39.1336 7.98683 41.1518 7.98683 42.3966 9.23164C43.6414 10.4764 43.6414 12.4947 42.3966 13.7395L12.0708 44.0653C10.8259 45.3101 8.80773 45.3101 7.56292 44.0653Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M4.3451 16.664C3.1003 15.4192 3.1003 13.4009 4.3451 12.1561L10.5676 5.9336C11.8124 4.6888 13.8307 4.6888 15.0755 5.9336C16.3203 7.1784 16.3203 9.19663 15.0755 10.4414L8.85293 16.664C7.60813 17.9088 5.5899 17.9088 4.3451 16.664Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M45.6548 16.664C46.8996 15.4192 46.8996 13.401 45.6548 12.1562L39.4322 5.93365C38.1874 4.68885 36.1692 4.68885 34.9244 5.93365C33.6796 7.17845 33.6796 9.19667 34.9244 10.4415L41.147 16.664C42.3918 17.9088 44.41 17.9088 45.6548 16.664Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M42.3966 44.0653C43.6414 42.8205 43.6414 40.8023 42.3966 39.5575L12.0708 9.23163C10.826 7.98683 8.80773 7.98683 7.56293 9.23164C6.31812 10.4764 6.31812 12.4947 7.56293 13.7395L37.8888 44.0653C39.1336 45.3101 41.1518 45.3101 42.3966 44.0653Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M28.0017 26.4171C28.0017 28.1695 26.5811 29.5901 24.8288 29.5901C23.0764 29.5901 21.6558 28.1695 21.6558 26.4171C21.6558 24.6647 23.0764 23.2441 24.8288 23.2441C26.5811 23.2441 28.0017 24.6647 28.0017 26.4171Z\\" fill=\\"#0A0A0A\\"/>\\n</svg>\\n", "Singbox": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M25 47C23.9439 47 22.9078 46.7122 22.0026 46.1675L8.34547 37.9665C7.47616 37.4456 6.75412 36.7059 6.25534 35.8235C5.76843 34.9435 5.50717 33.9541 5.50004 32.948V16.1442C5.49618 15.1283 5.75652 14.1289 6.25543 13.2444C6.75435 12.3598 7.47466 11.6206 8.34547 11.0994L22.0026 3.80947C22.9128 3.27929 23.947 3 25 3C26.053 3 27.0872 3.27929 27.9974 3.80947L41.6545 11.0994C42.5257 11.6208 43.2462 12.3604 43.7452 13.2454C44.2441 14.1304 44.5042 15.1303 44.4999 16.1465V32.9456C44.4928 33.9541 44.2316 34.9435 43.7447 35.8235C43.2459 36.7059 42.5238 37.4456 41.6545 37.9665L27.9974 46.1675C27.0922 46.7122 26.0561 47 25 47ZM25 47V24.5473M43.7185 13.2924L25 24.5473M25 24.5473L6.28145 13.2927M35.4031 27.221V18.2899L15.6562 7.2134\\" stroke=\\"#FAFAFA\\" stroke-width=\\"3\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"/>\\n</svg>\\n", "VTwoBox": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M37.826 12.9006C35.1288 13.7652 34.8433 13.8696 34.9505 13.9518C34.9769 13.9722 36.2663 14.4378 37.8157 14.9863L40.6328 15.9839L43.2485 15.0471C44.6872 14.5318 45.9943 14.061 46.1532 14.0008L46.4422 13.8913L46.2002 13.7987C46.067 13.7478 44.7604 13.3223 43.2965 12.8531L40.6349 12L37.826 12.9006ZM6.88105 13.0851L3.5 13.1155V14.4901V15.8646H4.8293H6.1586V25.9574C6.1586 31.569 6.2031 36.0503 6.2587 36.0503C6.34794 36.0503 9.41666 32.8753 16.793 25.1515C18.8376 23.0106 22.3178 19.3836 26.994 14.5205C27.6774 13.8097 28.2366 13.1891 28.2367 13.1414C28.2367 13.0937 26.5223 13.0805 24.427 13.112L20.6175 13.1694L15.5554 17.8046L10.4933 22.44L10.463 17.8091C10.4465 15.2622 10.3944 13.1505 10.3474 13.1164C10.3005 13.0825 8.74068 13.0683 6.88105 13.0851ZM34.8253 18.424V21.7861L37.2956 22.8969C38.6544 23.5079 39.7994 24.0077 39.8403 24.0077C39.8812 24.0077 39.9009 22.4519 39.8841 20.5503L39.8535 17.093L37.3796 16.0774C36.0191 15.5188 34.8877 15.0618 34.8655 15.0618C34.8434 15.0618 34.8253 16.5748 34.8253 18.424ZM43.7836 16.0962L41.3562 17.1113L41.3255 20.5595C41.3088 22.456 41.339 24.0077 41.3926 24.0077C41.5268 24.0077 46.1759 21.9379 46.3555 21.7982L46.5 21.6858V20.1124C46.5 18.0792 46.368 15.059 46.2797 15.0714C46.2419 15.0767 45.1187 15.5379 43.7836 16.0962ZM22.8998 23.6663C22.0324 23.8115 21.0741 24.117 20.3535 24.4779L19.6828 24.8139V26.7619V28.71H21.3589H23.0349V27.9015C23.0349 26.935 23.2216 26.5177 23.7698 26.2597C24.5035 25.9142 25.5165 26.103 25.8057 26.6393C25.9766 26.9562 25.9524 27.5215 25.7512 27.9075C25.6467 28.1079 24.5992 28.9662 23.1215 30.0622C20.4715 32.0277 19.7693 32.6833 19.5766 33.3716C19.5086 33.6148 19.4527 34.7556 19.4523 35.9069L19.4516 38H24.5376H29.6237V35.7033V33.4065L27.8031 33.4382L25.9825 33.4697L25.9237 34.1245C25.8914 34.4845 25.8067 34.8369 25.7356 34.9075C25.5344 35.1071 24.7914 35.2417 23.873 35.2447L23.0349 35.2474V34.9188C23.0349 34.7381 23.1446 34.4519 23.2786 34.2829C23.4126 34.1138 24.5448 33.2096 25.7947 32.2735C28.2485 30.4356 28.9308 29.7926 29.3112 28.9596L29.5561 28.4233L29.5543 27.2764L29.5526 26.1295L29.2945 25.6018C28.5815 24.1438 27.1565 23.5332 24.5376 23.5633C23.9337 23.5703 23.1967 23.6166 22.8998 23.6663Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Windows": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n      0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n      stroke-linejoin=\\"round\\"><path\\n      stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M17.8 20l-12 -1.5c-1 -.1\\n      -1.8 -.9 -1.8 -1.9v-9.2c0 -1 .8 -1.8 1.8 -1.9l12 -1.5c1.2 -.1 2.2 .8 2.2 1.9v12.1c0\\n      1.2 -1.1 2.1 -2.2 1.9z\\" /><path d=\\"M12 5l0 14\\" /><path d=\\"M4 12l16 0\\" /></svg>", "vrayTUN": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M9.6586 13.2268L12.1706 30.7123H12.3749L20.8724 13.2268H27.531L15.1393 37.1004H7.21872L3 13.2268H9.6586Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M26.0467 37.1004L26.7558 32.9505L37.0442 25.3268C37.8214 24.7362 38.4865 24.1922 39.0394 23.6948C39.6003 23.1974 40.049 22.7001 40.3855 22.2027C40.722 21.7053 40.9384 21.1613 41.0345 20.5707C41.1467 19.9102 41.0946 19.3428 40.8783 18.8688C40.6619 18.3947 40.3174 18.0334 39.8446 17.7847C39.3719 17.5282 38.803 17.4 38.1379 17.4C37.4568 17.4 36.8319 17.536 36.2629 17.808C35.694 18.0722 35.2213 18.4608 34.8447 18.9737C34.4761 19.4788 34.2317 20.0889 34.1115 20.8039H28.4625C28.743 19.1796 29.364 17.7769 30.3255 16.5957C31.287 15.4144 32.505 14.5052 33.9793 13.8679C35.4537 13.2229 37.1003 12.9004 38.9192 12.9004C40.7781 12.9004 42.3446 13.2035 43.6187 13.8096C44.9007 14.4158 45.8262 15.2629 46.3951 16.3509C46.972 17.4311 47.1363 18.6862 46.8879 20.1161C46.7276 21.0253 46.3791 21.9268 45.8422 22.8205C45.3134 23.7065 44.468 24.6934 43.3062 25.7814C42.1443 26.8616 40.5458 28.1556 38.5105 29.6632L35.1211 32.2977L35.0851 32.4492H45.073L44.2677 37.1004H26.0467Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "FlClashX": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<rect x=\\"16.1458\\" y=\\"47\\" width=\\"6.66417\\" height=\\"46.9593\\" rx=\\"3.33209\\" transform=\\"rotate(-150 16.1458 47)\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M38.1165 40.751C39.0362 42.3446 38.4902 44.3827 36.8967 45.3027C35.3031 46.2228 33.2652 45.6764 32.345 44.083L25.6887 32.5537L29.5364 25.8896L38.1165 40.751ZM13.4163 4.63477C15.01 3.71464 17.0479 4.26078 17.968 5.85449L24.5334 17.2266L20.6868 23.8906L12.1975 9.18652C11.2775 7.59298 11.8229 5.55504 13.4163 4.63477Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "VpnForTV": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M8.96283 4L13.1659 20.0974H13.3355L17.5385 4H20.0013L14.5669 23.7647H11.9345L6.5 4H8.96283Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M20.1057 23.7647V4H25.4885C26.6634 4 27.6367 4.27987 28.4085 4.83961C29.1803 5.39936 29.7579 6.16498 30.1414 7.13649C30.5248 8.10156 30.7165 9.18888 30.7165 10.3984C30.7165 11.6144 30.5223 12.7082 30.134 13.6797C29.7505 14.6448 29.1705 15.4104 28.3938 15.9766C27.622 16.5363 26.6511 16.8162 25.4811 16.8162H21.7795V14.2877H25.2747C26.017 14.2877 26.6192 14.1204 27.0812 13.7858C27.5433 13.4449 27.8825 12.9816 28.0988 12.3961C28.3151 11.8107 28.4233 11.1448 28.4233 10.3984C28.4233 9.65211 28.3151 8.98943 28.0988 8.41039C27.8825 7.83134 27.5409 7.37776 27.0739 7.04963C26.6118 6.72151 26.0022 6.55745 25.2452 6.55745H22.3842V23.7647H20.1057Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M43.5 4V23.7647H41.4059L33.7298 9.2693H33.5897V23.7647H31.3112V4H33.4201L41.1035 18.5147H41.2436V4H43.5Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M7.44103 42.1397V39.727L13.9668 26.2353H15.4194V29.7868H14.4977L9.83012 39.4568V39.6112H18.7745V42.1397H7.44103ZM14.6009 46V41.4062L14.6157 40.3061V26.2353H16.7762V46H14.6009Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M18.7295 28.8024V26.2353H30.4169V28.8024H25.7051V46H23.434V28.8024H18.7295Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M32.243 26.2353L36.446 42.3327H36.6156L40.8187 26.2353H43.2815L37.8471 46H35.2146L29.7802 26.2353H32.243Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "AppleIcon": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n      0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n      stroke-linejoin=\\"round\\"><path\\n      stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M8.286 7.008c-3.216 0\\n      -4.286 3.23 -4.286 5.92c0 3.229 2.143 8.072 4.286 8.072c1.165 -.05 1.799 -.538\\n      3.214 -.538c1.406 0 1.607 .538 3.214 .538s4.286 -3.229 4.286 -5.381c-.03 -.011\\n      -2.649 -.434 -2.679 -3.23c-.02 -2.335 2.589 -3.179 2.679 -3.228c-1.096 -1.606\\n      -3.162 -2.113 -3.75 -2.153c-1.535 -.12 -3.032 1.077 -3.75 1.077c-.729 0 -2.036\\n      -1.077 -3.214 -1.077z\\" /><path d=\\"M12 4a2 2 0 0 0 2 -2a2 2 0 0 0 -2 2\\" /></svg>", "ClashMeta": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M4.99239 5.21742C4.0328 5.32232 3.19446 5.43999 3.12928 5.47886C2.94374 5.58955 2.96432 33.4961 3.14997 33.6449C3.2266 33.7062 4.44146 34.002 5.84976 34.3022C7.94234 34.7483 8.60505 34.8481 9.47521 34.8481C10.3607 34.8481 10.5706 34.8154 10.7219 34.6541C10.8859 34.479 10.9066 33.7222 10.9338 26.9143L10.9638 19.3685L11.2759 19.1094C11.6656 18.7859 12.1188 18.7789 12.5285 19.0899C12.702 19.2216 14.319 20.624 16.1219 22.2061C17.9247 23.7883 19.5136 25.1104 19.6527 25.144C19.7919 25.1777 20.3714 25.105 20.9406 24.9825C22.6144 24.6221 23.3346 24.5424 24.9233 24.5421C26.4082 24.5417 27.8618 24.71 29.2219 25.0398C29.6074 25.1333 30.0523 25.1784 30.2107 25.1399C30.369 25.1016 31.1086 24.5336 31.8543 23.8777C33.3462 22.5653 33.6461 22.3017 35.4359 20.7293C36.1082 20.1388 36.6831 19.6313 36.7137 19.6017C37.5681 18.7742 38.0857 18.6551 38.6132 19.1642L38.9383 19.478V34.5138L39.1856 34.6809C39.6343 34.9843 41.2534 34.9022 43.195 34.4775C44.1268 34.2737 45.2896 34.0291 45.779 33.9339C46.2927 33.8341 46.7276 33.687 46.8079 33.5861C47.0172 33.3228 47.0109 5.87708 46.8014 5.6005C46.6822 5.4431 46.2851 5.37063 44.605 5.1996C43.477 5.08482 42.2972 5.00505 41.983 5.02223L41.4121 5.05368L35.4898 10.261C27.3144 17.4495 27.7989 17.0418 27.5372 16.9533C27.4148 16.912 26.1045 16.8746 24.6253 16.8702C22.0674 16.8626 21.9233 16.8513 21.6777 16.6396C21.0693 16.115 17.2912 12.8028 14.5726 10.4108C12.9548 8.98729 10.9055 7.18761 10.0186 6.41134L8.40584 5L7.5715 5.01331C7.11256 5.02072 5.95198 5.11252 4.99239 5.21742Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M25.572 37.9556C25.3176 38.3822 24.6815 38.3822 24.427 37.9556L23.4728 36.3558C23.2184 35.9292 23.5364 35.396 24.0453 35.396H25.9537C26.4626 35.396 26.7807 35.9292 26.5262 36.3558L25.572 37.9556Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M3 37.3157C3 36.9034 3.3453 36.5691 3.77126 36.5691H14.3485C14.7745 36.5691 15.1198 36.9034 15.1198 37.3157C15.1198 37.728 14.7745 38.0623 14.3485 38.0623H3.77126C3.3453 38.0623 3 37.728 3 37.3157Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M3.58851 44.5029C3.44604 44.1144 3.65596 43.6876 4.05738 43.5497L14.0254 40.1251C14.4269 39.9872 14.8678 40.1904 15.0102 40.5789C15.1527 40.9675 14.9428 41.3943 14.5414 41.5322L4.57331 44.9568C4.17189 45.0947 3.73098 44.8915 3.58851 44.5029Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M47 37.3157C47 36.9034 46.6547 36.5691 46.2287 36.5691H35.6515C35.2255 36.5691 34.8802 36.9034 34.8802 37.3157C34.8802 37.728 35.2255 38.0623 35.6515 38.0623H46.2287C46.6547 38.0623 47 37.728 47 37.3157Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M46.4115 44.5029C46.554 44.1144 46.344 43.6876 45.9426 43.5497L35.9746 40.1251C35.5731 39.9872 35.1322 40.1904 34.9898 40.5789C34.8473 40.9675 35.0572 41.3943 35.4586 41.5322L45.4267 44.9568C45.8281 45.0947 46.269 44.8915 46.4115 44.5029Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "Streisand": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M25 46L24.2602 47.0076C24.7027 47.3325 25.3054 47.3306 25.7459 47.0031L25 46ZM6.14773 32.1591H4.89773C4.89773 32.557 5.0872 32.9312 5.40797 33.1667L6.14773 32.1591ZM43.6136 32.1591L44.3595 33.1622C44.6767 32.9263 44.8636 32.5543 44.8636 32.1591H43.6136ZM6.14773 19.9886L5.42485 18.9689C5.09421 19.2032 4.89773 19.5834 4.89773 19.9886H6.14773ZM25 6.625L25.729 5.6096L25.0046 5.08952L24.2771 5.60522L25 6.625ZM43.6136 19.9886H44.8636C44.8636 19.586 44.6697 19.208 44.3426 18.9732L43.6136 19.9886ZM3.25 38.5568C2.69772 38.971 2.58579 39.7545 3 40.3068C3.41421 40.8591 4.19772 40.971 4.75 40.5568L4 39.5568L3.25 38.5568ZM13.3409 34.1136C13.8932 33.6994 14.0051 32.9159 13.5909 32.3636C13.1767 31.8114 12.3932 31.6994 11.8409 32.1136L12.5909 33.1136L13.3409 34.1136ZM8.97727 42.8523C8.42499 43.2665 8.31306 44.05 8.72727 44.6023C9.14149 45.1546 9.92499 45.2665 10.4773 44.8523L9.72727 43.8523L8.97727 42.8523ZM19.0682 38.4091C19.6205 37.9949 19.7324 37.2114 19.3182 36.6591C18.904 36.1068 18.1205 35.9949 17.5682 36.4091L18.3182 37.4091L19.0682 38.4091ZM45.25 40.5568C45.8023 40.971 46.5858 40.8591 47 40.3068C47.4142 39.7545 47.3023 38.971 46.75 38.5568L46 39.5568L45.25 40.5568ZM38.1591 32.1136C37.6068 31.6994 36.8233 31.8114 36.4091 32.3636C35.9949 32.9159 36.1068 33.6994 36.6591 34.1136L37.4091 33.1136L38.1591 32.1136ZM39.5227 44.8523C40.075 45.2665 40.8585 45.1546 41.2727 44.6023C41.6869 44.05 41.575 43.2665 41.0227 42.8523L40.2727 43.8523L39.5227 44.8523ZM32.4318 36.4091C31.8795 35.9949 31.096 36.1068 30.6818 36.6591C30.2676 37.2114 30.3795 37.9949 30.9318 38.4091L31.6818 37.4091L32.4318 36.4091ZM46.2727 9.29545C46.825 8.88124 46.9369 8.09774 46.5227 7.54545C46.1085 6.99317 45.325 6.88124 44.7727 7.29545L45.5227 8.29545L46.2727 9.29545ZM36.1818 13.7386C35.6295 14.1528 35.5176 14.9364 35.9318 15.4886C36.346 16.0409 37.1295 16.1528 37.6818 15.7386L36.9318 14.7386L36.1818 13.7386ZM40.5455 5C41.0977 4.58579 41.2097 3.80228 40.7955 3.25C40.3812 2.69772 39.5977 2.58579 39.0455 3L39.7955 4L40.5455 5ZM30.4545 9.44318C29.9023 9.8574 29.7903 10.6409 30.2045 11.1932C30.6188 11.7455 31.4023 11.8574 31.9545 11.4432L31.2045 10.4432L30.4545 9.44318ZM5.70455 7.29545C5.15226 6.88124 4.36876 6.99317 3.95455 7.54545C3.54033 8.09774 3.65226 8.88124 4.20455 9.29545L4.95455 8.29545L5.70455 7.29545ZM12.7955 15.7386C13.3477 16.1528 14.1312 16.0409 14.5455 15.4886C14.9597 14.9364 14.8477 14.1528 14.2955 13.7386L13.5455 14.7386L12.7955 15.7386ZM11.4318 3C10.8795 2.58579 10.096 2.69772 9.68182 3.25C9.2676 3.80228 9.37953 4.58579 9.93182 5L10.6818 4L11.4318 3ZM18.5227 11.4432C19.075 11.8574 19.8585 11.7455 20.2727 11.1932C20.6869 10.6409 20.575 9.8574 20.0227 9.44318L19.2727 10.4432L18.5227 11.4432ZM25 46L25.7398 44.9924L6.88748 31.1515L6.14773 32.1591L5.40797 33.1667L24.2602 47.0076L25 46ZM43.6136 32.1591L42.8678 31.156L24.2541 44.9969L25 46L25.7459 47.0031L44.3595 33.1622L43.6136 32.1591ZM25 33.8295L25.7398 32.8219L6.88748 18.981L6.14773 19.9886L5.40797 20.9962L24.2602 34.8371L25 33.8295ZM6.14773 19.9886L6.87061 21.0084L25.7229 7.64478L25 6.625L24.2771 5.60522L5.42485 18.9689L6.14773 19.9886ZM25 6.625L24.271 7.6404L42.8846 21.004L43.6136 19.9886L44.3426 18.9732L25.729 5.6096L25 6.625ZM43.6136 19.9886L42.8678 18.9856L24.2541 32.8265L25 33.8295L25.7459 34.8326L44.3595 20.9917L43.6136 19.9886ZM43.6136 32.1591H44.8636V19.9886H43.6136H42.3636V32.1591H43.6136ZM25 33.8295H23.75V46H25H26.25V33.8295H25ZM6.14773 32.1591H7.39773V19.9886H6.14773H4.89773V32.1591H6.14773ZM4 39.5568L4.75 40.5568L13.3409 34.1136L12.5909 33.1136L11.8409 32.1136L3.25 38.5568L4 39.5568ZM9.72727 43.8523L10.4773 44.8523L19.0682 38.4091L18.3182 37.4091L17.5682 36.4091L8.97727 42.8523L9.72727 43.8523ZM46 39.5568L46.75 38.5568L38.1591 32.1136L37.4091 33.1136L36.6591 34.1136L45.25 40.5568L46 39.5568ZM40.2727 43.8523L41.0227 42.8523L32.4318 36.4091L31.6818 37.4091L30.9318 38.4091L39.5227 44.8523L40.2727 43.8523ZM45.5227 8.29545L44.7727 7.29545L36.1818 13.7386L36.9318 14.7386L37.6818 15.7386L46.2727 9.29545L45.5227 8.29545ZM39.7955 4L39.0455 3L30.4545 9.44318L31.2045 10.4432L31.9545 11.4432L40.5455 5L39.7955 4ZM4.95455 8.29545L4.20455 9.29545L12.7955 15.7386L13.5455 14.7386L14.2955 13.7386L5.70455 7.29545L4.95455 8.29545ZM10.6818 4L9.93182 5L18.5227 11.4432L19.2727 10.4432L20.0227 9.44318L11.4318 3L10.6818 4Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "ClashVerge": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M30.9988 13.4144C27.2973 12.0435 23.5958 11.9064 19.0716 13.4144C14.1362 10.6726 10.846 4.36632 7.967 5.05171C5.08802 5.7371 5.91058 16.8418 5.91058 24.2448C4.26545 26.4384 3.64225 29.205 4.12911 31.7851C7.69353 48.9219 40.8711 49.8816 45.8057 31.7851C46.6656 28.6319 44.8461 25.0674 44.1599 24.2448C44.1599 16.7047 44.9825 5.20727 42.2406 5.05168C38.539 4.84163 35.523 10.8096 30.9988 13.4144Z\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2.5\\"/>\\n<path d=\\"M27.9837 34.1749C27.9836 33.078 21.5403 33.0711 21.5403 34.1749C21.5403 35.8199 24.6933 37.328 24.6933 37.328C24.6933 37.328 27.9838 35.8822 27.9837 34.1749Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M17.8383 25.5362C16.6044 24.5766 13.3656 23.754 12.0803 25.8105C10.9382 27.6378 12.4017 29.8157 14.2738 30.8829C16.1459 31.95 20.0317 31.2941 20.0317 29.649C20.0317 28.004 19.0721 26.4957 17.8383 25.5362Z\\" fill=\\"#FAFAFA\\"/>\\n<path d=\\"M31.8219 25.4405C33.0557 24.4809 36.2945 23.6583 37.5799 25.7148C38.722 27.5421 37.2584 29.72 35.3863 30.7872C33.5142 31.8543 29.6285 31.1984 29.6285 29.5533C29.6285 27.9083 30.588 26.4 31.8219 25.4405Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "KoalaClash": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M9.89914 12.0988C8.76625 12.3109 7.40023 12.9154 6.4671 13.6175C4.88097 14.8109 3.43945 16.9431 3.43945 18.0958C3.43945 18.5921 3.7749 18.897 4.32087 18.897C4.54535 18.897 4.56025 18.9067 4.52245 19.0284C4.49995 19.1006 4.4677 19.5801 4.45075 20.0939C4.42358 20.9148 4.43504 21.0917 4.54506 21.5535C4.77726 22.5281 5.36121 23.5213 6.10823 24.2123C7.0261 25.0612 8.09752 25.5287 9.47582 25.6819C10.0706 25.748 10.1056 25.7591 10.0711 25.8713C9.98977 26.1363 9.96722 28.7692 10.0409 29.3936C10.2707 31.3407 11.0434 33.2014 12.3129 34.8649C12.9693 35.7251 14.245 36.9013 15.2422 37.5658C17.8436 39.2992 21.8949 40.176 26.3591 39.9715C28.2677 39.8841 29.5744 39.695 31.0475 39.2929C34.981 38.2194 38.1435 35.3868 39.367 31.8411C39.8477 30.4483 39.9953 29.291 39.9344 27.3918C39.9128 26.7175 39.8806 26.0712 39.8628 25.9556L39.8304 25.7456L40.3178 25.705C42.8281 25.496 44.777 23.973 45.4062 21.7286C45.5595 21.1815 45.6046 19.9667 45.4944 19.3495L45.4136 18.897L45.6511 18.8969C46.1008 18.8968 46.5605 18.518 46.5605 18.1477C46.5605 17.6975 46.2365 16.8334 45.8015 16.1238C43.7587 12.7907 39.7682 11.1824 36.59 12.4113C36.027 12.6289 35.3838 13.0062 34.6993 13.5202C34.1087 13.9638 32.7678 15.2974 32.479 15.7285C32.3378 15.9393 32.2474 16.0228 32.1869 15.9983C31.0329 15.5301 28.8717 15.0268 27.045 14.8008C26.2485 14.7023 23.7063 14.701 22.8673 14.7988C21.2192 14.9908 19.7141 15.3186 18.4414 15.7624L17.6965 16.0221L17.4227 15.6351C17.0693 15.1358 15.9297 13.9978 15.3287 13.5442C14.4248 12.8621 13.614 12.4273 12.7882 12.1822C12.211 12.0108 10.6148 11.9648 9.89914 12.0988ZM25.8049 24.9694C26.7666 25.3068 27.3845 26.0745 27.8608 27.5239C28.5272 29.5517 28.8276 32.0738 28.5196 33.055C28.3591 33.5664 28.1983 33.8307 27.8071 34.2255C27.4325 34.6037 26.8449 34.9031 26.1978 35.0456C25.5992 35.1774 24.3828 35.1807 23.793 35.0522C22.0734 34.6774 21.2382 33.507 21.3472 31.6246C21.4385 30.0455 21.9862 27.7393 22.5465 26.5745C22.931 25.775 23.553 25.1993 24.2849 24.9655C24.7443 24.8187 25.3799 24.8204 25.8049 24.9694Z\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2.5\\" stroke-linejoin=\\"round\\"/>\\n<ellipse cx=\\"17.2999\\" cy=\\"27.0342\\" rx=\\"1.54004\\" ry=\\"1.54004\\" fill=\\"#FAFAFA\\"/>\\n<ellipse cx=\\"32.9243\\" cy=\\"27.0342\\" rx=\\"1.54004\\" ry=\\"1.54004\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "PandoraBox": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path fill-rule=\\"evenodd\\" clip-rule=\\"evenodd\\" d=\\"M7.04551 12.0456C17.0338 12.0456 27.1487 10.81 27.402 21.2051C27.402 31.1282 16.7823 29.9842 10.8396 29.9841V35.7085H28.7941L34.9881 27.8223L27.7822 18.1526H31.8277L37.1387 25.0228L42.4475 18.1526H46.2416L39.1604 27.8223L45.2297 35.7085H47V38H42.701L36.8852 30.3667L31.0693 38H3V35.7085H7.04551V12.0456ZM23.7367 20.9521C23.7367 14.464 16.9084 15.3531 10.8396 15.3531V26.6766C17.1611 26.5494 23.7362 27.6939 23.7367 20.9521Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "PrizrakBox": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M13.866 16.8181C18.8416 13.0077 17.7292 3.8174 25.4893 3.27965C35.4666 2.58824 33.4174 14.1614 38.9603 20.0418C41.3708 22.5989 45.1415 19.1332 48.1313 24.3428C48.8491 25.5936 47.2497 26.415 46.754 27.7693C46.4345 28.642 46.9019 29.893 45.9813 30.0201C45.2892 30.1156 45.1991 28.9508 44.5032 29.0123C43.5681 29.0948 43.7075 30.266 43.4282 31.1622C43.1444 32.0727 43.7413 32.8822 43.0923 33.581C42.5389 34.1768 41.8738 33.9395 41.1102 34.2193C40.1058 34.5872 39.6561 35.3909 38.5907 35.2942C36.004 35.8989 37.3478 31.9659 36.004 32.9091C35.0254 33.2737 35.1482 34.3116 34.7947 35.2942C34.3164 36.6236 34.6045 37.5153 34.1564 38.8552C33.8027 39.9127 33.8019 40.7258 32.947 41.4419C31.8803 42.3353 30.6937 41.3861 29.4197 41.9458C28.2641 42.4534 28.0354 43.4513 26.8666 43.9278C25.6336 44.4304 24.7775 43.9936 23.4737 44.2637C21.8948 44.5908 22.2643 47.251 17.662 47.251C12.623 47.251 13.9762 43.8047 11.4136 43.0879C9.29628 42.4957 6.72214 43.7417 4.79568 42.6823C2.57851 41.0698 3.73618 39.2893 3.25038 38.651C3.04583 38.3823 2.78007 38.1471 1.36914 37.9456C2.14179 37.0722 3.7478 36.9276 4.62771 37.4753C5.69493 38.1395 4.87296 39.4856 5.80348 40.3307C7.27871 41.6706 9.20527 40.9045 10.6745 39.5581C11.8745 38.4584 12.5426 37.3203 11.7495 35.8989C11.1167 34.7647 9.00651 35.3029 8.08784 34.3847C14.0675 33.7464 15.4784 28.7771 15.4784 28.7771C15.4784 28.7771 13.2258 32.0615 11.7495 31.1622C10.7424 30.5488 11.531 29.1511 10.6745 28.3404C9.20206 26.9466 6.81252 30.3234 5.50114 28.7771C4.37848 27.4533 6.54224 25.9134 5.80348 24.3428C5.13202 22.9152 2.64569 23.2988 2.64569 21.8233C3.25038 17.5543 9.52468 20.1427 13.866 16.8181Z\\" stroke=\\"#FAFAFA\\" stroke-linejoin=\\"round\\"/>\\n<path d=\\"M25.4541 2.78125C28.0529 2.60116 29.9301 3.21932 31.3438 4.39551C32.7382 5.55579 33.6286 7.21628 34.3516 9.00977C34.7142 9.90935 35.0409 10.8584 35.3662 11.8096C35.693 12.7651 36.0188 13.7246 36.3857 14.6631C37.1201 16.5414 38.0035 18.2981 39.3242 19.6992C39.8304 20.236 40.4048 20.4623 41.0674 20.5664C41.4056 20.6195 41.7639 20.6401 42.1504 20.6533C42.5275 20.6662 42.9464 20.6715 43.3604 20.6982C44.202 20.7526 45.1135 20.8959 46.0176 21.3945C46.9248 21.8949 47.7813 22.7292 48.5645 24.0938C48.6817 24.2983 48.6403 24.5573 48.4648 24.7148C48.2893 24.872 48.0275 24.8856 47.8369 24.7471C47.5075 24.5076 46.8867 24.2386 46.1533 24.2656C45.4411 24.292 44.5805 24.5989 43.7393 25.5742C43.6218 25.7099 43.4398 25.7721 43.2637 25.7373C43.0876 25.7023 42.9436 25.5756 42.8867 25.4053C42.7574 25.0172 42.6295 24.9378 42.6035 24.9258C42.5931 24.921 42.5381 24.8982 42.3857 24.9805C42.2337 25.0628 42.0604 25.2126 41.8916 25.3994C41.7266 25.5821 41.5873 25.775 41.501 25.9141C41.0537 26.6349 40.7456 27.5631 40.6553 28.4502C40.5638 29.3504 40.7037 30.1226 41.0459 30.5996C41.1532 30.7493 41.17 30.946 41.0889 31.1113C40.5681 32.1725 39.6992 32.6125 38.8975 32.71C38.505 32.7576 38.1286 32.7239 37.8135 32.6475C37.5117 32.5742 37.2147 32.4498 37.0156 32.2734C36.6021 31.9071 36.3478 31.2654 36.1699 30.6143C36.0173 30.0555 35.9026 29.4091 35.8096 28.7471C35.7477 29.0531 35.6816 29.3584 35.6055 29.6572C35.3571 30.6318 35.0245 31.5732 34.5801 32.3379C34.1387 33.097 33.5539 33.7378 32.7793 34.0156C31.2052 34.5801 29.9652 34.7362 29.2109 34.9209C28.8168 35.0174 28.5692 35.1152 28.3975 35.2461C28.2426 35.3643 28.1122 35.5384 28.0186 35.8662C27.8756 36.3677 27.9893 36.7535 28.1836 37.0469C28.3893 37.3573 28.6903 37.5682 28.8887 37.6592C29.1387 37.7738 29.2488 38.0687 29.1357 38.3193C28.8991 38.8435 28.4028 39.5828 27.6582 40.1572C26.9034 40.7393 25.8764 41.1632 24.6162 40.9941C21.7055 40.6035 20.0659 38.5441 19.6963 38.29C19.5202 38.1691 19.1741 38.0434 18.7168 37.998C18.2694 37.9537 17.7612 37.9917 17.2822 38.1514C16.8822 38.2848 16.3164 38.5919 15.877 39.0205C15.4365 39.4503 15.1844 39.9373 15.2363 40.4482C15.267 40.7477 15.4827 40.8907 15.8115 41.1934C15.8788 41.2553 15.9759 41.3489 16.0469 41.4658C16.126 41.5965 16.1956 41.7966 16.126 42.0273C16.0641 42.2317 15.9188 42.3677 15.8008 42.4541C15.6766 42.5449 15.5197 42.6266 15.3418 42.7041C14.2372 43.1853 13.2777 42.9902 12.6143 42.5156C12.2916 42.2848 12.0425 41.991 11.8828 41.6875C11.8257 41.5789 11.7762 41.462 11.7402 41.3418C11.6474 41.3402 11.5514 41.3363 11.4561 41.3252C11.14 41.2884 10.777 41.1931 10.4551 40.9961C10.1256 40.7943 9.83413 40.4809 9.70312 40.0283C9.57444 39.5832 9.61853 39.064 9.83594 38.4775C9.94067 38.1952 10.0685 37.9331 10.1846 37.7002C10.3046 37.4592 10.4073 37.2569 10.4883 37.0605C10.6464 36.6771 10.672 36.4231 10.5566 36.1729C10.3906 35.8132 10.1087 35.6923 9.57227 35.5625C9.07873 35.4431 8.31544 35.3189 7.73438 34.7383C7.59826 34.6022 7.55234 34.3993 7.61621 34.2178C7.68035 34.0366 7.84313 33.9084 8.03418 33.8877C10.4546 33.6293 12.071 32.6277 13.1338 31.5723C12.9823 31.5689 12.8348 31.4985 12.7402 31.3691C12.5965 31.1723 12.6163 30.9003 12.7861 30.7256C13.0237 30.482 13.2482 30.0241 13.3945 29.4189C13.5378 28.8261 13.5921 28.1476 13.5361 27.5166C13.4794 26.8784 13.3142 26.3344 13.0605 25.9727C12.8399 25.6581 12.5568 25.4822 12.168 25.4775C12.0747 25.5293 12.0244 25.5852 11.9834 25.6611C11.9165 25.7853 11.8574 25.9934 11.8086 26.3838C11.7751 26.6498 11.5378 26.8429 11.2705 26.8203C10.5726 26.7613 10.0555 26.5159 9.68945 26.1133C9.33845 25.727 9.17133 25.2437 9.06445 24.8018C9.01046 24.5783 8.96888 24.3487 8.92969 24.1348C8.8896 23.9159 8.85161 23.7122 8.80566 23.5176C8.71262 23.1235 8.59662 22.8282 8.41504 22.6182C8.20285 22.3728 7.80262 22.072 7.27832 21.7959C6.76115 21.5236 6.15884 21.2943 5.56836 21.1729C4.97213 21.0503 4.42631 21.0452 4 21.1777C3.59588 21.3035 3.28628 21.5538 3.11133 22.0039C3.01925 22.2402 2.76497 22.3706 2.51953 22.3066C2.27409 22.2424 2.11504 22.0041 2.15039 21.7529C2.32374 20.5295 2.92447 19.7555 3.80176 19.2705C4.63452 18.8103 5.69956 18.6218 6.78613 18.4717C9.0274 18.1621 11.5201 17.984 13.5615 16.4209C14.7208 15.5331 15.5431 14.3184 16.2441 12.9434C16.5943 12.2565 16.9112 11.537 17.2246 10.8047C17.5361 10.0771 17.8474 9.32991 18.1797 8.61133C18.8438 7.17527 19.6203 5.78484 20.7568 4.7207C21.9079 3.6431 23.4033 2.92352 25.4541 2.78125ZM26.0117 17.0078C25.0735 17.0081 24.3135 18.3545 24.3135 20.0156C24.3135 21.6766 25.0736 23.0231 26.0117 23.0234C26.95 23.0234 27.7109 21.6768 27.7109 20.0156C27.7109 18.3543 26.95 17.0078 26.0117 17.0078ZM23.3418 8.24023C22.0748 8.08413 20.822 9.78867 20.543 12.0479C20.264 14.3072 21.065 16.2654 22.332 16.4219C23.599 16.578 24.8518 14.8734 25.1309 12.6143C25.4099 10.3549 24.6089 8.39674 23.3418 8.24023ZM28.668 8.24023C27.4012 8.39718 26.6009 10.3552 26.8799 12.6143C27.1589 14.8735 28.4117 16.5781 29.6787 16.4219C30.9458 16.2654 31.7468 14.3072 31.4678 12.0479C31.1887 9.78844 29.9351 8.08373 28.668 8.24023Z\\" fill=\\"#FAFAFA\\"/>\\n</svg>\\n", "DownloadIcon": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n          0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n          stroke-linejoin=\\"round\\"><path\\n          stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M4 17v2a2 2 0 0 0\\n          2 2h12a2 2 0 0 0 2 -2v-2\\" /><path d=\\"M7 11l5 5l5 -5\\" /><path d=\\"M12 4l0\\n          12\\" /></svg>", "ExternalLink": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\"\\n            viewBox=\\"0 0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\"\\n            stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"><path stroke=\\"none\\" d=\\"M0\\n            0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M12 6h-6a2 2 0 0 0 -2 2v10a2 2 0 0 0\\n            2 2h10a2 2 0 0 0 2 -2v-6\\" /><path d=\\"M11 13l9 -9\\" /><path d=\\"M15 4h5v5\\"\\n            /></svg>", "Shadowrocket": "<svg width=\\"50\\" height=\\"50\\" viewBox=\\"0 0 50 50\\" fill=\\"none\\" xmlns=\\"http://www.w3.org/2000/svg\\">\\n<path d=\\"M21.2394 36.832L16.5386 39.568C16.5386 39.568 13.7182 36.832 11.8379 33.184C9.95756 29.536 16.5386 23.152 16.5386 23.152M21.2394 36.832H28.7606M21.2394 36.832C21.2394 36.832 15.5985 24.064 17.4788 16.768C19.3591 9.472 25 4 25 4C25 4 30.6409 9.472 32.5212 16.768C34.4015 24.064 28.7606 36.832 28.7606 36.832M28.7606 36.832L33.4614 39.568C33.4614 39.568 36.2818 36.832 38.1621 33.184C40.0424 29.536 33.4614 23.152 33.4614 23.152M25 46L26.8803 40.528H23.1197L25 46ZM25.9402 17.68C26.4594 18.1837 26.4594 19.0003 25.9402 19.504C25.4209 20.0077 24.5791 20.0077 24.0598 19.504C23.5406 19.0003 23.5406 18.1837 24.0598 17.68C24.5791 17.1763 25.4209 17.1763 25.9402 17.68Z\\" stroke=\\"#FAFAFA\\" stroke-width=\\"2.5\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\"/>\\n</svg>\\n", "CloudDownload": "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"24\\" height=\\"24\\" viewBox=\\"0\\n          0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\"\\n          stroke-linejoin=\\"round\\"><path\\n          stroke=\\"none\\" d=\\"M0 0h24v24H0z\\" fill=\\"none\\"/><path d=\\"M19 18a3.5 3.5 0 0\\n          0 0 -7h-1a5 4.5 0 0 0 -11 -2a4.6 4.4 0 0 0 -2.1 8.4\\" /><path d=\\"M12 13l0\\n          9\\" /><path d=\\"M9 19l3 3l3 -3\\" /></svg>"}, "baseSettings": {"metaTitle": "Join Mesh 🗽 CloudWEB", "metaDescription": "Subscription", "hideGetLinkButton": false, "showConnectionKeys": false}, "baseTranslations": {"name": {"en": "Username", "fa": "نام کاربری", "fr": "Nom d'utilisateur", "ru": "Имя пользователя", "zh": "用户名"}, "active": {"en": "Active", "fa": "فعال", "fr": "Actif", "ru": "Активна", "zh": "活跃"}, "status": {"en": "Status", "fa": "وضعیت", "fr": "Statut", "ru": "Статус", "zh": "状态"}, "expired": {"en": "Expired", "fa": "منقضی شده در", "fr": "Expiré", "ru": "Истекла", "zh": "已于"}, "expires": {"en": "Expires", "fa": "منقضی می‌شود", "fr": "Expire", "ru": "Истекает", "zh": "到期时间"}, "getLink": {"en": "Get Link", "fa": "دریافت لینک", "fr": "Obtenir le lien", "ru": "Получение ссылки", "zh": "获取链接"}, "unknown": {"en": "Unknown", "fa": "نامعلوم", "fr": "Inconnu", "ru": "Неизвестно", "zh": "未知"}, "copyLink": {"en": "Copy link", "fa": "کپی لینک", "fr": "Copier le lien", "ru": "Скопировать ссылку", "zh": "复制链接"}, "inactive": {"en": "Inactive", "fa": "غیرفعال", "fr": "Inactif", "ru": "Неактивна", "zh": "未激活"}, "bandwidth": {"en": "Bandwidth", "fa": "پهنای باند", "fr": "Bande passante", "ru": "Трафик", "zh": "流量"}, "expiresIn": {"en": "Expires", "fa": "منقضی می‌شود در", "fr": "Expire", "ru": "Истекает", "zh": "后到期"}, "linkCopied": {"en": "Link copied", "fa": "لینک کپی شد", "fr": "Lien copié", "ru": "Ссылка скопирована", "zh": "链接已复制"}, "scanQrCode": {"en": "Scan the QR code above in the client", "fa": "کد QR بالا را در کلاینت اسکن کنید", "fr": "Scannez le code QR ci-dessus dans le client", "ru": "Отсканируйте QR-код в приложении", "zh": "在客户端中扫描上方二维码"}, "indefinitely": {"en": "Indefinitely", "fa": "هیچوقت", "fr": "Indéfiniment", "ru": "Бессрочно", "zh": "永久"}, "scanToImport": {"en": "Scan to import this key", "fa": "برای وارد کردن این کلید اسکن کنید", "fr": "Scannez pour importer cette clé", "ru": "Отсканируйте QR-код для импорта ключа", "zh": "扫描以导入此密钥"}, "connectionKeysHeader": {"en": "Connection Keys", "fa": "کلیدهای اتصال", "fr": "Clés de connexion", "ru": "Ключи подключения", "zh": "连接密钥"}, "linkCopiedToClipboard": {"en": "Link copied to clipboard", "fa": "لینک به کلیپ‌بورد کپی شد", "fr": "Lien copié dans le presse-papiers", "ru": "Ссылка скопирована в буфер обмена", "zh": "链接已复制到剪贴板"}, "scanQrCodeDescription": {"en": "Easily add the subscription to any client. There's another option: copy the link below and paste it into the client", "fa": "افزودن آسان اشتراک به هر کلاینت. گزینه دیگری هم وجود دارد: لینک زیر را کپی کرده و در کلاینت جای‌گذاری کنید", "fr": "Ajoutez facilement l'abonnement à n'importe quel client. Il y a une autre option : copiez le lien ci-dessous et collez-le dans le client", "ru": "Простое добавление подписки в любой клиент. Есть и другой вариант: скопируйте ссылку ниже и вставьте в клиент.", "zh": "轻松将订阅添加到任何客户端。还有另一种选择：复制下面的链接并粘贴到客户端中"}, "installationGuideHeader": {"en": "Installation", "fa": "نصب", "fr": "Installation", "ru": "Установка", "zh": "安装"}}, "brandingSettings": {"title": "Join 🗽 Mesh", "logoUrl": "https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp", "supportUrl": "https://t.me/ProxyMeshCloudbot"}}	2026-05-15 01:34:59.113	2026-05-22 16:44:26.596
\.


--
-- Data for Name: subscription_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_settings (uuid, profile_title, support_link, profile_update_interval, happ_announce, happ_routing, created_at, updated_at, is_profile_webpage_url_enabled, serve_json_at_base_subscription, is_show_custom_remarks, custom_response_headers, randomize_hosts, response_rules, hwid_settings, custom_remarks) FROM stdin;
00000000-0000-0000-0000-000000000000	Mesh 🗽 NetWork	https://urlme.ru/CloudWEB	3	«Каждый имеет право свободно искать, получать, передавать, производить и распространять информацию любым законным способом.»\nСтатья 29, часть 4 Конституции РФ	\N	2026-05-15 01:34:58.96	2026-05-21 09:09:16.004	t	f	t	\N	f	{"rules": [{"name": "Browser Subscription", "enabled": true, "operator": "AND", "conditions": [{"value": "text/html", "operator": "CONTAINS", "headerName": "accept", "caseSensitive": true}], "description": "System critical: do not delete or disable this rule.", "responseType": "BROWSER"}, {"name": "Mihomo Clients", "enabled": true, "operator": "AND", "conditions": [{"value": "^(?:FlClash|FlClashX|Flowvy|[Cc]lash-[Vv]erge|[Kk]oala-[Cc]lash|[Cc]lash-?[Mm]eta|[Mm]urge|[Cc]lashX [Mm]eta|[Mm]ihomo|[Cc]lash-nyanpasu|clash.meta|prizrak-box)", "operator": "REGEX", "headerName": "user-agent", "caseSensitive": false}], "description": "Response with generated YAML config (Mihomo Template)", "responseType": "MIHOMO"}, {"name": "Stash (iOS, macOS)", "enabled": true, "operator": "AND", "conditions": [{"value": "^stash", "operator": "REGEX", "headerName": "user-agent", "caseSensitive": false}], "description": "Response with generated YAML config (Stash Template)", "responseType": "STASH"}, {"name": "Sing-box clients", "enabled": true, "operator": "AND", "conditions": [{"value": "^sfa|sfi|sfm|sft|karing|singbox", "operator": "REGEX", "headerName": "user-agent", "caseSensitive": false}], "description": "Resonse with generated JSON config (Singbox template)", "responseType": "SINGBOX"}, {"name": "Clash Core Clients", "enabled": true, "operator": "AND", "conditions": [{"value": "^clash", "operator": "REGEX", "headerName": "user-agent", "caseSensitive": false}], "description": "Response with generated YAML config (Clash Template)", "responseType": "CLASH"}, {"name": "Fallback Base64", "enabled": true, "operator": "AND", "conditions": [], "description": "System critical: do not delete or disable this rule.", "responseType": "XRAY_BASE64"}], "version": "1"}	{"enabled": true, "maxDevicesAnnounce": null, "fallbackDeviceLimit": 2}	{"emptyHosts": ["→ Remnawave", "→ No hosts found", "→ Check Hosts tab", "→ Check Internal Squads tab"], "expiredUsers": ["⌛ Subscription expired", "Contact support"], "limitedUsers": ["🚧 Subscription limited", "Contact support"], "disabledUsers": ["🚫 Subscription disabled", "Contact support"], "HWIDNotSupported": ["App not supported"], "HWIDMaxDevicesExceeded": ["Limit of devices reached"]}
\.


--
-- Data for Name: subscription_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_templates (uuid, template_type, template_yaml, template_json, created_at, updated_at, name, view_position) FROM stdin;
c87cb0d1-832d-4f4a-a234-3e07b5668add	MIHOMO	mixed-port: 7890\nsocks-port: 7891\nredir-port: 7892\nallow-lan: true\nmode: global\nlog-level: info\nexternal-controller: 127.0.0.1:9090\ndns:\n  enable: true\n  use-hosts: true\n  enhanced-mode: fake-ip\n  fake-ip-range: 198.18.0.1/16\n  default-nameserver:\n    - 1.1.1.1\n    - 8.8.8.8\n  nameserver:\n    - 1.1.1.1\n    - 8.8.8.8\n  fake-ip-filter:\n    - '*.lan'\n    - stun.*.*.*\n    - stun.*.*\n    - time.windows.com\n    - time.nist.gov\n    - time.apple.com\n    - time.asia.apple.com\n    - '*.openwrt.pool.ntp.org'\n    - pool.ntp.org\n    - ntp.ubuntu.com\n    - time1.apple.com\n    - time2.apple.com\n    - time3.apple.com\n    - time4.apple.com\n    - time5.apple.com\n    - time6.apple.com\n    - time7.apple.com\n    - time1.google.com\n    - time2.google.com\n    - time3.google.com\n    - time4.google.com\n    - api.joox.com\n    - joox.com\n    - '*.xiami.com'\n    - '*.msftconnecttest.com'\n    - '*.msftncsi.com'\n    - '+.xboxlive.com'\n    - '*.*.stun.playstation.net'\n    - xbox.*.*.microsoft.com\n    - '*.ipv6.microsoft.com'\n    - speedtest.cros.wr.pvp.net\n\nproxies: # LEAVE THIS LINE!\n\nproxy-groups:\n  - name: '→ Remnawave'\n    type: 'select'\n    proxies: # LEAVE THIS LINE!\n\nrules:\n  - MATCH,→ Remnawave\n	\N	2026-05-15 01:34:58.929	2026-05-15 01:34:58.929	Default	2
7f28c38d-909c-42a4-8b59-e8338f50e80a	STASH	proxy-groups:\n  - name: → Remnawave\n    type: select\n    proxies: # LEAVE THIS LINE!\n\nproxies: # LEAVE THIS LINE!\n\nrules:\n  - SCRIPT,quic,REJECT\n  - DOMAIN-SUFFIX,iphone-ld.apple.com,DIRECT\n  - DOMAIN-SUFFIX,lcdn-locator.apple.com,DIRECT\n  - DOMAIN-SUFFIX,lcdn-registration.apple.com,DIRECT\n  - DOMAIN-SUFFIX,push.apple.com,DIRECT\n  - PROCESS-NAME,v2ray,DIRECT\n  - PROCESS-NAME,Surge,DIRECT\n  - PROCESS-NAME,ss-local,DIRECT\n  - PROCESS-NAME,privoxy,DIRECT\n  - PROCESS-NAME,trojan,DIRECT\n  - PROCESS-NAME,trojan-go,DIRECT\n  - PROCESS-NAME,naive,DIRECT\n  - PROCESS-NAME,CloudflareWARP,DIRECT\n  - PROCESS-NAME,Cloudflare WARP,DIRECT\n  - IP-CIDR,162.159.193.0/24,DIRECT,no-resolve\n  - PROCESS-NAME,p4pclient,DIRECT\n  - PROCESS-NAME,Thunder,DIRECT\n  - PROCESS-NAME,DownloadService,DIRECT\n  - PROCESS-NAME,qbittorrent,DIRECT\n  - PROCESS-NAME,Transmission,DIRECT\n  - PROCESS-NAME,fdm,DIRECT\n  - PROCESS-NAME,aria2c,DIRECT\n  - PROCESS-NAME,Folx,DIRECT\n  - PROCESS-NAME,NetTransport,DIRECT\n  - PROCESS-NAME,uTorrent,DIRECT\n  - PROCESS-NAME,WebTorrent,DIRECT\n  - GEOIP,LAN,DIRECT\n  - MATCH,→ Remnawave\nscript:\n  shortcuts:\n    quic: network == 'udp' and dst_port == 443\ndns:\n  default-nameserver:\n    - 1.1.1.1\n    - 1.0.0.1\n  nameserver:\n    - 1.1.1.1\n    - 1.0.0.1\nlog-level: warning\nmode: rule\n\n	\N	2026-05-15 01:34:58.932	2026-05-15 01:34:58.931	Default	3
a12b164a-13d0-443b-8abe-062742158cde	CLASH	mixed-port: 7890\nsocks-port: 7891\nredir-port: 7892\nallow-lan: true\nmode: global\nlog-level: info\nexternal-controller: 127.0.0.1:9090\ndns:\n  enable: true\n  use-hosts: true\n  enhanced-mode: fake-ip\n  fake-ip-range: 198.18.0.1/16\n  default-nameserver:\n    - 1.1.1.1\n    - 8.8.8.8\n  nameserver:\n    - 1.1.1.1\n    - 8.8.8.8\n  fake-ip-filter:\n    - '*.lan'\n    - stun.*.*.*\n    - stun.*.*\n    - time.windows.com\n    - time.nist.gov\n    - time.apple.com\n    - time.asia.apple.com\n    - '*.openwrt.pool.ntp.org'\n    - pool.ntp.org\n    - ntp.ubuntu.com\n    - time1.apple.com\n    - time2.apple.com\n    - time3.apple.com\n    - time4.apple.com\n    - time5.apple.com\n    - time6.apple.com\n    - time7.apple.com\n    - time1.google.com\n    - time2.google.com\n    - time3.google.com\n    - time4.google.com\n    - api.joox.com\n    - joox.com\n    - '*.xiami.com'\n    - '*.msftconnecttest.com'\n    - '*.msftncsi.com'\n    - '+.xboxlive.com'\n    - '*.*.stun.playstation.net'\n    - xbox.*.*.microsoft.com\n    - '*.ipv6.microsoft.com'\n    - speedtest.cros.wr.pvp.net\n\nproxies: # LEAVE THIS LINE!\n\nproxy-groups:\n  - name: '→ Remnawave'\n    type: 'select'\n    proxies: # LEAVE THIS LINE!\n\nrules:\n  - MATCH,→ Remnawave	\N	2026-05-15 01:34:58.935	2026-05-15 01:34:58.935	Default	4
1deeae1b-4f1f-4b78-ab99-63fdb5488d51	SINGBOX	\N	{"dns": {"rules": [{"server": "remote", "query_type": ["A", "AAAA"]}, {"server": "local", "outbound": "any"}], "fakeip": {"enabled": true, "inet4_range": "198.18.0.0/15", "inet6_range": "fc00::/18"}, "servers": [{"tag": "cf-dns", "address": "tls://1.1.1.1"}, {"tag": "local", "detour": "direct", "address": "tcp://1.1.1.1", "strategy": "ipv4_only", "address_strategy": "prefer_ipv4"}, {"tag": "remote", "address": "fakeip"}], "independent_cache": true}, "log": {"level": "debug", "disabled": true, "timestamp": true}, "route": {"rules": [{"action": "sniff"}, {"mode": "or", "type": "logical", "rules": [{"protocol": "dns"}, {"port": 53}], "action": "hijack-dns"}, {"outbound": "direct", "ip_is_private": true}], "override_android_vpn": true, "auto_detect_interface": true}, "inbounds": [{"mtu": 9000, "tag": "tun-in", "type": "tun", "sniff": true, "stack": "mixed", "platform": {"http_proxy": {"server": "127.0.0.1", "enabled": true, "server_port": 2412}}, "auto_route": true, "strict_route": true, "inet4_address": "172.19.0.1/30", "inet6_address": "fdfe:dcba:9876::1/126", "interface_name": "tun125", "endpoint_independent_nat": true}, {"tag": "mixed-in", "type": "mixed", "sniff": true, "users": [], "listen": "127.0.0.1", "listen_port": 2412, "set_system_proxy": false}], "outbounds": [{"tag": "→ Remnawave", "type": "selector", "outbounds": null, "interrupt_exist_connections": true}, {"tag": "direct", "type": "direct"}], "experimental": {"clash_api": {"external_ui": "yacd", "default_mode": "rule", "external_controller": "127.0.0.1:9090", "external_ui_download_url": "https://github.com/MetaCubeX/Yacd-meta/archive/gh-pages.zip", "external_ui_download_detour": "direct"}, "cache_file": {"path": "remnawave.db", "enabled": true, "cache_id": "remnawave", "store_fakeip": true}}}	2026-05-15 01:34:58.937	2026-05-15 01:34:58.937	Default	5
dc0dfd5f-e5b5-40b1-a915-7658b74d2206	XRAY_JSON	\N	{"dns": {"servers": ["1.1.1.1", "1.0.0.1"], "queryStrategy": "UseIP"}, "routing": {"rules": [{"type": "field", "protocol": ["bittorrent"], "outboundTag": "direct"}], "domainMatcher": "hybrid", "domainStrategy": "IPIfNonMatch"}, "inbounds": [{"tag": "socks", "port": 10808, "listen": "127.0.0.1", "protocol": "socks", "settings": {"udp": true, "auth": "noauth"}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}}, {"tag": "http", "port": 10809, "listen": "127.0.0.1", "protocol": "http", "settings": {"allowTransparent": false}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}}], "outbounds": [{"tag": "direct", "protocol": "freedom"}, {"tag": "block", "protocol": "blackhole"}]}	2026-05-15 01:34:58.926	2026-05-23 19:23:52.783	Default	1
a3f48ed6-ca30-4c9a-aa20-402fbe72da8c	XRAY_JSON	\N	{"dns": {"servers": [{"address": "77.88.8.8", "domains": ["geosite:ru", "regexp:.*\\\\.ru$"], "skipFallback": true}, {"address": "https://1.1.1.1/dns-query", "domains": ["geosite:geolocation-!cn"]}, "https://1.1.1.1/dns-query"], "queryStrategy": "UseIPv4"}, "routing": {"rules": [{"type": "field", "protocol": ["bittorrent"], "outboundTag": "direct"}, {"ip": ["geoip:private"], "type": "field", "outboundTag": "direct"}, {"type": "field", "domain": ["1.1.1.1", "1.0.0.1", "dns.cloudflare.com"], "outboundTag": "proxy"}, {"type": "field", "domain": ["cloudflare.com", "cloudflareaccess.com", "cfargotunnel.com", "argotunnel.com", "cloudflaretunnel.net", "sberbank.ru", "sber.ru", "sberpay.ru", "sbrf.ru", "tinkoff.ru", "t-bank.ru", "raiffeisen.ru", "raiffeisenbank.ru", "vtb.ru", "vtbonline.ru", "alfabank.ru", "alfa.ru", "gazprombank.ru", "rshb.ru", "pochtabank.ru", "rosbank.ru", "uralsib.ru", "sovcombank.ru", "gosuslugi.ru", "mos.ru", "nalog.ru", "nalog.gov.ru", "pfr.gov.ru", "sfr.gov.ru", "cbr.ru", "government.ru", "kremlin.ru", "rkn.gov.ru", "mil.ru", "mvd.ru", "fsb.ru", "fas.gov.ru", "minzdrav.gov.ru", "edu.ru", "minobrnauki.gov.ru", "yandex.ru", "yandex.net", "ya.ru", "yastatic.net", "yandexcloud.net", "vk.com", "vk.me", "vkontakte.ru", "vk.ru", "userapi.com", "vk-cdn.net", "ok.ru", "odnoklassniki.ru", "mail.ru", "list.ru", "bk.ru", "max.ru", "inbox.ru", "myteam.mail.ru", "mcs.mail.ru", "avito.ru", "avito.st", "wildberries.ru", "wbx-ru.com", "wb.ru", "ozon.ru", "ozon.st", "dns-shop.ru", "dns-home.ru", "citilink.ru", "eldorado.ru", "mvideo.ru", "svyaznoy.ru", "beeline.ru", "megafon.ru", "mts.ru", "tele2.ru", "rostelecom.ru", "1c.ru", "1c-dn.com", "kaspersky.ru", "drweb.ru", "2gis.ru", "2gis.com", "hh.ru", "headhunter.ru", "superjob.ru", "ivi.ru", "okko.tv", "more.tv", "kion.ru", "kinopoisk.ru", "premier.one", "rutube.ru", "rbc.ru", "ria.ru", "tass.ru", "kommersant.ru", "iz.ru", "rt.com", "gazeta.ru", "lenta.ru", "fontanka.ru", "sbis.ru", "kontur.ru", "diadoc.ru", "mos-reg.ru", "goskey.ru", "epgu.ru", "pfdo.ru", "gosbar.ru", "gostech.ru", "gosteh.ru", "sbermarket.ru", "sbermegamarket.ru", "samokat.ru", "kuper.ru", "cdek.ru", "boxberry.ru", "pochta.ru"], "outboundTag": "direct"}, {"type": "field", "domain": ["claude.ai", "anthropic.com", "openai.com", "chatgpt.com", "api.openai.com", "auth.openai.com", "gemini.google.com", "aistudio.google.com", "deepmind.com", "grok.com", "x.ai", "mistral.ai", "perplexity.ai", "huggingface.co", "copilot.microsoft.com", "telegram.org", "t.me", "tg.dev", "cdn1.telegram.org", "cdn2.telegram.org", "cdn3.telegram.org", "cdn4.telegram.org", "cdn5.telegram.org", "dc1.cdn.telegram.org", "dc2.cdn.telegram.org", "instagram.com", "cdninstagram.com", "facebook.com", "fbcdn.net", "whatsapp.com", "whatsapp.net", "threads.net", "twitter.com", "x.com", "twimg.com", "t.co", "youtube.com", "youtu.be", "googlevideo.com", "ytimg.com", "yt3.ggpht.com", "gvt1.com", "gvt2.com", "ggpht.com", "reddit.com", "redd.it", "redditmedia.com", "redditstatic.com", "discord.com", "discordapp.com", "discordapp.net", "discord.gg", "discord.media", "tiktok.com", "tiktokcdn.com", "snapchat.com", "pinterest.com", "twitch.tv", "medium.com", "notion.so", "figma.com", "canva.com", "netflix.com", "nflxvideo.net", "spotify.com", "spotifycdn.com", "github.com", "githubusercontent.com", "githubassets.com", "npmjs.com", "signal.org", "protonmail.com", "proton.me", "wikimedia.org", "wikipedia.org", "archive.org", "web.archive.org", "apple.com", "itunes.apple.com", "apps.apple.com", "mzstatic.com", "icloud.com", "apple-cloudkit.com", "paypal.com", "stripe.com", "google.com", "googleapis.com", "googleusercontent.com", "google-analytics.com"], "outboundTag": "proxy"}, {"type": "field", "network": "tcp,udp", "outboundTag": "proxy"}], "domainMatcher": "hybrid", "domainStrategy": "IPIfNonMatch"}, "inbounds": [{"tag": "socks", "port": 10808, "listen": "127.0.0.1", "protocol": "socks", "settings": {"udp": true, "auth": "noauth"}, "sniffing": {"enabled": true, "routeOnly": true, "destOverride": ["http", "tls", "quic"]}}, {"tag": "http", "port": 10809, "listen": "127.0.0.1", "protocol": "http", "settings": {"allowTransparent": false}, "sniffing": {"enabled": true, "routeOnly": true, "destOverride": ["http", "tls", "quic"]}}], "outbounds": [{"tag": "proxy", "protocol": "vless", "settings": {}}, {"tag": "direct", "protocol": "freedom"}, {"tag": "block", "protocol": "blackhole"}]}	2026-05-23 12:24:45.134	2026-05-23 13:37:34.429	CloudWEB-RU-block	7
\.


--
-- Data for Name: torrent_blocker_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.torrent_blocker_reports (id, user_id, node_id, report, created_at) FROM stdin;
\.


--
-- Data for Name: user_meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_meta (user_id, metadata) FROM stdin;
\.


--
-- Data for Name: user_subscription_request_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_subscription_request_history (id, user_uuid, request_ip, user_agent, request_at) FROM stdin;
681	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.223.122	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:31:07.944
684	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.183.100	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:44:28.995
686	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.71.164.226	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 14:25:17.015
591	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.222.110	Happ/4.10.2/ios/2605221402666	2026-05-28 07:18:56.69
601	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.144.23	Happ/3.21.1/Android/17790979898951821678	2026-05-28 09:44:58.171
604	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	172.70.240.112	Happ/3.21.1/Android/17790979898951821678	2026-05-28 11:29:13.095
610	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.95.80	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 14:39:13.932
613	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.95.80	Happ/3.21.1/Android/17790979898951821678	2026-05-28 15:58:06.836
620	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.23	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:06:35.87
628	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.164.226	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:25:24.143
125	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.70.248.131	Happ/4.9.0/ios/2605051739563	2026-05-19 14:40:54.252
126	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.211	Happ/4.9.0/ios/2605051739563	2026-05-19 14:41:33.358
127	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.210	Happ/4.9.0/ios/2605051739563	2026-05-19 14:41:33.381
128	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.217.131	Happ/4.9.0/ios/2605051739563	2026-05-19 14:42:05.836
129	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.211	Happ/4.9.0/ios/2605051739563	2026-05-19 14:42:11.987
130	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.223.123	Happ/4.9.0/ios/2605051739563	2026-05-19 14:42:43.816
131	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.210	Happ/4.9.0/ios/2605051739563	2026-05-19 14:42:50.597
132	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.70.247.32	Happ/4.9.0/ios/2605051739563	2026-05-19 14:43:21.518
133	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.70.243.205	Happ/4.9.0/ios/2605051739563	2026-05-19 14:43:43.229
134	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.69.150.143	Happ/4.9.0/ios/2605051739563	2026-05-19 14:44:00.945
135	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.71.172.193	Happ/4.9.0/ios/2605051739563	2026-05-19 14:44:22.805
136	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.68.194.157	Happ/4.9.0/ios/2605051739563	2026-05-19 14:45:15.212
137	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.68.194.157	Happ/4.9.0/ios/2605051739563	2026-05-19 14:45:49.937
138	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.69.150.143	Happ/4.9.0/ios/2605051739563	2026-05-19 14:45:54.958
139	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.68.194.157	Happ/4.9.0/ios/2605051739563	2026-05-19 14:46:31.14
140	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.210	Happ/4.9.0/ios/2605051739563	2026-05-19 14:47:17.211
141	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.210	Happ/4.9.0/ios/2605051739563	2026-05-19 14:47:56.525
142	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.210	Happ/4.9.0/ios/2605051739563	2026-05-19 14:49:36.595
143	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.71.144.23	Happ/4.9.0/ios/2605051739563	2026-05-19 14:51:16.903
144	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.223.122	Happ/4.9.0/ios/2605051739563	2026-05-19 14:51:56.219
145	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.221.211	Happ/4.9.0/ios/2605051739563	2026-05-19 14:55:19.074
146	0638818d-b9e3-48a3-a62f-875b4a463a0a	104.23.217.130	Happ/4.9.0/ios/2605051739563	2026-05-19 14:57:04.053
147	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.69.192.186	Happ/4.9.0/ios/2605051739563	2026-05-19 15:08:59.071
157	0638818d-b9e3-48a3-a62f-875b4a463a0a	172.71.148.18	Happ/4.9.0/ios/2605051739663	2026-05-20 14:04:46.985
632	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.164.227	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:34:26.49
636	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.23	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 17:06:49.655
642	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.95.79	Happ/3.21.1/Android/17790979898951821678	2026-05-28 18:58:22.349
645	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.68.194.156	Happ/3.21.1/Android/17790979898951821678	2026-05-28 20:58:20.853
648	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.70.243.205	Happ/3.21.1/Android/17790979898951821678	2026-05-28 23:58:27.505
654	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.148.18	Happ/4.10.2/ios/2605221402566	2026-05-29 04:10:53.961
689	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.223.123	Happ/2.16.2/Windows/2605221224503	2026-05-29 15:12:13.552
225	53780d13-5737-4463-af47-ce48752f4a94	172.18.0.1	Happ/3.21.1/Android/17790979898951821678	2026-05-22 08:49:56.349
226	53780d13-5737-4463-af47-ce48752f4a94	172.18.0.1	Happ/3.21.1/Android/17790979898951821678	2026-05-22 08:58:36.389
657	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.68.194.156	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 06:49:12.111
233	53780d13-5737-4463-af47-ce48752f4a94	172.68.194.156	Happ/3.21.1/Android/17790979898951821678	2026-05-22 12:08:01.873
234	53780d13-5737-4463-af47-ce48752f4a94	172.71.148.19	Happ/3.21.1/Android/17790979898951821678	2026-05-22 12:08:01.894
663	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.69.155.221	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 08:02:17.534
241	515c5cab-bd05-4cf7-bafb-4438091434b6	104.23.239.88	Happ/3.21.1/Android/17790979898951821678	2026-05-22 15:44:42.551
668	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.70.248.132	Happ/3.21.1/Android/17790979898951821578	2026-05-29 10:03:14.873
669	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.144.22	Happ/3.21.1/Android/17790979898951821578	2026-05-29 10:03:28.414
672	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.70.247.31	Happ/3.21.1/Android/17790979898951821578	2026-05-29 12:00:02.512
676	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.71.164.226	Happ/3.21.1/Android/17790979898951821578	2026-05-29 13:03:52.673
679	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.221.132	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:27:52.352
433	53780d13-5737-4463-af47-ce48752f4a94	162.158.95.79	Happ/3.21.1/Android/17790979898951821578	2026-05-23 21:39:34.303
680	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.223.122	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:27:59.393
693	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.221.132	Happ/3.21.1/Android/17790979898951821578	2026-05-29 17:15:49.065
696	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.222.110	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:10:17.74
700	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	162.158.222.111	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:45:32.268
701	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.248.79	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:45:35.228
704	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.223.123	Happ/3.21.1/Android/17790979898951821578	2026-05-29 20:17:12.025
707	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.71.148.18	Happ/3.21.1/Android/17790979898951821578	2026-05-29 22:04:42.685
710	c217198d-b61a-4def-973f-63a8ea575e7b	172.69.50.135	Happ/4.10.2/ios/2605221402666	2026-05-30 03:46:51.569
715	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.183.100	Happ/3.21.1/Android/17790979898951821678	2026-05-30 05:10:11.934
718	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.95.80	Happ/3.21.1/Android/17790979898951821678	2026-05-30 06:47:54.627
721	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.223.123	Happ/3.21.1/Android/17790979898951821678	2026-05-30 08:10:36.448
724	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.70.240.113	Happ/3.21.1/Android/17790979898951821678	2026-05-30 09:51:10.64
728	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.71.148.18	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 10:10:01.893
682	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.223.122	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:31:19.835
576	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.183.99	Happ/3.21.1/Android/17790979898951821678	2026-05-28 05:24:09.359
685	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.183.100	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:44:35.465
687	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.141	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 14:32:48.527
690	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.243.205	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 15:27:51.134
592	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.222.110	Happ/4.10.2/ios/2605221402666	2026-05-28 08:02:55.101
596	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	172.69.151.172	Happ/3.21.1/Android/17790979898951821678	2026-05-28 08:28:21.004
608	c217198d-b61a-4def-973f-63a8ea575e7b	172.70.243.205	Happ/3.21.1/Android/17790979898951821678	2026-05-28 14:16:40.936
611	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.223.122	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 14:41:10.62
623	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.69.151.171	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:07:53.386
624	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.164.226	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:08:30.232
629	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	104.23.239.89	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:25:44.678
634	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.141	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:44:54.385
305	53780d13-5737-4463-af47-ce48752f4a94	172.64.198.81	Happ/3.21.1/Android/17790979898951821578	2026-05-23 10:38:15.405
306	53780d13-5737-4463-af47-ce48752f4a94	172.64.198.80	Happ/3.21.1/Android/17790979898951821578	2026-05-23 10:38:15.463
637	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.144.23	Happ/3.21.1/Android/17790979898951821678	2026-05-28 17:26:23.267
640	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.71.144.22	Happ/3.21.1/Android/17790979898951821678	2026-05-28 17:58:19.152
643	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.148.19	Happ/3.21.1/Android/17790979898951821678	2026-05-28 20:54:08.178
646	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.140	Happ/4.9.0/macos catalyst/2605051741520	2026-05-28 21:29:56.851
649	c217198d-b61a-4def-973f-63a8ea575e7b	172.70.248.79	Happ/3.21.1/Android/17790979898951821578	2026-05-29 00:56:55.289
652	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.70.248.79	Happ/3.21.1/Android/17790979898951821578	2026-05-29 02:58:49.12
655	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.183.99	Happ/3.21.1/Android/17790979898951821578	2026-05-29 05:11:58.561
658	c217198d-b61a-4def-973f-63a8ea575e7b	104.23.239.88	Happ/3.21.1/Android/17790979898951821578	2026-05-29 06:58:15.269
666	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.22.69.4	Happ/3.21.1/Android/17790979898951821578	2026-05-29 08:11:59.579
670	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.68.194.157	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 10:27:39.67
674	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	162.158.183.100	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 12:27:38.579
677	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.148.18	Happ/3.21.1/Android/17790979898951821578	2026-05-29 13:04:26.533
694	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.141	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 17:53:34.376
697	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.217.130	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:10:24.545
702	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.239.88	Happ/3.21.1/Android/17790979898951821578	2026-05-29 19:04:09.584
705	c217198d-b61a-4def-973f-63a8ea575e7b	172.69.151.171	Happ/3.21.1/Android/17790979898951821578	2026-05-29 20:44:42.361
708	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.144.23	Happ/3.21.1/Android/17790979898951821678	2026-05-30 00:47:27.484
711	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.71.148.18	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 04:05:43.852
716	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.70.248.79	Happ/3.21.1/Android/17790979898951821678	2026-05-30 05:42:07.909
719	1364078b-a5b8-4866-95c5-b9f5a8666e7c	104.23.217.131	Happ/3.21.1/Android/17790979898951821678	2026-05-30 06:51:07.287
722	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.70.240.112	Happ/3.21.1/Android/17790979898951821678	2026-05-30 08:43:07.269
725	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.221.133	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 10:09:57.803
727	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.23	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 10:10:01.849
729	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.141	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 10:23:55.164
731	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	172.71.164.227	Happ/3.21.1/Android/17790979898951821678	2026-05-30 11:10:51.133
733	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.70.240.113	Happ/3.21.1/Android/17790979898951821678	2026-05-30 11:47:02.831
735	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.240.112	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 13:16:32.403
737	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.148.19	Happ/3.21.1/Android/17790979898951821678	2026-05-30 13:52:28.714
739	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.221.132	Happ/3.21.1/Android/17790979898951821678	2026-05-30 15:00:04.904
741	1364078b-a5b8-4866-95c5-b9f5a8666e7c	104.23.221.133	Happ/3.21.1/Android/17790979898951821678	2026-05-30 16:02:22.678
744	c217198d-b61a-4def-973f-63a8ea575e7b	104.23.239.88	Happ/3.21.1/Android/17790979898951821678	2026-05-30 16:53:44.17
746	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.140	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 17:23:20.564
748	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.223.123	Happ/2.16.2/Windows/2605221224603	2026-05-30 18:02:42.607
750	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.221.132	Happ/2.16.2/Windows/2605221224603	2026-05-30 19:05:22.082
754	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.64.200.70	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 19:41:40.472
683	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.183.100	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:40:05.439
688	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.68.194.157	Happ/4.10.2/ios/2605221402566	2026-05-29 14:49:12.189
691	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.69.151.171	Happ/3.21.1/Android/17790979898951821578	2026-05-29 16:04:08.787
692	c217198d-b61a-4def-973f-63a8ea575e7b	172.71.148.19	Happ/3.21.1/Android/17790979898951821578	2026-05-29 16:04:28.14
695	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.71.144.22	Happ/3.21.1/Android/17790979898951821578	2026-05-29 18:00:54.001
698	217ce3e3-42e5-44a1-8733-5a235dbb09d0	104.23.217.130	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:16:07.899
699	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.64.209.65	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 18:16:14.777
703	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.221.132	Happ/2.16.2/Windows/2605221224503	2026-05-29 20:06:46.747
706	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.140	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 20:54:06.253
709	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.71.172.193	Happ/3.21.1/Android/17790979898951821678	2026-05-30 02:36:32.586
712	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.240.113	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 04:05:43.848
713	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.68.10.188	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 04:06:01.401
714	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.68.10.188	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 04:06:07.925
717	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.71.148.19	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 05:47:50.743
720	36ce2026-597f-43d7-8704-95ec02ff8a41	162.158.183.99	Happ/4.10.2/ios/2605221355612	2026-05-30 07:28:22.691
723	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.110.254	Happ/3.21.1/Android/17790979898951821678	2026-05-30 08:43:16.132
726	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	104.23.217.131	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 10:09:57.805
730	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.95.79	Happ/3.21.1/Android/17790979898951821678	2026-05-30 10:52:00.054
536	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.172.216	Happ/3.21.1/Android/17790979898951821578	2026-05-27 14:27:57.728
732	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.217.131	Happ/3.21.1/Android/17790979898951821678	2026-05-30 11:46:54.158
544	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.48.170	Happ/2.16.2/Windows/2605221224503	2026-05-27 19:55:13.022
545	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	172.71.218.110	Happ/3.21.1/Android/17790979898951821578	2026-05-27 20:32:37.721
546	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.179.78	Happ/3.21.1/Android/17790979898951821578	2026-05-27 20:32:46.45
734	1364078b-a5b8-4866-95c5-b9f5a8666e7c	104.23.239.89	Happ/3.21.1/Android/17790979898951821678	2026-05-30 13:02:11.658
736	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.70.247.31	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 13:16:32.441
738	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.221.133	Happ/3.21.1/Android/17790979898951821678	2026-05-30 14:15:25.902
740	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.110.254	Happ/3.21.1/Android/17790979898951821678	2026-05-30 15:00:13.871
742	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.69.151.171	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 16:20:11.052
743	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.22	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 16:20:11.197
745	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	104.23.223.122	Happ/3.21.1/Android/17790979898951821678	2026-05-30 17:16:16.654
747	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	162.158.110.254	Happ/3.21.1/Android/17790979898951821678	2026-05-30 18:01:13.064
749	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.69.151.172	Happ/3.21.1/Android/17790979898951821678	2026-05-30 19:02:31.367
751	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	104.23.221.132	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 19:41:33.907
752	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.172.91	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 19:41:33.933
753	217ce3e3-42e5-44a1-8733-5a235dbb09d0	162.158.172.90	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 19:41:40.469
755	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.140	Happ/4.9.0/macos catalyst/2605051741620	2026-05-30 20:35:47.589
590	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.102.218	Happ/4.10.2/ios/2605221402666	2026-05-28 07:18:17.293
597	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.102.218	Happ/4.10.2/ios/2605221402666	2026-05-28 08:34:10.21
598	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.102.218	Happ/4.10.2/ios/2605221402666	2026-05-28 08:34:10.585
599	c217198d-b61a-4def-973f-63a8ea575e7b	162.158.172.90	Happ/4.10.2/ios/2605221402666	2026-05-28 08:34:10.666
600	c217198d-b61a-4def-973f-63a8ea575e7b	172.69.155.221	Happ/4.10.2/ios/2605221402666	2026-05-28 08:34:10.752
609	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.48.171	Happ/3.21.1/Android/17790979898951821678	2026-05-28 14:29:20.082
612	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.68.194.157	Happ/3.21.1/Android/17790979898951821678	2026-05-28 14:58:09.915
621	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.247.31	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:06:37.184
625	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.70.248.79	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:08:31.86
627	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.23	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:09:13.591
631	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	172.71.144.22	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:28:03.722
635	dea17874-4b3b-46b1-9e54-e5d2eddb254c	162.158.151.140	Happ/4.9.0/macos catalyst/2605051741620	2026-05-28 16:52:59.182
638	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.48.171	Happ/3.21.1/Android/17790979898951821678	2026-05-28 17:30:29.59
641	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	162.158.48.171	Happ/2.16.2/Windows/2605221224603	2026-05-28 18:31:07.014
647	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.223.123	Happ/3.21.1/Android/17790979898951821678	2026-05-28 21:58:58.346
650	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.69.50.135	Happ/3.21.1/Android/17790979898951821578	2026-05-29 00:59:07.198
653	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	104.23.217.131	Happ/3.21.1/Android/17790979898951821578	2026-05-29 03:59:27.017
656	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.71.164.226	Happ/3.21.1/Android/17790979898951821578	2026-05-29 05:59:01.521
659	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	172.69.151.171	Happ/3.21.1/Android/17790979898951821578	2026-05-29 06:59:31.761
664	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	162.158.134.122	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 08:02:22.644
667	1364078b-a5b8-4866-95c5-b9f5a8666e7c	172.71.172.193	Happ/3.21.1/Android/17790979898951821578	2026-05-29 08:59:38.594
671	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	172.71.164.226	Happ/3.21.1/Android/17790979898951821578	2026-05-29 11:12:03.21
678	217ce3e3-42e5-44a1-8733-5a235dbb09d0	172.71.144.22	Happ/4.9.0/macos catalyst/2605051741520	2026-05-29 13:27:30.499
\.


--
-- Data for Name: user_traffic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_traffic (t_id, used_traffic_bytes, lifetime_used_traffic_bytes, online_at, last_connected_node_uuid, first_connected_at) FROM stdin;
4	0	0	\N	\N	\N
7	0	0	\N	\N	\N
8	0	0	\N	\N	\N
12	0	0	\N	\N	\N
10	2226407492	2226407492	2026-05-24 06:48:00.12	780aca89-03c4-4e8d-af79-c17c889341cb	2026-05-23 21:39:45.027
5	52888304	52888304	2026-05-29 15:54:00.106	780aca89-03c4-4e8d-af79-c17c889341cb	2026-05-17 12:24:00.096
17	0	0	\N	\N	\N
9	11019024	11019024	2026-05-30 18:03:45.046	9176215e-75da-4080-964c-bf91f2f58197	2026-05-30 07:28:45.048
15	11486161074	11486161074	2026-05-30 20:35:45.031	9176215e-75da-4080-964c-bf91f2f58197	2026-05-28 14:59:00.205
16	1132138188	1132138188	2026-05-30 20:03:30.114	a3de4fe1-da79-447a-b8a3-1552846c7441	2026-05-28 16:45:30.26
3	15377038870	15377038870	2026-05-28 17:25:00.13	a3de4fe1-da79-447a-b8a3-1552846c7441	2026-05-25 15:31:30.062
11	7868482679	7868482679	2026-05-30 20:37:00.096	780aca89-03c4-4e8d-af79-c17c889341cb	2026-05-22 08:02:45.208
2	36061834688	80780783080	2026-05-30 20:37:00.132	9176215e-75da-4080-964c-bf91f2f58197	2026-05-16 09:06:30.093
6	45217305958	45217305958	2026-05-30 20:22:45.072	780aca89-03c4-4e8d-af79-c17c889341cb	2026-05-19 08:29:15.061
14	8159854333	8159854333	2026-05-30 20:12:00.298	a3de4fe1-da79-447a-b8a3-1552846c7441	2026-05-26 13:01:30.081
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (uuid, short_uuid, username, status, traffic_limit_bytes, traffic_limit_strategy, expire_at, sub_revoked_at, last_traffic_reset_at, trojan_password, vless_uuid, ss_password, created_at, updated_at, description, email, telegram_id, hwid_device_limit, tag, last_triggered_threshold, t_id, external_squad_uuid) FROM stdin;
1ca699c0-0c89-4769-a227-39cc8fb91b7b	2qE2Y0E12QR46NReUDQ0_PGP	user_1448317647	ACTIVE	107374182400	MONTH	2026-06-20 06:03:36.13	\N	\N	u4EnM3FYTEUQEEaDeu6HUG6VXLswEUuc	d934a86b-56cf-43d3-8ef1-d974afca2902	n5E0RaA7aY16V0jqANxgmCcv4gcqfJzm	2026-05-17 12:00:50.214	2026-05-23 10:06:39.488	Bot user: Серж Добрый @Dobpblu_SERJ	\N	1448317647	2	TRIAL	0	4	\N
b7877eaa-67fe-4c7a-af31-cdbfa3f8a3cb	Kgqjef2Pf3-erbj9hmhgBT3V	user_5730145137	ACTIVE	53687091200	MONTH	2026-06-21 19:15:23.572	\N	\N	_ATZYovVW9ZG6Egwupa6SNarav1m5NNh	2370ec5a-8449-4564-a44c-98f9e6b5a60f	U6c-k2B92coFNs7kapcpC2ateTjnCYHe	2026-05-19 19:15:23.796	2026-05-23 10:06:39.589	Bot user: Наталия @natalisPax	\N	5730145137	2	TRIAL	0	7	\N
0638818d-b9e3-48a3-a62f-875b4a463a0a	aW6H3Jg67as2to3DMqjcZNJt	user_5213341082	ACTIVE	107374182400	MONTH	2026-05-31 09:00:00	\N	\N	ft1Dqr0XqmRuBJNHyFodjwVVjh5d8Rwb	d0913b1d-6441-4a46-8531-649a0b5582d6	kwA5gy--bqpcDjFQ6ZA3F7Pm4xc03add	2026-05-17 12:21:01.565	2026-05-23 10:06:39.717	Bot user: Серж @DobriySerj	\N	5213341082	3	\N	0	5	\N
ce95a655-9a6b-4669-8ed3-d9c07daf51c5	aQreKSgo6V0G6Nt-x2xhAAgP	user_5951923371	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	1bsue4QeEHZcc8r_NzM1VxTysj4P1Tzn	a28de28f-1c68-47bb-8a4a-25c8ae717c54	gTYguZYrwp_29fwgqQbpUXmavKcM5xMB	2026-05-17 07:27:08.599	2026-05-28 16:07:59.898	Bot user: Vision Illusion @AiControleBot	\N	5951923371	3	\N	0	3	\N
515c5cab-bd05-4cf7-bafb-4438091434b6	qWN7ty4tT_fGoNs0FjL4eVbs	user_1369958636	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	Wpsb8xfvyrFE9LR_26U_NLAy5ejJuG2S	9e950427-6898-45d3-99cc-a17b298ce37f	0GbXJ7_9eMRM0oqRCV6hG1erbhQBPTaN	2026-05-22 13:38:31.845	2026-05-25 14:46:22.801	Bot user: ТРИ КИТА Pacific Green @pacifictrikita	\N	1369958636	2	TRIAL	0	12	\N
c217198d-b61a-4def-973f-63a8ea575e7b	FfwPKCMfTwZvs0reA4jaJr94	user_1337226137	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	Nz01thBqRkoRy8xtK_86FwJ14Spc2FK1	79fe873d-c742-4fd3-86ee-f0bcf0c534a7	-8_pUGYUnZSLkWwMd_tPzMZNGFZHuAqJ	2026-05-21 16:20:02.79	2026-05-25 14:46:57.174	Bot user: Гранд Pacific Green @Pacificgrand	\N	1337226137	2	TRIAL	0	11	\N
53780d13-5737-4463-af47-ce48752f4a94	3SD7WNa_54gk3Wrn9TtkzJCV	user_1144744746	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	a9qWFsYs_st4o151BR_zTb30Hx1_dXS3	6a9de8fb-a8a3-485d-93e6-526a073be4ab	XAGz409F9Mrs_G_x20vK43fv4DVMetHL	2026-05-21 15:36:52.113	2026-05-25 14:47:24.647	Bot user: Andrey Dikov	\N	1144744746	2	TRIAL	0	10	\N
36ce2026-597f-43d7-8704-95ec02ff8a41	jqPK8W_KMprammFLHEzeXB-n	user_1389853920	ACTIVE	107374182400	MONTH	2027-05-31 09:00:00	\N	\N	JUFuqACnK6ZdqCf0YKK2rJqcc_h-W98V	f91e89b8-1105-4562-9bfa-c827b43cf639	_Abbh-Xad8ojZ_018ZjSpNou4FtMJnz0	2026-05-21 08:34:39.691	2026-05-25 14:47:59.367	Bot user: Its Me @LessTG	\N	1389853920	2	PAID	0	9	\N
a2d7491a-ec87-4f53-9cd1-c36b77018fba	505jGrhoqT7JbRbzeN7-W8G4	user_579783212	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	aBWUk2kmsP8UH27vRoDogz2PP7oJjVQ9	f2f5d5cc-5fa3-4181-b3ec-019f39fba003	Nv9hTLtQoYUsSC-LgrKRG7NgsR83GeqS	2026-05-21 08:19:04.26	2026-05-25 14:48:45.969	Bot user: Оксана Мартенкевич @pacificgreen	\N	579783212	2	TRIAL	0	8	\N
4e8760ef-b45f-42b1-ac85-70cf1856bdd7	7J3_UWPaogGgVLnGgjvbt3rZ	user_1065385609	ACTIVE	0	MONTH	2026-07-15 09:00:00	\N	\N	zgwQe6nqpjq53WYcmhPqZvcxq68_weV5	9a4499f8-48ef-4c62-8bcf-e021314fb71d	kyrKKjKNBgxgGk8eEkqM2v4cFoPt6oXY	2026-05-17 16:26:46.884	2026-05-25 14:49:20.232	Bot user: Sergey Emelyanenko @Sergey_arredocarisma	\N	1065385609	3	PAID	0	6	\N
1364078b-a5b8-4866-95c5-b9f5a8666e7c	HhMCVSYLa4ak_6V2A7YRDKsA	user_8449404239	ACTIVE	107374182400	MONTH	2026-06-30 13:31:40	\N	\N	uDJ3NHTEga5zbxBH07xhANZxq99FvxGo	21dd8f34-496e-46f8-b024-66504f5f376e	1ZyNR6PjaWTgr3szBZAWGALS6fjY2cef	2026-05-27 13:31:41.104	2026-05-28 16:13:00.795	Bot user: Виктория М	\N	8449404239	2	TRIAL	0	15	\N
217ce3e3-42e5-44a1-8733-5a235dbb09d0	zKKBbSgvANBzmP72m6KB0y0U	LuckyGUY	ACTIVE	0	MONTH	2100-12-26 09:59:00	\N	2026-05-24 02:26:47.256	WTfsvfFaX0WkkHwZ4uKsdT-j0G82N7wM	2ba17e27-d988-4b13-8f02-36c3185547e5	NyBRzsEg4femT3cD9JEtAt2sqeShuxn1	2026-05-16 09:03:53.016	2026-05-25 14:50:52.994	Bot user: Lucky GUY @MyTeleGO	aipostme@gmail.com	149054871	20	PAID	0	2	23fe3e60-3c12-48a0-bc09-e5b1488290fc
2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	UWyuNdLSouyshWDsQNW5Y7QX	user_5140550441	ACTIVE	107374182400	MONTH	2026-07-15 09:00:00	\N	\N	gHaqLDHZJnz6rq1xnksj1tUDhoSpro-T	2683cde9-21f3-4c6d-a5ec-eca982b9f44a	ZepJ1u0DbMPT37-SUE3-rReSHsybhDeR	2026-05-23 08:40:10.556	2026-05-26 08:04:59.921	Bot user: Влладимир	\N	5140550441	2	TRIAL	0	14	\N
dea17874-4b3b-46b1-9e54-e5d2eddb254c	9yadWsQGvbwEnhprmQCPNXz4	user_215490445	ACTIVE	107374182400	MONTH	2026-06-30 16:39:39	\N	\N	zBx_2AGfKrPP8whaK1kejHk6AfUS_1Cj	32d113de-484a-4754-8d76-ec63f032348b	wCxxsNF43hoNeJ8edxQqrKX_u7rcR62u	2026-05-28 16:39:39.432	2026-05-28 16:50:08.788	Bot user: Maria Muszynska @marichko	\N	215490445	2	TRIAL	0	16	\N
0d3ad44c-a5c2-4549-bc3a-afd08ad264bf	X0WjdkqetPzZEZKMAPy936rX	user_email_mybochka_20	ACTIVE	107374182400	MONTH	2026-06-02 19:19:26.776	\N	\N	ungXyh0U90TH34h5RCUaZhYqeB0pyZVf	bad44426-c528-4d52-967a-00fe3cdcbc53	ghEqnr3n48eSQZarNDP-pHJsFsfXgXPo	2026-05-30 19:19:26.91	2026-05-30 19:19:26.904	Bot user: mybochka	mybochka@yandex.ru	\N	2	TRIAL	0	17	\N
\.


--
-- Name: config_profiles_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.config_profiles_view_position_seq', 9, true);


--
-- Name: external_squads_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.external_squads_view_position_seq', 2, true);


--
-- Name: hosts_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hosts_view_position_seq', 10, true);


--
-- Name: internal_squads_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.internal_squads_view_position_seq', 4, true);


--
-- Name: node_plugin_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.node_plugin_view_position_seq', 2, true);


--
-- Name: nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nodes_id_seq', 15, true);


--
-- Name: nodes_traffic_usage_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nodes_traffic_usage_history_id_seq', 2, true);


--
-- Name: nodes_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nodes_view_position_seq', 15, true);


--
-- Name: subscription_page_config_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_page_config_view_position_seq', 2, true);


--
-- Name: subscription_templates_view_position_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_templates_view_position_seq', 7, true);


--
-- Name: torrent_blocker_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.torrent_blocker_reports_id_seq', 2, true);


--
-- Name: user_subscription_request_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_subscription_request_history_id_seq', 755, true);


--
-- Name: users_t_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_t_id_seq', 17, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (uuid);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (uuid);


--
-- Name: config_profile_inbounds config_profile_inbounds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_inbounds
    ADD CONSTRAINT config_profile_inbounds_pkey PRIMARY KEY (uuid);


--
-- Name: config_profile_inbounds_to_nodes config_profile_inbounds_to_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_inbounds_to_nodes
    ADD CONSTRAINT config_profile_inbounds_to_nodes_pkey PRIMARY KEY (config_profile_inbound_uuid, node_uuid);


--
-- Name: config_profile_snippets config_profile_snippets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_snippets
    ADD CONSTRAINT config_profile_snippets_pkey PRIMARY KEY (name);


--
-- Name: config_profiles config_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profiles
    ADD CONSTRAINT config_profiles_pkey PRIMARY KEY (uuid);


--
-- Name: external_squads external_squads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads
    ADD CONSTRAINT external_squads_pkey PRIMARY KEY (uuid);


--
-- Name: external_squads_templates external_squads_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads_templates
    ADD CONSTRAINT external_squads_templates_pkey PRIMARY KEY (external_squad_uuid, template_type);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (uuid);


--
-- Name: hosts_to_nodes hosts_to_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts_to_nodes
    ADD CONSTRAINT hosts_to_nodes_pkey PRIMARY KEY (host_uuid, node_uuid);


--
-- Name: hwid_user_devices hwid_user_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hwid_user_devices
    ADD CONSTRAINT hwid_user_devices_pkey PRIMARY KEY (hwid, user_uuid);


--
-- Name: infra_billing_history infra_billing_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_billing_history
    ADD CONSTRAINT infra_billing_history_pkey PRIMARY KEY (uuid);


--
-- Name: infra_billing_nodes infra_billing_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_billing_nodes
    ADD CONSTRAINT infra_billing_nodes_pkey PRIMARY KEY (uuid);


--
-- Name: infra_providers infra_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_providers
    ADD CONSTRAINT infra_providers_pkey PRIMARY KEY (uuid);


--
-- Name: internal_squad_host_exclusions internal_squad_host_exclusions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_host_exclusions
    ADD CONSTRAINT internal_squad_host_exclusions_pkey PRIMARY KEY (host_uuid, squad_uuid);


--
-- Name: internal_squad_inbounds internal_squad_inbounds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_inbounds
    ADD CONSTRAINT internal_squad_inbounds_pkey PRIMARY KEY (internal_squad_uuid, inbound_uuid);


--
-- Name: internal_squad_members internal_squad_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_members
    ADD CONSTRAINT internal_squad_members_pkey PRIMARY KEY (internal_squad_uuid, user_id);


--
-- Name: internal_squads internal_squads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squads
    ADD CONSTRAINT internal_squads_pkey PRIMARY KEY (uuid);


--
-- Name: keygen keygen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keygen
    ADD CONSTRAINT keygen_pkey PRIMARY KEY (uuid);


--
-- Name: node_meta node_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_meta
    ADD CONSTRAINT node_meta_pkey PRIMARY KEY (node_id);


--
-- Name: node_plugin node_plugin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_plugin
    ADD CONSTRAINT node_plugin_pkey PRIMARY KEY (uuid);


--
-- Name: nodes nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (uuid);


--
-- Name: nodes_traffic_usage_history nodes_traffic_usage_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_traffic_usage_history
    ADD CONSTRAINT nodes_traffic_usage_history_pkey PRIMARY KEY (id);


--
-- Name: nodes_usage_history nodes_usage_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_usage_history
    ADD CONSTRAINT nodes_usage_history_pkey PRIMARY KEY (node_uuid, created_at);


--
-- Name: nodes_user_usage_history nodes_user_usage_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_user_usage_history
    ADD CONSTRAINT nodes_user_usage_history_pkey PRIMARY KEY (node_id, created_at, user_id);


--
-- Name: passkeys passkeys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passkeys
    ADD CONSTRAINT passkeys_pkey PRIMARY KEY (id);


--
-- Name: remnawave_settings remnawave_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.remnawave_settings
    ADD CONSTRAINT remnawave_settings_pkey PRIMARY KEY (id);


--
-- Name: subscription_page_config subscription_page_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_page_config
    ADD CONSTRAINT subscription_page_config_pkey PRIMARY KEY (uuid);


--
-- Name: subscription_settings subscription_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_settings
    ADD CONSTRAINT subscription_settings_pkey PRIMARY KEY (uuid);


--
-- Name: subscription_templates subscription_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT subscription_templates_pkey PRIMARY KEY (uuid);


--
-- Name: torrent_blocker_reports torrent_blocker_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.torrent_blocker_reports
    ADD CONSTRAINT torrent_blocker_reports_pkey PRIMARY KEY (id);


--
-- Name: user_meta user_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_meta
    ADD CONSTRAINT user_meta_pkey PRIMARY KEY (user_id);


--
-- Name: user_subscription_request_history user_subscription_request_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_subscription_request_history
    ADD CONSTRAINT user_subscription_request_history_pkey PRIMARY KEY (id);


--
-- Name: user_traffic user_traffic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_traffic
    ADD CONSTRAINT user_traffic_pkey PRIMARY KEY (t_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (t_id);


--
-- Name: admin_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX admin_username_key ON public.admin USING btree (username);


--
-- Name: api_tokens_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_tokens_token_key ON public.api_tokens USING btree (token);


--
-- Name: config_profile_inbounds_profile_uuid_uuid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX config_profile_inbounds_profile_uuid_uuid_idx ON public.config_profile_inbounds USING btree (profile_uuid, uuid);


--
-- Name: config_profile_inbounds_tag_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX config_profile_inbounds_tag_key ON public.config_profile_inbounds USING btree (tag);


--
-- Name: config_profiles_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX config_profiles_name_key ON public.config_profiles USING btree (name);


--
-- Name: external_squads_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX external_squads_name_key ON public.external_squads USING btree (name);


--
-- Name: infra_billing_nodes_next_billing_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX infra_billing_nodes_next_billing_at_idx ON public.infra_billing_nodes USING btree (next_billing_at);


--
-- Name: infra_billing_nodes_node_uuid_provider_uuid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX infra_billing_nodes_node_uuid_provider_uuid_key ON public.infra_billing_nodes USING btree (node_uuid, provider_uuid);


--
-- Name: infra_providers_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX infra_providers_name_key ON public.infra_providers USING btree (name);


--
-- Name: internal_squad_members_internal_squad_uuid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_squad_members_internal_squad_uuid_idx ON public.internal_squad_members USING btree (internal_squad_uuid);


--
-- Name: internal_squad_members_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_squad_members_user_id_idx ON public.internal_squad_members USING btree (user_id);


--
-- Name: internal_squads_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX internal_squads_name_key ON public.internal_squads USING btree (name);


--
-- Name: nodes_address_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nodes_address_key ON public.nodes USING btree (address);


--
-- Name: nodes_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX nodes_id_idx ON public.nodes USING btree (id);


--
-- Name: nodes_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nodes_id_key ON public.nodes USING btree (id);


--
-- Name: nodes_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nodes_name_key ON public.nodes USING btree (name);


--
-- Name: nodes_usage_history_node_uuid_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX nodes_usage_history_node_uuid_created_at_idx ON public.nodes_usage_history USING btree (node_uuid, created_at DESC);


--
-- Name: passkeys_admin_uuid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX passkeys_admin_uuid_idx ON public.passkeys USING btree (admin_uuid);


--
-- Name: passkeys_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX passkeys_id_idx ON public.passkeys USING btree (id);


--
-- Name: subscription_page_config_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX subscription_page_config_name_key ON public.subscription_page_config USING btree (name);


--
-- Name: subscription_templates_template_type_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX subscription_templates_template_type_name_key ON public.subscription_templates USING btree (template_type, name);


--
-- Name: user_subscription_request_history_request_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_subscription_request_history_request_at_idx ON public.user_subscription_request_history USING btree (request_at);


--
-- Name: user_subscription_request_history_user_uuid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_subscription_request_history_user_uuid_idx ON public.user_subscription_request_history USING btree (user_uuid);


--
-- Name: users_short_uuid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_short_uuid_key ON public.users USING btree (short_uuid);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: users_uuid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_uuid_key ON public.users USING btree (uuid);


--
-- Name: config_profile_inbounds config_profile_inbounds_profile_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_inbounds
    ADD CONSTRAINT config_profile_inbounds_profile_uuid_fkey FOREIGN KEY (profile_uuid) REFERENCES public.config_profiles(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: config_profile_inbounds_to_nodes config_profile_inbounds_to_nodes_config_profile_inbound_uu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_inbounds_to_nodes
    ADD CONSTRAINT config_profile_inbounds_to_nodes_config_profile_inbound_uu_fkey FOREIGN KEY (config_profile_inbound_uuid) REFERENCES public.config_profile_inbounds(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: config_profile_inbounds_to_nodes config_profile_inbounds_to_nodes_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config_profile_inbounds_to_nodes
    ADD CONSTRAINT config_profile_inbounds_to_nodes_node_uuid_fkey FOREIGN KEY (node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: external_squads external_squads_subpage_config_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads
    ADD CONSTRAINT external_squads_subpage_config_uuid_fkey FOREIGN KEY (subpage_config_uuid) REFERENCES public.subscription_page_config(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: external_squads_templates external_squads_templates_external_squad_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads_templates
    ADD CONSTRAINT external_squads_templates_external_squad_uuid_fkey FOREIGN KEY (external_squad_uuid) REFERENCES public.external_squads(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: external_squads_templates external_squads_templates_template_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_squads_templates
    ADD CONSTRAINT external_squads_templates_template_uuid_fkey FOREIGN KEY (template_uuid) REFERENCES public.subscription_templates(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hosts hosts_config_profile_inbound_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_config_profile_inbound_uuid_fkey FOREIGN KEY (config_profile_inbound_uuid) REFERENCES public.config_profile_inbounds(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: hosts hosts_config_profile_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_config_profile_uuid_fkey FOREIGN KEY (config_profile_uuid) REFERENCES public.config_profiles(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: hosts_to_nodes hosts_to_nodes_host_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts_to_nodes
    ADD CONSTRAINT hosts_to_nodes_host_uuid_fkey FOREIGN KEY (host_uuid) REFERENCES public.hosts(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hosts_to_nodes hosts_to_nodes_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts_to_nodes
    ADD CONSTRAINT hosts_to_nodes_node_uuid_fkey FOREIGN KEY (node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hosts hosts_xray_json_template_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_xray_json_template_uuid_fkey FOREIGN KEY (xray_json_template_uuid) REFERENCES public.subscription_templates(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: hwid_user_devices hwid_user_devices_user_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hwid_user_devices
    ADD CONSTRAINT hwid_user_devices_user_uuid_fkey FOREIGN KEY (user_uuid) REFERENCES public.users(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: infra_billing_history infra_billing_history_provider_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_billing_history
    ADD CONSTRAINT infra_billing_history_provider_uuid_fkey FOREIGN KEY (provider_uuid) REFERENCES public.infra_providers(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: infra_billing_nodes infra_billing_nodes_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_billing_nodes
    ADD CONSTRAINT infra_billing_nodes_node_uuid_fkey FOREIGN KEY (node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: infra_billing_nodes infra_billing_nodes_provider_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_billing_nodes
    ADD CONSTRAINT infra_billing_nodes_provider_uuid_fkey FOREIGN KEY (provider_uuid) REFERENCES public.infra_providers(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_host_exclusions internal_squad_host_exclusions_host_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_host_exclusions
    ADD CONSTRAINT internal_squad_host_exclusions_host_uuid_fkey FOREIGN KEY (host_uuid) REFERENCES public.hosts(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_host_exclusions internal_squad_host_exclusions_squad_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_host_exclusions
    ADD CONSTRAINT internal_squad_host_exclusions_squad_uuid_fkey FOREIGN KEY (squad_uuid) REFERENCES public.internal_squads(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_inbounds internal_squad_inbounds_inbound_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_inbounds
    ADD CONSTRAINT internal_squad_inbounds_inbound_uuid_fkey FOREIGN KEY (inbound_uuid) REFERENCES public.config_profile_inbounds(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_inbounds internal_squad_inbounds_internal_squad_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_inbounds
    ADD CONSTRAINT internal_squad_inbounds_internal_squad_uuid_fkey FOREIGN KEY (internal_squad_uuid) REFERENCES public.internal_squads(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_members internal_squad_members_internal_squad_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_members
    ADD CONSTRAINT internal_squad_members_internal_squad_uuid_fkey FOREIGN KEY (internal_squad_uuid) REFERENCES public.internal_squads(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: internal_squad_members internal_squad_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_squad_members
    ADD CONSTRAINT internal_squad_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(t_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: node_meta node_meta_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_meta
    ADD CONSTRAINT node_meta_node_id_fkey FOREIGN KEY (node_id) REFERENCES public.nodes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nodes nodes_active_config_profile_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_active_config_profile_uuid_fkey FOREIGN KEY (active_config_profile_uuid) REFERENCES public.config_profiles(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: nodes nodes_active_plugin_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_active_plugin_uuid_fkey FOREIGN KEY (active_plugin_uuid) REFERENCES public.node_plugin(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: nodes nodes_provider_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_provider_uuid_fkey FOREIGN KEY (provider_uuid) REFERENCES public.infra_providers(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: nodes_traffic_usage_history nodes_traffic_usage_history_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_traffic_usage_history
    ADD CONSTRAINT nodes_traffic_usage_history_node_uuid_fkey FOREIGN KEY (node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nodes_usage_history nodes_usage_history_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_usage_history
    ADD CONSTRAINT nodes_usage_history_node_uuid_fkey FOREIGN KEY (node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nodes_user_usage_history nodes_user_usage_history_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_user_usage_history
    ADD CONSTRAINT nodes_user_usage_history_node_id_fkey FOREIGN KEY (node_id) REFERENCES public.nodes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nodes_user_usage_history nodes_user_usage_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes_user_usage_history
    ADD CONSTRAINT nodes_user_usage_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(t_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: passkeys passkeys_admin_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passkeys
    ADD CONSTRAINT passkeys_admin_uuid_fkey FOREIGN KEY (admin_uuid) REFERENCES public.admin(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: torrent_blocker_reports torrent_blocker_reports_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.torrent_blocker_reports
    ADD CONSTRAINT torrent_blocker_reports_node_id_fkey FOREIGN KEY (node_id) REFERENCES public.nodes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: torrent_blocker_reports torrent_blocker_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.torrent_blocker_reports
    ADD CONSTRAINT torrent_blocker_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(t_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_meta user_meta_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_meta
    ADD CONSTRAINT user_meta_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(t_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_subscription_request_history user_subscription_request_history_user_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_subscription_request_history
    ADD CONSTRAINT user_subscription_request_history_user_uuid_fkey FOREIGN KEY (user_uuid) REFERENCES public.users(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_traffic user_traffic_last_connected_node_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_traffic
    ADD CONSTRAINT user_traffic_last_connected_node_uuid_fkey FOREIGN KEY (last_connected_node_uuid) REFERENCES public.nodes(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_traffic user_traffic_t_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_traffic
    ADD CONSTRAINT user_traffic_t_id_fkey FOREIGN KEY (t_id) REFERENCES public.users(t_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_external_squad_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_external_squad_uuid_fkey FOREIGN KEY (external_squad_uuid) REFERENCES public.external_squads(uuid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict LU3dkba5Jr1zabBFBI1DDXuJzKlJrhRyx3tJK9KolQMf5kttVgkDKlwPkHfCucA

