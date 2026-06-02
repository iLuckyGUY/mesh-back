--
-- PostgreSQL database dump
--

\restrict UwPUlqjCPvvNJoheupLBQDDpFZkOgN057ZfDx9pU671nuxppclH8y6h4aNj3PNo

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
-- Name: access_policies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_policies (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    role_id integer,
    priority integer NOT NULL,
    effect character varying(10) NOT NULL,
    conditions jsonb NOT NULL,
    resource character varying(100) NOT NULL,
    actions jsonb NOT NULL,
    is_active boolean NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.access_policies OWNER TO postgres;

--
-- Name: access_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_policies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.access_policies_id_seq OWNER TO postgres;

--
-- Name: access_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_policies_id_seq OWNED BY public.access_policies.id;


--
-- Name: admin_audit_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_audit_log (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    action character varying(100) NOT NULL,
    resource_type character varying(50),
    resource_id character varying(100),
    details jsonb,
    ip_address character varying(45),
    user_agent text,
    status character varying(20) NOT NULL,
    request_method character varying(10),
    request_path text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.admin_audit_log OWNER TO postgres;

--
-- Name: admin_audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_audit_log_id_seq OWNER TO postgres;

--
-- Name: admin_audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_audit_log_id_seq OWNED BY public.admin_audit_log.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    level integer NOT NULL,
    permissions jsonb NOT NULL,
    color character varying(7),
    icon character varying(50),
    is_system boolean NOT NULL,
    is_active boolean NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.admin_roles OWNER TO postgres;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_roles_id_seq OWNER TO postgres;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: advertising_campaign_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.advertising_campaign_registrations (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    user_id integer NOT NULL,
    bonus_type character varying(20) NOT NULL,
    balance_bonus_kopeks integer,
    subscription_duration_days integer,
    tariff_id integer,
    tariff_duration_days integer,
    created_at timestamp with time zone
);


ALTER TABLE public.advertising_campaign_registrations OWNER TO postgres;

--
-- Name: advertising_campaign_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.advertising_campaign_registrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advertising_campaign_registrations_id_seq OWNER TO postgres;

--
-- Name: advertising_campaign_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.advertising_campaign_registrations_id_seq OWNED BY public.advertising_campaign_registrations.id;


--
-- Name: advertising_campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.advertising_campaigns (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    start_parameter character varying(64) NOT NULL,
    bonus_type character varying(20) NOT NULL,
    balance_bonus_kopeks integer,
    subscription_duration_days integer,
    subscription_traffic_gb integer,
    subscription_device_limit integer,
    subscription_squads json,
    tariff_id integer,
    tariff_duration_days integer,
    is_active boolean,
    partner_user_id integer,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.advertising_campaigns OWNER TO postgres;

--
-- Name: advertising_campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.advertising_campaigns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advertising_campaigns_id_seq OWNER TO postgres;

--
-- Name: advertising_campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.advertising_campaigns_id_seq OWNED BY public.advertising_campaigns.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: antilopay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antilopay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    antilopay_payment_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.antilopay_payments OWNER TO postgres;

--
-- Name: antilopay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antilopay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antilopay_payments_id_seq OWNER TO postgres;

--
-- Name: antilopay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antilopay_payments_id_seq OWNED BY public.antilopay_payments.id;


--
-- Name: apple_iap_abuse_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apple_iap_abuse_events (
    id integer NOT NULL,
    user_id integer,
    event_type character varying(64) NOT NULL,
    severity character varying(16) DEFAULT 'warning'::character varying NOT NULL,
    transaction_id character varying(64),
    product_id character varying(128),
    ip_address character varying(64),
    details_json json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.apple_iap_abuse_events OWNER TO postgres;

--
-- Name: apple_iap_abuse_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apple_iap_abuse_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apple_iap_abuse_events_id_seq OWNER TO postgres;

--
-- Name: apple_iap_abuse_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apple_iap_abuse_events_id_seq OWNED BY public.apple_iap_abuse_events.id;


--
-- Name: apple_iap_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apple_iap_accounts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    account_token_uuid character varying(36) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    rotated_at timestamp with time zone,
    disabled_at timestamp with time zone
);


ALTER TABLE public.apple_iap_accounts OWNER TO postgres;

--
-- Name: apple_iap_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apple_iap_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apple_iap_accounts_id_seq OWNER TO postgres;

--
-- Name: apple_iap_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apple_iap_accounts_id_seq OWNED BY public.apple_iap_accounts.id;


--
-- Name: apple_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apple_notifications (
    id integer NOT NULL,
    notification_uuid character varying(64) NOT NULL,
    notification_type character varying(64) NOT NULL,
    subtype character varying(64),
    environment character varying(16),
    transaction_id character varying(64),
    original_transaction_id character varying(64),
    status character varying(32) DEFAULT 'received'::character varying NOT NULL,
    error text,
    payload_hash character varying(64) NOT NULL,
    metadata_json json,
    received_at timestamp with time zone DEFAULT now(),
    processed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.apple_notifications OWNER TO postgres;

--
-- Name: apple_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apple_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apple_notifications_id_seq OWNER TO postgres;

--
-- Name: apple_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apple_notifications_id_seq OWNED BY public.apple_notifications.id;


--
-- Name: apple_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apple_transactions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    transaction_id character varying(64) NOT NULL,
    original_transaction_id character varying(64),
    product_id character varying(128) NOT NULL,
    bundle_id character varying(255) NOT NULL,
    amount_kopeks integer NOT NULL,
    environment character varying(16) NOT NULL,
    status character varying(50),
    is_paid boolean,
    paid_at timestamp with time zone,
    refunded_at timestamp with time zone,
    transaction_id_fk integer,
    metadata_json json,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    app_account_token character varying(36),
    web_order_line_item_id character varying(64),
    storefront character varying(16),
    currency character varying(3),
    price_micros bigint,
    purchase_date timestamp with time zone,
    revocation_date timestamp with time zone,
    revocation_reason character varying(50),
    credited_at timestamp with time zone,
    refund_reversed_at timestamp with time zone,
    signed_transaction_hash character varying(64)
);


ALTER TABLE public.apple_transactions OWNER TO postgres;

--
-- Name: apple_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apple_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apple_transactions_id_seq OWNER TO postgres;

--
-- Name: apple_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apple_transactions_id_seq OWNED BY public.apple_transactions.id;


--
-- Name: aurapay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aurapay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    aurapay_invoice_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.aurapay_payments OWNER TO postgres;

--
-- Name: aurapay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aurapay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aurapay_payments_id_seq OWNER TO postgres;

--
-- Name: aurapay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aurapay_payments_id_seq OWNED BY public.aurapay_payments.id;


--
-- Name: broadcast_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broadcast_history (
    id integer NOT NULL,
    target_type character varying(100) NOT NULL,
    message_text text,
    has_media boolean,
    media_type character varying(20),
    media_file_id character varying(255),
    media_caption text,
    total_count integer,
    sent_count integer,
    failed_count integer,
    blocked_count integer,
    status character varying(50),
    admin_id integer,
    admin_name character varying(255),
    created_at timestamp with time zone DEFAULT now(),
    completed_at timestamp with time zone,
    category character varying(20) NOT NULL,
    channel character varying(20) NOT NULL,
    email_subject character varying(255),
    email_html_content text
);


ALTER TABLE public.broadcast_history OWNER TO postgres;

--
-- Name: broadcast_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.broadcast_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.broadcast_history_id_seq OWNER TO postgres;

--
-- Name: broadcast_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.broadcast_history_id_seq OWNED BY public.broadcast_history.id;


--
-- Name: button_click_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.button_click_logs (
    id integer NOT NULL,
    button_id character varying(100) NOT NULL,
    user_id integer,
    callback_data character varying(255),
    clicked_at timestamp with time zone,
    button_type character varying(20),
    button_text character varying(255)
);


ALTER TABLE public.button_click_logs OWNER TO postgres;

--
-- Name: button_click_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.button_click_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.button_click_logs_id_seq OWNER TO postgres;

--
-- Name: button_click_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.button_click_logs_id_seq OWNED BY public.button_click_logs.id;


--
-- Name: cabinet_refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cabinet_refresh_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token_hash character varying(255) NOT NULL,
    device_info character varying(500),
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone,
    revoked_at timestamp with time zone
);


ALTER TABLE public.cabinet_refresh_tokens OWNER TO postgres;

--
-- Name: cabinet_refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cabinet_refresh_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cabinet_refresh_tokens_id_seq OWNER TO postgres;

--
-- Name: cabinet_refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cabinet_refresh_tokens_id_seq OWNED BY public.cabinet_refresh_tokens.id;


--
-- Name: cloudpayments_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cloudpayments_payments (
    id integer NOT NULL,
    user_id integer,
    transaction_id_cp bigint,
    invoice_id character varying(255) NOT NULL,
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(50) NOT NULL,
    is_paid boolean,
    paid_at timestamp with time zone,
    card_first_six character varying(6),
    card_last_four character varying(4),
    card_type character varying(50),
    card_exp_date character varying(10),
    token character varying(255),
    payment_url text,
    email character varying(255),
    test_mode boolean,
    metadata_json json,
    callback_payload json,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.cloudpayments_payments OWNER TO postgres;

--
-- Name: cloudpayments_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cloudpayments_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cloudpayments_payments_id_seq OWNER TO postgres;

--
-- Name: cloudpayments_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cloudpayments_payments_id_seq OWNED BY public.cloudpayments_payments.id;


--
-- Name: contest_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_attempts (
    id integer NOT NULL,
    round_id integer NOT NULL,
    user_id integer NOT NULL,
    answer text,
    is_winner boolean NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.contest_attempts OWNER TO postgres;

--
-- Name: contest_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contest_attempts_id_seq OWNER TO postgres;

--
-- Name: contest_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_attempts_id_seq OWNED BY public.contest_attempts.id;


--
-- Name: contest_rounds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_rounds (
    id integer NOT NULL,
    template_id integer NOT NULL,
    starts_at timestamp with time zone NOT NULL,
    ends_at timestamp with time zone NOT NULL,
    status character varying(20) NOT NULL,
    payload json,
    winners_count integer NOT NULL,
    max_winners integer NOT NULL,
    attempts_per_user integer NOT NULL,
    message_id bigint,
    chat_id bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.contest_rounds OWNER TO postgres;

--
-- Name: contest_rounds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_rounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contest_rounds_id_seq OWNER TO postgres;

--
-- Name: contest_rounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_rounds_id_seq OWNED BY public.contest_rounds.id;


--
-- Name: contest_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_templates (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    description text,
    prize_type character varying(20) NOT NULL,
    prize_value character varying(50) NOT NULL,
    max_winners integer NOT NULL,
    attempts_per_user integer NOT NULL,
    times_per_day integer NOT NULL,
    schedule_times character varying(255),
    cooldown_hours integer NOT NULL,
    payload json,
    is_enabled boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.contest_templates OWNER TO postgres;

--
-- Name: contest_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contest_templates_id_seq OWNER TO postgres;

--
-- Name: contest_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_templates_id_seq OWNED BY public.contest_templates.id;


--
-- Name: cryptobot_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cryptobot_payments (
    id integer NOT NULL,
    user_id integer,
    invoice_id character varying(255) NOT NULL,
    amount character varying(50) NOT NULL,
    asset character varying(10) NOT NULL,
    status character varying(50) NOT NULL,
    description text,
    payload text,
    bot_invoice_url text,
    mini_app_invoice_url text,
    web_app_invoice_url text,
    paid_at timestamp with time zone,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.cryptobot_payments OWNER TO postgres;

--
-- Name: cryptobot_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cryptobot_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cryptobot_payments_id_seq OWNER TO postgres;

--
-- Name: cryptobot_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cryptobot_payments_id_seq OWNED BY public.cryptobot_payments.id;


--
-- Name: discount_offers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_offers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    subscription_id integer,
    notification_type character varying(50) NOT NULL,
    discount_percent integer NOT NULL,
    bonus_amount_kopeks integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    claimed_at timestamp with time zone,
    is_active boolean NOT NULL,
    effect_type character varying(50) NOT NULL,
    extra_data json,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.discount_offers OWNER TO postgres;

--
-- Name: discount_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discount_offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_offers_id_seq OWNER TO postgres;

--
-- Name: discount_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discount_offers_id_seq OWNED BY public.discount_offers.id;


--
-- Name: donut_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donut_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    donut_transaction_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.donut_payments OWNER TO postgres;

--
-- Name: donut_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donut_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donut_payments_id_seq OWNER TO postgres;

--
-- Name: donut_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donut_payments_id_seq OWNED BY public.donut_payments.id;


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_templates (
    id integer NOT NULL,
    notification_type character varying(100) NOT NULL,
    language character varying(10) NOT NULL,
    subject character varying(500) NOT NULL,
    body_html text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.email_templates OWNER TO postgres;

--
-- Name: email_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_id_seq OWNER TO postgres;

--
-- Name: email_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_templates_id_seq OWNED BY public.email_templates.id;


--
-- Name: etoplatezhi_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etoplatezhi_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    etoplatezhi_payment_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.etoplatezhi_payments OWNER TO postgres;

--
-- Name: etoplatezhi_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etoplatezhi_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etoplatezhi_payments_id_seq OWNER TO postgres;

--
-- Name: etoplatezhi_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etoplatezhi_payments_id_seq OWNED BY public.etoplatezhi_payments.id;


--
-- Name: faq_pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faq_pages (
    id integer NOT NULL,
    language character varying(10) NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    display_order integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.faq_pages OWNER TO postgres;

--
-- Name: faq_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faq_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faq_pages_id_seq OWNER TO postgres;

--
-- Name: faq_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faq_pages_id_seq OWNED BY public.faq_pages.id;


--
-- Name: faq_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faq_settings (
    id integer NOT NULL,
    language character varying(10) NOT NULL,
    is_enabled boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.faq_settings OWNER TO postgres;

--
-- Name: faq_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faq_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faq_settings_id_seq OWNER TO postgres;

--
-- Name: faq_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faq_settings_id_seq OWNED BY public.faq_settings.id;


--
-- Name: freekassa_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freekassa_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    freekassa_order_id character varying(64),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_system_id integer,
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.freekassa_payments OWNER TO postgres;

--
-- Name: freekassa_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.freekassa_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.freekassa_payments_id_seq OWNER TO postgres;

--
-- Name: freekassa_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.freekassa_payments_id_seq OWNED BY public.freekassa_payments.id;


--
-- Name: guest_purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guest_purchases (
    id integer NOT NULL,
    token character varying(64) NOT NULL,
    landing_id integer,
    contact_type character varying(20) NOT NULL,
    contact_value character varying(255) NOT NULL,
    is_gift boolean NOT NULL,
    source character varying(20) DEFAULT 'landing'::character varying NOT NULL,
    buyer_user_id integer,
    gift_recipient_type character varying(20),
    gift_recipient_value character varying(255),
    gift_message text,
    tariff_id integer,
    period_days integer NOT NULL,
    amount_kopeks integer NOT NULL,
    currency character varying(3) NOT NULL,
    payment_method character varying(50),
    payment_id character varying(255),
    status character varying(20) NOT NULL,
    subscription_url text,
    subscription_crypto_link text,
    user_id integer,
    created_at timestamp with time zone DEFAULT now(),
    paid_at timestamp with time zone,
    delivered_at timestamp with time zone,
    cabinet_password text,
    auto_login_token text,
    recipient_warning character varying(50),
    retry_count integer DEFAULT 0 NOT NULL,
    receipt_uuid character varying(255),
    receipt_created_at timestamp with time zone,
    yandex_cid character varying(128),
    subid character varying(255),
    referrer character varying(500)
);


ALTER TABLE public.guest_purchases OWNER TO postgres;

--
-- Name: guest_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guest_purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guest_purchases_id_seq OWNER TO postgres;

--
-- Name: guest_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guest_purchases_id_seq OWNED BY public.guest_purchases.id;


--
-- Name: heleket_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.heleket_payments (
    id integer NOT NULL,
    user_id integer,
    uuid character varying(255) NOT NULL,
    order_id character varying(128) NOT NULL,
    amount character varying(50) NOT NULL,
    currency character varying(10) NOT NULL,
    payer_amount character varying(50),
    payer_currency character varying(10),
    exchange_rate double precision,
    discount_percent integer,
    status character varying(50) NOT NULL,
    payment_url text,
    metadata_json json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.heleket_payments OWNER TO postgres;

--
-- Name: heleket_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.heleket_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.heleket_payments_id_seq OWNER TO postgres;

--
-- Name: heleket_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.heleket_payments_id_seq OWNED BY public.heleket_payments.id;


--
-- Name: info_pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info_pages (
    id integer NOT NULL,
    slug character varying(200) NOT NULL,
    title jsonb DEFAULT '{}'::jsonb NOT NULL,
    content jsonb DEFAULT '{}'::jsonb NOT NULL,
    page_type character varying(20) DEFAULT 'page'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    icon character varying(50),
    replaces_tab character varying(20),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.info_pages OWNER TO postgres;

--
-- Name: info_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.info_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_pages_id_seq OWNER TO postgres;

--
-- Name: info_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.info_pages_id_seq OWNED BY public.info_pages.id;


--
-- Name: jupiter_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jupiter_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    jupiter_transaction_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.jupiter_payments OWNER TO postgres;

--
-- Name: jupiter_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jupiter_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jupiter_payments_id_seq OWNER TO postgres;

--
-- Name: jupiter_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jupiter_payments_id_seq OWNED BY public.jupiter_payments.id;


--
-- Name: kassa_ai_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kassa_ai_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    kassa_ai_order_id character varying(64),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_system_id integer,
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.kassa_ai_payments OWNER TO postgres;

--
-- Name: kassa_ai_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kassa_ai_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kassa_ai_payments_id_seq OWNER TO postgres;

--
-- Name: kassa_ai_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kassa_ai_payments_id_seq OWNED BY public.kassa_ai_payments.id;


--
-- Name: landing_pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.landing_pages (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    is_active boolean NOT NULL,
    title json NOT NULL,
    subtitle json,
    features json NOT NULL,
    footer_text json,
    allowed_tariff_ids json NOT NULL,
    allowed_periods json NOT NULL,
    payment_methods json NOT NULL,
    gift_enabled boolean NOT NULL,
    custom_css text,
    meta_title json,
    meta_description json,
    display_order integer NOT NULL,
    discount_percent integer,
    discount_overrides json,
    discount_starts_at timestamp with time zone,
    discount_ends_at timestamp with time zone,
    discount_badge_text json,
    background_config json,
    sticky_pay_button boolean DEFAULT false NOT NULL,
    analytics_view_enabled boolean DEFAULT false NOT NULL,
    analytics_view_goal character varying(64),
    analytics_click_enabled boolean DEFAULT false NOT NULL,
    analytics_click_goal character varying(64),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT chk_landing_discount_dates_order CHECK (((discount_starts_at IS NULL) OR (discount_ends_at IS NULL) OR (discount_starts_at < discount_ends_at))),
    CONSTRAINT chk_landing_discount_percent_range CHECK (((discount_percent IS NULL) OR ((discount_percent >= 1) AND (discount_percent <= 99))))
);


ALTER TABLE public.landing_pages OWNER TO postgres;

--
-- Name: landing_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.landing_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.landing_pages_id_seq OWNER TO postgres;

--
-- Name: landing_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.landing_pages_id_seq OWNED BY public.landing_pages.id;


--
-- Name: lava_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lava_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    lava_invoice_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.lava_payments OWNER TO postgres;

--
-- Name: lava_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lava_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lava_payments_id_seq OWNER TO postgres;

--
-- Name: lava_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lava_payments_id_seq OWNED BY public.lava_payments.id;


--
-- Name: main_menu_buttons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_menu_buttons (
    id integer NOT NULL,
    text character varying(64) NOT NULL,
    action_type character varying(20) NOT NULL,
    action_value text NOT NULL,
    visibility character varying(20) NOT NULL,
    is_active boolean NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.main_menu_buttons OWNER TO postgres;

--
-- Name: main_menu_buttons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.main_menu_buttons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.main_menu_buttons_id_seq OWNER TO postgres;

--
-- Name: main_menu_buttons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.main_menu_buttons_id_seq OWNED BY public.main_menu_buttons.id;


--
-- Name: menu_layout_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_layout_history (
    id integer NOT NULL,
    config_json text NOT NULL,
    action character varying(50) NOT NULL,
    changes_summary text,
    user_info character varying(255),
    created_at timestamp with time zone
);


ALTER TABLE public.menu_layout_history OWNER TO postgres;

--
-- Name: menu_layout_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_layout_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_layout_history_id_seq OWNER TO postgres;

--
-- Name: menu_layout_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_layout_history_id_seq OWNED BY public.menu_layout_history.id;


--
-- Name: monitoring_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monitoring_logs (
    id integer NOT NULL,
    event_type character varying(100) NOT NULL,
    message text NOT NULL,
    data json,
    is_success boolean,
    created_at timestamp with time zone
);


ALTER TABLE public.monitoring_logs OWNER TO postgres;

--
-- Name: monitoring_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monitoring_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.monitoring_logs_id_seq OWNER TO postgres;

--
-- Name: monitoring_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monitoring_logs_id_seq OWNED BY public.monitoring_logs.id;


--
-- Name: mulenpay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mulenpay_payments (
    id integer NOT NULL,
    user_id integer,
    mulen_payment_id integer,
    uuid character varying(255) NOT NULL,
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(50) NOT NULL,
    is_paid boolean,
    paid_at timestamp with time zone,
    payment_url text,
    metadata_json json,
    callback_payload json,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.mulenpay_payments OWNER TO postgres;

--
-- Name: mulenpay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mulenpay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mulenpay_payments_id_seq OWNER TO postgres;

--
-- Name: mulenpay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mulenpay_payments_id_seq OWNED BY public.mulenpay_payments.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_articles (
    id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(500) NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    excerpt text,
    category character varying(100) DEFAULT ''::character varying NOT NULL,
    category_color character varying(20) DEFAULT '#00e5a0'::character varying NOT NULL,
    tag character varying(50),
    featured_image_url text,
    is_published boolean DEFAULT false NOT NULL,
    is_featured boolean DEFAULT false NOT NULL,
    published_at timestamp with time zone,
    read_time_minutes integer DEFAULT 1 NOT NULL,
    views_count integer DEFAULT 0 NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    category_id integer,
    tag_id integer
);


ALTER TABLE public.news_articles OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_articles_id_seq OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_articles_id_seq OWNED BY public.news_articles.id;


--
-- Name: news_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(20) DEFAULT '#00e5a0'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.news_categories OWNER TO postgres;

--
-- Name: news_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_categories_id_seq OWNER TO postgres;

--
-- Name: news_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_categories_id_seq OWNED BY public.news_categories.id;


--
-- Name: news_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_tags (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    color character varying(20) DEFAULT '#94a3b8'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.news_tags OWNER TO postgres;

--
-- Name: news_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_tags_id_seq OWNER TO postgres;

--
-- Name: news_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_tags_id_seq OWNED BY public.news_tags.id;


--
-- Name: overpay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.overpay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    overpay_payment_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.overpay_payments OWNER TO postgres;

--
-- Name: overpay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.overpay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.overpay_payments_id_seq OWNER TO postgres;

--
-- Name: overpay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.overpay_payments_id_seq OWNED BY public.overpay_payments.id;


--
-- Name: pal24_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pal24_payments (
    id integer NOT NULL,
    user_id integer,
    bill_id character varying(255) NOT NULL,
    order_id character varying(255),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    type character varying(20) NOT NULL,
    status character varying(50) NOT NULL,
    is_active boolean,
    is_paid boolean,
    paid_at timestamp with time zone,
    last_status character varying(50),
    last_status_checked_at timestamp with time zone,
    link_url text,
    link_page_url text,
    metadata_json json,
    callback_payload json,
    payment_id character varying(255),
    payment_status character varying(50),
    payment_method character varying(50),
    balance_amount character varying(50),
    balance_currency character varying(10),
    payer_account character varying(255),
    ttl integer,
    expires_at timestamp with time zone,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.pal24_payments OWNER TO postgres;

--
-- Name: pal24_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pal24_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pal24_payments_id_seq OWNER TO postgres;

--
-- Name: pal24_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pal24_payments_id_seq OWNED BY public.pal24_payments.id;


--
-- Name: partner_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_applications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    company_name character varying(255),
    website_url character varying(500),
    telegram_channel character varying(255),
    description text,
    expected_monthly_referrals integer,
    desired_commission_percent integer,
    status character varying(20) NOT NULL,
    admin_comment text,
    approved_commission_percent integer,
    processed_by integer,
    processed_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.partner_applications OWNER TO postgres;

--
-- Name: partner_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partner_applications_id_seq OWNER TO postgres;

--
-- Name: partner_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_applications_id_seq OWNED BY public.partner_applications.id;


--
-- Name: payment_method_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method_configs (
    id integer NOT NULL,
    method_id character varying(50) NOT NULL,
    sort_order integer NOT NULL,
    is_enabled boolean NOT NULL,
    display_name character varying(255),
    sub_options json,
    min_amount_kopeks integer,
    max_amount_kopeks integer,
    user_type_filter character varying(20) NOT NULL,
    first_topup_filter character varying(10) NOT NULL,
    promo_group_filter_mode character varying(20) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    open_url_direct boolean DEFAULT false NOT NULL
);


ALTER TABLE public.payment_method_configs OWNER TO postgres;

--
-- Name: payment_method_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_method_configs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_method_configs_id_seq OWNER TO postgres;

--
-- Name: payment_method_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_method_configs_id_seq OWNED BY public.payment_method_configs.id;


--
-- Name: payment_method_promo_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method_promo_groups (
    payment_method_config_id integer NOT NULL,
    promo_group_id integer NOT NULL
);


ALTER TABLE public.payment_method_promo_groups OWNER TO postgres;

--
-- Name: paypear_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paypear_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    paypear_id character varying(64),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.paypear_payments OWNER TO postgres;

--
-- Name: paypear_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paypear_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paypear_payments_id_seq OWNER TO postgres;

--
-- Name: paypear_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypear_payments_id_seq OWNED BY public.paypear_payments.id;


--
-- Name: pinned_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pinned_messages (
    id integer NOT NULL,
    content text NOT NULL,
    media_type character varying(32),
    media_file_id character varying(255),
    send_before_menu boolean DEFAULT true NOT NULL,
    send_on_every_start boolean DEFAULT true NOT NULL,
    is_active boolean,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.pinned_messages OWNER TO postgres;

--
-- Name: pinned_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pinned_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pinned_messages_id_seq OWNER TO postgres;

--
-- Name: pinned_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pinned_messages_id_seq OWNED BY public.pinned_messages.id;


--
-- Name: platega_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platega_payments (
    id integer NOT NULL,
    user_id integer,
    platega_transaction_id character varying(255),
    correlation_id character varying(64) NOT NULL,
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    payment_method_code integer NOT NULL,
    status character varying(50) NOT NULL,
    is_paid boolean,
    paid_at timestamp with time zone,
    redirect_url text,
    return_url text,
    failed_url text,
    payload character varying(255),
    metadata_json json,
    callback_payload json,
    expires_at timestamp with time zone,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.platega_payments OWNER TO postgres;

--
-- Name: platega_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platega_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platega_payments_id_seq OWNER TO postgres;

--
-- Name: platega_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platega_payments_id_seq OWNED BY public.platega_payments.id;


--
-- Name: poll_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poll_answers (
    id integer NOT NULL,
    response_id integer NOT NULL,
    question_id integer NOT NULL,
    option_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.poll_answers OWNER TO postgres;

--
-- Name: poll_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poll_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poll_answers_id_seq OWNER TO postgres;

--
-- Name: poll_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poll_answers_id_seq OWNED BY public.poll_answers.id;


--
-- Name: poll_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poll_options (
    id integer NOT NULL,
    question_id integer NOT NULL,
    text text NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.poll_options OWNER TO postgres;

--
-- Name: poll_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poll_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poll_options_id_seq OWNER TO postgres;

--
-- Name: poll_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poll_options_id_seq OWNED BY public.poll_options.id;


--
-- Name: poll_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poll_questions (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    text text NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.poll_questions OWNER TO postgres;

--
-- Name: poll_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poll_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poll_questions_id_seq OWNER TO postgres;

--
-- Name: poll_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poll_questions_id_seq OWNED BY public.poll_questions.id;


--
-- Name: poll_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poll_responses (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    user_id integer NOT NULL,
    sent_at timestamp with time zone NOT NULL,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    reward_given boolean NOT NULL,
    reward_amount_kopeks integer NOT NULL
);


ALTER TABLE public.poll_responses OWNER TO postgres;

--
-- Name: poll_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poll_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poll_responses_id_seq OWNER TO postgres;

--
-- Name: poll_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poll_responses_id_seq OWNED BY public.poll_responses.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.polls (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    reward_enabled boolean NOT NULL,
    reward_amount_kopeks integer NOT NULL,
    created_by integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.polls OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.polls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.polls_id_seq OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.polls_id_seq OWNED BY public.polls.id;


--
-- Name: privacy_policies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privacy_policies (
    id integer NOT NULL,
    language character varying(10) NOT NULL,
    content text NOT NULL,
    is_enabled boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.privacy_policies OWNER TO postgres;

--
-- Name: privacy_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privacy_policies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.privacy_policies_id_seq OWNER TO postgres;

--
-- Name: privacy_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privacy_policies_id_seq OWNED BY public.privacy_policies.id;


--
-- Name: promo_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promo_groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    priority integer NOT NULL,
    server_discount_percent integer NOT NULL,
    traffic_discount_percent integer NOT NULL,
    device_discount_percent integer NOT NULL,
    period_discounts json,
    auto_assign_total_spent_kopeks integer,
    apply_discounts_to_addons boolean NOT NULL,
    is_default boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.promo_groups OWNER TO postgres;

--
-- Name: promo_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promo_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promo_groups_id_seq OWNER TO postgres;

--
-- Name: promo_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promo_groups_id_seq OWNED BY public.promo_groups.id;


--
-- Name: promo_offer_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promo_offer_logs (
    id integer NOT NULL,
    user_id integer,
    offer_id integer,
    action character varying(50) NOT NULL,
    source character varying(100),
    percent integer,
    effect_type character varying(50),
    details json,
    created_at timestamp with time zone
);


ALTER TABLE public.promo_offer_logs OWNER TO postgres;

--
-- Name: promo_offer_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promo_offer_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promo_offer_logs_id_seq OWNER TO postgres;

--
-- Name: promo_offer_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promo_offer_logs_id_seq OWNED BY public.promo_offer_logs.id;


--
-- Name: promo_offer_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promo_offer_templates (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    offer_type character varying(50) NOT NULL,
    message_text text NOT NULL,
    button_text character varying(255) NOT NULL,
    valid_hours integer NOT NULL,
    discount_percent integer NOT NULL,
    bonus_amount_kopeks integer NOT NULL,
    active_discount_hours integer,
    test_duration_hours integer,
    test_squad_uuids json,
    is_active boolean NOT NULL,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.promo_offer_templates OWNER TO postgres;

--
-- Name: promo_offer_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promo_offer_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promo_offer_templates_id_seq OWNER TO postgres;

--
-- Name: promo_offer_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promo_offer_templates_id_seq OWNED BY public.promo_offer_templates.id;


--
-- Name: promocode_uses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promocode_uses (
    id integer NOT NULL,
    promocode_id integer NOT NULL,
    user_id integer NOT NULL,
    used_at timestamp with time zone
);


ALTER TABLE public.promocode_uses OWNER TO postgres;

--
-- Name: promocode_uses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promocode_uses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promocode_uses_id_seq OWNER TO postgres;

--
-- Name: promocode_uses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promocode_uses_id_seq OWNED BY public.promocode_uses.id;


--
-- Name: promocodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promocodes (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    type character varying(50) NOT NULL,
    balance_bonus_kopeks integer,
    subscription_days integer,
    max_uses integer,
    current_uses integer,
    valid_from timestamp with time zone,
    valid_until timestamp with time zone,
    is_active boolean,
    first_purchase_only boolean,
    tariff_id integer,
    created_by integer,
    promo_group_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.promocodes OWNER TO postgres;

--
-- Name: promocodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promocodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promocodes_id_seq OWNER TO postgres;

--
-- Name: promocodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promocodes_id_seq OWNED BY public.promocodes.id;


--
-- Name: public_offers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.public_offers (
    id integer NOT NULL,
    language character varying(10) NOT NULL,
    content text NOT NULL,
    is_enabled boolean NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.public_offers OWNER TO postgres;

--
-- Name: public_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.public_offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.public_offers_id_seq OWNER TO postgres;

--
-- Name: public_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.public_offers_id_seq OWNED BY public.public_offers.id;


--
-- Name: referral_contest_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral_contest_events (
    id integer NOT NULL,
    contest_id integer NOT NULL,
    referrer_id integer NOT NULL,
    referral_id integer NOT NULL,
    event_type character varying(50) NOT NULL,
    amount_kopeks integer NOT NULL,
    occurred_at timestamp with time zone NOT NULL
);


ALTER TABLE public.referral_contest_events OWNER TO postgres;

--
-- Name: referral_contest_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_contest_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_contest_events_id_seq OWNER TO postgres;

--
-- Name: referral_contest_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_contest_events_id_seq OWNED BY public.referral_contest_events.id;


--
-- Name: referral_contest_virtual_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral_contest_virtual_participants (
    id integer NOT NULL,
    contest_id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    referral_count integer NOT NULL,
    total_amount_kopeks integer CONSTRAINT referral_contest_virtual_participa_total_amount_kopeks_not_null NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.referral_contest_virtual_participants OWNER TO postgres;

--
-- Name: referral_contest_virtual_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_contest_virtual_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_contest_virtual_participants_id_seq OWNER TO postgres;

--
-- Name: referral_contest_virtual_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_contest_virtual_participants_id_seq OWNED BY public.referral_contest_virtual_participants.id;


--
-- Name: referral_contests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral_contests (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    prize_text text,
    contest_type character varying(50) NOT NULL,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    daily_summary_time time without time zone NOT NULL,
    daily_summary_times character varying(255),
    timezone character varying(64) NOT NULL,
    is_active boolean NOT NULL,
    last_daily_summary_date date,
    last_daily_summary_at timestamp with time zone,
    final_summary_sent boolean NOT NULL,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.referral_contests OWNER TO postgres;

--
-- Name: referral_contests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_contests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_contests_id_seq OWNER TO postgres;

--
-- Name: referral_contests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_contests_id_seq OWNED BY public.referral_contests.id;


--
-- Name: referral_earnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral_earnings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    referral_id integer NOT NULL,
    amount_kopeks integer NOT NULL,
    reason character varying(100) NOT NULL,
    referral_transaction_id integer,
    campaign_id integer,
    created_at timestamp with time zone
);


ALTER TABLE public.referral_earnings OWNER TO postgres;

--
-- Name: referral_earnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_earnings_id_seq OWNER TO postgres;

--
-- Name: referral_earnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_earnings_id_seq OWNED BY public.referral_earnings.id;


--
-- Name: required_channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_channels (
    id integer NOT NULL,
    channel_id character varying(100) NOT NULL,
    channel_link character varying(500),
    title character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    disable_trial_on_leave boolean DEFAULT true NOT NULL,
    disable_paid_on_leave boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.required_channels OWNER TO postgres;

--
-- Name: required_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.required_channels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.required_channels_id_seq OWNER TO postgres;

--
-- Name: required_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.required_channels_id_seq OWNED BY public.required_channels.id;


--
-- Name: riopay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.riopay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    riopay_order_id character varying(64),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.riopay_payments OWNER TO postgres;

--
-- Name: riopay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.riopay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.riopay_payments_id_seq OWNER TO postgres;

--
-- Name: riopay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riopay_payments_id_seq OWNED BY public.riopay_payments.id;


--
-- Name: rollypay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rollypay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    rollypay_payment_id character varying(128),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.rollypay_payments OWNER TO postgres;

--
-- Name: rollypay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rollypay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rollypay_payments_id_seq OWNER TO postgres;

--
-- Name: rollypay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rollypay_payments_id_seq OWNED BY public.rollypay_payments.id;


--
-- Name: saved_payment_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_payment_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    yookassa_payment_method_id character varying(255) NOT NULL,
    method_type character varying(50) NOT NULL,
    card_first6 character varying(6),
    card_last4 character varying(4),
    card_type character varying(50),
    card_expiry_month character varying(2),
    card_expiry_year character varying(4),
    title character varying(255),
    is_active boolean,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.saved_payment_methods OWNER TO postgres;

--
-- Name: saved_payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saved_payment_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.saved_payment_methods_id_seq OWNER TO postgres;

--
-- Name: saved_payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saved_payment_methods_id_seq OWNED BY public.saved_payment_methods.id;


--
-- Name: sent_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sent_notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    subscription_id integer NOT NULL,
    notification_type character varying(50) NOT NULL,
    days_before integer,
    created_at timestamp with time zone
);


ALTER TABLE public.sent_notifications OWNER TO postgres;

--
-- Name: sent_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sent_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sent_notifications_id_seq OWNER TO postgres;

--
-- Name: sent_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sent_notifications_id_seq OWNED BY public.sent_notifications.id;


--
-- Name: server_squad_promo_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server_squad_promo_groups (
    server_squad_id integer NOT NULL,
    promo_group_id integer NOT NULL
);


ALTER TABLE public.server_squad_promo_groups OWNER TO postgres;

--
-- Name: server_squads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server_squads (
    id integer NOT NULL,
    squad_uuid character varying(255) NOT NULL,
    display_name character varying(255) NOT NULL,
    original_name character varying(255),
    country_code character varying(5),
    is_available boolean,
    is_trial_eligible boolean NOT NULL,
    price_kopeks integer,
    description text,
    sort_order integer,
    max_users integer,
    current_users integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.server_squads OWNER TO postgres;

--
-- Name: server_squads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.server_squads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.server_squads_id_seq OWNER TO postgres;

--
-- Name: server_squads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.server_squads_id_seq OWNED BY public.server_squads.id;


--
-- Name: service_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_rules (
    id integer NOT NULL,
    "order" integer,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    is_active boolean,
    language character varying(5),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.service_rules OWNER TO postgres;

--
-- Name: service_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_rules_id_seq OWNER TO postgres;

--
-- Name: service_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_rules_id_seq OWNED BY public.service_rules.id;


--
-- Name: severpay_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.severpay_payments (
    id integer NOT NULL,
    user_id integer,
    order_id character varying(64) NOT NULL,
    severpay_id character varying(64),
    severpay_uid character varying(64),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    is_paid boolean,
    payment_url text,
    payment_method character varying(32),
    metadata_json json,
    callback_payload json,
    paid_at timestamp with time zone,
    expires_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    transaction_id integer
);


ALTER TABLE public.severpay_payments OWNER TO postgres;

--
-- Name: severpay_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.severpay_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.severpay_payments_id_seq OWNER TO postgres;

--
-- Name: severpay_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.severpay_payments_id_seq OWNED BY public.severpay_payments.id;


--
-- Name: squads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.squads (
    id integer NOT NULL,
    uuid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    country_code character varying(5),
    is_available boolean,
    price_kopeks integer,
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.squads OWNER TO postgres;

--
-- Name: squads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.squads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.squads_id_seq OWNER TO postgres;

--
-- Name: squads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.squads_id_seq OWNED BY public.squads.id;


--
-- Name: subscription_conversions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_conversions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    converted_at timestamp with time zone,
    trial_duration_days integer,
    payment_method character varying(50),
    first_payment_amount_kopeks integer,
    first_paid_period_days integer,
    created_at timestamp with time zone
);


ALTER TABLE public.subscription_conversions OWNER TO postgres;

--
-- Name: subscription_conversions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_conversions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_conversions_id_seq OWNER TO postgres;

--
-- Name: subscription_conversions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_conversions_id_seq OWNED BY public.subscription_conversions.id;


--
-- Name: subscription_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_events (
    id integer NOT NULL,
    event_type character varying(50) NOT NULL,
    user_id integer NOT NULL,
    subscription_id integer,
    transaction_id integer,
    amount_kopeks integer,
    currency character varying(16),
    message text,
    occurred_at timestamp with time zone NOT NULL,
    extra json,
    created_at timestamp with time zone
);


ALTER TABLE public.subscription_events OWNER TO postgres;

--
-- Name: subscription_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_events_id_seq OWNER TO postgres;

--
-- Name: subscription_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_events_id_seq OWNED BY public.subscription_events.id;


--
-- Name: subscription_servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_servers (
    id integer NOT NULL,
    subscription_id integer NOT NULL,
    server_squad_id integer NOT NULL,
    connected_at timestamp with time zone,
    paid_price_kopeks integer
);


ALTER TABLE public.subscription_servers OWNER TO postgres;

--
-- Name: subscription_servers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_servers_id_seq OWNER TO postgres;

--
-- Name: subscription_servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_servers_id_seq OWNED BY public.subscription_servers.id;


--
-- Name: subscription_temporary_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_temporary_access (
    id integer NOT NULL,
    subscription_id integer NOT NULL,
    offer_id integer NOT NULL,
    squad_uuid character varying(255) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone,
    deactivated_at timestamp with time zone,
    is_active boolean NOT NULL,
    was_already_connected boolean NOT NULL
);


ALTER TABLE public.subscription_temporary_access OWNER TO postgres;

--
-- Name: subscription_temporary_access_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_temporary_access_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_temporary_access_id_seq OWNER TO postgres;

--
-- Name: subscription_temporary_access_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_temporary_access_id_seq OWNED BY public.subscription_temporary_access.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(20),
    is_trial boolean,
    start_date timestamp with time zone,
    end_date timestamp with time zone NOT NULL,
    traffic_limit_gb integer,
    traffic_used_gb double precision,
    purchased_traffic_gb integer,
    traffic_reset_at timestamp with time zone,
    subscription_url character varying,
    subscription_crypto_link character varying,
    device_limit integer,
    modem_enabled boolean,
    connected_squads json,
    autopay_enabled boolean,
    autopay_days_before integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    last_webhook_update_at timestamp with time zone,
    last_revoke_at timestamp with time zone,
    remnawave_short_uuid character varying(255),
    remnawave_uuid character varying(255),
    remnawave_short_id character varying(16) DEFAULT ''::character varying NOT NULL,
    tariff_id integer,
    is_daily_paused boolean NOT NULL,
    last_daily_charge_at timestamp with time zone
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_id_seq OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: support_audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_audit_logs (
    id integer NOT NULL,
    actor_user_id integer,
    actor_telegram_id bigint,
    is_moderator boolean,
    action character varying(50) NOT NULL,
    ticket_id integer,
    target_user_id integer,
    details json,
    created_at timestamp with time zone
);


ALTER TABLE public.support_audit_logs OWNER TO postgres;

--
-- Name: support_audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_audit_logs_id_seq OWNER TO postgres;

--
-- Name: support_audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_audit_logs_id_seq OWNED BY public.support_audit_logs.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_settings (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.system_settings OWNER TO postgres;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.system_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_settings_id_seq OWNER TO postgres;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: tariff_promo_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariff_promo_groups (
    tariff_id integer NOT NULL,
    promo_group_id integer NOT NULL
);


ALTER TABLE public.tariff_promo_groups OWNER TO postgres;

--
-- Name: tariffs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariffs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    display_order integer NOT NULL,
    is_active boolean NOT NULL,
    traffic_limit_gb integer NOT NULL,
    device_limit integer NOT NULL,
    device_price_kopeks integer,
    max_device_limit integer,
    allowed_squads json,
    server_traffic_limits json,
    period_prices json NOT NULL,
    tier_level integer NOT NULL,
    is_trial_available boolean NOT NULL,
    allow_traffic_topup boolean NOT NULL,
    traffic_topup_enabled boolean NOT NULL,
    traffic_topup_packages json,
    max_topup_traffic_gb integer NOT NULL,
    is_daily boolean NOT NULL,
    daily_price_kopeks integer NOT NULL,
    custom_days_enabled boolean NOT NULL,
    price_per_day_kopeks integer NOT NULL,
    min_days integer NOT NULL,
    max_days integer NOT NULL,
    custom_traffic_enabled boolean NOT NULL,
    traffic_price_per_gb_kopeks integer NOT NULL,
    min_traffic_gb integer NOT NULL,
    max_traffic_gb integer NOT NULL,
    show_in_gift boolean DEFAULT true NOT NULL,
    traffic_reset_mode character varying(20),
    external_squad_uuid character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.tariffs OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariffs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tariffs_id_seq OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariffs_id_seq OWNED BY public.tariffs.id;


--
-- Name: ticket_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_messages (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    message_text text NOT NULL,
    is_from_admin boolean NOT NULL,
    has_media boolean,
    media_type character varying(20),
    media_file_id character varying(255),
    media_caption text,
    media_items jsonb,
    created_at timestamp with time zone
);


ALTER TABLE public.ticket_messages OWNER TO postgres;

--
-- Name: ticket_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_messages_id_seq OWNER TO postgres;

--
-- Name: ticket_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_messages_id_seq OWNED BY public.ticket_messages.id;


--
-- Name: ticket_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_notifications (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    notification_type character varying(50) NOT NULL,
    message text,
    is_for_admin boolean NOT NULL,
    is_read boolean NOT NULL,
    created_at timestamp with time zone,
    read_at timestamp with time zone
);


ALTER TABLE public.ticket_notifications OWNER TO postgres;

--
-- Name: ticket_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_notifications_id_seq OWNER TO postgres;

--
-- Name: ticket_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_notifications_id_seq OWNED BY public.ticket_notifications.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    status character varying(20) NOT NULL,
    priority character varying(20) NOT NULL,
    user_reply_block_permanent boolean NOT NULL,
    user_reply_block_until timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    closed_at timestamp with time zone,
    last_sla_reminder_at timestamp with time zone
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_id_seq OWNER TO postgres;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: traffic_purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_purchases (
    id integer NOT NULL,
    subscription_id integer NOT NULL,
    traffic_gb integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.traffic_purchases OWNER TO postgres;

--
-- Name: traffic_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traffic_purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_purchases_id_seq OWNER TO postgres;

--
-- Name: traffic_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traffic_purchases_id_seq OWNED BY public.traffic_purchases.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    amount_kopeks integer NOT NULL,
    description text,
    payment_method character varying(50),
    external_id character varying(255),
    is_completed boolean,
    receipt_uuid character varying(255),
    receipt_created_at timestamp with time zone,
    created_at timestamp with time zone,
    completed_at timestamp with time zone
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_channel_subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_channel_subscriptions (
    id integer NOT NULL,
    telegram_id bigint NOT NULL,
    channel_id character varying(100) NOT NULL,
    is_member boolean DEFAULT false NOT NULL,
    checked_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_channel_subscriptions OWNER TO postgres;

--
-- Name: user_channel_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_channel_subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_channel_subscriptions_id_seq OWNER TO postgres;

--
-- Name: user_channel_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_channel_subscriptions_id_seq OWNED BY public.user_channel_subscriptions.id;


--
-- Name: user_device_aliases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_device_aliases (
    id integer NOT NULL,
    user_id integer NOT NULL,
    hwid character varying(255) NOT NULL,
    alias character varying(64) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_device_aliases OWNER TO postgres;

--
-- Name: user_device_aliases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_device_aliases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_device_aliases_id_seq OWNER TO postgres;

--
-- Name: user_device_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_device_aliases_id_seq OWNED BY public.user_device_aliases.id;


--
-- Name: user_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_messages (
    id integer NOT NULL,
    message_text text NOT NULL,
    is_active boolean,
    sort_order integer,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.user_messages OWNER TO postgres;

--
-- Name: user_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_messages_id_seq OWNER TO postgres;

--
-- Name: user_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_messages_id_seq OWNED BY public.user_messages.id;


--
-- Name: user_promo_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_promo_groups (
    user_id integer NOT NULL,
    promo_group_id integer NOT NULL,
    assigned_at timestamp with time zone,
    assigned_by character varying(50)
);


ALTER TABLE public.user_promo_groups OWNER TO postgres;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    assigned_by integer,
    assigned_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone,
    is_active boolean NOT NULL,
    revocation_source character varying(20)
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    telegram_id bigint,
    auth_type character varying(20) NOT NULL,
    username character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    status character varying(20),
    language character varying(5),
    balance_kopeks integer,
    used_promocodes integer,
    has_had_paid_subscription boolean NOT NULL,
    referred_by_id integer,
    referral_code character varying(20),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    last_activity timestamp with time zone,
    remnawave_uuid character varying(255),
    email character varying(255),
    email_verified boolean NOT NULL,
    email_verified_at timestamp with time zone,
    password_hash character varying(255),
    email_verification_token character varying(255),
    email_verification_expires timestamp with time zone,
    password_reset_token character varying(255),
    password_reset_expires timestamp with time zone,
    cabinet_last_login timestamp with time zone,
    pending_campaign_slug character varying(64),
    email_change_new character varying(255),
    email_change_code character varying(6),
    email_change_expires timestamp with time zone,
    google_id character varying(255),
    yandex_id character varying(255),
    discord_id character varying(255),
    vk_id bigint,
    lifetime_used_traffic_bytes bigint,
    auto_promo_group_assigned boolean NOT NULL,
    auto_promo_group_threshold_kopeks bigint NOT NULL,
    referral_commission_percent integer,
    promo_offer_discount_percent integer NOT NULL,
    promo_offer_discount_source character varying(100),
    promo_offer_discount_expires_at timestamp with time zone,
    last_remnawave_sync timestamp with time zone,
    trojan_password character varying(255),
    vless_uuid character varying(255),
    ss_password character varying(255),
    has_made_first_topup boolean NOT NULL,
    promo_group_id integer,
    notification_settings jsonb,
    last_pinned_message_id integer,
    restriction_topup boolean NOT NULL,
    restriction_subscription boolean NOT NULL,
    restriction_reason character varying(500),
    partner_status character varying(20) NOT NULL,
    email_verification_source character varying(32)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wata_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wata_payments (
    id integer NOT NULL,
    user_id integer,
    payment_link_id character varying(64) NOT NULL,
    order_id character varying(255),
    amount_kopeks integer NOT NULL,
    currency character varying(10) NOT NULL,
    description text,
    type character varying(50),
    status character varying(50) NOT NULL,
    is_paid boolean,
    paid_at timestamp with time zone,
    last_status character varying(50),
    terminal_public_id character varying(64),
    url text,
    success_redirect_url text,
    fail_redirect_url text,
    metadata_json json,
    callback_payload json,
    expires_at timestamp with time zone,
    transaction_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.wata_payments OWNER TO postgres;

--
-- Name: wata_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wata_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wata_payments_id_seq OWNER TO postgres;

--
-- Name: wata_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wata_payments_id_seq OWNED BY public.wata_payments.id;


--
-- Name: web_api_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_api_tokens (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    token_hash character varying(128) NOT NULL,
    token_prefix character varying(32) NOT NULL,
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    expires_at timestamp with time zone,
    last_used_at timestamp with time zone,
    last_used_ip character varying(64),
    is_active boolean NOT NULL,
    created_by character varying(255)
);


ALTER TABLE public.web_api_tokens OWNER TO postgres;

--
-- Name: web_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.web_api_tokens_id_seq OWNER TO postgres;

--
-- Name: web_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_api_tokens_id_seq OWNED BY public.web_api_tokens.id;


--
-- Name: webhook_deliveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_deliveries (
    id integer NOT NULL,
    webhook_id integer NOT NULL,
    event_type character varying(50) NOT NULL,
    payload json NOT NULL,
    response_status integer,
    response_body text,
    status character varying(20) NOT NULL,
    error_message text,
    attempt_number integer NOT NULL,
    created_at timestamp with time zone,
    delivered_at timestamp with time zone,
    next_retry_at timestamp with time zone
);


ALTER TABLE public.webhook_deliveries OWNER TO postgres;

--
-- Name: webhook_deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhook_deliveries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.webhook_deliveries_id_seq OWNER TO postgres;

--
-- Name: webhook_deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhook_deliveries_id_seq OWNED BY public.webhook_deliveries.id;


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    url text NOT NULL,
    secret character varying(128),
    event_type character varying(50) NOT NULL,
    is_active boolean NOT NULL,
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    last_triggered_at timestamp with time zone,
    failure_count integer NOT NULL,
    success_count integer NOT NULL
);


ALTER TABLE public.webhooks OWNER TO postgres;

--
-- Name: webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.webhooks_id_seq OWNER TO postgres;

--
-- Name: webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhooks_id_seq OWNED BY public.webhooks.id;


--
-- Name: welcome_texts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.welcome_texts (
    id integer NOT NULL,
    text_content text NOT NULL,
    is_active boolean,
    is_enabled boolean,
    created_by integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.welcome_texts OWNER TO postgres;

--
-- Name: welcome_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.welcome_texts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.welcome_texts_id_seq OWNER TO postgres;

--
-- Name: welcome_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.welcome_texts_id_seq OWNED BY public.welcome_texts.id;


--
-- Name: wheel_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wheel_configs (
    id integer NOT NULL,
    is_enabled boolean NOT NULL,
    name character varying(255) NOT NULL,
    spin_cost_stars integer NOT NULL,
    spin_cost_days integer NOT NULL,
    spin_cost_stars_enabled boolean NOT NULL,
    spin_cost_days_enabled boolean NOT NULL,
    rtp_percent integer NOT NULL,
    daily_spin_limit integer NOT NULL,
    min_subscription_days_for_day_payment integer NOT NULL,
    promo_prefix character varying(20) NOT NULL,
    promo_validity_days integer NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.wheel_configs OWNER TO postgres;

--
-- Name: wheel_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wheel_configs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wheel_configs_id_seq OWNER TO postgres;

--
-- Name: wheel_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wheel_configs_id_seq OWNED BY public.wheel_configs.id;


--
-- Name: wheel_prizes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wheel_prizes (
    id integer NOT NULL,
    config_id integer NOT NULL,
    prize_type character varying(50) NOT NULL,
    prize_value integer NOT NULL,
    display_name character varying(100) NOT NULL,
    emoji character varying(10) NOT NULL,
    color character varying(20) NOT NULL,
    prize_value_kopeks integer NOT NULL,
    sort_order integer NOT NULL,
    manual_probability double precision,
    is_active boolean NOT NULL,
    promo_balance_bonus_kopeks integer,
    promo_subscription_days integer,
    promo_traffic_gb integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.wheel_prizes OWNER TO postgres;

--
-- Name: wheel_prizes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wheel_prizes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wheel_prizes_id_seq OWNER TO postgres;

--
-- Name: wheel_prizes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wheel_prizes_id_seq OWNED BY public.wheel_prizes.id;


--
-- Name: wheel_spins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wheel_spins (
    id integer NOT NULL,
    user_id integer NOT NULL,
    prize_id integer,
    payment_type character varying(50) NOT NULL,
    payment_amount integer NOT NULL,
    payment_value_kopeks integer NOT NULL,
    prize_type character varying(50) NOT NULL,
    prize_value integer NOT NULL,
    prize_display_name character varying(100) NOT NULL,
    prize_value_kopeks integer NOT NULL,
    generated_promocode_id integer,
    is_applied boolean NOT NULL,
    applied_at timestamp with time zone,
    created_at timestamp with time zone
);


ALTER TABLE public.wheel_spins OWNER TO postgres;

--
-- Name: wheel_spins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wheel_spins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wheel_spins_id_seq OWNER TO postgres;

--
-- Name: wheel_spins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wheel_spins_id_seq OWNED BY public.wheel_spins.id;


--
-- Name: withdrawal_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.withdrawal_requests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    amount_kopeks integer NOT NULL,
    status character varying(50) NOT NULL,
    payment_details text,
    risk_score integer,
    risk_analysis text,
    processed_by integer,
    processed_at timestamp with time zone,
    admin_comment text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.withdrawal_requests OWNER TO postgres;

--
-- Name: withdrawal_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.withdrawal_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.withdrawal_requests_id_seq OWNER TO postgres;

--
-- Name: withdrawal_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.withdrawal_requests_id_seq OWNED BY public.withdrawal_requests.id;


--
-- Name: yandex_client_id_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yandex_client_id_map (
    id integer NOT NULL,
    user_id integer NOT NULL,
    yandex_cid character varying(128) NOT NULL,
    source character varying(20) DEFAULT 'web'::character varying NOT NULL,
    counter_id character varying(32),
    registration_sent boolean DEFAULT false NOT NULL,
    trial_sent boolean DEFAULT false NOT NULL,
    subid character varying(255),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.yandex_client_id_map OWNER TO postgres;

--
-- Name: yandex_client_id_map_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yandex_client_id_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.yandex_client_id_map_id_seq OWNER TO postgres;

--
-- Name: yandex_client_id_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yandex_client_id_map_id_seq OWNED BY public.yandex_client_id_map.id;


--
-- Name: yookassa_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yookassa_payments (
    id integer NOT NULL,
    user_id integer,
    yookassa_payment_id character varying(255) NOT NULL,
    amount_kopeks integer NOT NULL,
    currency character varying(3) NOT NULL,
    description text,
    status character varying(50) NOT NULL,
    is_paid boolean,
    is_captured boolean,
    confirmation_url text,
    metadata_json json,
    transaction_id integer,
    payment_method_type character varying(50),
    refundable boolean,
    test_mode boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    yookassa_created_at timestamp with time zone,
    captured_at timestamp with time zone
);


ALTER TABLE public.yookassa_payments OWNER TO postgres;

--
-- Name: yookassa_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yookassa_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.yookassa_payments_id_seq OWNER TO postgres;

--
-- Name: yookassa_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yookassa_payments_id_seq OWNED BY public.yookassa_payments.id;


--
-- Name: access_policies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_policies ALTER COLUMN id SET DEFAULT nextval('public.access_policies_id_seq'::regclass);


--
-- Name: admin_audit_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_log ALTER COLUMN id SET DEFAULT nextval('public.admin_audit_log_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: advertising_campaign_registrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations ALTER COLUMN id SET DEFAULT nextval('public.advertising_campaign_registrations_id_seq'::regclass);


--
-- Name: advertising_campaigns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaigns ALTER COLUMN id SET DEFAULT nextval('public.advertising_campaigns_id_seq'::regclass);


--
-- Name: antilopay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antilopay_payments ALTER COLUMN id SET DEFAULT nextval('public.antilopay_payments_id_seq'::regclass);


--
-- Name: apple_iap_abuse_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_abuse_events ALTER COLUMN id SET DEFAULT nextval('public.apple_iap_abuse_events_id_seq'::regclass);


--
-- Name: apple_iap_accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_accounts ALTER COLUMN id SET DEFAULT nextval('public.apple_iap_accounts_id_seq'::regclass);


--
-- Name: apple_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_notifications ALTER COLUMN id SET DEFAULT nextval('public.apple_notifications_id_seq'::regclass);


--
-- Name: apple_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_transactions ALTER COLUMN id SET DEFAULT nextval('public.apple_transactions_id_seq'::regclass);


--
-- Name: aurapay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aurapay_payments ALTER COLUMN id SET DEFAULT nextval('public.aurapay_payments_id_seq'::regclass);


--
-- Name: broadcast_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_history ALTER COLUMN id SET DEFAULT nextval('public.broadcast_history_id_seq'::regclass);


--
-- Name: button_click_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.button_click_logs ALTER COLUMN id SET DEFAULT nextval('public.button_click_logs_id_seq'::regclass);


--
-- Name: cabinet_refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet_refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.cabinet_refresh_tokens_id_seq'::regclass);


--
-- Name: cloudpayments_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloudpayments_payments ALTER COLUMN id SET DEFAULT nextval('public.cloudpayments_payments_id_seq'::regclass);


--
-- Name: contest_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_attempts ALTER COLUMN id SET DEFAULT nextval('public.contest_attempts_id_seq'::regclass);


--
-- Name: contest_rounds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rounds ALTER COLUMN id SET DEFAULT nextval('public.contest_rounds_id_seq'::regclass);


--
-- Name: contest_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_templates ALTER COLUMN id SET DEFAULT nextval('public.contest_templates_id_seq'::regclass);


--
-- Name: cryptobot_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptobot_payments ALTER COLUMN id SET DEFAULT nextval('public.cryptobot_payments_id_seq'::regclass);


--
-- Name: discount_offers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_offers ALTER COLUMN id SET DEFAULT nextval('public.discount_offers_id_seq'::regclass);


--
-- Name: donut_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donut_payments ALTER COLUMN id SET DEFAULT nextval('public.donut_payments_id_seq'::regclass);


--
-- Name: email_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates ALTER COLUMN id SET DEFAULT nextval('public.email_templates_id_seq'::regclass);


--
-- Name: etoplatezhi_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etoplatezhi_payments ALTER COLUMN id SET DEFAULT nextval('public.etoplatezhi_payments_id_seq'::regclass);


--
-- Name: faq_pages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faq_pages ALTER COLUMN id SET DEFAULT nextval('public.faq_pages_id_seq'::regclass);


--
-- Name: faq_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faq_settings ALTER COLUMN id SET DEFAULT nextval('public.faq_settings_id_seq'::regclass);


--
-- Name: freekassa_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freekassa_payments ALTER COLUMN id SET DEFAULT nextval('public.freekassa_payments_id_seq'::regclass);


--
-- Name: guest_purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases ALTER COLUMN id SET DEFAULT nextval('public.guest_purchases_id_seq'::regclass);


--
-- Name: heleket_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heleket_payments ALTER COLUMN id SET DEFAULT nextval('public.heleket_payments_id_seq'::regclass);


--
-- Name: info_pages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_pages ALTER COLUMN id SET DEFAULT nextval('public.info_pages_id_seq'::regclass);


--
-- Name: jupiter_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jupiter_payments ALTER COLUMN id SET DEFAULT nextval('public.jupiter_payments_id_seq'::regclass);


--
-- Name: kassa_ai_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassa_ai_payments ALTER COLUMN id SET DEFAULT nextval('public.kassa_ai_payments_id_seq'::regclass);


--
-- Name: landing_pages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.landing_pages ALTER COLUMN id SET DEFAULT nextval('public.landing_pages_id_seq'::regclass);


--
-- Name: lava_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lava_payments ALTER COLUMN id SET DEFAULT nextval('public.lava_payments_id_seq'::regclass);


--
-- Name: main_menu_buttons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_menu_buttons ALTER COLUMN id SET DEFAULT nextval('public.main_menu_buttons_id_seq'::regclass);


--
-- Name: menu_layout_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_layout_history ALTER COLUMN id SET DEFAULT nextval('public.menu_layout_history_id_seq'::regclass);


--
-- Name: monitoring_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoring_logs ALTER COLUMN id SET DEFAULT nextval('public.monitoring_logs_id_seq'::regclass);


--
-- Name: mulenpay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mulenpay_payments ALTER COLUMN id SET DEFAULT nextval('public.mulenpay_payments_id_seq'::regclass);


--
-- Name: news_articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN id SET DEFAULT nextval('public.news_articles_id_seq'::regclass);


--
-- Name: news_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_categories ALTER COLUMN id SET DEFAULT nextval('public.news_categories_id_seq'::regclass);


--
-- Name: news_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_tags ALTER COLUMN id SET DEFAULT nextval('public.news_tags_id_seq'::regclass);


--
-- Name: overpay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpay_payments ALTER COLUMN id SET DEFAULT nextval('public.overpay_payments_id_seq'::regclass);


--
-- Name: pal24_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pal24_payments ALTER COLUMN id SET DEFAULT nextval('public.pal24_payments_id_seq'::regclass);


--
-- Name: partner_applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_applications ALTER COLUMN id SET DEFAULT nextval('public.partner_applications_id_seq'::regclass);


--
-- Name: payment_method_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method_configs ALTER COLUMN id SET DEFAULT nextval('public.payment_method_configs_id_seq'::regclass);


--
-- Name: paypear_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypear_payments ALTER COLUMN id SET DEFAULT nextval('public.paypear_payments_id_seq'::regclass);


--
-- Name: pinned_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pinned_messages ALTER COLUMN id SET DEFAULT nextval('public.pinned_messages_id_seq'::regclass);


--
-- Name: platega_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platega_payments ALTER COLUMN id SET DEFAULT nextval('public.platega_payments_id_seq'::regclass);


--
-- Name: poll_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers ALTER COLUMN id SET DEFAULT nextval('public.poll_answers_id_seq'::regclass);


--
-- Name: poll_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_options ALTER COLUMN id SET DEFAULT nextval('public.poll_options_id_seq'::regclass);


--
-- Name: poll_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_questions ALTER COLUMN id SET DEFAULT nextval('public.poll_questions_id_seq'::regclass);


--
-- Name: poll_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_responses ALTER COLUMN id SET DEFAULT nextval('public.poll_responses_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls ALTER COLUMN id SET DEFAULT nextval('public.polls_id_seq'::regclass);


--
-- Name: privacy_policies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_policies ALTER COLUMN id SET DEFAULT nextval('public.privacy_policies_id_seq'::regclass);


--
-- Name: promo_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_groups ALTER COLUMN id SET DEFAULT nextval('public.promo_groups_id_seq'::regclass);


--
-- Name: promo_offer_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_logs ALTER COLUMN id SET DEFAULT nextval('public.promo_offer_logs_id_seq'::regclass);


--
-- Name: promo_offer_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_templates ALTER COLUMN id SET DEFAULT nextval('public.promo_offer_templates_id_seq'::regclass);


--
-- Name: promocode_uses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocode_uses ALTER COLUMN id SET DEFAULT nextval('public.promocode_uses_id_seq'::regclass);


--
-- Name: promocodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes ALTER COLUMN id SET DEFAULT nextval('public.promocodes_id_seq'::regclass);


--
-- Name: public_offers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_offers ALTER COLUMN id SET DEFAULT nextval('public.public_offers_id_seq'::regclass);


--
-- Name: referral_contest_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events ALTER COLUMN id SET DEFAULT nextval('public.referral_contest_events_id_seq'::regclass);


--
-- Name: referral_contest_virtual_participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_virtual_participants ALTER COLUMN id SET DEFAULT nextval('public.referral_contest_virtual_participants_id_seq'::regclass);


--
-- Name: referral_contests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contests ALTER COLUMN id SET DEFAULT nextval('public.referral_contests_id_seq'::regclass);


--
-- Name: referral_earnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings ALTER COLUMN id SET DEFAULT nextval('public.referral_earnings_id_seq'::regclass);


--
-- Name: required_channels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_channels ALTER COLUMN id SET DEFAULT nextval('public.required_channels_id_seq'::regclass);


--
-- Name: riopay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riopay_payments ALTER COLUMN id SET DEFAULT nextval('public.riopay_payments_id_seq'::regclass);


--
-- Name: rollypay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rollypay_payments ALTER COLUMN id SET DEFAULT nextval('public.rollypay_payments_id_seq'::regclass);


--
-- Name: saved_payment_methods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_payment_methods ALTER COLUMN id SET DEFAULT nextval('public.saved_payment_methods_id_seq'::regclass);


--
-- Name: sent_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_notifications ALTER COLUMN id SET DEFAULT nextval('public.sent_notifications_id_seq'::regclass);


--
-- Name: server_squads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_squads ALTER COLUMN id SET DEFAULT nextval('public.server_squads_id_seq'::regclass);


--
-- Name: service_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_rules ALTER COLUMN id SET DEFAULT nextval('public.service_rules_id_seq'::regclass);


--
-- Name: severpay_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.severpay_payments ALTER COLUMN id SET DEFAULT nextval('public.severpay_payments_id_seq'::regclass);


--
-- Name: squads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.squads ALTER COLUMN id SET DEFAULT nextval('public.squads_id_seq'::regclass);


--
-- Name: subscription_conversions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_conversions ALTER COLUMN id SET DEFAULT nextval('public.subscription_conversions_id_seq'::regclass);


--
-- Name: subscription_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_events ALTER COLUMN id SET DEFAULT nextval('public.subscription_events_id_seq'::regclass);


--
-- Name: subscription_servers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_servers ALTER COLUMN id SET DEFAULT nextval('public.subscription_servers_id_seq'::regclass);


--
-- Name: subscription_temporary_access id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_temporary_access ALTER COLUMN id SET DEFAULT nextval('public.subscription_temporary_access_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: support_audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_audit_logs ALTER COLUMN id SET DEFAULT nextval('public.support_audit_logs_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: tariffs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs ALTER COLUMN id SET DEFAULT nextval('public.tariffs_id_seq'::regclass);


--
-- Name: ticket_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_messages ALTER COLUMN id SET DEFAULT nextval('public.ticket_messages_id_seq'::regclass);


--
-- Name: ticket_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_notifications ALTER COLUMN id SET DEFAULT nextval('public.ticket_notifications_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: traffic_purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_purchases ALTER COLUMN id SET DEFAULT nextval('public.traffic_purchases_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_channel_subscriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_channel_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.user_channel_subscriptions_id_seq'::regclass);


--
-- Name: user_device_aliases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_device_aliases ALTER COLUMN id SET DEFAULT nextval('public.user_device_aliases_id_seq'::regclass);


--
-- Name: user_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_messages ALTER COLUMN id SET DEFAULT nextval('public.user_messages_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wata_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wata_payments ALTER COLUMN id SET DEFAULT nextval('public.wata_payments_id_seq'::regclass);


--
-- Name: web_api_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.web_api_tokens_id_seq'::regclass);


--
-- Name: webhook_deliveries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_deliveries ALTER COLUMN id SET DEFAULT nextval('public.webhook_deliveries_id_seq'::regclass);


--
-- Name: webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks ALTER COLUMN id SET DEFAULT nextval('public.webhooks_id_seq'::regclass);


--
-- Name: welcome_texts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.welcome_texts ALTER COLUMN id SET DEFAULT nextval('public.welcome_texts_id_seq'::regclass);


--
-- Name: wheel_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_configs ALTER COLUMN id SET DEFAULT nextval('public.wheel_configs_id_seq'::regclass);


--
-- Name: wheel_prizes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_prizes ALTER COLUMN id SET DEFAULT nextval('public.wheel_prizes_id_seq'::regclass);


--
-- Name: wheel_spins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_spins ALTER COLUMN id SET DEFAULT nextval('public.wheel_spins_id_seq'::regclass);


--
-- Name: withdrawal_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_requests ALTER COLUMN id SET DEFAULT nextval('public.withdrawal_requests_id_seq'::regclass);


--
-- Name: yandex_client_id_map id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yandex_client_id_map ALTER COLUMN id SET DEFAULT nextval('public.yandex_client_id_map_id_seq'::regclass);


--
-- Name: yookassa_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yookassa_payments ALTER COLUMN id SET DEFAULT nextval('public.yookassa_payments_id_seq'::regclass);


--
-- Data for Name: access_policies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.access_policies (id, name, description, role_id, priority, effect, conditions, resource, actions, is_active, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: admin_audit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_audit_log (id, user_id, action, resource_type, resource_id, details, ip_address, user_agent, status, request_method, request_path, created_at) FROM stdin;
1	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:02:08.094721+00
2	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 20:02:08.405871+00
3	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 20:02:08.406401+00
4	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-15 20:02:14.961996+00
5	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-15 20:02:14.962079+00
6	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-15 20:02:20.735763+00
7	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-15 20:02:23.736862+00
8	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/squads", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/squads	2026-05-15 20:02:26.409725+00
9	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-15 20:02:32.2733+00
10	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-15 20:02:42.411624+00
11	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 20:03:01.133188+00
12	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 20:03:01.135695+00
13	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:03:01.136535+00
14	1	email_templates:read	email_templates	\N	{"path": "/cabinet/admin/email-templates", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/email-templates	2026-05-15 20:03:05.05821+00
15	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 20:03:13.499343+00
16	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 20:03:13.499721+00
17	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 20:03:42.593494+00
18	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:03:42.597614+00
19	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 20:03:42.598+00
20	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-15 20:03:46.330578+00
21	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:04:45.987093+00
22	1	settings:edit	settings	\N	{"path": "/cabinet/branding/animation-config", "method": "PATCH", "request_body": {"blur": 0, "type": "vortex", "enabled": true, "opacity": 1, "settings": {"rangeY": 100, "baseHue": 220, "rangeSpeed": 1.5, "particleCount": 300, "backgroundColor": "#000000"}, "reducedOnMobile": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/animation-config	2026-05-15 20:04:56.459192+00
23	1	settings:edit	settings	\N	{"path": "/cabinet/branding/animation-config", "method": "PATCH", "request_body": {"blur": 0, "type": "background-lines", "enabled": true, "opacity": 1, "settings": {"speed": 0.002, "lineColor": "#818cf8", "lineCount": 40, "strokeWidth": 1}, "reducedOnMobile": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/animation-config	2026-05-15 20:05:42.172531+00
24	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:05:46.12233+00
29	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:06:46.240105+00
25	1	settings:edit	settings	\N	{"path": "/cabinet/branding/animation-config", "method": "PATCH", "request_body": {"blur": 0, "type": "shooting-stars", "enabled": true, "opacity": 1, "settings": {"maxSpeed": 30, "minSpeed": 10, "starColor": "#9E00FF", "trailColor": "#2EB9DF", "starDensity": 0.00015}, "reducedOnMobile": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/animation-config	2026-05-15 20:06:30.936264+00
32	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#f43f5e", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#fff1f2", "lightText": "#881337", "darkSurface": "#2d1520", "lightSurface": "#fff1f2", "darkBackground": "#1a0a10", "lightBackground": "#ffe4e6", "darkTextSecondary": "#fda4af", "lightTextSecondary": "#be123c"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:51.532234+00
40	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-15 20:10:54.773954+00
26	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#0ea5e9", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#f1f5f9", "lightText": "#0c4a6e", "darkSurface": "#1e293b", "lightSurface": "#f0f9ff", "darkBackground": "#0c1222", "lightBackground": "#e0f2fe", "darkTextSecondary": "#94a3b8", "lightTextSecondary": "#0369a1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:41.229611+00
34	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#6366f1", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#f9fafb", "lightText": "#111827", "darkSurface": "#111827", "lightSurface": "#f3f4f6", "darkBackground": "#030712", "lightBackground": "#e5e7eb", "darkTextSecondary": "#9ca3af", "lightTextSecondary": "#4b5563"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:54.2532+00
44	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 20:13:08.215308+00
27	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#22c55e", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#f0fdf4", "lightText": "#14532d", "darkSurface": "#14532d", "lightSurface": "#f0fdf4", "darkBackground": "#0a1a0f", "lightBackground": "#dcfce7", "darkTextSecondary": "#86efac", "lightTextSecondary": "#166534"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:43.248076+00
28	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#f97316", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#fff7ed", "lightText": "#7c2d12", "darkSurface": "#2d1a0e", "lightSurface": "#fff7ed", "darkBackground": "#1c1009", "lightBackground": "#ffedd5", "darkTextSecondary": "#fdba74", "lightTextSecondary": "#c2410c"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:45.023385+00
36	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:07:58.450171+00
30	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#14b8a6", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#f0fdfa", "lightText": "#134e4a", "darkSurface": "#134e4a", "lightSurface": "#f0fdfa", "darkBackground": "#0a1614", "lightBackground": "#ccfbf1", "darkTextSecondary": "#5eead4", "lightTextSecondary": "#0f766e"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:46.436435+00
38	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:10:10.866973+00
31	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#6366f1", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#f9fafb", "lightText": "#111827", "darkSurface": "#111827", "lightSurface": "#f3f4f6", "darkBackground": "#030712", "lightBackground": "#e5e7eb", "darkTextSecondary": "#9ca3af", "lightTextSecondary": "#4b5563"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:47.881022+00
33	1	settings:edit	settings	\N	{"path": "/cabinet/branding/colors", "method": "PATCH", "request_body": {"error": "#ef4444", "accent": "#a855f7", "success": "#22c55e", "warning": "#f59e0b", "darkText": "#faf5ff", "lightText": "#581c87", "darkSurface": "#1e1b2e", "lightSurface": "#faf5ff", "darkBackground": "#0f0a1a", "lightBackground": "#f3e8ff", "darkTextSecondary": "#c4b5fd", "lightTextSecondary": "#7e22ce"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/branding/colors	2026-05-15 20:06:52.569921+00
39	1	settings:edit	settings	\N	{"path": "/cabinet/admin/settings/BACKUP_SEND_ENABLED", "method": "PUT", "request_body": {"value": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/settings/BACKUP_SEND_ENABLED	2026-05-15 20:10:54.625183+00
35	1	settings:read	settings	\N	{"path": "/cabinet/admin/menu-layout", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/menu-layout	2026-05-15 20:07:10.082428+00
42	1	settings:edit	settings	\N	{"path": "/cabinet/branding/name", "method": "PUT", "request_body": {"name": "Mesh"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/branding/name	2026-05-15 20:11:20.010224+00
37	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:08:58.58334+00
41	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:11:10.998386+00
43	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:12:11.216398+00
45	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 20:13:08.215798+00
46	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 20:13:08.240873+00
47	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-15 21:33:09.714098+00
48	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-15 21:33:09.869766+00
49	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-15 21:33:09.870791+00
50	1	roles:read	roles	\N	{"path": "/cabinet/admin/rbac/policies", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/policies	2026-05-15 21:33:23.768417+00
51	1	roles:read	roles	\N	{"path": "/cabinet/admin/rbac/roles", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/roles	2026-05-15 21:33:23.768959+00
52	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 08:58:31.601987+00
53	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 08:58:31.922098+00
54	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 08:58:31.922521+00
55	1	apps:read	apps	\N	{"path": "/cabinet/admin/apps/remnawave/configs", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/apps/remnawave/configs	2026-05-16 08:58:34.958215+00
56	1	apps:read	apps	\N	{"path": "/cabinet/admin/apps/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/apps/remnawave/status	2026-05-16 08:58:34.961059+00
57	1	apps:edit	apps	\N	{"path": "/cabinet/admin/apps/remnawave/uuid", "method": "PUT", "request_body": {"uuid": "00000000-0000-0000-0000-000000000000"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/apps/remnawave/uuid	2026-05-16 08:58:37.76054+00
58	1	apps:read	apps	\N	{"path": "/cabinet/admin/apps/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/apps/remnawave/status	2026-05-16 08:58:37.976202+00
59	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 08:58:48.331625+00
60	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 08:58:48.378144+00
61	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-16 08:58:52.749422+00
62	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 08:59:00.275072+00
63	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 08:59:00.275508+00
64	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 08:59:03.652565+00
65	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-16 08:59:03.958404+00
66	1	servers:edit	servers	\N	{"path": "/cabinet/admin/servers/1/toggle", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/servers/1/toggle	2026-05-16 08:59:10.697009+00
67	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-16 08:59:10.934516+00
68	1	servers:edit	servers	\N	{"path": "/cabinet/admin/servers/sync", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/servers/sync	2026-05-16 08:59:12.927624+00
69	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-16 08:59:15.408462+00
70	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 08:59:18.136786+00
71	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 08:59:18.138317+00
81	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-16 08:59:45.675928+00
82	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 08:59:46.931897+00
94	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-16 09:04:56.52739+00
72	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 08:59:21.79445+00
73	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-16 08:59:21.792983+00
74	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 08:59:25.409739+00
86	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 09:00:00.306909+00
87	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 09:00:11.71656+00
88	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 09:00:17.801889+00
95	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 09:04:58.742546+00
97	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/from-panel", "method": "POST", "request_body": {"mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/from-panel	2026-05-16 09:05:05.784606+00
99	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-16 09:05:16.663846+00
75	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/from-panel", "method": "POST", "request_body": {"mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/from-panel	2026-05-16 08:59:29.264497+00
76	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/to-panel", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/to-panel	2026-05-16 08:59:31.08944+00
77	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 08:59:35.589533+00
89	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 09:00:23.093852+00
96	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/to-panel", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/to-panel	2026-05-16 09:05:03.210898+00
98	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/squads", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/squads	2026-05-16 09:05:08.792403+00
78	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/run", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/auto/run	2026-05-16 08:59:36.265384+00
79	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-16 08:59:41.505427+00
100	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-16 09:05:23.852636+00
80	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-16 08:59:45.086594+00
83	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 08:59:56.382828+00
84	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 08:59:57.301952+00
91	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 09:04:50.044858+00
93	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 09:04:56.52697+00
102	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 09:05:30.304108+00
85	1	remnawave:manage	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/restart-all", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/nodes/restart-all	2026-05-16 09:00:00.156015+00
90	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 09:04:49.971623+00
92	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 09:04:50.043073+00
101	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 09:05:25.351287+00
103	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 12:02:52.761147+00
104	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 12:02:53.005074+00
105	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 12:02:53.005184+00
106	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-16 12:02:59.217734+00
107	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-16 12:03:03.841855+00
108	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-16 12:03:03.843843+00
109	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-16 12:03:03.848666+00
110	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/1	2026-05-16 12:03:03.850072+00
111	1	tariffs:edit	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "PUT", "request_body": {"name": "Стандартный", "is_daily": false, "is_active": true, "tier_level": 1, "description": "Базовый тарифный план", "device_limit": 3, "show_in_gift": true, "period_prices": [{"days": 14, "price_kopeks": 7000, "price_rubles": 70}, {"days": 30, "price_kopeks": 14000, "price_rubles": 10}, {"days": 60, "price_kopeks": 25900, "price_rubles": 259}, {"days": 90, "price_kopeks": 36900, "price_rubles": 369}, {"days": 180, "price_kopeks": 69900, "price_rubles": 699}, {"days": 360, "price_kopeks": 109900, "price_rubles": 1099}], "allowed_squads": [], "traffic_limit_gb": 100, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/tariffs/1	2026-05-16 12:03:17.232689+00
112	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-16 12:03:17.421749+00
113	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 12:03:31.687591+00
114	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 12:03:31.688094+00
115	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 12:03:31.688829+00
116	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:03:38.90676+00
117	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-16 12:03:42.406791+00
118	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:03:42.407178+00
119	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 12:04:50.799565+00
120	1	payment_methods:edit	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/telegram_stars", "method": "PUT", "request_body": {"is_enabled": true, "display_name": "Telegram Stars", "user_type_filter": "all", "max_amount_kopeks": 1000000, "min_amount_kopeks": 100, "first_topup_filter": "any", "allowed_promo_group_ids": [], "promo_group_filter_mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/payment-methods/telegram_stars	2026-05-16 12:05:15.466092+00
121	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:05:15.614054+00
122	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:05:18.85197+00
123	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-16 12:05:18.892751+00
124	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 12:06:03.155738+00
125	1	payment_methods:edit	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/tribute", "method": "PUT", "request_body": {"is_enabled": false, "display_name": "Tribute", "user_type_filter": "all", "max_amount_kopeks": 10000000, "min_amount_kopeks": 10000, "first_topup_filter": "any", "allowed_promo_group_ids": [], "promo_group_filter_mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/payment-methods/tribute	2026-05-16 12:06:16.413537+00
126	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:06:16.552227+00
127	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 12:06:34.112383+00
128	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:06:34.542918+00
129	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:06:36.831107+00
130	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-16 12:06:36.831584+00
131	1	payment_methods:edit	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/tribute", "method": "PUT", "request_body": {"is_enabled": true, "display_name": "Tribute", "user_type_filter": "all", "max_amount_kopeks": 10000000, "min_amount_kopeks": 10000, "first_topup_filter": "any", "allowed_promo_group_ids": [], "promo_group_filter_mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/payment-methods/tribute	2026-05-16 12:06:39.846803+00
132	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:06:39.984628+00
133	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-16 12:06:47.460544+00
134	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-16 12:06:47.461494+00
135	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 14:55:33.80644+00
136	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 14:55:34.120937+00
137	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 14:55:34.123541+00
138	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET", "query_params": {"category_key": "CHANNEL"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-16 14:55:46.06515+00
139	1	channels:read	channels	\N	{"path": "/cabinet/admin/channel-subscriptions", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/channel-subscriptions	2026-05-16 14:55:46.066444+00
140	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 14:55:56.221396+00
141	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 14:55:56.226279+00
142	1	updates:read	updates	\N	{"path": "/cabinet/admin/updates/releases", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/updates/releases	2026-05-16 14:56:01.189639+00
143	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 14:59:52.147511+00
144	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 14:59:52.17082+00
145	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 14:59:52.169874+00
146	1	roles:read	roles	\N	{"path": "/cabinet/admin/rbac/roles", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/roles	2026-05-16 14:59:55.124617+00
147	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 15:00:07.189438+00
148	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 15:00:07.191162+00
149	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 15:00:13.022813+00
150	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-16 15:00:13.026338+00
151	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 15:00:26.185286+00
152	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/run", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/auto/run	2026-05-16 15:00:34.895449+00
153	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 15:00:36.336458+00
154	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 15:00:46.517975+00
155	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/from-panel", "method": "POST", "request_body": {"mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/from-panel	2026-05-16 15:00:46.84175+00
156	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/to-panel", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/to-panel	2026-05-16 15:00:49.241738+00
157	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-16 15:07:04.743104+00
158	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 22:45:28.956207+00
159	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 22:45:29.267214+00
160	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 22:45:29.268284+00
161	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 22:46:05.382467+00
162	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 22:46:05.384219+00
163	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 22:46:05.385467+00
164	1	promocodes:read	promocodes	\N	{"path": "/cabinet/admin/promocodes", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promocodes	2026-05-16 22:46:18.600083+00
165	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 22:46:27.74327+00
166	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 22:46:27.744935+00
167	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 22:46:56.094427+00
168	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 22:46:56.094979+00
169	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 22:46:56.102887+00
170	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-16 22:46:59.722149+00
171	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers/1	2026-05-16 22:47:04.729707+00
172	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-16 22:47:35.377853+00
173	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-16 22:47:35.379478+00
174	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-16 22:47:35.437634+00
175	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-16 22:47:38.8114+00
176	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-16 22:47:38.810877+00
177	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 22:47:44.429958+00
178	1	remnawave:manage	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/restart-all", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/nodes/restart-all	2026-05-16 22:47:54.105664+00
179	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 22:47:54.243821+00
180	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-16 22:48:21.521344+00
181	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 05:56:31.43066+00
182	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-17 05:56:31.675894+00
183	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 05:56:31.676443+00
184	1	updates:read	updates	\N	{"path": "/cabinet/admin/updates/releases", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/updates/releases	2026-05-17 05:56:35.441542+00
185	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 05:57:38.033859+00
186	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-17 05:57:38.036306+00
187	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 05:57:38.041546+00
188	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-17 05:58:18.992261+00
189	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 05:58:18.994968+00
190	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 05:58:18.996049+00
191	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications", "method": "GET", "query_params": {"limit": "10", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications	2026-05-17 05:58:19.006429+00
192	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 07:12:35.419241+00
193	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 07:12:35.771297+00
194	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15	success	GET	/cabinet/admin/stats/system-info	2026-05-17 07:12:35.77169+00
436	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-20 19:12:56.772659+00
195	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 07:15:32.707305+00
196	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-17 07:15:32.780967+00
197	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 07:15:32.781671+00
198	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-17 07:15:40.988577+00
199	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-17 07:15:40.988984+00
200	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:15:44.505482+00
201	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:15:44.517929+00
202	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:15:44.521165+00
203	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:15:44.52906+00
204	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:15:44.865617+00
205	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:15:44.865999+00
206	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:15:44.86639+00
207	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-17 07:16:16.46187+00
208	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-17 07:16:16.470092+00
209	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:16:16.471231+00
210	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-17 07:16:16.478515+00
211	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:16:22.632486+00
212	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-17 07:16:26.689359+00
213	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/gifts", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/gifts	2026-05-17 07:16:27.719148+00
214	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "100", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:16:28.666913+00
215	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:16:30.248542+00
216	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:16:32.271103+00
221	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:16:50.429665+00
238	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:19:13.558271+00
217	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:16:32.271848+00
233	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:19:09.330719+00
242	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/from-panel", "method": "POST", "query_params": {"subscription_id": "1"}, "request_body": {"update_traffic": true, "update_subscription": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/users/1/sync/from-panel	2026-05-17 07:19:21.073961+00
218	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 07:16:40.674308+00
229	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-17 07:19:05.758253+00
239	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/from-panel", "method": "POST", "query_params": {"subscription_id": "1"}, "request_body": {"update_traffic": true, "update_subscription": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/users/1/sync/from-panel	2026-05-17 07:19:18.575872+00
219	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:16:50.428175+00
220	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:16:50.428525+00
227	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-17 07:18:55.662498+00
247	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:19:22.927658+00
222	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:16:50.430044+00
230	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-17 07:19:05.760072+00
223	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:16:50.713797+00
235	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:19:09.52751+00
245	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/from-panel", "method": "POST", "query_params": {"subscription_id": "1"}, "request_body": {"update_traffic": true, "update_subscription": true}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/users/1/sync/from-panel	2026-05-17 07:19:22.391718+00
224	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-17 07:16:50.71497+00
225	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:16:50.71549+00
232	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:19:09.328339+00
243	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:19:21.246392+00
226	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-17 07:18:55.346784+00
228	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-17 07:18:55.663007+00
236	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-17 07:19:09.527936+00
231	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:19:09.327012+00
234	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:19:09.330393+00
241	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:19:18.866147+00
237	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-17 07:19:09.528897+00
246	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:19:22.787959+00
240	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-17 07:19:18.728765+00
244	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-17 07:19:21.387794+00
248	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-18 07:30:15.619911+00
249	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-18 07:30:15.993301+00
250	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-18 07:30:15.993882+00
251	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-18 07:30:18.364209+00
252	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-18 07:30:18.364979+00
253	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-18 07:30:55.536378+00
254	1	users:read	users	\N	{"path": "/cabinet/admin/users/6", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6	2026-05-18 07:30:55.537293+00
255	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-18 07:30:55.540527+00
256	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-18 07:30:55.543658+00
257	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-18 07:30:56.0321+00
258	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-18 07:30:56.030881+00
259	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-18 07:30:56.033096+00
260	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/node-usage", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/node-usage	2026-05-18 07:31:07.948468+00
261	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-18 07:31:07.947294+00
262	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/available-tariffs	2026-05-18 07:31:07.947934+00
263	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/devices", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/devices	2026-05-18 07:31:07.953057+00
264	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-18 07:31:17.998095+00
265	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-18 07:32:20.358912+00
266	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/available-tariffs	2026-05-18 07:32:20.368098+00
267	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/devices", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/devices	2026-05-18 07:32:20.368544+00
268	1	users:sync	users	\N	{"path": "/cabinet/admin/users/6/sync/status", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/sync/status	2026-05-18 07:32:20.368975+00
269	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/node-usage", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/node-usage	2026-05-18 07:32:20.378008+00
270	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-18 07:32:20.378361+00
272	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-18 07:33:45.617169+00
271	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-18 07:33:45.616357+00
273	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-18 07:33:45.617569+00
274	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-18 07:33:47.494357+00
275	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-18 07:33:47.504118+00
279	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-18 07:34:44.530408+00
276	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-18 07:34:12.527152+00
277	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-18 07:34:12.527687+00
278	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-18 07:34:44.195628+00
280	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:20:04.34796+00
281	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:20:04.649521+00
282	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:20:04.648949+00
283	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 04:20:12.774281+00
284	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 04:20:12.776731+00
285	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 04:20:41.042284+00
286	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:20:41.043836+00
287	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-19 04:20:41.042993+00
288	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 04:20:41.044218+00
289	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 04:20:41.31886+00
290	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 04:20:41.31521+00
291	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:20:41.319619+00
292	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-19 04:21:03.962852+00
293	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 04:21:03.9625+00
294	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-19 04:21:03.971234+00
295	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-19 04:21:03.971564+00
296	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-19 04:21:03.953517+00
297	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:21:12.512883+00
298	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:21:34.288592+00
299	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:21:34.2883+00
300	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:21:55.345628+00
301	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/stats	2026-05-19 04:21:55.661255+00
302	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"page": "1", "per_page": "20"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-19 04:21:55.661985+00
303	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:21:59.453968+00
304	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:21:59.455483+00
305	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-19 04:22:10.864351+00
306	1	servers:edit	servers	\N	{"path": "/cabinet/admin/servers/sync", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/servers/sync	2026-05-19 04:22:20.83118+00
318	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 04:23:10.538542+00
307	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-19 04:22:23.316249+00
317	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:23:07.748936+00
308	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:22:26.193653+00
320	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/referrals	2026-05-19 04:23:24.696424+00
309	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:22:26.198819+00
324	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-19 04:23:25.028627+00
333	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:25:13.729902+00
310	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:22:26.199267+00
328	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-19 04:23:53.479323+00
334	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:25:13.736781+00
311	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-19 04:22:33.02346+00
319	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 04:23:10.556632+00
327	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/available-tariffs	2026-05-19 04:23:53.478745+00
312	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 04:22:36.231732+00
313	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:22:36.232369+00
314	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 04:23:07.717169+00
329	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/devices", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/devices	2026-05-19 04:23:53.480737+00
315	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-19 04:23:07.717567+00
330	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/node-usage", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/node-usage	2026-05-19 04:23:53.481114+00
316	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:23:07.748353+00
321	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-19 04:23:24.6956+00
322	1	users:read	users	\N	{"path": "/cabinet/admin/users/4", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4	2026-05-19 04:23:24.73157+00
323	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:23:24.773963+00
331	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:24:10.502177+00
335	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 04:25:17.574594+00
336	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 04:25:17.575822+00
325	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:23:25.028829+00
326	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/referrals	2026-05-19 04:23:25.08696+00
332	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 04:25:10.692376+00
337	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 04:25:40.572732+00
338	1	users:read	users	\N	{"path": "/cabinet/admin/users/6", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6	2026-05-19 04:25:40.573078+00
339	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 04:25:40.57444+00
340	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:25:40.583626+00
341	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 04:25:40.790774+00
342	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 04:25:40.79167+00
343	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 04:25:40.792203+00
344	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/node-usage", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/node-usage	2026-05-19 04:25:46.8615+00
345	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/available-tariffs	2026-05-19 04:25:46.861822+00
346	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 04:25:46.863593+00
347	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/devices", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/devices	2026-05-19 04:25:46.863556+00
348	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 09:32:19.068858+00
349	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 09:32:19.391855+00
350	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 09:32:19.392238+00
351	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 09:32:25.473928+00
352	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 09:32:25.473385+00
353	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-19 09:32:28.842043+00
354	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:32:28.843666+00
355	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:32:28.845492+00
356	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:32:28.847306+00
357	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:32:29.230082+00
358	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:32:29.230673+00
359	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:32:29.23119+00
360	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-19 09:32:34.478662+00
362	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-19 09:32:34.478986+00
387	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/node-usage", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/node-usage	2026-05-19 09:33:25.163036+00
410	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 09:34:13.887478+00
417	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 09:34:15.704309+00
363	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:32:34.479281+00
379	1	users:read	users	\N	{"path": "/cabinet/admin/users/6", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6	2026-05-19 09:33:19.168014+00
389	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 09:33:25.163825+00
411	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 09:34:13.888621+00
416	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 09:34:15.698025+00
364	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-19 09:32:46.546432+00
367	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "100", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:32:51.766818+00
371	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-19 09:33:03.466044+00
374	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 09:33:12.302146+00
376	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 09:33:12.304695+00
377	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 09:33:16.274663+00
381	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:33:19.169276+00
383	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 09:33:19.402871+00
388	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/available-tariffs	2026-05-19 09:33:25.163475+00
392	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 09:33:38.286155+00
397	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:33:44.295011+00
398	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:33:44.295371+00
400	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:33:44.529366+00
403	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-19 09:33:50.999338+00
405	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:33:58.615272+00
412	1	users:read	users	\N	{"path": "/cabinet/admin/users/6", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6	2026-05-19 09:34:15.465686+00
415	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 09:34:15.466896+00
418	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:34:15.7076+00
419	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 09:34:17.593681+00
421	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-19 09:34:19.464712+00
424	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-20 19:00:25.526316+00
428	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-20 19:11:11.686163+00
434	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-20 19:12:34.042722+00
438	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 05:58:56.294381+00
441	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 06:00:02.796+00
361	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-19 09:32:34.479549+00
370	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-19 09:33:03.462449+00
407	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 09:34:07.625294+00
420	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 09:34:17.594258+00
365	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-19 09:32:49.837479+00
368	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:32:53.452238+00
372	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-19 09:33:03.466986+00
375	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 09:33:12.302616+00
382	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 09:33:19.169557+00
384	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:33:19.403454+00
390	1	users:sync	users	\N	{"path": "/cabinet/admin/users/6/sync/status", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/sync/status	2026-05-19 09:33:30.822756+00
391	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 09:33:38.285729+00
395	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-19 09:33:44.293625+00
399	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:33:44.527978+00
406	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:33:58.615845+00
408	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 09:34:07.625801+00
425	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-20 19:00:25.526762+00
427	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-20 19:11:11.686801+00
430	1	audit_log:read	audit_log	\N	{"path": "/cabinet/admin/rbac/audit-log", "method": "GET", "query_params": {"limit": "20", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/audit-log	2026-05-20 19:11:49.580633+00
435	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-20 19:12:34.416492+00
437	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-20 19:12:56.776208+00
439	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 05:58:56.609197+00
442	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-21 06:00:03.027933+00
443	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-21 06:00:02.991845+00
445	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-21 06:00:36.804227+00
446	1	users:read	users	\N	{"path": "/cabinet/admin/users/4", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4	2026-05-21 06:00:36.803793+00
447	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/referrals	2026-05-21 06:00:36.803427+00
448	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/referrals	2026-05-21 06:00:37.235473+00
449	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-21 06:00:37.236246+00
366	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/gifts", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/gifts	2026-05-19 09:32:50.974367+00
369	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:32:53.451763+00
373	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:33:03.466605+00
378	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 09:33:16.275794+00
380	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/panel-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/panel-info	2026-05-19 09:33:19.168962+00
385	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 09:33:19.403909+00
386	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/devices", "method": "GET", "query_params": {"subscription_id": "5"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/devices	2026-05-19 09:33:25.162528+00
393	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-19 09:33:41.627682+00
394	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-19 09:33:41.629017+00
396	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-19 09:33:44.294315+00
401	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-19 09:33:44.532843+00
402	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-19 09:33:46.550297+00
404	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-19 09:33:52.841753+00
409	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-19 09:34:13.88154+00
413	1	users:read	users	\N	{"path": "/cabinet/admin/users/6/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/6/referrals	2026-05-19 09:34:15.466845+00
414	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-19 09:34:15.46725+00
422	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-19 09:34:19.465586+00
423	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-20 19:00:25.230863+00
426	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-20 19:11:11.381504+00
429	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-20 19:11:49.210358+00
431	1	roles:read	roles	\N	{"path": "/cabinet/admin/rbac/users", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/users	2026-05-20 19:11:49.582832+00
432	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-20 19:12:34.041672+00
433	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-20 19:12:34.045198+00
440	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 05:58:56.610358+00
444	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-21 06:00:36.802098+00
450	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-21 06:00:37.235858+00
451	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 06:01:06.3853+00
452	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/node-usage", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/node-usage	2026-05-21 06:01:06.388855+00
453	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/panel-info", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/panel-info	2026-05-21 06:01:06.38476+00
454	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/devices", "method": "GET", "query_params": {"subscription_id": "3"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/devices	2026-05-21 06:01:06.444693+00
455	1	users:read	users	\N	{"path": "/cabinet/admin/users/4/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/4/available-tariffs	2026-05-21 06:01:06.454086+00
456	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-21 06:01:10.258961+00
457	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-21 06:01:10.332689+00
460	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 06:01:41.700307+00
458	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 06:01:41.636283+00
459	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 06:01:41.693368+00
461	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 08:46:06.829798+00
462	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 08:46:07.134802+00
463	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 08:46:07.135463+00
464	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-21 08:46:09.784751+00
465	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-21 08:46:09.785259+00
466	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 08:46:56.087391+00
467	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 08:46:56.088149+00
468	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 08:46:56.090148+00
469	1	landings:read	landings	\N	{"path": "/cabinet/admin/landings", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/landings	2026-05-21 08:47:04.026687+00
470	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-21 08:47:14.869671+00
471	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-21 08:47:14.872546+00
472	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 13:25:56.737489+00
473	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 13:25:57.056498+00
474	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 13:25:57.091058+00
475	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 16:38:18.032273+00
476	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 16:38:18.599198+00
477	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 16:38:18.599813+00
478	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-21 16:38:24.365446+00
479	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-21 16:38:24.366231+00
480	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-21 16:38:27.595841+00
481	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-21 16:38:33.257444+00
482	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-21 16:38:55.637236+00
483	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-21 16:38:55.635681+00
484	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-21 16:38:55.63641+00
485	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/config", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/config	2026-05-21 16:39:03.541527+00
486	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/statistics", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/statistics	2026-05-21 16:39:34.308891+00
488	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:45:42.747497+00
489	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:45:42.917738+00
490	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:45:42.918407+00
491	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-22 18:45:56.197271+00
492	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-22 18:45:56.197942+00
493	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:47:07.973796+00
494	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:48:08.112984+00
495	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:49:20.343261+00
496	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:50:20.519416+00
497	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:51:32.741319+00
498	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:51:37.51817+00
499	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:51:37.533566+00
500	1	settings:read	settings	\N	{"path": "/cabinet/admin/settings", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/settings	2026-05-22 18:51:39.8696+00
501	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:51:43.509266+00
502	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:51:43.511343+00
561	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/deposits", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/deposits	2026-05-22 18:57:02.302603+00
503	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-22 18:51:47.923534+00
510	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes/realtime", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes/realtime	2026-05-22 18:52:40.678164+00
532	1	stats:read	stats	\N	{"path": "/cabinet/admin/referral-network/scope-options", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/referral-network/scope-options	2026-05-22 18:55:29.059915+00
545	1	broadcasts:read	broadcasts	\N	{"path": "/cabinet/admin/broadcasts", "method": "GET", "query_params": {"limit": "20", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/broadcasts	2026-05-22 18:56:01.091551+00
504	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/status	2026-05-22 18:51:47.922691+00
505	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-22 18:51:53.633796+00
506	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-22 18:52:03.758434+00
511	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-22 18:52:46.172897+00
512	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:52:47.608912+00
518	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-22 18:53:38.296777+00
528	1	roles:read	roles	\N	{"path": "/cabinet/admin/rbac/roles", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/rbac/roles	2026-05-22 18:55:06.900124+00
538	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:55:40.524448+00
539	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:55:40.526465+00
540	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/config", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/config	2026-05-22 18:55:44.303143+00
560	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/addons", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/addons	2026-05-22 18:57:00.853515+00
568	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:57:17.10395+00
575	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:57:29.104279+00
576	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:57:29.104876+00
579	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:57:34.393205+00
585	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/campaigns/top", "method": "GET", "query_params": {"limit": "10"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/campaigns/top	2026-05-22 18:57:36.053959+00
593	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:58:11.379014+00
595	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-22 18:58:32.388811+00
598	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-22 18:58:38.593468+00
507	1	remnawave:sync	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/to-panel", "method": "POST"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/remnawave/sync/to-panel	2026-05-22 18:52:09.730056+00
508	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/sync/auto/status", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/sync/auto/status	2026-05-22 18:52:13.899538+00
513	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/nodes", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/nodes	2026-05-22 18:53:12.921329+00
534	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:55:34.130019+00
535	1	partners:read	partners	\N	{"path": "/cabinet/admin/partners", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/partners	2026-05-22 18:55:37.822983+00
541	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/statistics", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/statistics	2026-05-22 18:55:55.091979+00
548	1	campaigns:read	campaigns	\N	{"path": "/cabinet/admin/campaigns", "method": "GET", "query_params": {"limit": "50", "offset": "0", "include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/campaigns	2026-05-22 18:56:08.014768+00
555	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:56:41.831793+00
564	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/deposits", "method": "GET", "query_params": {"days": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/deposits	2026-05-22 18:57:09.804769+00
572	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic", "method": "GET", "query_params": {"limit": "50", "offset": "0", "period": "7", "sort_by": "total_bytes", "sort_desc": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic	2026-05-22 18:57:22.814131+00
588	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:58:08.933192+00
590	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:58:08.961629+00
509	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/system", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/system	2026-05-22 18:52:22.615961+00
514	1	remnawave:read	remnawave	\N	{"path": "/cabinet/admin/remnawave/squads", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/remnawave/squads	2026-05-22 18:53:22.838404+00
519	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-22 18:54:01.327165+00
530	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:55:20.225094+00
552	1	news:read	news	\N	{"path": "/cabinet/admin/news", "method": "GET", "query_params": {"limit": "20", "offset": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/news	2026-05-22 18:56:12.523334+00
574	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic", "method": "GET", "query_params": {"limit": "50", "offset": "0", "period": "14", "sort_by": "total_bytes", "sort_desc": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic	2026-05-22 18:57:22.817693+00
584	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/payments/recent", "method": "GET", "query_params": {"limit": "20"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/payments/recent	2026-05-22 18:57:36.045753+00
592	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:58:11.377997+00
515	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:53:35.05913+00
516	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:53:35.05292+00
517	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:53:35.055538+00
524	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-22 18:54:13.570637+00
526	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:55:06.797949+00
536	1	partners:read	partners	\N	{"path": "/cabinet/admin/partners/applications", "method": "GET", "query_params": {"status": "pending"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/partners/applications	2026-05-22 18:55:37.823826+00
537	1	partners:read	partners	\N	{"path": "/cabinet/admin/partners/stats", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/partners/stats	2026-05-22 18:55:37.829268+00
542	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:55:57.718415+00
551	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:56:10.414989+00
557	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/trials", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/trials	2026-05-22 18:56:42.004735+00
562	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/deposits", "method": "GET", "query_params": {"days": "90"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/deposits	2026-05-22 18:57:08.629872+00
567	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:57:17.101747+00
571	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic", "method": "GET", "query_params": {"limit": "50", "offset": "0", "period": "1", "sort_by": "total_bytes", "sort_desc": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic	2026-05-22 18:57:22.812834+00
580	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:57:34.395973+00
582	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:57:36.044406+00
591	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:58:11.375752+00
594	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods	2026-05-22 18:58:26.62066+00
597	1	payment_methods:edit	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/tribute", "method": "PUT", "request_body": {"is_enabled": false, "display_name": "Tribute", "open_url_direct": false, "user_type_filter": "all", "max_amount_kopeks": 10000000, "min_amount_kopeks": 10000, "first_topup_filter": "any", "allowed_promo_group_ids": [], "promo_group_filter_mode": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/payment-methods/tribute	2026-05-22 18:58:38.423613+00
520	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/1	2026-05-22 18:54:01.340786+00
522	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-22 18:54:01.339594+00
521	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-22 18:54:01.33815+00
549	1	campaigns:read	campaigns	\N	{"path": "/cabinet/admin/campaigns/overview", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/campaigns/overview	2026-05-22 18:56:08.013232+00
553	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:56:41.825527+00
556	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/summary", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/summary	2026-05-22 18:56:41.999895+00
565	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/summary", "method": "GET", "query_params": {"days": "0"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/summary	2026-05-22 18:57:09.805614+00
570	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic/enrichment", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic/enrichment	2026-05-22 18:57:22.49958+00
573	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic", "method": "GET", "query_params": {"limit": "50", "offset": "0", "period": "3", "sort_by": "total_bytes", "sort_desc": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic	2026-05-22 18:57:22.816471+00
577	1	payments:read	payments	\N	{"path": "/cabinet/admin/payments/search", "method": "GET", "query_params": {"page": "1", "period": "24h", "per_page": "20", "status_filter": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payments/search	2026-05-22 18:57:31.95019+00
586	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/referrals/top", "method": "GET", "query_params": {"limit": "10"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/referrals/top	2026-05-22 18:58:08.929185+00
589	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/payments/recent", "method": "GET", "query_params": {"limit": "20"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/payments/recent	2026-05-22 18:58:08.941001+00
523	1	tariffs:edit	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "PUT", "request_body": {"name": "Стандартный", "is_daily": false, "is_active": true, "tier_level": 1, "description": "Базовый тарифный план", "device_limit": 2, "show_in_gift": true, "period_prices": [{"days": 14, "price_kopeks": 7000, "price_rubles": 70}, {"days": 30, "price_kopeks": 14000, "price_rubles": 140}, {"days": 60, "price_kopeks": 25900, "price_rubles": 259}, {"days": 90, "price_kopeks": 36900, "price_rubles": 369}, {"days": 180, "price_kopeks": 69900, "price_rubles": 699}, {"days": 360, "price_kopeks": 109900, "price_rubles": 1099}], "allowed_squads": [], "traffic_limit_gb": 100, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/tariffs/1	2026-05-22 18:54:13.395935+00
529	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:55:20.226137+00
566	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:57:17.098971+00
583	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/referrals/top", "method": "GET", "query_params": {"limit": "10"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/referrals/top	2026-05-22 18:57:36.044931+00
525	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:54:38.042273+00
527	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:55:06.799565+00
533	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:55:34.130776+00
546	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:56:05.187154+00
563	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/summary", "method": "GET", "query_params": {"days": "90"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/summary	2026-05-22 18:57:08.630909+00
531	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:55:20.228147+00
543	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:55:57.724762+00
550	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:56:10.415598+00
558	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/subscriptions", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/subscriptions	2026-05-22 18:56:55.928004+00
581	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:57:36.043766+00
544	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:55:57.725265+00
559	1	sales_stats:read	sales_stats	\N	{"path": "/cabinet/admin/stats/sales/renewals", "method": "GET", "query_params": {"days": "30"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/sales/renewals	2026-05-22 18:56:58.627694+00
596	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-22 18:58:32.393262+00
547	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:56:05.188404+00
554	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:56:41.827696+00
569	1	traffic:read	traffic	\N	{"path": "/cabinet/admin/traffic", "method": "GET", "query_params": {"limit": "50", "offset": "0", "period": "30", "sort_by": "total_bytes", "sort_desc": "true"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/traffic	2026-05-22 18:57:22.272734+00
578	1	payments:read	payments	\N	{"path": "/cabinet/admin/payments/search/stats", "method": "GET", "query_params": {"period": "24h", "status_filter": "all"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payments/search/stats	2026-05-22 18:57:31.950961+00
587	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/campaigns/top", "method": "GET", "query_params": {"limit": "10"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/campaigns/top	2026-05-22 18:58:08.932136+00
599	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-22 18:59:31.787745+00
600	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-22 18:59:32.077894+00
601	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-22 18:59:32.079217+00
602	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:00:53.910638+00
603	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:00:54.223662+00
604	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:00:54.225283+00
605	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:00:57.701317+00
606	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:00:57.70033+00
608	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:01:07.439964+00
607	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:01:07.441508+00
609	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:01:21.042617+00
610	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups/1	2026-05-23 10:01:33.07582+00
611	1	promo_groups:edit	promo_groups	\N	{"path": "/cabinet/admin/promo-groups/1", "method": "PATCH", "request_body": {"name": "Базовый юзер", "is_default": true, "period_discounts": {}, "device_discount_percent": 0, "server_discount_percent": 0, "traffic_discount_percent": 0, "apply_discounts_to_addons": true, "auto_assign_total_spent_kopeks": 0}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PATCH	/cabinet/admin/promo-groups/1	2026-05-23 10:01:50.495372+00
612	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:01:50.623497+00
613	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:02:32.836955+00
614	1	promo_groups:create	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "POST", "request_body": {"name": "Arredo Proxy Group", "is_default": false, "period_discounts": {}, "device_discount_percent": 0, "server_discount_percent": 0, "traffic_discount_percent": 0, "apply_discounts_to_addons": true, "auto_assign_total_spent_kopeks": 0}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/promo-groups	2026-05-23 10:02:35.506334+00
615	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:02:35.742752+00
616	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:02:50.101437+00
617	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:02:50.099962+00
618	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:02:52.065793+00
629	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/node-usage", "method": "GET", "query_params": {"subscription_id": "10"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/node-usage	2026-05-23 10:03:11.330882+00
689	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:07:36.369797+00
619	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:02:52.065008+00
630	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/devices", "method": "GET", "query_params": {"subscription_id": "10"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/devices	2026-05-23 10:03:11.331369+00
649	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:04:45.619382+00
620	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/panel-info	2026-05-23 10:03:04.152788+00
633	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:03:33.074975+00
654	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-23 10:04:54.223783+00
677	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:05:53.323215+00
621	1	users:read	users	\N	{"path": "/cabinet/admin/users/13", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13	2026-05-23 10:03:04.153876+00
639	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:04:04.401165+00
663	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-23 10:05:24.04632+00
672	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:05:40.681946+00
622	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:03:04.156057+00
623	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/referrals	2026-05-23 10:03:04.156128+00
647	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-23 10:04:45.617497+00
659	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-23 10:05:19.447584+00
667	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-23 10:05:31.983052+00
674	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:05:43.357067+00
679	1	tariffs:edit	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "PUT", "request_body": {"name": "Стандартный", "is_daily": false, "is_active": true, "tier_level": 1, "description": "Базовый тарифный план", "device_limit": 2, "show_in_gift": true, "period_prices": [{"days": 14, "price_kopeks": 7000, "price_rubles": 70}, {"days": 30, "price_kopeks": 14000, "price_rubles": 140}, {"days": 60, "price_kopeks": 25900, "price_rubles": 259}, {"days": 90, "price_kopeks": 36900, "price_rubles": 369}, {"days": 180, "price_kopeks": 69900, "price_rubles": 699}, {"days": 360, "price_kopeks": 109900, "price_rubles": 1099}], "allowed_squads": ["32eb5185-c698-4bdd-bc41-7630a5065531"], "traffic_limit_gb": 100, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/tariffs/1	2026-05-23 10:06:39.340476+00
684	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:06:47.071614+00
686	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:07:28.565549+00
694	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:12:08.189068+00
703	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:13:52.58267+00
624	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:03:04.461419+00
637	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:04:04.193991+00
642	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:04:40.14098+00
651	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:04:45.839102+00
671	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:05:40.671021+00
683	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/1	2026-05-23 10:06:47.070524+00
692	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:09:55.831112+00
697	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:13:19.732208+00
707	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:14:32.170282+00
625	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/referrals	2026-05-23 10:03:04.461996+00
626	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/panel-info", "method": "GET", "query_params": {"subscription_id": "10"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/panel-info	2026-05-23 10:03:04.462607+00
634	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:04:04.183214+00
661	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "100", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:05:19.453691+00
669	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:05:38.398341+00
696	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:12:50.150631+00
704	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:13:52.583835+00
627	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/available-tariffs	2026-05-23 10:03:11.325915+00
628	1	users:read	users	\N	{"path": "/cabinet/admin/users/13/panel-info", "method": "GET", "query_params": {"subscription_id": "10"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/13/panel-info	2026-05-23 10:03:11.326764+00
635	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:04:04.189007+00
638	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:04:04.400512+00
653	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:04:45.838514+00
675	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:05:53.305899+00
688	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:07:36.368817+00
695	1	tariffs:create	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "POST", "request_body": {"name": "Единый 10", "is_daily": false, "is_active": true, "tier_level": 2, "description": "Одна подписка для всех членов семьи. Подключите до 10 устройств в едином тарифном плане.", "device_limit": 10, "show_in_gift": true, "period_prices": [{"days": 7, "price_kopeks": 30000}], "allowed_squads": ["32eb5185-c698-4bdd-bc41-7630a5065531"], "traffic_limit_gb": 500, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/tariffs	2026-05-23 10:12:49.901861+00
706	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/3	2026-05-23 10:13:52.585818+00
631	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:03:33.071174+00
655	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-23 10:04:54.224335+00
664	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-23 10:05:25.141334+00
676	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/1	2026-05-23 10:05:53.316298+00
690	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:07:43.214781+00
632	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:03:33.074882+00
646	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:04:41.846408+00
657	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-23 10:04:54.227071+00
668	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:05:31.984869+00
636	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:04:04.19388+00
640	1	promo_groups:create	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "POST", "request_body": {"name": "VIP Клиенты", "is_default": false, "period_discounts": {}, "device_discount_percent": 0, "server_discount_percent": 0, "traffic_discount_percent": 0, "apply_discounts_to_addons": true, "auto_assign_total_spent_kopeks": 0}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/promo-groups	2026-05-23 10:04:33.667194+00
641	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:04:33.786415+00
643	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:04:40.140263+00
644	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:04:40.139367+00
648	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:04:45.619057+00
652	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:04:45.839718+00
658	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-23 10:05:19.445382+00
662	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/gifts", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/gifts	2026-05-23 10:05:22.777396+00
666	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-23 10:05:31.982132+00
680	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:06:39.531355+00
685	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:06:47.071138+00
693	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:10:55.988891+00
702	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:13:47.385054+00
645	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:04:41.846309+00
656	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:04:54.226839+00
673	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:05:40.683471+00
682	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:06:47.065721+00
698	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:13:19.732348+00
650	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:04:45.618064+00
660	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/gifts", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/gifts	2026-05-23 10:05:19.451729+00
670	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:05:38.399491+00
687	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:07:36.361694+00
705	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:13:52.585744+00
665	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-23 10:05:31.981511+00
678	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:05:53.329015+00
681	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:06:43.052773+00
691	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:08:43.575529+00
699	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:13:19.720652+00
700	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:13:19.861885+00
701	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/1	2026-05-23 10:13:19.869555+00
708	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:15:32.511843+00
709	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:16:44.8502+00
710	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:17:27.014682+00
711	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:17:27.01574+00
712	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:17:27.283006+00
713	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:17:30.707896+00
714	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:17:33.806143+00
715	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:17:33.81041+00
716	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/3	2026-05-23 10:17:33.805762+00
717	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:17:33.80679+00
718	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:18:42.811677+00
719	1	tariffs:edit	tariffs	\N	{"path": "/cabinet/admin/tariffs/3", "method": "PUT", "request_body": {"name": "Единый 10", "is_daily": false, "is_active": true, "tier_level": 2, "description": "Одна подписка для всех членов семьи. Подключите до 10 устройств в едином тарифном плане.", "device_limit": 10, "show_in_gift": true, "period_prices": [{"days": 14, "price_kopeks": 17900}, {"days": 30, "price_kopeks": 34900}, {"days": 60, "price_kopeks": 64900}, {"days": 90, "price_kopeks": 94900}, {"days": 180, "price_kopeks": 179000}, {"days": 360, "price_kopeks": 299000}], "allowed_squads": ["32eb5185-c698-4bdd-bc41-7630a5065531"], "traffic_limit_gb": 500, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	PUT	/cabinet/admin/tariffs/3	2026-05-23 10:18:59.451963+00
720	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:18:59.625019+00
721	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:19:55.043927+00
722	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:20:22.00352+00
723	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:20:22.003608+00
724	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:20:22.01049+00
725	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:21:07.259279+00
726	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:22:07.551741+00
730	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:25:48.302159+00
732	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:25:52.131146+00
739	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:26:44.404187+00
749	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:31:09.350082+00
802	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/gifts", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/gifts	2026-05-23 10:49:19.83295+00
727	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:23:19.742067+00
737	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:26:07.160571+00
746	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/4", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/4	2026-05-23 10:29:41.228264+00
728	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:24:19.913756+00
747	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:29:41.230135+00
752	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:34:30.895873+00
773	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:39:24.38806+00
779	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:42:43.693952+00
729	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:25:32.184899+00
731	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/3	2026-05-23 10:25:52.142922+00
733	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:25:52.128954+00
734	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:25:52.253415+00
741	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:28:56.780827+00
750	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:32:21.582018+00
753	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:34:30.905139+00
759	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:35:31.486144+00
760	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:36:43.690413+00
767	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:39:17.359775+00
774	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:39:24.644797+00
780	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:43:43.821157+00
805	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:49:24.394483+00
735	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:26:02.978046+00
736	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:26:07.154361+00
738	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:26:07.163397+00
740	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:27:44.598989+00
742	1	tariffs:create	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "POST", "request_body": {"name": "Premium", "is_daily": false, "is_active": true, "tier_level": 3, "description": "Max\\n\\n* до 20 устройств\\n* 1000 GB guaranteed\\n* приоритетные ноды\\n* heavy traffic\\n* роутеры / whole-home\\n* media  / 4k", "device_limit": 20, "show_in_gift": true, "period_prices": [{"days": 14, "price_kopeks": 19900}, {"days": 30, "price_kopeks": 39900}, {"days": 60, "price_kopeks": 74900}, {"days": 90, "price_kopeks": 104900}, {"days": 180, "price_kopeks": 189000}, {"days": 360, "price_kopeks": 329000}], "allowed_squads": ["a4d53819-8d21-4594-b85c-08e5425293ad", "32eb5185-c698-4bdd-bc41-7630a5065531"], "traffic_limit_gb": 1000, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": "23fe3e60-3c12-48a0-bc09-e5b1488290fc", "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/tariffs	2026-05-23 10:28:58.314245+00
743	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:28:58.443452+00
744	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:29:41.225506+00
751	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:33:21.742668+00
764	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:38:46.709114+00
765	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:39:17.358307+00
770	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-23 10:39:24.384761+00
775	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:39:24.645201+00
778	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:41:31.480475+00
789	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:48:44.373047+00
745	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-external-squads", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-external-squads	2026-05-23 10:29:41.229337+00
748	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:30:09.005805+00
756	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs/available-servers", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs/available-servers	2026-05-23 10:34:30.923071+00
777	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:40:31.320361+00
754	1	payment_methods:read	payment_methods	\N	{"path": "/cabinet/admin/payment-methods/promo-groups", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/payment-methods/promo-groups	2026-05-23 10:34:30.907257+00
755	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 10:34:30.901681+00
757	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:34:30.916826+00
758	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:34:31.199326+00
761	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:37:43.836777+00
762	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:38:44.094988+00
763	1	tariffs:create	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "POST", "request_body": {"name": "Dedicated Proxy", "is_daily": false, "is_active": true, "tier_level": 10, "description": "Корпоративный Dedicated Proxy — выделенный приватный канал для бизнеса, команд и high-load задач.\\n\\n• Выделенный IP без посторонних пользователей  \\n• Стабильное соединение и приоритетная маршрутизация  \\n• Подходит для офисов, команд, роутеров и постоянной работы  \\n• Повышенная устойчивость и низкий риск ограничений антифрод-систем  \\n• Индивидуальная настройка под задачи клиента  \\n\\nКаждый Dedicated Proxy разворачивается отдельно и не используется другими клиентами.\\n\\nДоступно подключение с гарантированным лимитом трафика до 1000 GB и более.\\n\\nСтоимость рассчитывается индивидуально в зависимости от страны, нагрузки и количества пользователей.\\n\\nОформление и подключение — через поддержку.", "device_limit": 1000, "show_in_gift": true, "period_prices": [{"days": 30, "price_kopeks": 790000}], "allowed_squads": [], "traffic_limit_gb": 0, "daily_price_kopeks": 0, "traffic_reset_mode": null, "device_price_kopeks": 0, "external_squad_uuid": null, "max_topup_traffic_gb": 0, "traffic_topup_enabled": false, "traffic_topup_packages": {}}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	POST	/cabinet/admin/tariffs	2026-05-23 10:38:46.475856+00
766	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:39:17.359097+00
768	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:39:19.227815+00
769	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:39:19.225058+00
771	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:39:24.383474+00
772	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:39:24.384832+00
776	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:39:24.645713+00
781	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:44:56.230149+00
782	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:45:56.446479+00
783	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:47:08.785771+00
784	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 10:48:28.988593+00
785	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-23 10:48:28.990765+00
786	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:48:28.989886+00
787	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 10:48:28.991549+00
788	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-23 10:48:28.994+00
790	1	users:read	users	\N	{"path": "/cabinet/admin/users/1", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1	2026-05-23 10:48:44.374459+00
791	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:48:44.373936+00
792	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:48:44.375739+00
800	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets", "method": "GET", "query_params": {"user_id": "1", "per_page": "50"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets	2026-05-23 10:49:18.71728+00
793	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:48:44.637361+00
794	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-23 10:48:44.639644+00
803	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "100", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:49:21.110433+00
795	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:48:44.639689+00
796	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/available-tariffs	2026-05-23 10:48:48.115064+00
797	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/panel-info", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/panel-info	2026-05-23 10:48:48.115967+00
806	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 10:49:29.204831+00
798	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/devices", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/devices	2026-05-23 10:48:48.115207+00
799	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/node-usage", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/node-usage	2026-05-23 10:48:48.116882+00
801	1	users:sync	users	\N	{"path": "/cabinet/admin/users/1/sync/status", "method": "GET", "query_params": {"subscription_id": "1"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/sync/status	2026-05-23 10:49:18.718108+00
804	1	users:read	users	\N	{"path": "/cabinet/admin/users/1/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/1/referrals	2026-05-23 10:49:24.392619+00
807	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 19:57:55.57261+00
808	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 19:57:55.879884+00
809	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 19:57:55.880586+00
810	1	tariffs:read	tariffs	\N	{"path": "/cabinet/admin/tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tariffs	2026-05-23 19:58:03.063702+00
811	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 19:58:39.539931+00
812	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 19:58:39.541057+00
813	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 19:58:39.543142+00
814	1	apps:read	apps	\N	{"path": "/cabinet/admin/apps/remnawave/status", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/apps/remnawave/status	2026-05-23 19:58:39.639653+00
815	1	apps:read	apps	\N	{"path": "/cabinet/admin/apps/remnawave/configs", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/apps/remnawave/configs	2026-05-23 19:58:39.661953+00
816	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-23 19:59:09.929343+00
817	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-23 19:59:09.930057+00
818	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 19:59:09.928707+00
819	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-23 19:59:13.871712+00
820	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers/3	2026-05-23 20:00:02.536337+00
821	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-23 20:00:13.579084+00
822	1	servers:read	servers	\N	{"path": "/cabinet/admin/servers", "method": "GET", "query_params": {"include_unavailable": "true"}}	172.18.0.3	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/servers	2026-05-23 20:00:16.743421+00
823	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-24 17:21:35.525293+00
824	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-24 17:21:35.831961+00
825	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-24 17:21:35.831869+00
826	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/config", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/config	2026-05-24 17:21:50.926614+00
827	1	wheel:read	wheel	\N	{"path": "/cabinet/admin/wheel/statistics", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/wheel/statistics	2026-05-24 17:21:54.278466+00
828	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-24 17:22:17.435934+00
829	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-24 17:22:17.436871+00
830	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-24 17:22:17.435017+00
831	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-24 17:22:22.314139+00
832	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups/3", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups/3	2026-05-24 17:22:34.719615+00
833	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-24 17:22:40.259013+00
834	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-24 17:22:40.260142+00
835	1	promo_offers:read	promo_offers	\N	{"path": "/cabinet/admin/promo-offers/templates", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-offers/templates	2026-05-24 17:22:44.884671+00
836	1	promo_offers:read	promo_offers	\N	{"path": "/cabinet/admin/promo-offers/logs", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-offers/logs	2026-05-24 17:22:56.819748+00
837	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-24 17:23:01.702567+00
838	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-24 17:23:01.704061+00
839	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-24 17:23:01.701313+00
840	1	updates:read	updates	\N	{"path": "/cabinet/admin/updates/releases", "method": "GET"}	172.18.0.8	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/updates/releases	2026-05-24 17:23:14.609637+00
841	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.4	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-27 10:40:28.842516+00
842	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.4	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-27 10:40:29.179704+00
843	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.4	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-27 10:40:29.181029+00
845	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.4	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-27 10:40:36.580553+00
844	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.4	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-27 10:40:36.579515+00
846	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-27 19:46:17.542363+00
847	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-27 19:46:18.099603+00
848	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-27 19:46:18.100289+00
849	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-27 19:46:20.499915+00
850	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-27 19:46:20.501465+00
851	1	users:read	users	\N	{"path": "/cabinet/admin/users/17", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17	2026-05-27 19:46:24.969698+00
852	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/panel-info", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/panel-info	2026-05-27 19:46:24.971867+00
853	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-27 19:46:24.990912+00
854	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/referrals	2026-05-27 19:46:24.989786+00
855	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/panel-info", "method": "GET", "query_params": {"subscription_id": "14"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/panel-info	2026-05-27 19:46:25.933371+00
856	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/promo-groups	2026-05-27 19:46:25.935455+00
857	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/referrals	2026-05-27 19:46:25.934542+00
858	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/available-tariffs	2026-05-27 19:46:34.083852+00
859	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/panel-info", "method": "GET", "query_params": {"subscription_id": "14"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/panel-info	2026-05-27 19:46:34.083129+00
860	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/node-usage", "method": "GET", "query_params": {"subscription_id": "14"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/node-usage	2026-05-27 19:46:34.082259+00
861	1	users:read	users	\N	{"path": "/cabinet/admin/users/17/devices", "method": "GET", "query_params": {"subscription_id": "14"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/17/devices	2026-05-27 19:46:34.084407+00
862	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-27 19:47:29.456497+00
863	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-29 13:08:54.003157+00
864	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/system-info	2026-05-29 13:08:54.300193+00
865	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/stats/dashboard	2026-05-29 13:08:54.299235+00
866	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users	2026-05-29 13:08:56.164714+00
867	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.7	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko)	success	GET	/cabinet/admin/users/stats	2026-05-29 13:08:56.164815+00
868	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 07:14:58.301698+00
870	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-30 07:14:58.635124+00
869	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-30 07:14:58.635983+00
871	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-30 07:15:01.28127+00
872	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-30 07:15:01.282164+00
873	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/promo-groups	2026-05-30 07:15:33.384173+00
874	1	users:read	users	\N	{"path": "/cabinet/admin/users/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3	2026-05-30 07:15:33.383494+00
875	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/referrals	2026-05-30 07:15:33.382742+00
876	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/panel-info	2026-05-30 07:15:33.382095+00
877	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/referrals	2026-05-30 07:15:33.755994+00
878	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/panel-info", "method": "GET", "query_params": {"subscription_id": "8"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/panel-info	2026-05-30 07:15:33.757399+00
879	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/promo-groups	2026-05-30 07:15:33.756705+00
880	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/node-usage", "method": "GET", "query_params": {"subscription_id": "8"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/node-usage	2026-05-30 07:15:36.242981+00
881	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/panel-info", "method": "GET", "query_params": {"subscription_id": "8"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/panel-info	2026-05-30 07:15:36.24241+00
882	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/available-tariffs", "method": "GET", "query_params": {"include_inactive": "true"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/available-tariffs	2026-05-30 07:15:36.241538+00
883	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/devices", "method": "GET", "query_params": {"subscription_id": "8"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/devices	2026-05-30 07:15:36.244657+00
884	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 07:16:00.976094+00
885	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 07:19:03.237902+00
886	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-30 07:19:09.66494+00
887	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-30 07:19:09.663375+00
888	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-30 07:19:10.735191+00
889	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-30 07:19:10.750912+00
890	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 09:13:32.820071+00
891	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-30 09:13:33.133049+00
892	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-30 09:13:33.13393+00
893	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-30 09:13:41.237066+00
894	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-30 09:13:41.237973+00
895	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 09:15:43.730854+00
896	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-30 09:15:44.060182+00
897	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-30 09:15:44.062097+00
898	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-30 09:15:48.025048+00
899	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-30 09:15:48.02686+00
900	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/panel-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/panel-info	2026-05-30 09:15:55.340099+00
901	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/referrals	2026-05-30 09:15:55.341261+00
902	1	users:read	users	\N	{"path": "/cabinet/admin/users/3", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3	2026-05-30 09:15:55.340753+00
903	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/promo-groups	2026-05-30 09:15:55.340173+00
904	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/panel-info", "method": "GET", "query_params": {"subscription_id": "8"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/panel-info	2026-05-30 09:15:55.622924+00
905	1	users:read	users	\N	{"path": "/cabinet/admin/users/3/referrals", "method": "GET", "query_params": {"limit": "50", "offset": "0"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/3/referrals	2026-05-30 09:15:55.624573+00
906	1	promo_groups:read	promo_groups	\N	{"path": "/cabinet/admin/promo-groups", "method": "GET", "query_params": {"limit": "100"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/promo-groups	2026-05-30 09:15:55.625266+00
907	1	users:read	users	\N	{"path": "/cabinet/admin/users", "method": "GET", "query_params": {"limit": "20", "offset": "0", "sort_by": "created_at"}}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users	2026-05-30 09:16:11.40204+00
908	1	users:read	users	\N	{"path": "/cabinet/admin/users/stats", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/users/stats	2026-05-30 09:16:11.403149+00
909	1	tickets:read	tickets	\N	{"path": "/cabinet/admin/tickets/notifications/unread-count", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/tickets/notifications/unread-count	2026-05-30 09:16:15.51675+00
910	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/dashboard", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/dashboard	2026-05-30 09:16:15.525106+00
911	1	stats:read	stats	\N	{"path": "/cabinet/admin/stats/system-info", "method": "GET"}	172.18.0.3	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	success	GET	/cabinet/admin/stats/system-info	2026-05-30 09:16:15.520676+00
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_roles (id, name, description, level, permissions, color, icon, is_system, is_active, created_by, created_at, updated_at) FROM stdin;
1	Superadmin	Full system access	999	["*:*"]	#EF4444	shield	t	t	\N	2026-05-15 01:43:32.100025+00	2026-05-15 01:43:32.100025+00
2	Admin	Administrative access	100	["users:*", "tickets:*", "stats:*", "sales_stats:*", "broadcasts:*", "tariffs:*", "promocodes:*", "promo_groups:*", "promo_offers:*", "campaigns:*", "partners:*", "withdrawals:*", "payments:*", "payment_methods:*", "servers:*", "remnawave:*", "traffic:*", "settings:*", "roles:read", "roles:create", "roles:edit", "roles:assign", "audit_log:*", "channels:*", "ban_system:*", "wheel:*", "apps:*", "email_templates:*", "pinned_messages:*", "updates:*", "landings:read", "landings:create", "landings:edit", "landings:delete"]	#F59E0B	crown	t	t	\N	2026-05-15 01:43:32.100025+00	2026-05-15 01:43:32.100025+00
3	Moderator	User and ticket management	50	["users:read", "users:edit", "users:block", "tickets:*", "ban_system:*"]	#3B82F6	user-shield	t	t	\N	2026-05-15 01:43:32.100025+00	2026-05-15 01:43:32.100025+00
4	Marketer	Marketing tools access	30	["campaigns:*", "broadcasts:*", "promocodes:*", "promo_offers:*", "promo_groups:*", "stats:read", "sales_stats:read", "pinned_messages:*", "wheel:*"]	#8B5CF6	megaphone	t	t	\N	2026-05-15 01:43:32.100025+00	2026-05-15 01:43:32.100025+00
5	Support	Ticket support access	20	["tickets:read", "tickets:reply", "users:read"]	#10B981	headset	t	t	\N	2026-05-15 01:43:32.100025+00	2026-05-15 01:43:32.100025+00
\.


--
-- Data for Name: advertising_campaign_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.advertising_campaign_registrations (id, campaign_id, user_id, bonus_type, balance_bonus_kopeks, subscription_duration_days, tariff_id, tariff_duration_days, created_at) FROM stdin;
\.


--
-- Data for Name: advertising_campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.advertising_campaigns (id, name, start_parameter, bonus_type, balance_bonus_kopeks, subscription_duration_days, subscription_traffic_gb, subscription_device_limit, subscription_squads, tariff_id, tariff_duration_days, is_active, partner_user_id, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
0085
\.


--
-- Data for Name: antilopay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antilopay_payments (id, user_id, order_id, antilopay_payment_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: apple_iap_abuse_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apple_iap_abuse_events (id, user_id, event_type, severity, transaction_id, product_id, ip_address, details_json, created_at) FROM stdin;
\.


--
-- Data for Name: apple_iap_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apple_iap_accounts (id, user_id, account_token_uuid, created_at, rotated_at, disabled_at) FROM stdin;
\.


--
-- Data for Name: apple_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apple_notifications (id, notification_uuid, notification_type, subtype, environment, transaction_id, original_transaction_id, status, error, payload_hash, metadata_json, received_at, processed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: apple_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apple_transactions (id, user_id, transaction_id, original_transaction_id, product_id, bundle_id, amount_kopeks, environment, status, is_paid, paid_at, refunded_at, transaction_id_fk, metadata_json, created_at, updated_at, app_account_token, web_order_line_item_id, storefront, currency, price_micros, purchase_date, revocation_date, revocation_reason, credited_at, refund_reversed_at, signed_transaction_hash) FROM stdin;
\.


--
-- Data for Name: aurapay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aurapay_payments (id, user_id, order_id, aurapay_invoice_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: broadcast_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broadcast_history (id, target_type, message_text, has_media, media_type, media_file_id, media_caption, total_count, sent_count, failed_count, blocked_count, status, admin_id, admin_name, created_at, completed_at, category, channel, email_subject, email_html_content) FROM stdin;
\.


--
-- Data for Name: button_click_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.button_click_logs (id, button_id, user_id, callback_data, clicked_at, button_type, button_text) FROM stdin;
\.


--
-- Data for Name: cabinet_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cabinet_refresh_tokens (id, user_id, token_hash, device_info, expires_at, created_at, revoked_at) FROM stdin;
43	1	34418a84820a786b7a4d88a7f021010f4cad12bb8bcfd756ee6dd665d6594e10	\N	2026-05-31 02:22:36.494178+00	2026-05-24 02:22:36.483048+00	\N
44	1	9d1413135bcb2bc7e1d97b264b63ba17a467cf05279ca65c4d802a02f21d29f6	\N	2026-06-03 02:30:26.09827+00	2026-05-27 02:30:26.08862+00	\N
45	18	0821a685ad48e6679af7529fc1071631b6c806eedf0b8d615a4858478b2331a0	\N	2026-06-04 08:26:01.127564+00	2026-05-28 08:26:01.123978+00	\N
46	3	5c01d0f8e3eb8cb1759f1b5ad457ac501daa0d41afb28db4a8e6e2bffb1a0d37	\N	2026-06-06 07:30:08.034399+00	2026-05-30 07:30:08.031682+00	\N
47	20	75e666d374517549e6f5d6118864f6ef251d5a508978edfee06f471995ca0678	\N	2026-06-06 19:18:55.854683+00	2026-05-30 19:18:55.85123+00	\N
\.


--
-- Data for Name: cloudpayments_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cloudpayments_payments (id, user_id, transaction_id_cp, invoice_id, amount_kopeks, currency, description, status, is_paid, paid_at, card_first_six, card_last_four, card_type, card_exp_date, token, payment_url, email, test_mode, metadata_json, callback_payload, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contest_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_attempts (id, round_id, user_id, answer, is_winner, created_at) FROM stdin;
\.


--
-- Data for Name: contest_rounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_rounds (id, template_id, starts_at, ends_at, status, payload, winners_count, max_winners, attempts_per_user, message_id, chat_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contest_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_templates (id, name, slug, description, prize_type, prize_value, max_winners, attempts_per_user, times_per_day, schedule_times, cooldown_hours, payload, is_enabled, created_at, updated_at) FROM stdin;
3	Квест-кнопки	quest_buttons	Найди секретную кнопку 3×3	days	1	3	1	2	10:00,18:00	24	{"rows": 3, "cols": 3}	f	2026-05-24 14:24:40.065998+00	2026-05-24 14:24:40.065998+00
4	Кнопочный взлом	lock_hack	Найди взломанную кнопку среди 20 замков	days	5	1	1	2	09:00,19:00	24	{"buttons": 20}	f	2026-05-24 14:24:40.128091+00	2026-05-24 14:24:40.128091+00
5	Шифр букв	letter_cipher	Расшифруй слово по номерам	days	1	1	1	2	12:00,20:00	24	{"words": ["VPN", "SERVER", "PROXY", "XRAY"]}	f	2026-05-24 14:24:40.136735+00	2026-05-24 14:24:40.136735+00
6	Сервер-лотерея	server_lottery	Угадай доступный сервер	days	7	1	1	1	15:00	24	{"flags": ["\\ud83c\\uddf8\\ud83c\\uddea", "\\ud83c\\uddf8\\ud83c\\uddec", "\\ud83c\\uddfa\\ud83c\\uddf8", "\\ud83c\\uddf7\\ud83c\\uddfa", "\\ud83c\\udde9\\ud83c\\uddea", "\\ud83c\\uddef\\ud83c\\uddf5", "\\ud83c\\udde7\\ud83c\\uddf7", "\\ud83c\\udde6\\ud83c\\uddfa", "\\ud83c\\udde8\\ud83c\\udde6", "\\ud83c\\uddeb\\ud83c\\uddf7"]}	f	2026-05-24 14:24:40.145043+00	2026-05-24 14:24:40.145043+00
7	Блиц-реакция	blitz_reaction	Нажми кнопку за 10 секунд	days	1	1	1	2	11:00,21:00	24	{"timeout_seconds": 10}	f	2026-05-24 14:24:40.15085+00	2026-05-24 14:24:40.15085+00
8	Угадай сервис по эмодзи	emoji_guess	Определи сервис по эмодзи	days	1	1	1	1	13:00	24	{"pairs": [{"question": "\\ud83d\\udd10\\ud83d\\udce1\\ud83c\\udf10", "answer": "VPN"}]}	f	2026-05-24 14:24:40.157732+00	2026-05-24 14:24:40.157732+00
9	Анаграмма дня	anagram	Собери слово из букв	days	1	1	1	1	17:00	24	{"words": ["SERVER", "XRAY", "VPN"]}	f	2026-05-24 14:24:40.163394+00	2026-05-24 14:24:40.163394+00
\.


--
-- Data for Name: cryptobot_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cryptobot_payments (id, user_id, invoice_id, amount, asset, status, description, payload, bot_invoice_url, mini_app_invoice_url, web_app_invoice_url, paid_at, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: discount_offers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_offers (id, user_id, subscription_id, notification_type, discount_percent, bonus_amount_kopeks, expires_at, claimed_at, is_active, effect_type, extra_data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: donut_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donut_payments (id, user_id, order_id, donut_transaction_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_templates (id, notification_type, language, subject, body_html, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: etoplatezhi_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etoplatezhi_payments (id, user_id, order_id, etoplatezhi_payment_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: faq_pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faq_pages (id, language, title, content, display_order, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: faq_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faq_settings (id, language, is_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: freekassa_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.freekassa_payments (id, user_id, order_id, freekassa_order_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_system_id, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: guest_purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guest_purchases (id, token, landing_id, contact_type, contact_value, is_gift, source, buyer_user_id, gift_recipient_type, gift_recipient_value, gift_message, tariff_id, period_days, amount_kopeks, currency, payment_method, payment_id, status, subscription_url, subscription_crypto_link, user_id, created_at, paid_at, delivered_at, cabinet_password, auto_login_token, recipient_warning, retry_count, receipt_uuid, receipt_created_at, yandex_cid, subid, referrer) FROM stdin;
\.


--
-- Data for Name: heleket_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.heleket_payments (id, user_id, uuid, order_id, amount, currency, payer_amount, payer_currency, exchange_rate, discount_percent, status, payment_url, metadata_json, paid_at, expires_at, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: info_pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.info_pages (id, slug, title, content, page_type, is_active, sort_order, icon, replaces_tab, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: jupiter_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jupiter_payments (id, user_id, order_id, jupiter_transaction_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: kassa_ai_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kassa_ai_payments (id, user_id, order_id, kassa_ai_order_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_system_id, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: landing_pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.landing_pages (id, slug, is_active, title, subtitle, features, footer_text, allowed_tariff_ids, allowed_periods, payment_methods, gift_enabled, custom_css, meta_title, meta_description, display_order, discount_percent, discount_overrides, discount_starts_at, discount_ends_at, discount_badge_text, background_config, sticky_pay_button, analytics_view_enabled, analytics_view_goal, analytics_click_enabled, analytics_click_goal, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lava_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lava_payments (id, user_id, order_id, lava_invoice_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: main_menu_buttons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_menu_buttons (id, text, action_type, action_value, visibility, is_active, display_order, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: menu_layout_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_layout_history (id, config_json, action, changes_summary, user_info, created_at) FROM stdin;
\.


--
-- Data for Name: monitoring_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monitoring_logs (id, event_type, message, data, is_success, created_at) FROM stdin;
1	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T01:43:43.825353+00:00"}	t	2026-05-15 01:43:43.636813+00
2	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T02:03:44.772731+00:00"}	t	2026-05-15 02:03:44.584034+00
3	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T04:22:18.498882+00:00"}	t	2026-05-15 04:22:18.302075+00
4	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T18:38:57.572271+00:00"}	t	2026-05-15 18:38:57.261093+00
5	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T18:50:16.343487+00:00"}	t	2026-05-15 18:50:16.107329+00
6	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 671715328, "used": 1386496000}, "uptime": 35832.08, "timestamp": 1778871632528, "users": {"statusCounts": {"ACTIVE": 0, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 0}, "onlineStats": {"onlineNow": 0, "lastDay": 0, "lastWeek": 0, "neverOnline": 0}, "nodes": {"totalOnline": 0, "totalBytesLifetime": "0"}}}	t	2026-05-15 19:00:32.379076+00
7	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T19:00:32.538930+00:00"}	t	2026-05-15 19:00:32.540634+00
8	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T19:46:58.373943+00:00"}	t	2026-05-15 19:46:58.254211+00
9	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T19:59:18.536747+00:00"}	t	2026-05-15 19:59:18.423568+00
10	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T20:21:54.584553+00:00"}	t	2026-05-15 20:21:54.471454+00
11	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T21:21:54.623518+00:00"}	t	2026-05-15 21:21:54.594283+00
12	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T22:21:54.704661+00:00"}	t	2026-05-15 22:21:54.673767+00
13	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-15T23:21:54.769015+00:00"}	t	2026-05-15 23:21:54.737846+00
14	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T00:21:54.839334+00:00"}	t	2026-05-16 00:21:54.811572+00
15	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T01:21:54.913826+00:00"}	t	2026-05-16 01:21:54.883806+00
16	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T02:21:54.985565+00:00"}	t	2026-05-16 02:21:54.949933+00
17	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T03:21:55.047137+00:00"}	t	2026-05-16 03:21:55.019466+00
18	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T04:21:55.150239+00:00"}	t	2026-05-16 04:21:55.088476+00
19	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T05:21:55.222974+00:00"}	t	2026-05-16 05:21:55.18855+00
20	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T06:21:55.314314+00:00"}	t	2026-05-16 06:21:55.27764+00
21	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T07:21:55.392567+00:00"}	t	2026-05-16 07:21:55.359899+00
22	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T07:28:49.674150+00:00"}	t	2026-05-16 07:28:49.472968+00
23	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T08:28:51.172882+00:00"}	t	2026-05-16 08:28:50.57607+00
24	expiring_notifications_sent	Отправлено 1 уведомлений об истечении через 1 дней	{"days": 1, "count": 1}	t	2026-05-16 09:28:52.823295+00
25	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T09:28:52.893024+00:00"}	t	2026-05-16 09:28:52.865731+00
26	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T10:28:54.029597+00:00"}	t	2026-05-16 10:28:53.044507+00
27	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T11:15:48.738356+00:00"}	t	2026-05-16 11:15:48.387727+00
28	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T12:15:48.811997+00:00"}	t	2026-05-16 12:15:48.752149+00
29	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T12:36:28.001958+00:00"}	t	2026-05-16 12:36:27.656577+00
30	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 714985472, "used": 1343225856}, "uptime": 100611.08, "timestamp": 1778936411527, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "860935051"}}}	t	2026-05-16 13:00:11.290981+00
31	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T13:00:11.536252+00:00"}	t	2026-05-16 13:00:11.537759+00
32	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 608325632, "used": 1449885696}, "uptime": 104211.25, "timestamp": 1778940011693, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 0, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 0, "totalBytesLifetime": "950696566"}}}	t	2026-05-16 14:00:11.585782+00
33	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T14:00:11.703443+00:00"}	t	2026-05-16 14:00:11.740878+00
34	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 588115968, "used": 1470095360}, "uptime": 107811.38, "timestamp": 1778943611823, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1110906427"}}}	t	2026-05-16 15:00:11.750415+00
35	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T15:00:11.836159+00:00"}	t	2026-05-16 15:00:11.838203+00
61	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T05:53:03.472987+00:00"}	t	2026-05-17 05:53:03.35615+00
36	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 586289152, "used": 1471922176}, "uptime": 111411.5, "timestamp": 1778947211947, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1371697566"}}}	t	2026-05-16 16:00:11.879367+00
37	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T16:00:11.958756+00:00"}	t	2026-05-16 16:00:12.004919+00
38	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 585945088, "used": 1472266240}, "uptime": 115011.67, "timestamp": 1778950812110, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1421973976"}}}	t	2026-05-16 17:00:12.048984+00
39	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T17:00:12.115142+00:00"}	t	2026-05-16 17:00:12.149372+00
40	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 596963328, "used": 1461248000}, "uptime": 118611.79, "timestamp": 1778954412237, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1474463300"}}}	t	2026-05-16 18:00:12.187924+00
41	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T18:00:12.243557+00:00"}	t	2026-05-16 18:00:12.279607+00
42	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 583503872, "used": 1474707456}, "uptime": 122211.93, "timestamp": 1778958012376, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1525409591"}}}	t	2026-05-16 19:00:12.323339+00
43	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T19:00:12.382221+00:00"}	t	2026-05-16 19:00:12.414346+00
44	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 597069824, "used": 1461141504}, "uptime": 125812.07, "timestamp": 1778961612515, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1579261551"}}}	t	2026-05-16 20:00:12.45795+00
45	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T20:00:12.520807+00:00"}	t	2026-05-16 20:00:12.553889+00
46	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 613711872, "used": 1444499456}, "uptime": 129412.22, "timestamp": 1778965212659, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "1683214151"}}}	t	2026-05-16 21:00:12.597869+00
47	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T21:00:12.668641+00:00"}	t	2026-05-16 21:00:12.702994+00
48	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 568393728, "used": 1489817600}, "uptime": 133012.35, "timestamp": 1778968812794, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "2145421621"}}}	t	2026-05-16 22:00:12.749505+00
49	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T22:00:12.802404+00:00"}	t	2026-05-16 22:00:12.832806+00
50	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 602648576, "used": 1455562752}, "uptime": 136612.44, "timestamp": 1778972412885, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "2384057061"}}}	t	2026-05-16 23:00:12.8407+00
51	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-16T23:00:12.890841+00:00"}	t	2026-05-16 23:00:12.892637+00
52	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 584400896, "used": 1473810432}, "uptime": 140220.1, "timestamp": 1778976020540, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 0, "totalBytesLifetime": "2446784495"}}}	t	2026-05-17 00:00:20.580974+00
53	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T00:00:21.321877+00:00"}	t	2026-05-17 00:00:21.35707+00
54	remnawave_sync	Синхронизация с RemnaWave завершена	{"stats": {"cpu": {"cores": 1}, "memory": {"total": 2058211328, "free": 621142016, "used": 1437069312}, "uptime": 143821, "timestamp": 1778979621448, "users": {"statusCounts": {"ACTIVE": 1, "DISABLED": 0, "LIMITED": 0, "EXPIRED": 0}, "totalUsers": 1}, "onlineStats": {"onlineNow": 1, "lastDay": 1, "lastWeek": 1, "neverOnline": 0}, "nodes": {"totalOnline": 1, "totalBytesLifetime": "2454674240"}}}	t	2026-05-17 01:00:21.39834+00
55	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T01:00:21.462863+00:00"}	t	2026-05-17 01:00:21.530072+00
56	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T01:13:06.087829+00:00"}	t	2026-05-17 01:13:05.898595+00
57	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T02:13:06.164238+00:00"}	t	2026-05-17 02:13:06.131581+00
58	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T03:13:06.367123+00:00"}	t	2026-05-17 03:13:06.234139+00
59	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T04:13:06.441151+00:00"}	t	2026-05-17 04:13:06.406162+00
60	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T05:13:06.574890+00:00"}	t	2026-05-17 05:13:06.521192+00
62	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T06:53:03.706395+00:00"}	t	2026-05-17 06:53:03.544752+00
63	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T07:53:03.791041+00:00"}	t	2026-05-17 07:53:03.748654+00
64	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T08:53:03.965416+00:00"}	t	2026-05-17 08:53:03.831684+00
65	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T09:53:04.072142+00:00"}	t	2026-05-17 09:53:04.009908+00
66	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T10:53:04.182579+00:00"}	t	2026-05-17 10:53:04.121491+00
67	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T11:53:04.280144+00:00"}	t	2026-05-17 11:53:04.234024+00
68	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T12:53:04.367902+00:00"}	t	2026-05-17 12:53:04.29067+00
69	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T13:53:06.370200+00:00"}	t	2026-05-17 13:53:04.971387+00
70	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T14:53:06.651426+00:00"}	t	2026-05-17 14:53:06.575377+00
71	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T15:53:06.817597+00:00"}	t	2026-05-17 15:53:06.743143+00
72	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T16:53:06.873272+00:00"}	t	2026-05-17 16:53:06.828678+00
73	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T17:53:06.957068+00:00"}	t	2026-05-17 17:53:06.913198+00
74	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T18:53:07.061868+00:00"}	t	2026-05-17 18:53:07.006441+00
75	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T19:53:07.155998+00:00"}	t	2026-05-17 19:53:07.099767+00
76	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T20:53:07.241107+00:00"}	t	2026-05-17 20:53:07.197431+00
77	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T21:53:07.326262+00:00"}	t	2026-05-17 21:53:07.279165+00
78	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T22:53:07.476348+00:00"}	t	2026-05-17 22:53:07.392544+00
79	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-17T23:53:07.553547+00:00"}	t	2026-05-17 23:53:07.510054+00
80	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T00:53:07.627311+00:00"}	t	2026-05-18 00:53:07.591633+00
81	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T01:53:07.695546+00:00"}	t	2026-05-18 01:53:07.658227+00
82	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T02:53:07.842169+00:00"}	t	2026-05-18 02:53:07.760946+00
83	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T03:53:07.891903+00:00"}	t	2026-05-18 03:53:07.855878+00
84	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T04:53:07.936261+00:00"}	t	2026-05-18 04:53:07.901579+00
85	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T05:53:08.044005+00:00"}	t	2026-05-18 05:53:07.987651+00
86	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T06:53:08.130615+00:00"}	t	2026-05-18 06:53:08.086813+00
87	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T07:53:08.177784+00:00"}	t	2026-05-18 07:53:08.179253+00
88	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T08:53:08.228765+00:00"}	t	2026-05-18 08:53:08.185655+00
89	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T09:53:08.333791+00:00"}	t	2026-05-18 09:53:08.276416+00
90	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T10:53:08.441200+00:00"}	t	2026-05-18 10:53:08.380707+00
91	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T11:53:08.842592+00:00"}	t	2026-05-18 11:53:08.56369+00
92	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T12:53:09.041268+00:00"}	t	2026-05-18 12:53:08.924872+00
93	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T13:53:09.146458+00:00"}	t	2026-05-18 13:53:09.095068+00
94	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T14:53:09.243753+00:00"}	t	2026-05-18 14:53:09.188849+00
95	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T15:53:09.348775+00:00"}	t	2026-05-18 15:53:09.288802+00
96	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T16:53:09.451280+00:00"}	t	2026-05-18 16:53:09.390289+00
97	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T17:53:09.557593+00:00"}	t	2026-05-18 17:53:09.505458+00
98	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T18:53:09.630593+00:00"}	t	2026-05-18 18:53:09.585805+00
99	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T19:53:09.740750+00:00"}	t	2026-05-18 19:53:09.675126+00
100	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T20:53:09.845243+00:00"}	t	2026-05-18 20:53:09.792527+00
101	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T21:53:09.934521+00:00"}	t	2026-05-18 21:53:09.89115+00
102	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T22:53:10.025558+00:00"}	t	2026-05-18 22:53:09.969971+00
103	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-18T23:53:10.103316+00:00"}	t	2026-05-18 23:53:10.060595+00
104	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T00:53:10.171581+00:00"}	t	2026-05-19 00:53:10.138517+00
105	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T01:53:10.211701+00:00"}	t	2026-05-19 01:53:10.178125+00
106	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T02:53:10.299745+00:00"}	t	2026-05-19 02:53:10.260357+00
107	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T03:53:10.377686+00:00"}	t	2026-05-19 03:53:10.334918+00
108	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T04:42:30.806324+00:00"}	t	2026-05-19 04:42:30.6465+00
109	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T05:42:31.991083+00:00"}	t	2026-05-19 05:42:31.062476+00
110	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T06:58:17.472439+00:00"}	t	2026-05-19 06:58:14.050551+00
111	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T07:53:29.275177+00:00"}	t	2026-05-19 07:53:29.081598+00
112	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T08:53:29.324266+00:00"}	t	2026-05-19 08:53:29.282916+00
113	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T09:25:30.067046+00:00"}	t	2026-05-19 09:25:28.449441+00
114	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T09:30:02.619509+00:00"}	t	2026-05-19 09:30:02.414697+00
115	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T10:30:02.689475+00:00"}	t	2026-05-19 10:30:02.638607+00
116	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T11:30:02.893962+00:00"}	t	2026-05-19 11:30:02.730823+00
117	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T12:30:03.068595+00:00"}	t	2026-05-19 12:30:03.00069+00
118	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T13:30:03.166770+00:00"}	t	2026-05-19 13:30:03.119033+00
119	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T14:30:03.273646+00:00"}	t	2026-05-19 14:30:03.213589+00
120	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T15:30:03.361598+00:00"}	t	2026-05-19 15:30:03.316289+00
121	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T16:30:03.565385+00:00"}	t	2026-05-19 16:30:03.441952+00
122	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T17:30:03.703520+00:00"}	t	2026-05-19 17:30:03.611644+00
123	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T18:30:03.821317+00:00"}	t	2026-05-19 18:30:03.770723+00
124	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T19:30:03.910994+00:00"}	t	2026-05-19 19:30:03.839167+00
125	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T20:30:04.023322+00:00"}	t	2026-05-19 20:30:03.965735+00
126	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T21:30:04.117427+00:00"}	t	2026-05-19 21:30:04.071981+00
127	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T22:30:04.205475+00:00"}	t	2026-05-19 22:30:04.160928+00
128	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-19T23:30:04.346668+00:00"}	t	2026-05-19 23:30:04.265655+00
129	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T00:30:04.697435+00:00"}	t	2026-05-20 00:30:04.414421+00
130	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T01:30:04.785006+00:00"}	t	2026-05-20 01:30:04.741307+00
131	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T02:30:04.861565+00:00"}	t	2026-05-20 02:30:04.821649+00
132	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T03:30:05.071522+00:00"}	t	2026-05-20 03:30:04.936504+00
133	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T04:30:05.194493+00:00"}	t	2026-05-20 04:30:05.138029+00
134	trial_expiring_notifications_sent	Отправлено 1 уведомлений об окончании тестовых подписок	{"count": 1}	t	2026-05-20 05:30:05.652334+00
135	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T05:30:05.735105+00:00"}	t	2026-05-20 05:30:05.704217+00
136	trial_expiring_notifications_sent	Отправлено 1 уведомлений об окончании тестовых подписок	{"count": 1}	t	2026-05-20 06:30:06.445884+00
137	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T06:30:07.245819+00:00"}	t	2026-05-20 06:30:07.208247+00
138	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T07:30:07.409270+00:00"}	t	2026-05-20 07:30:07.357602+00
139	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T08:30:07.538549+00:00"}	t	2026-05-20 08:30:07.577642+00
140	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T09:30:07.695781+00:00"}	t	2026-05-20 09:30:07.626622+00
141	trial_expiring_notifications_sent	Отправлено 2 уведомлений об окончании тестовых подписок	{"count": 2}	t	2026-05-20 10:30:09.346373+00
142	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T10:30:09.408243+00:00"}	t	2026-05-20 10:30:09.38722+00
143	trial_expiring_notifications_sent	Отправлено 2 уведомлений об окончании тестовых подписок	{"count": 2}	t	2026-05-20 11:30:09.450392+00
144	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T11:30:09.576273+00:00"}	t	2026-05-20 11:30:09.554457+00
145	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T12:30:09.681607+00:00"}	t	2026-05-20 12:30:09.62776+00
146	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T13:30:09.792399+00:00"}	t	2026-05-20 13:30:09.731292+00
147	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T14:30:09.839741+00:00"}	t	2026-05-20 14:30:09.80034+00
148	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T15:30:09.933572+00:00"}	t	2026-05-20 15:30:09.884291+00
149	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T16:30:10.039058+00:00"}	t	2026-05-20 16:30:09.981543+00
150	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T17:30:10.130111+00:00"}	t	2026-05-20 17:30:10.081929+00
151	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T18:30:10.219294+00:00"}	t	2026-05-20 18:30:10.178607+00
152	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T19:30:10.320055+00:00"}	t	2026-05-20 19:30:10.264538+00
153	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T20:30:10.423306+00:00"}	t	2026-05-20 20:30:10.370002+00
154	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T21:30:10.516781+00:00"}	t	2026-05-20 21:30:10.463647+00
155	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T22:30:10.630352+00:00"}	t	2026-05-20 22:30:10.583818+00
156	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-20T23:30:10.712936+00:00"}	t	2026-05-20 23:30:10.672399+00
157	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T00:30:10.801931+00:00"}	t	2026-05-21 00:30:10.760563+00
158	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T01:30:10.891638+00:00"}	t	2026-05-21 01:30:10.847289+00
159	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T02:30:10.955183+00:00"}	t	2026-05-21 02:30:10.924302+00
160	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T03:30:11.051975+00:00"}	t	2026-05-21 03:30:10.997044+00
161	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T04:30:11.123218+00:00"}	t	2026-05-21 04:30:11.084405+00
162	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T05:30:11.209582+00:00"}	t	2026-05-21 05:30:11.164643+00
163	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T06:30:11.302995+00:00"}	t	2026-05-21 06:30:11.254032+00
164	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T07:30:11.396518+00:00"}	t	2026-05-21 07:30:11.351641+00
165	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T08:30:11.705170+00:00"}	t	2026-05-21 08:30:11.404286+00
166	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T09:31:11.855081+00:00"}	t	2026-05-21 09:30:11.776842+00
167	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T10:31:13.111578+00:00"}	t	2026-05-21 10:31:11.903741+00
168	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T11:31:13.187146+00:00"}	t	2026-05-21 11:31:13.146486+00
169	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T12:10:04.579933+00:00"}	t	2026-05-21 12:10:04.366843+00
170	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T13:23:31.910254+00:00"}	t	2026-05-21 13:23:31.654504+00
171	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T14:23:31.979598+00:00"}	t	2026-05-21 14:23:31.929057+00
172	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T15:23:33.073428+00:00"}	t	2026-05-21 15:23:32.125824+00
173	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T16:23:33.482610+00:00"}	t	2026-05-21 16:23:33.203761+00
174	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T17:23:34.162521+00:00"}	t	2026-05-21 17:23:33.765576+00
175	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T20:06:42.273837+00:00"}	t	2026-05-21 20:06:41.549204+00
176	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T21:06:42.371043+00:00"}	t	2026-05-21 21:06:42.32686+00
177	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T22:06:42.486182+00:00"}	t	2026-05-21 22:06:42.451631+00
178	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-21T23:06:42.608067+00:00"}	t	2026-05-21 23:06:42.53057+00
179	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T00:06:42.644967+00:00"}	t	2026-05-22 00:06:42.614004+00
180	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T01:06:42.685602+00:00"}	t	2026-05-22 01:06:42.652054+00
181	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T02:06:43.315027+00:00"}	t	2026-05-22 02:06:42.738057+00
182	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T03:06:43.364928+00:00"}	t	2026-05-22 03:06:43.330987+00
183	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T04:06:43.402246+00:00"}	t	2026-05-22 04:06:43.370051+00
184	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T05:06:43.519041+00:00"}	t	2026-05-22 05:06:43.440326+00
185	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T06:06:43.558823+00:00"}	t	2026-05-22 06:06:43.524858+00
186	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T07:06:44.174063+00:00"}	t	2026-05-22 07:06:43.599477+00
187	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T08:06:44.232138+00:00"}	t	2026-05-22 08:06:44.184244+00
188	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T09:06:44.282167+00:00"}	t	2026-05-22 09:06:44.242617+00
189	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T10:06:44.665460+00:00"}	t	2026-05-22 10:06:44.340322+00
190	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T11:06:45.263649+00:00"}	t	2026-05-22 11:06:44.723737+00
191	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T12:06:45.319759+00:00"}	t	2026-05-22 12:06:45.280247+00
192	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T13:06:45.392942+00:00"}	t	2026-05-22 13:06:45.342945+00
193	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T13:32:45.186029+00:00"}	t	2026-05-22 13:32:43.583267+00
194	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T14:15:26.403339+00:00"}	t	2026-05-22 14:15:26.175047+00
196	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T16:15:31.617354+00:00"}	t	2026-05-22 16:15:31.525213+00
197	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T16:52:55.577937+00:00"}	t	2026-05-22 16:52:54.970558+00
198	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T17:52:56.071260+00:00"}	t	2026-05-22 17:52:55.700647+00
199	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T18:32:29.524928+00:00"}	t	2026-05-22 18:32:28.870278+00
200	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T19:32:29.666564+00:00"}	t	2026-05-22 19:32:29.594957+00
201	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T20:32:29.882399+00:00"}	t	2026-05-22 20:32:29.964938+00
202	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T21:32:30.169049+00:00"}	t	2026-05-22 21:32:29.99553+00
203	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T22:32:30.327817+00:00"}	t	2026-05-22 22:32:30.251755+00
204	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-22T23:32:30.411123+00:00"}	t	2026-05-22 23:32:30.466535+00
205	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T00:32:30.584031+00:00"}	t	2026-05-23 00:32:30.48512+00
206	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T01:32:30.762096+00:00"}	t	2026-05-23 01:32:30.607307+00
207	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T02:32:30.861644+00:00"}	t	2026-05-23 02:32:30.792823+00
208	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T03:32:30.984352+00:00"}	t	2026-05-23 03:32:30.885063+00
209	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T04:23:04.460462+00:00"}	t	2026-05-23 04:23:04.164447+00
210	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T05:23:04.612534+00:00"}	t	2026-05-23 05:23:04.538577+00
211	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T06:23:04.712474+00:00"}	t	2026-05-23 06:23:04.63995+00
212	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T07:23:04.800381+00:00"}	t	2026-05-23 07:23:04.732215+00
213	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T08:23:04.948284+00:00"}	t	2026-05-23 08:23:04.877542+00
214	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T09:23:05.034798+00:00"}	t	2026-05-23 09:23:04.969829+00
215	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T10:23:05.144298+00:00"}	t	2026-05-23 10:23:05.060312+00
216	expiring_notifications_sent	Отправлено 1 уведомлений об истечении через 3 дней	{"days": 3, "count": 1}	t	2026-05-23 11:23:05.456505+00
217	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T11:23:05.557944+00:00"}	t	2026-05-23 11:23:05.560257+00
218	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T12:23:05.696494+00:00"}	t	2026-05-23 12:23:05.579429+00
219	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T13:23:05.898965+00:00"}	t	2026-05-23 13:23:05.770958+00
220	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T14:23:06.157133+00:00"}	t	2026-05-23 14:23:05.933315+00
221	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T15:23:06.294919+00:00"}	t	2026-05-23 15:23:06.180266+00
222	expiring_notifications_sent	Отправлено 1 уведомлений об истечении через 1 дней	{"days": 1, "count": 1}	t	2026-05-23 16:23:06.540389+00
223	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T16:23:06.586796+00:00"}	t	2026-05-23 16:23:06.553747+00
224	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T17:23:06.973767+00:00"}	t	2026-05-23 17:23:06.664962+00
225	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T18:23:07.144420+00:00"}	t	2026-05-23 18:23:06.998165+00
226	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T19:23:07.343803+00:00"}	t	2026-05-23 19:23:07.164494+00
227	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T20:23:07.729386+00:00"}	t	2026-05-23 20:23:07.35955+00
228	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T21:23:07.959500+00:00"}	t	2026-05-23 21:23:07.752055+00
229	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T22:23:08.102864+00:00"}	t	2026-05-23 22:23:07.974667+00
230	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-23T23:23:08.331011+00:00"}	t	2026-05-23 23:23:08.181971+00
231	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T00:23:08.491664+00:00"}	t	2026-05-24 00:23:08.350447+00
232	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T01:23:08.662906+00:00"}	t	2026-05-24 01:23:08.505267+00
233	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T02:23:08.910417+00:00"}	t	2026-05-24 02:23:08.91266+00
234	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T03:23:09.190781+00:00"}	t	2026-05-24 03:23:08.930672+00
235	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T04:23:09.362652+00:00"}	t	2026-05-24 04:23:09.220016+00
236	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T05:23:09.560767+00:00"}	t	2026-05-24 05:23:09.388653+00
237	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T06:23:09.840809+00:00"}	t	2026-05-24 06:23:09.842974+00
238	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T07:23:10.142339+00:00"}	t	2026-05-24 07:23:10.144716+00
239	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T08:23:10.376407+00:00"}	t	2026-05-24 08:23:10.432363+00
240	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T09:23:10.651360+00:00"}	t	2026-05-24 09:23:10.517803+00
241	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T10:23:10.868865+00:00"}	t	2026-05-24 10:23:10.677799+00
242	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T11:23:11.049757+00:00"}	t	2026-05-24 11:23:11.052885+00
243	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T12:23:11.365994+00:00"}	t	2026-05-24 12:23:11.4255+00
244	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T13:23:11.578500+00:00"}	t	2026-05-24 13:23:11.444398+00
245	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T14:09:38.821675+00:00"}	t	2026-05-24 14:09:38.501866+00
246	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T14:19:30.992175+00:00"}	t	2026-05-24 14:19:30.707445+00
247	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T14:24:47.326114+00:00"}	t	2026-05-24 14:24:46.95994+00
248	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T14:32:15.525591+00:00"}	t	2026-05-24 14:32:15.118085+00
249	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T15:32:15.919875+00:00"}	t	2026-05-24 15:32:15.718422+00
250	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T16:32:16.162555+00:00"}	t	2026-05-24 16:32:16.252717+00
251	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T17:32:16.359699+00:00"}	t	2026-05-24 17:32:16.274573+00
252	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T18:32:16.523178+00:00"}	t	2026-05-24 18:32:16.376513+00
253	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T19:32:16.662774+00:00"}	t	2026-05-24 19:32:16.541728+00
254	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T20:32:16.776327+00:00"}	t	2026-05-24 20:32:16.679414+00
255	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T21:32:16.898917+00:00"}	t	2026-05-24 21:32:16.793114+00
256	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T22:32:17.006182+00:00"}	t	2026-05-24 22:32:16.920199+00
257	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-24T23:32:17.154380+00:00"}	t	2026-05-24 23:32:17.04839+00
258	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T00:32:17.267655+00:00"}	t	2026-05-25 00:32:17.172959+00
259	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T01:32:17.446438+00:00"}	t	2026-05-25 01:32:17.318817+00
260	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T02:32:17.572150+00:00"}	t	2026-05-25 02:32:17.467053+00
261	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T03:32:17.749638+00:00"}	t	2026-05-25 03:32:17.662667+00
262	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T04:32:17.932947+00:00"}	t	2026-05-25 04:32:17.937187+00
263	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T05:32:18.048273+00:00"}	t	2026-05-25 05:32:17.960776+00
264	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T06:32:18.219298+00:00"}	t	2026-05-25 06:32:18.066115+00
265	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T07:32:18.387241+00:00"}	t	2026-05-25 07:32:18.244724+00
266	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T08:32:18.495858+00:00"}	t	2026-05-25 08:32:18.407485+00
267	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T09:32:18.636408+00:00"}	t	2026-05-25 09:32:18.525422+00
268	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T10:32:18.979693+00:00"}	t	2026-05-25 10:32:18.819239+00
269	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T11:32:19.197816+00:00"}	t	2026-05-25 11:32:19.086887+00
270	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T12:32:19.473314+00:00"}	t	2026-05-25 12:32:19.22507+00
271	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T13:32:19.597527+00:00"}	t	2026-05-25 13:32:19.489776+00
272	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T14:32:19.752025+00:00"}	t	2026-05-25 14:32:19.620771+00
273	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T15:30:07.597841+00:00"}	t	2026-05-25 15:30:07.265338+00
274	expired_followups_sent	Follow-ups: 1д=1, скидка 2-3д=0, скидка N=0	{"day1": 1, "wave2": 0, "wave3": 0}	t	2026-05-25 16:30:08.435515+00
275	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T16:30:08.479142+00:00"}	t	2026-05-25 16:30:08.446332+00
276	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T17:30:08.653257+00:00"}	t	2026-05-25 17:30:08.518718+00
277	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T18:30:08.788735+00:00"}	t	2026-05-25 18:30:08.673462+00
278	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T19:30:08.993679+00:00"}	t	2026-05-25 19:30:08.808069+00
279	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T20:30:09.096474+00:00"}	t	2026-05-25 20:30:09.014577+00
280	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T21:30:09.226612+00:00"}	t	2026-05-25 21:30:09.116462+00
281	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T22:30:09.514579+00:00"}	t	2026-05-25 22:30:09.245728+00
282	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-25T23:30:09.630170+00:00"}	t	2026-05-25 23:30:09.545324+00
283	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T00:30:09.766461+00:00"}	t	2026-05-26 00:30:09.646063+00
284	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T01:30:09.987813+00:00"}	t	2026-05-26 01:30:09.790071+00
285	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T02:30:10.224509+00:00"}	t	2026-05-26 02:30:10.018875+00
286	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T03:30:10.395305+00:00"}	t	2026-05-26 03:30:10.28428+00
287	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T04:30:10.750357+00:00"}	t	2026-05-26 04:30:10.416519+00
288	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T05:30:11.199613+00:00"}	t	2026-05-26 05:30:10.840544+00
289	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T06:30:11.374937+00:00"}	t	2026-05-26 06:30:11.223045+00
290	trial_expiring_notifications_sent	Отправлено 1 уведомлений об окончании тестовых подписок	{"count": 1}	t	2026-05-26 07:30:11.698562+00
291	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T07:30:11.746604+00:00"}	t	2026-05-26 07:30:11.710665+00
292	trial_expiring_notifications_sent	Отправлено 1 уведомлений об окончании тестовых подписок	{"count": 1}	t	2026-05-26 08:30:11.763989+00
293	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T08:30:11.913213+00:00"}	t	2026-05-26 08:30:11.91995+00
294	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T09:30:12.126212+00:00"}	t	2026-05-26 09:30:12.129182+00
295	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T10:30:12.469969+00:00"}	t	2026-05-26 10:30:12.174182+00
296	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T11:30:12.749228+00:00"}	t	2026-05-26 11:30:12.56655+00
297	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T12:30:13.081459+00:00"}	t	2026-05-26 12:30:12.828475+00
298	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T13:30:13.464543+00:00"}	t	2026-05-26 13:30:13.226871+00
299	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T14:30:13.740108+00:00"}	t	2026-05-26 14:30:13.488598+00
300	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T15:30:13.852518+00:00"}	t	2026-05-26 15:30:13.763011+00
301	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T16:30:14.094903+00:00"}	t	2026-05-26 16:30:13.874064+00
302	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T17:30:14.230180+00:00"}	t	2026-05-26 17:30:14.119432+00
303	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T18:30:14.494799+00:00"}	t	2026-05-26 18:30:14.27058+00
304	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T19:30:14.657084+00:00"}	t	2026-05-26 19:30:14.523768+00
305	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T20:30:14.817219+00:00"}	t	2026-05-26 20:30:14.675267+00
306	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T21:30:14.925265+00:00"}	t	2026-05-26 21:30:14.846945+00
307	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T22:30:15.104943+00:00"}	t	2026-05-26 22:30:14.949677+00
308	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-26T23:30:15.310025+00:00"}	t	2026-05-26 23:30:15.135715+00
309	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T00:30:15.481190+00:00"}	t	2026-05-27 00:30:15.330309+00
310	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T01:30:15.760727+00:00"}	t	2026-05-27 01:30:15.510256+00
311	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T02:30:15.866475+00:00"}	t	2026-05-27 02:30:15.78801+00
312	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T03:30:16.064806+00:00"}	t	2026-05-27 03:30:15.945094+00
313	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T04:30:16.224206+00:00"}	t	2026-05-27 04:30:16.136277+00
314	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T05:30:16.355389+00:00"}	t	2026-05-27 05:30:16.237287+00
315	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T06:30:16.507176+00:00"}	t	2026-05-27 06:30:16.375335+00
316	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T07:30:16.632560+00:00"}	t	2026-05-27 07:30:16.531644+00
317	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T08:30:16.863730+00:00"}	t	2026-05-27 08:30:16.652802+00
318	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T09:30:17.020211+00:00"}	t	2026-05-27 09:30:16.888998+00
319	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T10:30:17.202584+00:00"}	t	2026-05-27 10:30:17.033071+00
320	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T11:30:17.337403+00:00"}	t	2026-05-27 11:30:17.219315+00
321	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T12:30:17.493087+00:00"}	t	2026-05-27 12:30:17.357885+00
322	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T13:04:18.996819+00:00"}	t	2026-05-27 13:04:18.04674+00
323	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T13:43:04.926012+00:00"}	t	2026-05-27 13:43:04.0202+00
324	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T13:50:30.291721+00:00"}	t	2026-05-27 13:50:29.727744+00
325	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T14:50:30.436044+00:00"}	t	2026-05-27 14:50:30.440098+00
358	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T15:08:47.308400+00:00"}	t	2026-05-27 15:08:46.940098+00
359	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T16:08:47.439266+00:00"}	t	2026-05-27 16:08:47.332823+00
360	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T17:08:47.543994+00:00"}	t	2026-05-27 17:08:47.453142+00
361	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T18:08:47.693432+00:00"}	t	2026-05-27 18:08:47.561318+00
362	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T19:08:47.803258+00:00"}	t	2026-05-27 19:08:47.70876+00
363	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T20:08:47.909719+00:00"}	t	2026-05-27 20:08:47.821733+00
364	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T21:08:48.039256+00:00"}	t	2026-05-27 21:08:47.924421+00
365	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T22:08:48.142479+00:00"}	t	2026-05-27 22:08:48.056036+00
366	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-27T23:08:48.286334+00:00"}	t	2026-05-27 23:08:48.16078+00
367	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T00:08:48.442263+00:00"}	t	2026-05-28 00:08:48.305764+00
368	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T01:08:48.589232+00:00"}	t	2026-05-28 01:08:48.469314+00
369	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T02:08:48.717582+00:00"}	t	2026-05-28 02:08:48.609868+00
370	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T03:08:48.860500+00:00"}	t	2026-05-28 03:08:48.74051+00
371	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T04:08:49.131582+00:00"}	t	2026-05-28 04:08:48.886846+00
372	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T05:08:49.244468+00:00"}	t	2026-05-28 05:08:49.150563+00
373	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T06:08:49.525017+00:00"}	t	2026-05-28 06:08:49.343418+00
374	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T07:08:49.743325+00:00"}	t	2026-05-28 07:08:49.545964+00
375	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T08:08:50.124502+00:00"}	t	2026-05-28 08:08:49.848114+00
376	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T09:08:50.281547+00:00"}	t	2026-05-28 09:08:50.283982+00
377	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T10:08:50.423938+00:00"}	t	2026-05-28 10:08:50.3046+00
378	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T11:08:50.595354+00:00"}	t	2026-05-28 11:08:50.44426+00
379	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T12:08:50.738030+00:00"}	t	2026-05-28 12:08:50.616328+00
380	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T13:08:51.033491+00:00"}	t	2026-05-28 13:08:50.823709+00
381	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T14:08:51.154265+00:00"}	t	2026-05-28 14:08:51.059919+00
382	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T15:08:51.353439+00:00"}	t	2026-05-28 15:08:51.23803+00
383	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T16:08:51.513450+00:00"}	t	2026-05-28 16:08:51.517567+00
384	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T17:08:51.677510+00:00"}	t	2026-05-28 17:08:51.680276+00
385	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T18:08:51.830360+00:00"}	t	2026-05-28 18:08:51.702445+00
386	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T19:08:51.968229+00:00"}	t	2026-05-28 19:08:51.8491+00
387	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T20:08:52.117294+00:00"}	t	2026-05-28 20:08:51.980427+00
388	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T21:08:52.441115+00:00"}	t	2026-05-28 21:08:52.290054+00
389	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T22:08:52.542737+00:00"}	t	2026-05-28 22:08:52.455408+00
390	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-28T23:08:52.648220+00:00"}	t	2026-05-28 23:08:52.557129+00
391	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T00:08:52.813046+00:00"}	t	2026-05-29 00:08:52.673292+00
392	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T01:08:52.936180+00:00"}	t	2026-05-29 01:08:52.834461+00
393	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T02:08:53.096831+00:00"}	t	2026-05-29 02:08:52.957384+00
394	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T03:08:53.212316+00:00"}	t	2026-05-29 03:08:53.114983+00
395	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T04:08:53.453708+00:00"}	t	2026-05-29 04:08:53.350608+00
396	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T05:08:53.654296+00:00"}	t	2026-05-29 05:08:53.540819+00
397	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T06:08:53.871225+00:00"}	t	2026-05-29 06:08:53.743238+00
398	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T07:08:53.982121+00:00"}	t	2026-05-29 07:08:53.896702+00
399	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T08:08:54.196421+00:00"}	t	2026-05-29 08:08:54.008221+00
400	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T09:08:54.346888+00:00"}	t	2026-05-29 09:08:54.351569+00
401	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T10:08:54.493475+00:00"}	t	2026-05-29 10:08:54.496968+00
402	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T11:08:54.608724+00:00"}	t	2026-05-29 11:08:54.512212+00
403	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T12:08:54.953889+00:00"}	t	2026-05-29 12:08:54.765785+00
404	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T13:08:55.071153+00:00"}	t	2026-05-29 13:08:54.96734+00
405	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T14:08:55.221493+00:00"}	t	2026-05-29 14:08:55.225689+00
406	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T14:15:35.950592+00:00"}	t	2026-05-29 14:15:33.265528+00
407	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T15:15:36.095854+00:00"}	t	2026-05-29 15:15:35.972189+00
408	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T16:15:36.248579+00:00"}	t	2026-05-29 16:15:36.252355+00
409	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T17:15:36.377846+00:00"}	t	2026-05-29 17:15:36.26579+00
410	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T18:15:36.643579+00:00"}	t	2026-05-29 18:15:36.461404+00
411	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T19:15:36.838531+00:00"}	t	2026-05-29 19:15:36.907509+00
412	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T20:15:37.041903+00:00"}	t	2026-05-29 20:15:36.924558+00
413	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T21:15:37.164277+00:00"}	t	2026-05-29 21:15:37.072329+00
414	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T22:15:37.261666+00:00"}	t	2026-05-29 22:15:37.180946+00
415	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-29T23:15:37.374592+00:00"}	t	2026-05-29 23:15:37.276651+00
416	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T00:15:37.482542+00:00"}	t	2026-05-30 00:15:37.396432+00
417	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T01:15:37.581892+00:00"}	t	2026-05-30 01:15:37.501092+00
418	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T02:15:37.711126+00:00"}	t	2026-05-30 02:15:37.603684+00
419	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T03:15:37.831526+00:00"}	t	2026-05-30 03:15:37.739451+00
420	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T04:15:37.935363+00:00"}	t	2026-05-30 04:15:37.850243+00
421	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T05:15:38.047983+00:00"}	t	2026-05-30 05:15:37.952765+00
422	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T06:15:38.154054+00:00"}	t	2026-05-30 06:15:38.070978+00
423	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T07:15:38.257999+00:00"}	t	2026-05-30 07:15:38.165935+00
424	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T08:15:38.362252+00:00"}	t	2026-05-30 08:15:38.27254+00
425	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T09:15:38.604695+00:00"}	t	2026-05-30 09:15:38.612835+00
426	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T10:15:38.732184+00:00"}	t	2026-05-30 10:15:38.627075+00
427	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T11:15:38.871170+00:00"}	t	2026-05-30 11:15:38.874038+00
428	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T12:15:39.023096+00:00"}	t	2026-05-30 12:15:38.896188+00
429	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T13:15:39.135557+00:00"}	t	2026-05-30 13:15:39.053316+00
430	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T14:15:39.308112+00:00"}	t	2026-05-30 14:15:39.159251+00
431	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T15:15:39.426745+00:00"}	t	2026-05-30 15:15:39.334705+00
432	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T16:15:39.558003+00:00"}	t	2026-05-30 16:15:39.459008+00
433	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T17:15:39.689760+00:00"}	t	2026-05-30 17:15:39.586635+00
434	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T18:15:39.797526+00:00"}	t	2026-05-30 18:15:39.714042+00
435	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T19:15:39.906503+00:00"}	t	2026-05-30 19:15:39.816371+00
436	monitoring_cycle_completed	Цикл мониторинга успешно завершен	{"timestamp": "2026-05-30T20:15:40.119570+00:00"}	t	2026-05-30 20:15:39.926303+00
\.


--
-- Data for Name: mulenpay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mulenpay_payments (id, user_id, mulen_payment_id, uuid, amount_kopeks, currency, description, status, is_paid, paid_at, payment_url, metadata_json, callback_payload, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_articles (id, title, slug, content, excerpt, category, category_color, tag, featured_image_url, is_published, is_featured, published_at, read_time_minutes, views_count, created_by, created_at, updated_at, category_id, tag_id) FROM stdin;
\.


--
-- Data for Name: news_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_categories (id, name, color, created_at) FROM stdin;
\.


--
-- Data for Name: news_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_tags (id, name, color, created_at) FROM stdin;
\.


--
-- Data for Name: overpay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.overpay_payments (id, user_id, order_id, overpay_payment_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: pal24_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pal24_payments (id, user_id, bill_id, order_id, amount_kopeks, currency, description, type, status, is_active, is_paid, paid_at, last_status, last_status_checked_at, link_url, link_page_url, metadata_json, callback_payload, payment_id, payment_status, payment_method, balance_amount, balance_currency, payer_account, ttl, expires_at, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: partner_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner_applications (id, user_id, company_name, website_url, telegram_channel, description, expected_monthly_referrals, desired_commission_percent, status, admin_comment, approved_commission_percent, processed_by, processed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: payment_method_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_method_configs (id, method_id, sort_order, is_enabled, display_name, sub_options, min_amount_kopeks, max_amount_kopeks, user_type_filter, first_topup_filter, promo_group_filter_mode, created_at, updated_at, open_url_direct) FROM stdin;
3	cryptobot	2	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
4	heleket	3	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
5	yookassa	4	f	\N	{"card": true, "sbp": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
6	mulenpay	5	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
7	pal24	6	f	\N	{"sbp": true, "card": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
8	platega	7	f	\N	{"2": true, "11": true, "12": true, "13": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
9	wata	8	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
10	freekassa	9	f	\N	{"sbp": true, "card": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
11	freekassa_sbp	10	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
12	freekassa_card	11	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
13	cloudpayments	12	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
14	kassa_ai	13	f	\N	{"sbp": true, "card": true, "sberpay": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
15	riopay	14	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
16	severpay	15	f	\N	null	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
17	paypear	16	f	\N	{"bank_card": true, "sbp": true, "sberpay": true, "tpay": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
18	rollypay	17	f	\N	{"sbp": true, "card": true, "crypto": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
19	overpay	18	f	\N	{"card": true, "fps": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
20	aurapay	19	f	\N	{"card": true, "sbp": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
21	etoplatezhi	20	f	\N	{"card": true, "sbp": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
22	antilopay	21	f	\N	{"card": true, "sbp": true, "sberpay": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
23	jupiter	22	f	\N	{"sbp": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
24	donut	23	f	\N	{"card": true, "sbp": true, "sbp_qr": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
25	lava	24	f	\N	{"card": true, "sbp": true}	\N	\N	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-15 01:43:32.673963+00	f
1	telegram_stars	0	t	Telegram Stars	null	100	1000000	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-16 12:05:15.481562+00	f
2	tribute	1	f	Tribute	null	10000	10000000	all	any	all	2026-05-15 01:43:32.673963+00	2026-05-22 18:58:38.487337+00	f
\.


--
-- Data for Name: payment_method_promo_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_method_promo_groups (payment_method_config_id, promo_group_id) FROM stdin;
\.


--
-- Data for Name: paypear_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paypear_payments (id, user_id, order_id, paypear_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: pinned_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pinned_messages (id, content, media_type, media_file_id, send_before_menu, send_on_every_start, is_active, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: platega_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platega_payments (id, user_id, platega_transaction_id, correlation_id, amount_kopeks, currency, description, payment_method_code, status, is_paid, paid_at, redirect_url, return_url, failed_url, payload, metadata_json, callback_payload, expires_at, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: poll_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poll_answers (id, response_id, question_id, option_id, created_at) FROM stdin;
\.


--
-- Data for Name: poll_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poll_options (id, question_id, text, "order") FROM stdin;
\.


--
-- Data for Name: poll_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poll_questions (id, poll_id, text, "order") FROM stdin;
\.


--
-- Data for Name: poll_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poll_responses (id, poll_id, user_id, sent_at, started_at, completed_at, reward_given, reward_amount_kopeks) FROM stdin;
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.polls (id, title, description, reward_enabled, reward_amount_kopeks, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: privacy_policies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privacy_policies (id, language, content, is_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: promo_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promo_groups (id, name, priority, server_discount_percent, traffic_discount_percent, device_discount_percent, period_discounts, auto_assign_total_spent_kopeks, apply_discounts_to_addons, is_default, created_at, updated_at) FROM stdin;
1	Базовый юзер	0	0	0	0	null	\N	t	t	2026-05-15 01:48:48.572756+00	2026-05-23 10:01:50.521421+00
3	Arredo Proxy Group	0	0	0	0	null	\N	t	f	2026-05-23 10:02:35.544548+00	2026-05-23 10:02:35.544548+00
4	VIP Клиенты	0	0	0	0	null	\N	t	f	2026-05-23 10:04:33.695134+00	2026-05-23 10:04:33.695134+00
\.


--
-- Data for Name: promo_offer_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promo_offer_logs (id, user_id, offer_id, action, source, percent, effect_type, details, created_at) FROM stdin;
\.


--
-- Data for Name: promo_offer_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promo_offer_templates (id, name, offer_type, message_text, button_text, valid_hours, discount_percent, bonus_amount_kopeks, active_discount_hours, test_duration_hours, test_squad_uuids, is_active, created_by, created_at, updated_at) FROM stdin;
3	Тестовые сервера	test_access	🔥 <b>Испытайте новые сервера</b>\n\nАктивируйте предложение и получите временный доступ к дополнительным сквадам на {test_duration_hours} ч.\nПредложение действительно {valid_hours} ч.	🚀 Попробовать серверы	24	0	0	\N	24	[]	t	1	2026-05-24 17:22:44.922596+00	2026-05-24 17:22:44.922596+00
4	Скидка на продление	extend_discount	💎 Экономия {discount_percent}% при продлении\n\nСкидка суммируется с промогруппой и действует один раз.\nСрок действия предложения — {valid_hours} ч.\nПосле активации скидка действует {active_discount_hours} ч.	🎁 Получить скидку	24	20	0	24	\N	[]	t	1	2026-05-24 17:22:44.922596+00	2026-05-24 17:22:44.922596+00
5	Скидка на покупку	purchase_discount	🎯 Вернитесь со скидкой {discount_percent}%\n\nСкидка суммируется с промогруппой и действует один раз.\nПредложение действует {valid_hours} ч.\nПосле активации скидка действует {active_discount_hours} ч.	🎁 Забрать скидку	48	25	0	48	\N	[]	t	1	2026-05-24 17:22:44.922596+00	2026-05-24 17:22:44.922596+00
\.


--
-- Data for Name: promocode_uses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promocode_uses (id, promocode_id, user_id, used_at) FROM stdin;
\.


--
-- Data for Name: promocodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promocodes (id, code, type, balance_bonus_kopeks, subscription_days, max_uses, current_uses, valid_from, valid_until, is_active, first_purchase_only, tariff_id, created_by, promo_group_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: public_offers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.public_offers (id, language, content, is_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: referral_contest_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral_contest_events (id, contest_id, referrer_id, referral_id, event_type, amount_kopeks, occurred_at) FROM stdin;
\.


--
-- Data for Name: referral_contest_virtual_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral_contest_virtual_participants (id, contest_id, display_name, referral_count, total_amount_kopeks, created_at) FROM stdin;
\.


--
-- Data for Name: referral_contests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral_contests (id, title, description, prize_text, contest_type, start_at, end_at, daily_summary_time, daily_summary_times, timezone, is_active, last_daily_summary_date, last_daily_summary_at, final_summary_sent, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: referral_earnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral_earnings (id, user_id, referral_id, amount_kopeks, reason, referral_transaction_id, campaign_id, created_at) FROM stdin;
\.


--
-- Data for Name: required_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_channels (id, channel_id, channel_link, title, is_active, sort_order, disable_trial_on_leave, disable_paid_on_leave, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: riopay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riopay_payments (id, user_id, order_id, riopay_order_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: rollypay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rollypay_payments (id, user_id, order_id, rollypay_payment_id, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: saved_payment_methods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_payment_methods (id, user_id, yookassa_payment_method_id, method_type, card_first6, card_last4, card_type, card_expiry_month, card_expiry_year, title, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sent_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sent_notifications (id, user_id, subscription_id, notification_type, days_before, created_at) FROM stdin;
2	2	2	trial_2h	\N	2026-05-20 05:30:05.235539+00
4	5	4	trial_2h	\N	2026-05-20 10:30:09.040865+00
6	12	9	expiring	3	2026-05-23 11:23:05.226403+00
7	12	9	expiring	1	2026-05-23 16:23:06.310551+00
8	12	9	expired_1d	\N	2026-05-25 16:30:07.826828+00
9	16	13	trial_2h	\N	2026-05-26 07:30:11.393741+00
\.


--
-- Data for Name: server_squad_promo_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.server_squad_promo_groups (server_squad_id, promo_group_id) FROM stdin;
1	1
2	1
3	1
\.


--
-- Data for Name: server_squads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.server_squads (id, squad_uuid, display_name, original_name, country_code, is_available, is_trial_eligible, price_kopeks, description, sort_order, max_users, current_users, created_at, updated_at) FROM stdin;
2	a4d53819-8d21-4594-b85c-08e5425293ad	VIP-CloudWEB	VIP-CloudWEB	DE	t	f	917000	🐍 Anaconda13 - proxy pool	0	30	5	2026-05-21 07:47:36.127554+00	2026-05-23 08:40:10.497232+00
3	0ab61a31-3380-407f-93ed-ee707cc63495	ArredoCarisma-CloudWEB	ArredoCarisma-CloudWEB	DE	t	f	360000	Корпоративный прокси - ArredoCarisma (vip)	0	30	4	2026-05-21 07:47:36.526708+00	2026-05-23 10:00:17.222747+00
1	32eb5185-c698-4bdd-bc41-7630a5065531	Default-CloudWEB	Default-CloudWEB	DE	t	t	360000	Общественный прокси - (Base)	0	50	14	2026-05-15 04:22:12.191564+00	2026-05-30 19:19:26.806913+00
\.


--
-- Data for Name: service_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_rules (id, "order", title, content, is_active, language, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: severpay_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.severpay_payments (id, user_id, order_id, severpay_id, severpay_uid, amount_kopeks, currency, description, status, is_paid, payment_url, payment_method, metadata_json, callback_payload, paid_at, expires_at, created_at, updated_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: squads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.squads (id, uuid, name, country_code, is_available, price_kopeks, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subscription_conversions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_conversions (id, user_id, converted_at, trial_duration_days, payment_method, first_payment_amount_kopeks, first_paid_period_days, created_at) FROM stdin;
\.


--
-- Data for Name: subscription_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_events (id, event_type, user_id, subscription_id, transaction_id, amount_kopeks, currency, message, occurred_at, extra, created_at) FROM stdin;
1	activation	2	2	\N	\N	\N	Trial activation	2026-05-17 07:27:08.680623+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-17 07:27:08.664764+00
2	activation	4	3	\N	0	\N	Trial activation	2026-05-17 12:00:50.304425+00	{"charged_amount_kopeks": 0, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-17 12:00:50.293945+00
3	activation	5	4	\N	\N	\N	Trial activation	2026-05-17 12:21:01.629343+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-17 12:21:01.611303+00
4	activation	6	5	\N	\N	\N	Trial activation	2026-05-17 16:26:47.021689+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-17 16:26:46.937663+00
5	activation	10	6	\N	0	\N	Trial activation	2026-05-19 19:15:23.974581+00	{"charged_amount_kopeks": 0, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-19 19:15:23.964354+00
6	activation	12	9	\N	\N	\N	Trial activation	2026-05-21 15:36:52.887676+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-21 15:36:52.356053+00
7	activation	13	10	\N	\N	\N	Trial activation	2026-05-21 16:20:03.559671+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-21 16:20:03.53019+00
8	activation	14	11	\N	\N	\N	Trial activation	2026-05-22 13:38:32.881144+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 3}	2026-05-22 13:38:32.822934+00
10	activation	16	13	\N	\N	\N	Trial activation	2026-05-23 08:40:10.693711+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 2}	2026-05-23 08:40:10.668308+00
11	purchase	1	1	\N	329000	\N	Subscription purchase	2026-05-24 02:26:48.167321+00	{"period_days": 360, "was_trial_conversion": false, "payment_method": "\\u0411\\u0430\\u043b\\u0430\\u043d\\u0441"}	2026-05-24 02:26:48.00068+00
12	activation	17	14	\N	0	\N	Trial activation	2026-05-27 13:31:41.252869+00	{"charged_amount_kopeks": 0, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 2}	2026-05-27 13:31:41.221151+00
13	activation	19	15	\N	0	\N	Trial activation	2026-05-28 16:39:39.562647+00	{"charged_amount_kopeks": 0, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 2}	2026-05-28 16:39:39.525729+00
14	activation	20	16	\N	\N	\N	Trial activation	2026-05-30 19:19:27.071416+00	{"charged_amount_kopeks": null, "trial_duration_days": 3, "traffic_limit_gb": 100, "device_limit": 2}	2026-05-30 19:19:27.02957+00
\.


--
-- Data for Name: subscription_servers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_servers (id, subscription_id, server_squad_id, connected_at, paid_price_kopeks) FROM stdin;
\.


--
-- Data for Name: subscription_temporary_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_temporary_access (id, subscription_id, offer_id, squad_uuid, expires_at, created_at, deactivated_at, is_active, was_already_connected) FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, user_id, status, is_trial, start_date, end_date, traffic_limit_gb, traffic_used_gb, purchased_traffic_gb, traffic_reset_at, subscription_url, subscription_crypto_link, device_limit, modem_enabled, connected_squads, autopay_enabled, autopay_days_before, created_at, updated_at, last_webhook_update_at, last_revoke_at, remnawave_short_uuid, remnawave_uuid, remnawave_short_id, tariff_id, is_daily_paused, last_daily_charge_at) FROM stdin;
4	5	active	t	2026-05-17 12:21:01.520909+00	2026-05-31 09:00:00+00	100	0.03983943723142147	0	\N	https://mesh-go.cloudweb.name/aW6H3Jg67as2to3DMqjcZNJt	happ://crypt4/ON1NF11pUwngrCRthAsDoj+7L4GBYorwAWzYGj4K8fswJFaQE1XqoKDJy4tyTV1Sb+cOMKi/2fDhuxDm6GCi+RAl3nTioNVLsDqVpD05kAayu55xpviLxCT9Esa4fUf34RrFyM641eB+yR7GalsP5ACgR6BwBp47/BGkQAT4T08pS53TmaDsWMFn3RjdICZwKlwQrmpj7DEkM3ZPyfE+Fwaz7a2zNxNr6AO3XFOr+I2LlCMS2Df37opF2si5rxYsXyoF0cnEctKoy/H2QIeiMZPJJ1/a7FKEbOrr8hvsHkkQSbl7RmrISCKmOY0ZdphQFZ1is7vJVdMxxF52YPBnwBfTgP52V9ebBN1mh9TaGtiod6VDBU1PzY2cGA1BhVLlOJc+3mBQ87b8qMpFr3oa/erqwt++l1zG3jW+eranmkJNKHCXL7IN5xNH+wYQSNlTH+ctBrcrsqCmv6B9ar2ZOdmDShdRKGXWbHXcUbl8dAVh+3rnb5RxCTWWaz9UNqL5ygBUCjMLxhz47pbp6CO/oAtnQmnDUQowca7TteyNVX74LH9UoHmvZC5fbqcjlHOQT8urO3lKEXtInxY3E0e5Wr77aZqyry8kywOc6O4OJuUZuVBLEWZ1nz2CNnjM8J/327KBYIyKuu+O3gxpvPVm5JZuhN1bn2jPpAvKM24m9xc=	3	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	f	3	2026-05-17 12:21:01.501349+00	2026-05-23 10:06:40.294674+00	2026-05-23 10:06:40.348199+00	\N	aW6H3Jg67as2to3DMqjcZNJt	0638818d-b9e3-48a3-a62f-875b4a463a0a	128b1d	1	f	\N
10	13	active	f	2026-05-21 16:20:02.609742+00	2026-07-15 09:00:00+00	100	6.1280854772776365	0	\N	https://mesh-go.cloudweb.name/FfwPKCMfTwZvs0reA4jaJr94	happ://crypt4/aIMBb/6PQqo5fAmPKWdPeeSvtxY/EzJe5zZyYkkEUsUnn7GIM0RI34HnEOV3MTF3N5vCI+mdQo8+tUp/6wJonMHWnly4c0/5cqWy8972/C01O2qmHs2D/qLs6gYTcb6U2xFTl3KdBQSH2AVVlhQN3wAfZPHtzdg/DQJ7zGrKtK3Lza+eX6ba/XKj5S3ksXfuAtaPM24dauiiVNqlHi6YkRi/2mli9I3tMULD9X/2+cDWqqIhUHpRr/TRV0JJV0ofdfc5nKgWfPg9ukyi0FLiBqgRH4oktQPwdTRBd1GViA04ZuLRJ18+Ow78cJF1FCn70zzbev13g1jhcjxe1K6dmCkLDZ8F86STP3SP/NFtk1PDsU7LBqbuu+CI1qz3U2d//f4lJKK8zQJzqEj2N+N97NwoAbTQyZDJEvi8V+IB0GrM2bHA6RLEGjSEOWyTihY62zs8rvvg8PsoQKh7pRg6QcNLE1SPca1C0/+oNaCXRqPz3Pc3CQudwyixL3Nhh7WUIxFSVX2UYAVnWz03OIwSz6fYAXMRDWG4GQsU/KPIk64g9ZpYjTMVWDjBDuegEkQyynk8fUWBkM1vD+v3KNxd5Ysjsz6Df69MKW0c+B4ci6gQlxLJdw5RoepJBl5MiiAe/o8eNXfauzwmrB4J+VjUE25DNEmLUrjUhf+uBQ+SR60=	3	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-21 16:20:02.550339+00	2026-05-30 03:00:00.314555+00	2026-05-23 10:06:40.233435+00	\N	FfwPKCMfTwZvs0reA4jaJr94	c217198d-b61a-4def-973f-63a8ea575e7b	144936	1	f	\N
11	14	active	f	2026-05-22 13:38:20.708404+00	2026-07-15 09:00:00+00	100	0	0	\N	https://mesh-go.cloudweb.name/qWN7ty4tT_fGoNs0FjL4eVbs	happ://crypt4/vYr9Y0RBhTnO3OcYLKPEz42IWtGRDfHcUITRKsvof/LIecHV3lAm6JsrqcbQex0tXzCr1FmXZRaG6W01DJjHCE2r8VCSNWZZGZSknNlGtHjhgaUAvufoBuYQkyf8+8mjF5/PRDCoffWbZ6iqSc5B7OUmXuPhNlEacS+glcpg4owfge2Xkqav7zWz/JcNNm5+dRP5Cb2i1rzhqJzNiHiglbgxFUzETDY44uz4ZoeD52sUAWXUr4mhOPVmNPZ7ndvFg42Auo00cxVv4SKip+99Cj0369BzqWZ1A6zQDqHM91I9q1A5qU5SpjIEyNlH73Qt3kKg9mGkp1QtEv7VotgcYt+wVRGtwR70FhEumO7ZZY9wWvLg/LDtuH39Bg7TdD/zv4FH4eL68KQ4dJeekPt8olpMASPldoUrcs/pb7lwIFEB6Cz2blCb78Bxwy9pemzFHLSYT9/XQfLWwIKaRZjvBhICzXxiUp7k0AhQkvHmauDfdsCoPGo56aNhn715DIKpTJ4h45Ip1ovpLbt/SPJsTJG7iCUrM5xAmiNdDDuI80q0CWUx44hmjbo6Ljqb9CZtRkF4r/Ub8IyNSehN8z/RgTwpHLi7hy+SQc3Eoq6pimDrHgvnl/9aKOtXdiUFobG8J0f+YDK8jnS4hzirkseVpNBVhvYb0+WJOBpnxH04l/c=	2	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-22 13:38:20.623263+00	2026-05-26 03:00:00.417636+00	2026-05-23 10:59:15.591339+00	\N	qWN7ty4tT_fGoNs0FjL4eVbs	515c5cab-bd05-4cf7-bafb-4438091434b6	80ca17	1	f	\N
2	2	active	t	2026-05-17 07:27:08.509538+00	2026-07-15 09:00:00+00	100	14.320983430370688	0	\N	https://mesh-go.cloudweb.name/aQreKSgo6V0G6Nt-x2xhAAgP	happ://crypt4/2pJ6EVa36HLL/J2ILdrxiJ1MizfhHuDOOTh7zHCXY0XixbHr7o4C4ufxuCroLrZwZvLCwymwaaU1gDElpodP/XxcABebObzMeU7mCO7Cb++qJKvwmapw5zeu20Pv+ITtKA2QgCLdeK66y2fUDc8t2RPsQzj1mYdLZF9mQ/No1kH+MoMkaegu2BJoVSV/HfFoF1N2lHzI6QysEL3wEm6xFB/DsLRO4Pi1cZ8qLRqdhc/wkLQC4zQRSafsPPhlv1VSAwwbrgNeZ1uHTVczBqbf8bfbpB5Dhn/zCgUVxqWK6sZEzpr2r9sYbj8G72p/9UnGDU988aNhZvP9nGYhoD+PN2hmT6crFqNfd4peA3URu71yefmWIqZY+U89Ufdujc8NVVcZ9+jtKjaAI7m7nKrbrjc21zHM6V674asS8w/Pe8ZvSjyFajf2fiiurXNGNohjt5Fp9Q+g9x3N80tg6e/YKMPNbXNO8cb7wRoyxCdmrNZrlha3v3l9XEDLgOqzM+S0TNBqgIBq2tI2gm6I7MVFfio1aIfqMoEnAnQy6VOfgJtVbqEwJUZvazN2aQxbj3ymHxxJ/Pebw3lfVXg6q2RHtBMSu+rzORfh0v+z8WTK7b1WWQa0v9lO/eAR9q6OIzMLRcDZU5Fj4gHcCEjK3zTVP2kLTAvx67p2jzDJqSuYhdY=	3	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-17 07:27:08.483101+00	2026-05-29 03:00:00.542281+00	2026-05-23 10:06:40.960807+00	\N	aQreKSgo6V0G6Nt-x2xhAAgP	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	c723bd	1	f	\N
7	11	active	f	2026-05-21 08:19:04.151295+00	2026-07-15 09:00:00+00	100	0	0	\N	https://mesh-go.cloudweb.name/505jGrhoqT7JbRbzeN7-W8G4	happ://crypt4/exJrIBaHnBaSqIkDLofJeoF0HQxugGiYADswZahE8C5i+b2FVHfRFtM2Jl1U85Zyw31Sq8ViLQoTdqwElENlmOrVghUjKgLubiP2ftRFhtfTjaryPKiL7aicFKcuPKPosbvyF8rF+knN+/AXjDUkMTqBHiuF1wYHmfT4Tv/HGVwtb9vw1zIQzRTU5M7MTS6Kd0EM09UIaIEtuJ7U5AZe2Hd8t64IDGvaeWHq8ZEmPYJ83JO5aRhOG/JvulyEUrFKuAQ7vXRzdgpkbXLx0kDQ4t/Cq17E2vZ57YE24PnMZH6JXh7Ahr1umrAwMDH8hXHz0F3INVmBmDvR3BnJC/f02AtOByR9mwy7kN7WXLgIUSqKGc6s/yS2deJH6TtXNLRXLUPDM72f0kFJBjzVkH9iTEQhGtKQgETuQPD1S3++VT5kd9BUSmkPWnp/H5zHRnk7DfhwmG3nqvLqwTS9FaedbISROX6W6fYciEVQFZ+9//236J1PVp1V7NErviAxg6fw4S0ezdZ+2CoDeAAbGiVPKvwM2coq5ulXWntHmpz6vs4dC/KgaO2NhmnukdEDUUe8Zo8EfzSFTrBT7VZQh9v5H1/li5XUcQC7HOaglYu0oMSsGrwBHYGamILQlAddRWPv9ENrdfh1W0I77d5f58E6j5qdEThuONfgtlA0cgKDSdc=	2	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	t	3	2026-05-21 08:19:04.123728+00	2026-05-26 03:00:00.417636+00	2026-05-22 18:52:10.670069+00	\N	505jGrhoqT7JbRbzeN7-W8G4	a2d7491a-ec87-4f53-9cd1-c36b77018fba	3cd6dc	\N	f	\N
3	4	active	t	2026-05-17 12:00:50.100201+00	2026-06-20 06:03:36.13+00	100	0	0	\N	https://mesh-go.cloudweb.name/2qE2Y0E12QR46NReUDQ0_PGP	happ://crypt4/wQTjIqL+1I0c5ALOl1bn0TxszP6RQfMjNhy3WMSonEzYuADMUaY+NSJ4fn04Jn2IUZlVKm/ADNDfD3IgkW6aJ3Xd29auOF9jIxlZEvAXOhYFW+8GxHTavEXrUmAIFizz4A88jZFDyZZ2tFAsjKWrrqzCYj4lIzCr7RJu8ht0W2p6aDe/4SxrNx0iJJWYjcKhP3bBw6Lj0ies+az5v5LJjlSl4cbROF7Mex1hvHRzc73f/OnKM8YpODMbZWrqBr9JzGqmM9s/Isy7fmC6I6bTNwMybEPS3DeZPRECxmsByNbIswCiqLSFLPLVI/0Qzmar+Jhl06ZUpmyFroLTwK3GU5OUtdwliK2mbiHceAF3DQ943tYodWM/j3+6YKiMbZv5deM/1YC3AGqroH3nZ1Qpq69CewhydpeLhmxoVRLFY7KXwN28Aw8goik1JwuLOPIT3PWWvZeV7AZEVOb5zu1C0oKrRW4SDtOh6sZH9tnaW032Zb1YJzlouuNG18UAz4czIU4l2dzVTi2D2t2o3wDZGRw5SQ4RoD1bH2nnNGarFJ9nWd+YrwenyDlgU/XRNm/KVon1ofq6iRv9QoH2KF/gjghampOLZUwuvsK+iOfGpqdT5OEMZih5NJ8sXjhalQRV6INFwSXAF8h1Xkg+7tczHBVUTo1SREsxUjs6fLhpok4=	2	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	f	3	2026-05-17 12:00:50.067162+00	2026-05-23 10:06:39.392526+00	2026-05-23 10:06:40.004265+00	\N	2qE2Y0E12QR46NReUDQ0_PGP	1ca699c0-0c89-4769-a227-39cc8fb91b7b	8dd8e5	1	f	\N
5	6	active	f	2026-05-17 16:26:46.666938+00	2026-07-15 09:00:00+00	0	41.32993084471673	0	\N	https://mesh-go.cloudweb.name/7J3_UWPaogGgVLnGgjvbt3rZ	happ://crypt4/0OKqhSqAMsL860GCjh0VDIofxZbmiqf098QeTzMvYuMG0nEx2bSBJxXXoH2uj55wtToonZW8WQ6NCGP33K6VZaQF6RocbcbEdhp6jTbiL2xZgZWUJmLPwtBEgzJ/BAeeM8oYlXh4cM4CSBZYNQBMpM1VHoQETZdrVrviSgTDSFkDK97GiIHSXw8RBcIpdxd/3va3Q1jgrcPwHkyv34lT4N07akb2zJxMLkAwjepLi99E9/rYJVVTWRD8Zxwg/cj98l02jKAB8iWHIlli63IObsbGoU9aUYsKv9Y+7G6BNsamspLiumR+DoQtwnbEMWXM/eUTchJeLfRmwt5DkvQ/kFNbE1K1VJksfTTidwzNahPO0XZ1Kk7Ul26PwmKla67vngpJ8sMwGHRjgDVtO1lBdeUmXAi/nkdEjTI+vwTLM7cfr6DK5v8C6iDjSUyw7p7o0OTqrr1Bl1fCNN0QfnHWr9K0yES23LCK8eka+apK8c1KJw930ZkFEO2zkRA1O5FyFioelW9AQl5NQC9sRcCRy3xOBdQqWx59I2ylaF5xv8i2IjO0yD21r5GdFdJ2ZCpNjErLAdapqQNwRJY81QBFtkoL750TaVWq7UBJxoY1xtUjSzAKgvTCE3fVwCClB1hk+uKv+O3daZJqVfTYxnHEHRmX/UP5pbFCAEdYprQwips=	3	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-17 16:26:46.576916+00	2026-05-30 03:00:00.314555+00	2026-05-23 10:06:40.989816+00	\N	7J3_UWPaogGgVLnGgjvbt3rZ	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	616ceb	1	f	\N
13	16	active	t	2026-05-23 08:40:10.46637+00	2026-07-15 09:00:00+00	100	5.062400992028415	0	\N	https://mesh-go.cloudweb.name/UWyuNdLSouyshWDsQNW5Y7QX	happ://crypt4/r3HZcfZPCsuIrkvsiq+Uqqroye3anETSBc9V3AqwF1pgku1eJZqooJ+QmUXeEkLNiext0xJsLkzNrqu5ZAVIPOSIqo359D53b30INCL9Ig8anDJCxQBrAuetdeepdTmwQEGdnutIGlG3a5dcv+AZt4wS4CVkW3QmtLYYozDf/Vwp4lx2peCp+jveuW0sUmxQWz9RNOM4bwOr2jH+nOrzTDCttM2Ae0P4FfjRi694hxTo2gGgW4B3sFSe4PmLhCanKuimdnYYmDA6+yO8F3blol27VlOcKzuGN5uffYYyUc+UCl55PCAi/Rwy+fLDMe6poxRafILOtE3wUpqOnyU69NXAWSnICt1MFGCmJQ+P2BGeQhq743AyXQ8HXOvPrIOABGbEKb0S2fGxNVpJ6WAvdvzj1e2yG/3njHAT8wYqwxWZuuOSxludVmM+/S/fzd83hd6/LWOmnuhSE6eskjVRFK22Is5vw+K77PajuB0RUN2RZGzn8tjl6bdwaIFxmNj7i73iZlQC5Hi8TwXrHes3mG90AEGwecTOZuPYTZH8UdyOZyFN9OiT+fni4v/vXwYSBekGiFYv13fGU8lvTyqiv4OQRlO0Y/OdR7StKwD+7ngCcAb8VVP0C5rOUQQg+TOuWm/N9hkiNltht7NEUWdqzIxOIXZt2tCu0xUZw7jlXpk=	2	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-23 08:40:10.42106+00	2026-05-30 03:00:00.314555+00	2026-05-23 10:06:40.701477+00	\N	UWyuNdLSouyshWDsQNW5Y7QX	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	ea7b8f	1	f	\N
6	10	active	t	2026-05-19 19:15:23.583863+00	2026-06-21 19:15:23.572+00	50	0	0	\N	https://mesh-go.cloudweb.name/Kgqjef2Pf3-erbj9hmhgBT3V	happ://crypt4/N2m4pHpmsPv7BDixUy952UBAppSLCOr9oUwaL8pKlskTYumMEbdf/3oxBfa/l4M6InBrKvN7KQzR8EpDxPzst7LiJWdyPQjWFj5peXFPqJGkwf3sXSELRBL4U3oEX1NXjYBwCI/e9wzDbCG95wuSvww3hTfy2SkcO4l58nkJyiXa15DMJk03FtA1X+io69e6Yl766ZDpW/FztGqWPo2KVoCGPRPsHnB2MmiXcTkF0Lax0TFaSYmE2bbcdWXVA/+jGHORmFqaY9WtmuceOqIVy0AMoQeco/zX4+Ex8d8qvrPD4wLYVOSPBblTabls9Ri1KSEtrdBaB3JgebO/ENJ3A25tGC3Mbsfr+RyA5j9QagjX3PVzHZCxF01qMKUC3jM8xgWTYlbnfBEJrFbDL0Sez19d5OgNC+EqXFSfBWddHhe9RLeaAIfXIX3sfiFOVMr2zftdgqCvJEy8+sH2K7GdanSWyoBiO8kcNKiUpEkxdHev6LvEPvkm6J8ZaBqN4wPbza9tLRdFHt4UbEtfBKhrlitKVwM2k+Nv+8UhieReET68S81F/IcdFRPtb0I/22IYG/U4R02W60MGGJdRpBFzRWdB96xLphR/koZq5ht6op/y0ZoawE4w2pDBIyCMD0LBmMOoMhC4O9/Rs56T+xd/4oyRWxP6ADAbNWix57tSgQk=	2	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	f	3	2026-05-19 19:15:23.546539+00	2026-05-23 10:06:39.392526+00	2026-05-23 10:06:40.484107+00	\N	Kgqjef2Pf3-erbj9hmhgBT3V	b7877eaa-67fe-4c7a-af31-cdbfa3f8a3cb	1ad769	1	f	\N
8	3	active	f	2026-05-21 08:34:39.555019+00	2027-05-31 09:00:00+00	100	0	0	\N	https://mesh-go.cloudweb.name/jqPK8W_KMprammFLHEzeXB-n	happ://crypt4/sBPRuwk1hZoeJlL0JREfBW2x42GIGAeqOh/8Qtv9QmVGAnvSGqfVceRDWM9OiuBhUqdrSpNiEvC8lT6AqEm+6qKy7ZFw/F7cqrtw871m82kZv0Qoot0bEuOdSGqSRXhLmz+Cim/qM/mLKXLkNxJNpvMvw/ZkONxdWPsrP83prkZRJNAlwmfnXDo8SAxpr6Z5sKlCoIomJB4ZmGhktMOJDzKE9UH4kH1aFWnRGOBsMIUjCXdGcvyvHFNXzWDsyDCDCHuUP6UdclmXVXjK3qT6Y3olTX4dEiFU1E0ex4wpOGkG8PCcn7FUCbf8NrBglTObkNtLBLv7+LY8z8ewgUp6qoh6bQGzMXIq4gFb1PIhvCEq7GL5IOk4a9u5ZjJEwidNBgugFcKzn2kCNrg6NPU5iHP5B71WO+3a/qFzjyl7QvIN5lcNN4sDGGNP3mVhQD7qdxTkqMM4obz+8RtD1F7dbAWKzzzVrpAfQg3w3l+HqAF8f6Tr/xqelLjIJZHMV5uGLsIl4FUNXRiFOkmm3c0bA4SGI7Dj79M12qsQg0KGQ9hHUSneiv0wUXzRSAeGV/4Dr8yXi6Lht3TTxuLgxuLHPKmYdS+KtCmO5OgllEHvpWEZbXSlyQKpQx9MzgPQfS1vo18rlaPvdWrVA/8hBlmoFtShYKu+yHozhtPitZw84IY=	2	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	t	3	2026-05-21 08:34:39.505898+00	2026-05-26 03:00:00.417636+00	2026-05-22 18:52:10.915843+00	\N	jqPK8W_KMprammFLHEzeXB-n	36ce2026-597f-43d7-8704-95ec02ff8a41	60355c	\N	f	\N
9	12	active	f	2026-05-21 15:36:49.838585+00	2026-07-15 09:00:00+00	100	2.0735035575926304	0	\N	https://mesh-go.cloudweb.name/3SD7WNa_54gk3Wrn9TtkzJCV	happ://crypt4/kcFRI71dK6E5Bq9G6NKf9TMs16pmEf3JHgBYBLi0+xNSjdzLpANbM1NuCJ9RBv5T18RaMzwi5LhMyj9HsiWplq0X9skVM6AOWCJofflKK3YdZ1DVFQ9fmUdIrwsRFHGMYdekhIXVc1sjRht0g3NghoY4n6bR9kKJVCjiKYJaVdOpdkCuWXCFn/BRfmM9Na1Vbby/PSOBIcfiMxBlpKIvnpPyeI65qGVUZxbDi7vf5cV4Iu9aJZ8p2JuUycCrXDBLK1JADJqLvWV/0Ru08ECJwMjH0mS9GTTdy07FJIC4yT+lwLOB4D8XfPk1wiIgYB7MgnVsjCwr6HrlOs2sViCAAXTVTEeznpFvwImiqo0Xi6ZXlsKJaBzIzqatksoQj0OCAWafp8Acsd5f3LsB6JFvisCYhTlWpbh1UlfZANJiS19R4UzN7f2v0JsFR8bmZg9EEQcBvMsFEhJd6Rdw+ZWl3kMM24BWNq54KBiNAugpYLSixStb08EvLRhQauULWqwzNRpJYeJPQBP899vZ+ioXgZtzWqsgbefvxidcFzw6BVS1vap7dXdAMm/qeSRG95v93hbip9Ls6ySIHRIB7m1S0L6p+2zvsnpTRKa2brSPCJLKyxXFCrCvrbYSR6e0fhOesNJf3KDIEOxQfiUwqiovNddHCNyGCWRsdxUUWpEqs2U=	2	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-21 15:36:49.263963+00	2026-05-26 03:00:00.417636+00	2026-05-23 10:58:37.017024+00	\N	3SD7WNa_54gk3Wrn9TtkzJCV	53780d13-5737-4463-af47-ce48752f4a94	cf8697	1	f	\N
1	1	active	f	2026-05-24 02:26:46.985102+00	2100-12-26 09:59:00+00	1000	29.18394558597356	0	\N	https://mesh-go.cloudweb.name/zKKBbSgvANBzmP72m6KB0y0U	happ://crypt4/B3NpICaS6Z/swiWwHTrCuuiTQRVIOiR2VYcnVSSI5yms1aXSCSnUNrtMtpbvhS16l4xSZr8M7X+TgcjJ13V4tQ+fIKNd5TbEg48MSPikxC6EHi1IHt5NUl7a7bM0i4jGrfOk0ZlWAQLYujy5hD/9Qhm0Z1oROXgd1IKMGjIGR4mPlG9gzObOBeCk+qJn25pvv4VEg147xhvmxw44nM197vBdU/5dy7OwttWleuLm8UV54Zd4CxJJsKrNPONHblSmnKt7NrpsOpCqA2ANjVl+gzQ0s3NinBHus6rWnE+Nx9pgcObc8zqQRW75hFlwelP38U8TBrFJDrv9BT5KFpj2nBegIE7o9S3hTyhpkyHSJ3z+MeXHjxmlCPzdABLUJODI/qoUtogYQ8Wx8qD4iLGnxi6sDKU2HIudXAdkBcuk7KDjD67Rr4nNHtLkIv5bVodt/s6VeetHh0MOeKs9Mi7oshElakZU24p/L57lDoWc2N/xq+HI3ITAmfGFLFUMZ/znG+EiFNx0HGw897Zwi391Bo3h4sV6EHyMgyPM3IlP0pzj3dq/8EHt6kjaJPKYr/JMScnO/JIPupi/hcEhexLMaLHQCx9MsvuHcxkULcyUQkQ+LB1ow/DE+ayJSGlPiFCMplNYZMkfXHEdwnT+iJKdkzdQ6Quf687KI/lJIKNoO/Y=	20	f	["a4d53819-8d21-4594-b85c-08e5425293ad", "32eb5185-c698-4bdd-bc41-7630a5065531", "0ab61a31-3380-407f-93ed-ee707cc63495"]	t	3	2026-05-16 09:05:05.823316+00	2026-05-30 09:13:00.842239+00	2026-05-24 02:26:47.683625+00	2026-05-16 09:21:09.183325+00	zKKBbSgvANBzmP72m6KB0y0U	\N	6fd04d	4	f	\N
15	19	active	t	2026-05-28 16:39:39.302546+00	2026-06-30 16:39:39+00	100	0.8389003882184625	0	\N	https://mesh-go.cloudweb.name/9yadWsQGvbwEnhprmQCPNXz4	happ://crypt4/frIr4HMrWQAdboUbbL3bwI9r5Y6+hHknfNFMuwLZz8EcK/f861rUow2S7PjcdnSX3hwhRRpnh1HdlXN5Op9k6m/+T8eTUeJ7KMNJsA4D9Z9Ujl8CS7UQNVft+X3ng7Exq+oscLPVC1YiagyaHoJ9nMcsdrykFWLrnnEQkowZJRrxWm2uuNIcg3JpeHz6W47RQJBO6RgRxLGs50KY9iFLLAOMsnnZ9ll4oYpFCtUkw1LopZ5hB75Ed8P5NylxZbTe+3WOZDWtIJheySJm4k9FxJ7XKEWRXV4PCjzZfgqkXrnBxjfLrCq25FxOGlX+mDdTTsTAcynIDYxTxVXf+9uvrgZ08bcQOIdvOV3IPY7A1fRhfsM4q6np9tgwVk9t5b7WQ1yzhbqoS1mFSEa+lea3AKRQqIpB0ojF17RFJ/AMqdKWu1ggT1o/LnRlxsCESKXfMIqoQdYUQTChJCdLoMSu1XYOdbm+BE/CVD+XNjDScDhxSL8YOgc98v6vX4Qs5owFuoFb3Tn/oZPb4YaBGZKGKCi6D3C2HnfcSzGzHko/uLQ2b9tGPus/gXy/X1gJ4ykQ+ARh3J3VIKVYcRvLXsyfkFYbsd16vM5VJqmIiKz18oJuHsMRic5fvvyDG4OW+p9ViR2DSzuV0S8aRhleWmcsKIwW6tdpN2V4/c0HTH8EB18=	2	f	["0ab61a31-3380-407f-93ed-ee707cc63495"]	f	3	2026-05-28 16:39:39.247674+00	2026-05-30 03:00:00.314555+00	\N	\N	9yadWsQGvbwEnhprmQCPNXz4	dea17874-4b3b-46b1-9e54-e5d2eddb254c	47b17b	1	f	\N
14	17	active	t	2026-05-27 13:31:40.927097+00	2026-06-30 13:31:40+00	100	6.291311914101243	0	\N	https://mesh-go.cloudweb.name/HhMCVSYLa4ak_6V2A7YRDKsA	happ://crypt4/xwtjSTGURU/pKzW4OBH5BLtIiNVk08bI5YOKUrCFFvVki1hBztJ4Ikq6urkso5csDiEy6EZ21mSlb9pUP58GYvQcC1/cjYIxoVzvX92GjkPI1a2uzP269cAj2Owi0K/3rR/q1HrC/8FYM7EAZQk82mEtj/1St52XdApxT/rg4AmMrnz2IG5loW5cJfTzf9vspg0+Eotm9ebj3w1SeUXmt5owIyBNSmxW5ae98Y0ETBwPzqVEVUFpWt0gLJm4uodYxA45Lbt523qjlQElqNIt7yeQyzGBxx+ZQo5L5w8rtCJKCYDd7XOoRfzLoTqRFtyUeE1luK4LTiIWJq9FaGNhvMFo2TxH/SJGPS3WSuTuFnU3tyrdYkd/O8kFDgtKkLC3A/y8BD6z4tMgtIPkvxEZW1Qvl8UEeaPj4avoIDCIiPwPWrHzvTtnMDG3NA581LosC5QGGuClPxK36is3QR6zOdHVpEjwRPvMlo8O+5EAtzkG6plr7zjk/tR+xgv7sFfwlgMzONhfG0R4wyAFOIRjY/96CFJ+rMpiJYouYuzhtWfW/cCiqq4CQ7sxuBC16e0u3vtT3XikV0YagVsnFA+AD5gcDetfEuRVrp4+lyfJjY6uAdgqYHJL8ufhidyGyOzt8bJFvNEjg50t2xyMdWnHccM1x/qMfEOJn4RN4ViXnKA=	2	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	f	3	2026-05-27 13:31:40.892512+00	2026-05-30 11:38:04.263059+00	\N	\N	HhMCVSYLa4ak_6V2A7YRDKsA	1364078b-a5b8-4866-95c5-b9f5a8666e7c	5e8366	1	f	\N
16	20	active	t	2026-05-30 19:19:26.782755+00	2026-06-02 19:19:26.776625+00	100	0	0	\N	https://mesh-go.cloudweb.name/X0WjdkqetPzZEZKMAPy936rX	happ://crypt4/KHMiSgweELPCOdnBUboaeVrYObaIVASv3zXvcewgV8IEeAfFR0MEL825v4riB7/yB3TLfqgTTKPel4gs+N2nF9gH7DTHJeVlZLRUhH/BknQxz6M9txVvraLTmxea7Wj1MlN9qVLRhhjJbjc86V9KEirDHfuZfFG0fEPchzXNswg+HztXttRjMLJISqLJJBGBM1a+69TlPSbc8aAlJ1YpVQbqeQco24Lpq0VMxEMLFXmFYenXoCKEM4MhBap1SDukFnkBHOHYThdcIM40JYNuP34Ywo7bgHR5FKE07wuY+/qY9n8smO1s0MMkEIIaLcRTCkcmZo0j9AMFx3FH1SyUpIu7omtaUOTuG/pQHFKZzov+FonpWgp6PozFpeDicZAqpDpLxTPKOm5KtP4lyvJ26LJ7UZ6WwauPLYCuIoxbio3mv21GdUR7Krn9KUX0rPHY6JMZ4+2zVlL0s7jnRLoWek21//afp0yIxzZd4Rxj677cVpatDeDn/SV4c62BxSqTSCIS7vhRG5GocC9tdg+USebvk/GoW1UOJBdGQdge8RgA53Jz+dG6Ols7zLmUHtWNHOsC2wxZApMt1nIMD6a5LBFzZP4/oFpAffYRCienRgy07b10KIh2v4sZ83dSjxrPV9+vjd6aiSBBZv4Da6VMfP2u2nyv2NeupVGO8AaFMM8=	2	f	["32eb5185-c698-4bdd-bc41-7630a5065531"]	f	3	2026-05-30 19:19:26.73809+00	2026-05-30 19:19:26.806913+00	\N	\N	X0WjdkqetPzZEZKMAPy936rX	0d3ad44c-a5c2-4549-bc3a-afd08ad264bf	67c8f7	1	f	\N
\.


--
-- Data for Name: support_audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_audit_logs (id, actor_user_id, actor_telegram_id, is_moderator, action, ticket_id, target_user_id, details, created_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_settings (id, key, value, description, created_at, updated_at) FROM stdin;
2	CABINET_ANIMATION_ENABLED	true	\N	2026-05-15 20:04:56.488133+00	2026-05-15 20:04:56.488133+00
1	CABINET_ANIMATION_CONFIG	{"enabled": true, "type": "shooting-stars", "settings": {"starColor": "#9E00FF", "trailColor": "#2EB9DF", "starDensity": 0.00015, "minSpeed": 10, "maxSpeed": 30}, "opacity": 1.0, "blur": 0.0, "reducedOnMobile": true}	\N	2026-05-15 20:04:56.474896+00	2026-05-15 20:06:30.964732+00
3	CABINET_THEME_COLORS	{"accent": "#6366f1", "darkBackground": "#030712", "darkSurface": "#111827", "darkText": "#f9fafb", "darkTextSecondary": "#9ca3af", "lightBackground": "#e5e7eb", "lightSurface": "#f3f4f6", "lightText": "#111827", "lightTextSecondary": "#4b5563", "success": "#22c55e", "warning": "#f59e0b", "error": "#ef4444"}	\N	2026-05-15 20:06:41.247799+00	2026-05-15 20:06:54.257278+00
4	BACKUP_SEND_ENABLED	true	\N	2026-05-15 20:10:54.649614+00	2026-05-15 20:10:54.649614+00
5	CABINET_BRANDING_NAME	Mesh	\N	2026-05-15 20:11:20.024909+00	2026-05-15 20:11:20.024909+00
6	CABINET_REMNA_SUB_CONFIG	00000000-0000-0000-0000-000000000000	\N	2026-05-16 08:58:37.805742+00	2026-05-16 08:58:37.805742+00
8	REMNAWAVE_AUTO_SYNC_TIMES	15:00	\N	2026-05-23 11:01:07.335687+00	2026-05-23 11:01:07.335687+00
\.


--
-- Data for Name: tariff_promo_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariff_promo_groups (tariff_id, promo_group_id) FROM stdin;
\.


--
-- Data for Name: tariffs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariffs (id, name, description, display_order, is_active, traffic_limit_gb, device_limit, device_price_kopeks, max_device_limit, allowed_squads, server_traffic_limits, period_prices, tier_level, is_trial_available, allow_traffic_topup, traffic_topup_enabled, traffic_topup_packages, max_topup_traffic_gb, is_daily, daily_price_kopeks, custom_days_enabled, price_per_day_kopeks, min_days, max_days, custom_traffic_enabled, traffic_price_per_gb_kopeks, min_traffic_gb, max_traffic_gb, show_in_gift, traffic_reset_mode, external_squad_uuid, created_at, updated_at) FROM stdin;
1	Стандартный	Базовый тарифный план	0	t	100	2	0	\N	["32eb5185-c698-4bdd-bc41-7630a5065531"]	{}	{"14": 7000, "30": 14000, "60": 25900, "90": 36900, "180": 69900, "360": 109900}	1	t	t	f	{}	0	f	0	f	0	1	365	f	0	1	1000	t	\N	\N	2026-05-15 01:43:32.166021+00	2026-05-23 10:06:39.361311+00
3	Единый 10	Одна подписка для всех членов семьи. Подключите до 10 устройств в едином тарифном плане.	0	t	500	10	0	\N	["32eb5185-c698-4bdd-bc41-7630a5065531"]	{}	{"14": 17900, "30": 34900, "60": 64900, "90": 94900, "180": 179000, "360": 299000}	2	f	t	f	{}	0	f	0	f	0	1	365	f	0	1	1000	t	\N	\N	2026-05-23 10:12:49.932292+00	2026-05-23 10:18:59.500798+00
4	Premium	Max\n\n* до 20 устройств\n* 1000 GB guaranteed\n* приоритетные ноды\n* heavy traffic\n* роутеры / whole-home\n* media  / 4k	0	t	1000	20	0	\N	["a4d53819-8d21-4594-b85c-08e5425293ad", "32eb5185-c698-4bdd-bc41-7630a5065531"]	{}	{"14": 19900, "30": 39900, "60": 74900, "90": 104900, "180": 189000, "360": 329000}	3	f	t	f	{}	0	f	0	f	0	1	365	f	0	1	1000	t	\N	23fe3e60-3c12-48a0-bc09-e5b1488290fc	2026-05-23 10:28:58.336151+00	2026-05-23 10:28:58.336151+00
5	Dedicated Proxy	Корпоративный Dedicated Proxy — выделенный приватный канал для бизнеса, команд и high-load задач.\n\n• Выделенный IP без посторонних пользователей  \n• Стабильное соединение и приоритетная маршрутизация  \n• Подходит для офисов, команд, роутеров и постоянной работы  \n• Повышенная устойчивость и низкий риск ограничений антифрод-систем  \n• Индивидуальная настройка под задачи клиента  \n\nКаждый Dedicated Proxy разворачивается отдельно и не используется другими клиентами.\n\nДоступно подключение с гарантированным лимитом трафика до 1000 GB и более.\n\nСтоимость рассчитывается индивидуально в зависимости от страны, нагрузки и количества пользователей.\n\nОформление и подключение — через поддержку.	0	t	0	1000	0	\N	[]	{}	{"30": 790000}	10	f	t	f	{}	0	f	0	f	0	1	365	f	0	1	1000	t	\N	\N	2026-05-23 10:38:46.575508+00	2026-05-23 10:38:46.575508+00
\.


--
-- Data for Name: ticket_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_messages (id, ticket_id, user_id, message_text, is_from_admin, has_media, media_type, media_file_id, media_caption, media_items, created_at) FROM stdin;
\.


--
-- Data for Name: ticket_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_notifications (id, ticket_id, user_id, notification_type, message, is_for_admin, is_read, created_at, read_at) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, user_id, title, status, priority, user_reply_block_permanent, user_reply_block_until, created_at, updated_at, closed_at, last_sla_reminder_at) FROM stdin;
\.


--
-- Data for Name: traffic_purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traffic_purchases (id, subscription_id, traffic_gb, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, type, amount_kopeks, description, payment_method, external_id, is_completed, receipt_uuid, receipt_created_at, created_at, completed_at) FROM stdin;
1	6	deposit	650000	Пополнение администратором: +6500 ₽	manual	\N	t	\N	\N	2026-05-21 08:10:33.731019+00	2026-05-21 08:10:33.805877+00
2	1	deposit	1000000	Пополнение администратором: +10000 ₽	manual	\N	t	\N	\N	2026-05-21 08:13:07.07531+00	2026-05-21 08:13:07.09742+00
3	2	deposit	500000	Пополнение администратором: +5000 ₽	manual	\N	t	\N	\N	2026-05-21 08:38:43.589637+00	2026-05-21 08:38:43.61359+00
5	1	subscription_payment	-329000	Смена тарифа на Premium	balance	\N	t	\N	\N	2026-05-24 02:26:47.390134+00	2026-05-24 02:26:47.946532+00
\.


--
-- Data for Name: user_channel_subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_channel_subscriptions (id, telegram_id, channel_id, is_member, checked_at) FROM stdin;
\.


--
-- Data for Name: user_device_aliases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_device_aliases (id, user_id, hwid, alias, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_messages (id, message_text, is_active, sort_order, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_promo_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_promo_groups (user_id, promo_group_id, assigned_at, assigned_by) FROM stdin;
1	4	2026-05-23 10:52:18.080901+00	admin
2	3	2026-05-23 10:53:55.936766+00	admin
6	3	2026-05-23 10:54:24.219471+00	admin
11	3	2026-05-23 10:54:50.108656+00	admin
12	3	2026-05-23 10:55:04.072949+00	admin
13	3	2026-05-23 10:55:18.165413+00	admin
14	3	2026-05-23 10:55:34.797862+00	admin
7	1	2026-05-23 10:56:58.586101+00	admin
8	1	2026-05-23 10:57:30.492589+00	admin
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, user_id, role_id, assigned_by, assigned_at, expires_at, is_active, revocation_source) FROM stdin;
1	1	1	\N	2026-05-15 02:03:37.303435+00	\N	t	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, telegram_id, auth_type, username, first_name, last_name, status, language, balance_kopeks, used_promocodes, has_had_paid_subscription, referred_by_id, referral_code, created_at, updated_at, last_activity, remnawave_uuid, email, email_verified, email_verified_at, password_hash, email_verification_token, email_verification_expires, password_reset_token, password_reset_expires, cabinet_last_login, pending_campaign_slug, email_change_new, email_change_code, email_change_expires, google_id, yandex_id, discord_id, vk_id, lifetime_used_traffic_bytes, auto_promo_group_assigned, auto_promo_group_threshold_kopeks, referral_commission_percent, promo_offer_discount_percent, promo_offer_discount_source, promo_offer_discount_expires_at, last_remnawave_sync, trojan_password, vless_uuid, ss_password, has_made_first_topup, promo_group_id, notification_settings, last_pinned_message_id, restriction_topup, restriction_subscription, restriction_reason, partner_status, email_verification_source) FROM stdin;
7	6441734876	telegram	Belokochka	Зомбальный	\N	active	ru	0	0	f	\N	ref5qrZm7TB	2026-05-18 04:31:49.064022+00	2026-05-18 04:31:51.973661+00	2026-05-18 04:31:51.978052+00	\N	\N	f	\N	\N	\N	\N	\N	\N	2026-05-18 04:31:49.108931+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
10	5730145137	telegram	natalisPax	Наталия	\N	active	ru	0	0	f	\N	refioaamkca	2026-05-19 19:14:56.620475+00	2026-05-19 19:15:23.675155+00	2026-05-19 19:15:23.560024+00	b7877eaa-67fe-4c7a-af31-cdbfa3f8a3cb	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
8	937262771	telegram	hagen_ak	Серёга	\N	active	ru	0	0	f	\N	refXzeOnkuL	2026-05-18 10:00:19.547249+00	2026-05-18 10:00:31.142714+00	2026-05-18 10:00:31.15921+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
4	1448317647	telegram	Dobpblu_SERJ	Серж	Добрый	active	ru	0	0	f	\N	refMalWHfQ8	2026-05-17 12:00:37.457762+00	2026-05-17 12:15:13.875615+00	2026-05-17 12:00:50.081765+00	1ca699c0-0c89-4769-a227-39cc8fb91b7b	\N	f	\N	\N	\N	\N	\N	\N	2026-05-17 12:15:14.066972+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
9	1191535338	telegram	friesenpro	S.F.	\N	active	ru	0	0	f	\N	refRLZkSUKH	2026-05-18 10:08:19.733369+00	2026-05-18 10:08:19.733369+00	2026-05-18 10:08:19.733369+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
5	5213341082	telegram	DobriySerj	Серж	\N	active	ru	0	0	f	\N	refcB3jgzZ4	2026-05-17 12:20:46.507348+00	2026-05-17 12:21:01.529014+00	2026-05-17 12:20:46.507348+00	0638818d-b9e3-48a3-a62f-875b4a463a0a	\N	f	\N	\N	\N	\N	\N	\N	2026-05-17 12:20:46.54002+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
2	5951923371	telegram	AiControleBot	Vision	Illusion	active	ru	500000	0	f	\N	refrOvpwC32	2026-05-15 23:03:08.440619+00	2026-05-23 11:08:52.172311+00	2026-05-15 23:03:36.991666+00	ce95a655-9a6b-4669-8ed3-d9c07daf51c5	\N	f	\N	\N	\N	\N	\N	\N	2026-05-23 11:08:52.196697+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
14	1369958636	telegram	pacifictrikita	ТРИ КИТА Pacific Green	\N	active	ru	0	0	t	\N	ref9VugOSVg	2026-05-22 13:34:07.663883+00	2026-05-23 10:59:04.573824+00	2026-05-22 13:38:50.913854+00	515c5cab-bd05-4cf7-bafb-4438091434b6	\N	f	\N	\N	\N	\N	\N	\N	2026-05-22 14:25:35.841885+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
13	1337226137	telegram	Pacificgrand	Гранд Pacific Green	\N	active	ru	0	0	t	\N	refXbkVMo3A	2026-05-21 16:17:13.241159+00	2026-05-23 10:55:18.208967+00	2026-05-23 09:20:31.512409+00	c217198d-b61a-4def-973f-63a8ea575e7b	\N	f	\N	\N	\N	\N	\N	\N	2026-05-23 09:20:44.532761+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
3	1389853920	telegram	LessTG	Its	Me	active	ru	0	0	f	\N	refeF2I6Sob	2026-05-15 23:17:56.519732+00	2026-05-30 07:30:18.486093+00	2026-05-30 07:30:18.515304+00	36ce2026-597f-43d7-8704-95ec02ff8a41	\N	f	\N	\N	\N	\N	\N	\N	2026-05-30 07:30:08.020989+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
11	579783212	telegram	pacificgreen	Оксана	Мартенкевич	active	ru	0	0	f	\N	refSWglmoS7	2026-05-20 14:20:07.731836+00	2026-05-23 10:54:50.151502+00	2026-05-20 14:20:07.731836+00	a2d7491a-ec87-4f53-9cd1-c36b77018fba	\N	f	\N	\N	\N	\N	\N	\N	2026-05-22 15:54:01.643519+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
1	149054871	telegram	MyTeleGO	Lucky	GUY	active	ru	671000	0	t	\N	refAZTqctG9	2026-05-15 01:48:48.572756+00	2026-05-30 09:14:43.167244+00	2026-05-30 09:14:43.192225+00	217ce3e3-42e5-44a1-8733-5a235dbb09d0	aipostme@gmail.com	t	2026-05-17 07:11:14.614554+00	$2b$12$DtUzpFLlHxLg8FtQEqkF6.nPA0cpcB7O0qDp75RGWDM0ca3UIlEmu	\N	\N	\N	\N	2026-05-30 09:12:59.573858+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	2026-05-17 07:19:22.420381+00	\N	\N	\N	f	4	{}	\N	f	f	\N	none	cabinet
6	1065385609	telegram	Sergey_arredocarisma	Sergey	Emelyanenko	active	ru	650000	0	t	\N	refpbKj5cnP	2026-05-17 16:26:32.624587+00	2026-05-23 10:54:24.26137+00	2026-05-17 16:26:32.624587+00	4e8760ef-b45f-42b1-ac85-70cf1856bdd7	\N	f	\N	\N	\N	\N	\N	\N	2026-05-23 08:40:38.167111+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
12	1144744746	telegram	\N	Andrey	Dikov	active	ru	0	0	t	\N	refgxZ7hDWL	2026-05-21 15:30:16.624102+00	2026-05-24 16:20:40.463379+00	2026-05-24 16:20:40.541262+00	53780d13-5737-4463-af47-ce48752f4a94	\N	f	\N	\N	\N	\N	\N	\N	2026-05-22 13:48:37.489013+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	3	{}	\N	f	f	\N	none	\N
16	5140550441	telegram	\N	Влладимир	\N	active	ru	0	0	f	\N	refXTJGAw3G	2026-05-23 08:28:26.031274+00	2026-05-26 08:59:43.405218+00	2026-05-23 08:32:00.436053+00	2e9c1e9b-0d0e-4a7c-8d27-08a09a04c2c9	\N	f	\N	\N	\N	\N	\N	\N	2026-05-26 08:59:43.5429+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
18	5335543128	telegram	ketrin2323	Екатерина	\N	active	ru	0	0	f	\N	refV3yRBGXa	2026-05-28 08:26:00.795059+00	2026-05-28 08:26:14.957021+00	2026-05-28 08:26:14.956956+00	\N	\N	f	\N	\N	\N	\N	\N	\N	2026-05-28 08:26:01.107439+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
19	215490445	telegram	marichko	Maria	Muszynska	active	ru	0	0	f	\N	reffGabMar2	2026-05-28 16:39:11.007361+00	2026-05-28 16:39:39.329487+00	2026-05-28 16:39:39.284327+00	dea17874-4b3b-46b1-9e54-e5d2eddb254c	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
17	8449404239	telegram	\N	Виктория М	\N	active	ru	0	0	f	\N	refPniegVJq	2026-05-27 10:06:51.093966+00	2026-05-30 11:37:53.019862+00	2026-05-30 11:37:53.051492+00	1364078b-a5b8-4866-95c5-b9f5a8666e7c	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	\N
20	\N	email	\N	\N	\N	active	ru	0	0	f	\N	refOtOqTMET	2026-05-30 19:18:25.634926+00	2026-05-30 19:19:26.806913+00	2026-05-30 19:18:25.634926+00	0d3ad44c-a5c2-4549-bc3a-afd08ad264bf	mybochka@yandex.ru	t	2026-05-30 19:18:55.814861+00	$2b$12$.LtQ8sUc6rKixaz1SL3isOAG9FMa9HBLTmo3oFfkAgKDAuHz5e632	\N	\N	\N	\N	2026-05-30 19:18:55.814889+00	\N	\N	\N	\N	\N	\N	\N	\N	0	f	0	\N	0	\N	\N	\N	\N	\N	\N	f	1	{}	\N	f	f	\N	none	cabinet
\.


--
-- Data for Name: wata_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wata_payments (id, user_id, payment_link_id, order_id, amount_kopeks, currency, description, type, status, is_paid, paid_at, last_status, terminal_public_id, url, success_redirect_url, fail_redirect_url, metadata_json, callback_payload, expires_at, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: web_api_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_api_tokens (id, name, token_hash, token_prefix, description, created_at, updated_at, expires_at, last_used_at, last_used_ip, is_active, created_by) FROM stdin;
1	Bootstrap Token	d40fd924f15afa8eef4279e8f6dd21b3a4bdf92161dff77674226ca738280709	179c79b4	Автоматически создан при миграции	2026-05-15 01:43:32.074645+00	2026-05-15 01:43:32.074645+00	\N	\N	\N	t	migration
\.


--
-- Data for Name: webhook_deliveries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_deliveries (id, webhook_id, event_type, payload, response_status, response_body, status, error_message, attempt_number, created_at, delivered_at, next_retry_at) FROM stdin;
\.


--
-- Data for Name: webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhooks (id, name, url, secret, event_type, is_active, description, created_at, updated_at, last_triggered_at, failure_count, success_count) FROM stdin;
\.


--
-- Data for Name: welcome_texts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.welcome_texts (id, text_content, is_active, is_enabled, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wheel_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wheel_configs (id, is_enabled, name, spin_cost_stars, spin_cost_days, spin_cost_stars_enabled, spin_cost_days_enabled, rtp_percent, daily_spin_limit, min_subscription_days_for_day_payment, promo_prefix, promo_validity_days, created_at, updated_at) FROM stdin;
1	f	Колесо удачи	10	1	t	t	80	5	3	WHEEL	7	2026-05-15 19:18:15.191373+00	2026-05-15 19:18:15.191373+00
\.


--
-- Data for Name: wheel_prizes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wheel_prizes (id, config_id, prize_type, prize_value, display_name, emoji, color, prize_value_kopeks, sort_order, manual_probability, is_active, promo_balance_bonus_kopeks, promo_subscription_days, promo_traffic_gb, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wheel_spins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wheel_spins (id, user_id, prize_id, payment_type, payment_amount, payment_value_kopeks, prize_type, prize_value, prize_display_name, prize_value_kopeks, generated_promocode_id, is_applied, applied_at, created_at) FROM stdin;
\.


--
-- Data for Name: withdrawal_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawal_requests (id, user_id, amount_kopeks, status, payment_details, risk_score, risk_analysis, processed_by, processed_at, admin_comment, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: yandex_client_id_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yandex_client_id_map (id, user_id, yandex_cid, source, counter_id, registration_sent, trial_sent, subid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: yookassa_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yookassa_payments (id, user_id, yookassa_payment_id, amount_kopeks, currency, description, status, is_paid, is_captured, confirmation_url, metadata_json, transaction_id, payment_method_type, refundable, test_mode, created_at, updated_at, yookassa_created_at, captured_at) FROM stdin;
\.


--
-- Name: access_policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.access_policies_id_seq', 2, true);


--
-- Name: admin_audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_audit_log_id_seq', 911, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 6, true);


--
-- Name: advertising_campaign_registrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.advertising_campaign_registrations_id_seq', 2, true);


--
-- Name: advertising_campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.advertising_campaigns_id_seq', 2, true);


--
-- Name: antilopay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antilopay_payments_id_seq', 2, true);


--
-- Name: apple_iap_abuse_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apple_iap_abuse_events_id_seq', 2, true);


--
-- Name: apple_iap_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apple_iap_accounts_id_seq', 2, true);


--
-- Name: apple_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apple_notifications_id_seq', 2, true);


--
-- Name: apple_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apple_transactions_id_seq', 2, true);


--
-- Name: aurapay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aurapay_payments_id_seq', 2, true);


--
-- Name: broadcast_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.broadcast_history_id_seq', 2, true);


--
-- Name: button_click_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.button_click_logs_id_seq', 2, true);


--
-- Name: cabinet_refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cabinet_refresh_tokens_id_seq', 47, true);


--
-- Name: cloudpayments_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cloudpayments_payments_id_seq', 2, true);


--
-- Name: contest_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_attempts_id_seq', 2, true);


--
-- Name: contest_rounds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_rounds_id_seq', 2, true);


--
-- Name: contest_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_templates_id_seq', 9, true);


--
-- Name: cryptobot_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cryptobot_payments_id_seq', 2, true);


--
-- Name: discount_offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_offers_id_seq', 2, true);


--
-- Name: donut_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donut_payments_id_seq', 2, true);


--
-- Name: email_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_templates_id_seq', 2, true);


--
-- Name: etoplatezhi_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etoplatezhi_payments_id_seq', 2, true);


--
-- Name: faq_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faq_pages_id_seq', 2, true);


--
-- Name: faq_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faq_settings_id_seq', 2, true);


--
-- Name: freekassa_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.freekassa_payments_id_seq', 2, true);


--
-- Name: guest_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guest_purchases_id_seq', 2, true);


--
-- Name: heleket_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.heleket_payments_id_seq', 2, true);


--
-- Name: info_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.info_pages_id_seq', 2, true);


--
-- Name: jupiter_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jupiter_payments_id_seq', 2, true);


--
-- Name: kassa_ai_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kassa_ai_payments_id_seq', 2, true);


--
-- Name: landing_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.landing_pages_id_seq', 2, true);


--
-- Name: lava_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lava_payments_id_seq', 2, true);


--
-- Name: main_menu_buttons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_menu_buttons_id_seq', 2, true);


--
-- Name: menu_layout_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_layout_history_id_seq', 2, true);


--
-- Name: monitoring_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.monitoring_logs_id_seq', 436, true);


--
-- Name: mulenpay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mulenpay_payments_id_seq', 2, true);


--
-- Name: news_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_articles_id_seq', 2, true);


--
-- Name: news_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_categories_id_seq', 2, true);


--
-- Name: news_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_tags_id_seq', 2, true);


--
-- Name: overpay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.overpay_payments_id_seq', 2, true);


--
-- Name: pal24_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pal24_payments_id_seq', 2, true);


--
-- Name: partner_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_applications_id_seq', 2, true);


--
-- Name: payment_method_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_method_configs_id_seq', 26, true);


--
-- Name: paypear_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypear_payments_id_seq', 2, true);


--
-- Name: pinned_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pinned_messages_id_seq', 2, true);


--
-- Name: platega_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platega_payments_id_seq', 2, true);


--
-- Name: poll_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poll_answers_id_seq', 2, true);


--
-- Name: poll_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poll_options_id_seq', 2, true);


--
-- Name: poll_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poll_questions_id_seq', 2, true);


--
-- Name: poll_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poll_responses_id_seq', 2, true);


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.polls_id_seq', 2, true);


--
-- Name: privacy_policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privacy_policies_id_seq', 2, true);


--
-- Name: promo_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promo_groups_id_seq', 4, true);


--
-- Name: promo_offer_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promo_offer_logs_id_seq', 2, true);


--
-- Name: promo_offer_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promo_offer_templates_id_seq', 5, true);


--
-- Name: promocode_uses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promocode_uses_id_seq', 2, true);


--
-- Name: promocodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promocodes_id_seq', 2, true);


--
-- Name: public_offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.public_offers_id_seq', 2, true);


--
-- Name: referral_contest_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_contest_events_id_seq', 2, true);


--
-- Name: referral_contest_virtual_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_contest_virtual_participants_id_seq', 2, true);


--
-- Name: referral_contests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_contests_id_seq', 2, true);


--
-- Name: referral_earnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_earnings_id_seq', 2, true);


--
-- Name: required_channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.required_channels_id_seq', 2, true);


--
-- Name: riopay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riopay_payments_id_seq', 2, true);


--
-- Name: rollypay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rollypay_payments_id_seq', 2, true);


--
-- Name: saved_payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saved_payment_methods_id_seq', 2, true);


--
-- Name: sent_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sent_notifications_id_seq', 9, true);


--
-- Name: server_squads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.server_squads_id_seq', 4, true);


--
-- Name: service_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_rules_id_seq', 2, true);


--
-- Name: severpay_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.severpay_payments_id_seq', 2, true);


--
-- Name: squads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.squads_id_seq', 2, true);


--
-- Name: subscription_conversions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_conversions_id_seq', 2, true);


--
-- Name: subscription_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_events_id_seq', 14, true);


--
-- Name: subscription_servers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_servers_id_seq', 2, true);


--
-- Name: subscription_temporary_access_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_temporary_access_id_seq', 2, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 16, true);


--
-- Name: support_audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_audit_logs_id_seq', 2, true);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 8, true);


--
-- Name: tariffs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tariffs_id_seq', 5, true);


--
-- Name: ticket_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_messages_id_seq', 2, true);


--
-- Name: ticket_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_notifications_id_seq', 2, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_id_seq', 2, true);


--
-- Name: traffic_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traffic_purchases_id_seq', 2, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 5, true);


--
-- Name: user_channel_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_channel_subscriptions_id_seq', 2, true);


--
-- Name: user_device_aliases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_device_aliases_id_seq', 2, true);


--
-- Name: user_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_messages_id_seq', 2, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: wata_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wata_payments_id_seq', 2, true);


--
-- Name: web_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_api_tokens_id_seq', 2, true);


--
-- Name: webhook_deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_deliveries_id_seq', 2, true);


--
-- Name: webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhooks_id_seq', 2, true);


--
-- Name: welcome_texts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.welcome_texts_id_seq', 2, true);


--
-- Name: wheel_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wheel_configs_id_seq', 2, true);


--
-- Name: wheel_prizes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wheel_prizes_id_seq', 2, true);


--
-- Name: wheel_spins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wheel_spins_id_seq', 2, true);


--
-- Name: withdrawal_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawal_requests_id_seq', 2, true);


--
-- Name: yandex_client_id_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yandex_client_id_map_id_seq', 2, true);


--
-- Name: yookassa_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yookassa_payments_id_seq', 2, true);


--
-- Name: access_policies access_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_policies
    ADD CONSTRAINT access_policies_pkey PRIMARY KEY (id);


--
-- Name: admin_audit_log admin_audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_log
    ADD CONSTRAINT admin_audit_log_pkey PRIMARY KEY (id);


--
-- Name: admin_roles admin_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_name_key UNIQUE (name);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: advertising_campaign_registrations advertising_campaign_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations
    ADD CONSTRAINT advertising_campaign_registrations_pkey PRIMARY KEY (id);


--
-- Name: advertising_campaigns advertising_campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaigns
    ADD CONSTRAINT advertising_campaigns_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: antilopay_payments antilopay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antilopay_payments
    ADD CONSTRAINT antilopay_payments_pkey PRIMARY KEY (id);


--
-- Name: apple_iap_abuse_events apple_iap_abuse_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_abuse_events
    ADD CONSTRAINT apple_iap_abuse_events_pkey PRIMARY KEY (id);


--
-- Name: apple_iap_accounts apple_iap_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_accounts
    ADD CONSTRAINT apple_iap_accounts_pkey PRIMARY KEY (id);


--
-- Name: apple_notifications apple_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_notifications
    ADD CONSTRAINT apple_notifications_pkey PRIMARY KEY (id);


--
-- Name: apple_transactions apple_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_transactions
    ADD CONSTRAINT apple_transactions_pkey PRIMARY KEY (id);


--
-- Name: aurapay_payments aurapay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aurapay_payments
    ADD CONSTRAINT aurapay_payments_pkey PRIMARY KEY (id);


--
-- Name: broadcast_history broadcast_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_history
    ADD CONSTRAINT broadcast_history_pkey PRIMARY KEY (id);


--
-- Name: button_click_logs button_click_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.button_click_logs
    ADD CONSTRAINT button_click_logs_pkey PRIMARY KEY (id);


--
-- Name: cabinet_refresh_tokens cabinet_refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet_refresh_tokens
    ADD CONSTRAINT cabinet_refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: cloudpayments_payments cloudpayments_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloudpayments_payments
    ADD CONSTRAINT cloudpayments_payments_pkey PRIMARY KEY (id);


--
-- Name: contest_attempts contest_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_attempts
    ADD CONSTRAINT contest_attempts_pkey PRIMARY KEY (id);


--
-- Name: contest_rounds contest_rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rounds
    ADD CONSTRAINT contest_rounds_pkey PRIMARY KEY (id);


--
-- Name: contest_templates contest_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_templates
    ADD CONSTRAINT contest_templates_pkey PRIMARY KEY (id);


--
-- Name: cryptobot_payments cryptobot_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptobot_payments
    ADD CONSTRAINT cryptobot_payments_pkey PRIMARY KEY (id);


--
-- Name: discount_offers discount_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_offers
    ADD CONSTRAINT discount_offers_pkey PRIMARY KEY (id);


--
-- Name: donut_payments donut_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donut_payments
    ADD CONSTRAINT donut_payments_pkey PRIMARY KEY (id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (id);


--
-- Name: etoplatezhi_payments etoplatezhi_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etoplatezhi_payments
    ADD CONSTRAINT etoplatezhi_payments_pkey PRIMARY KEY (id);


--
-- Name: faq_pages faq_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faq_pages
    ADD CONSTRAINT faq_pages_pkey PRIMARY KEY (id);


--
-- Name: faq_settings faq_settings_language_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faq_settings
    ADD CONSTRAINT faq_settings_language_key UNIQUE (language);


--
-- Name: faq_settings faq_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faq_settings
    ADD CONSTRAINT faq_settings_pkey PRIMARY KEY (id);


--
-- Name: freekassa_payments freekassa_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freekassa_payments
    ADD CONSTRAINT freekassa_payments_pkey PRIMARY KEY (id);


--
-- Name: guest_purchases guest_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases
    ADD CONSTRAINT guest_purchases_pkey PRIMARY KEY (id);


--
-- Name: heleket_payments heleket_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heleket_payments
    ADD CONSTRAINT heleket_payments_pkey PRIMARY KEY (id);


--
-- Name: info_pages info_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_pages
    ADD CONSTRAINT info_pages_pkey PRIMARY KEY (id);


--
-- Name: info_pages info_pages_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_pages
    ADD CONSTRAINT info_pages_slug_key UNIQUE (slug);


--
-- Name: jupiter_payments jupiter_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jupiter_payments
    ADD CONSTRAINT jupiter_payments_pkey PRIMARY KEY (id);


--
-- Name: kassa_ai_payments kassa_ai_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassa_ai_payments
    ADD CONSTRAINT kassa_ai_payments_pkey PRIMARY KEY (id);


--
-- Name: landing_pages landing_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.landing_pages
    ADD CONSTRAINT landing_pages_pkey PRIMARY KEY (id);


--
-- Name: lava_payments lava_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lava_payments
    ADD CONSTRAINT lava_payments_pkey PRIMARY KEY (id);


--
-- Name: main_menu_buttons main_menu_buttons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_menu_buttons
    ADD CONSTRAINT main_menu_buttons_pkey PRIMARY KEY (id);


--
-- Name: menu_layout_history menu_layout_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_layout_history
    ADD CONSTRAINT menu_layout_history_pkey PRIMARY KEY (id);


--
-- Name: monitoring_logs monitoring_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoring_logs
    ADD CONSTRAINT monitoring_logs_pkey PRIMARY KEY (id);


--
-- Name: mulenpay_payments mulenpay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mulenpay_payments
    ADD CONSTRAINT mulenpay_payments_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (id);


--
-- Name: news_categories news_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_categories
    ADD CONSTRAINT news_categories_pkey PRIMARY KEY (id);


--
-- Name: news_tags news_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_tags
    ADD CONSTRAINT news_tags_pkey PRIMARY KEY (id);


--
-- Name: overpay_payments overpay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpay_payments
    ADD CONSTRAINT overpay_payments_pkey PRIMARY KEY (id);


--
-- Name: pal24_payments pal24_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pal24_payments
    ADD CONSTRAINT pal24_payments_pkey PRIMARY KEY (id);


--
-- Name: partner_applications partner_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_applications
    ADD CONSTRAINT partner_applications_pkey PRIMARY KEY (id);


--
-- Name: payment_method_configs payment_method_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method_configs
    ADD CONSTRAINT payment_method_configs_pkey PRIMARY KEY (id);


--
-- Name: payment_method_promo_groups payment_method_promo_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method_promo_groups
    ADD CONSTRAINT payment_method_promo_groups_pkey PRIMARY KEY (payment_method_config_id, promo_group_id);


--
-- Name: paypear_payments paypear_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypear_payments
    ADD CONSTRAINT paypear_payments_pkey PRIMARY KEY (id);


--
-- Name: pinned_messages pinned_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pinned_messages
    ADD CONSTRAINT pinned_messages_pkey PRIMARY KEY (id);


--
-- Name: platega_payments platega_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platega_payments
    ADD CONSTRAINT platega_payments_pkey PRIMARY KEY (id);


--
-- Name: poll_answers poll_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_pkey PRIMARY KEY (id);


--
-- Name: poll_options poll_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_options
    ADD CONSTRAINT poll_options_pkey PRIMARY KEY (id);


--
-- Name: poll_questions poll_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_questions
    ADD CONSTRAINT poll_questions_pkey PRIMARY KEY (id);


--
-- Name: poll_responses poll_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_responses
    ADD CONSTRAINT poll_responses_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: privacy_policies privacy_policies_language_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_policies
    ADD CONSTRAINT privacy_policies_language_key UNIQUE (language);


--
-- Name: privacy_policies privacy_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_policies
    ADD CONSTRAINT privacy_policies_pkey PRIMARY KEY (id);


--
-- Name: promo_groups promo_groups_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_groups
    ADD CONSTRAINT promo_groups_name_key UNIQUE (name);


--
-- Name: promo_groups promo_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_groups
    ADD CONSTRAINT promo_groups_pkey PRIMARY KEY (id);


--
-- Name: promo_offer_logs promo_offer_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_logs
    ADD CONSTRAINT promo_offer_logs_pkey PRIMARY KEY (id);


--
-- Name: promo_offer_templates promo_offer_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_templates
    ADD CONSTRAINT promo_offer_templates_pkey PRIMARY KEY (id);


--
-- Name: promocode_uses promocode_uses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocode_uses
    ADD CONSTRAINT promocode_uses_pkey PRIMARY KEY (id);


--
-- Name: promocodes promocodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_pkey PRIMARY KEY (id);


--
-- Name: public_offers public_offers_language_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_offers
    ADD CONSTRAINT public_offers_language_key UNIQUE (language);


--
-- Name: public_offers public_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_offers
    ADD CONSTRAINT public_offers_pkey PRIMARY KEY (id);


--
-- Name: referral_contest_events referral_contest_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events
    ADD CONSTRAINT referral_contest_events_pkey PRIMARY KEY (id);


--
-- Name: referral_contest_virtual_participants referral_contest_virtual_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_virtual_participants
    ADD CONSTRAINT referral_contest_virtual_participants_pkey PRIMARY KEY (id);


--
-- Name: referral_contests referral_contests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contests
    ADD CONSTRAINT referral_contests_pkey PRIMARY KEY (id);


--
-- Name: referral_earnings referral_earnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings
    ADD CONSTRAINT referral_earnings_pkey PRIMARY KEY (id);


--
-- Name: required_channels required_channels_channel_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_channels
    ADD CONSTRAINT required_channels_channel_id_key UNIQUE (channel_id);


--
-- Name: required_channels required_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_channels
    ADD CONSTRAINT required_channels_pkey PRIMARY KEY (id);


--
-- Name: riopay_payments riopay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riopay_payments
    ADD CONSTRAINT riopay_payments_pkey PRIMARY KEY (id);


--
-- Name: rollypay_payments rollypay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rollypay_payments
    ADD CONSTRAINT rollypay_payments_pkey PRIMARY KEY (id);


--
-- Name: saved_payment_methods saved_payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_payment_methods
    ADD CONSTRAINT saved_payment_methods_pkey PRIMARY KEY (id);


--
-- Name: sent_notifications sent_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_pkey PRIMARY KEY (id);


--
-- Name: server_squad_promo_groups server_squad_promo_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_squad_promo_groups
    ADD CONSTRAINT server_squad_promo_groups_pkey PRIMARY KEY (server_squad_id, promo_group_id);


--
-- Name: server_squads server_squads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_squads
    ADD CONSTRAINT server_squads_pkey PRIMARY KEY (id);


--
-- Name: service_rules service_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_rules
    ADD CONSTRAINT service_rules_pkey PRIMARY KEY (id);


--
-- Name: severpay_payments severpay_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.severpay_payments
    ADD CONSTRAINT severpay_payments_pkey PRIMARY KEY (id);


--
-- Name: squads squads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.squads
    ADD CONSTRAINT squads_pkey PRIMARY KEY (id);


--
-- Name: squads squads_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.squads
    ADD CONSTRAINT squads_uuid_key UNIQUE (uuid);


--
-- Name: subscription_conversions subscription_conversions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_conversions
    ADD CONSTRAINT subscription_conversions_pkey PRIMARY KEY (id);


--
-- Name: subscription_events subscription_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_events
    ADD CONSTRAINT subscription_events_pkey PRIMARY KEY (id);


--
-- Name: subscription_servers subscription_servers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_servers
    ADD CONSTRAINT subscription_servers_pkey PRIMARY KEY (id);


--
-- Name: subscription_temporary_access subscription_temporary_access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_temporary_access
    ADD CONSTRAINT subscription_temporary_access_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_remnawave_short_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_remnawave_short_id_key UNIQUE (remnawave_short_id);


--
-- Name: support_audit_logs support_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_audit_logs
    ADD CONSTRAINT support_audit_logs_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_key_key UNIQUE (key);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: tariff_promo_groups tariff_promo_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_promo_groups
    ADD CONSTRAINT tariff_promo_groups_pkey PRIMARY KEY (tariff_id, promo_group_id);


--
-- Name: tariffs tariffs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs
    ADD CONSTRAINT tariffs_pkey PRIMARY KEY (id);


--
-- Name: ticket_messages ticket_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_pkey PRIMARY KEY (id);


--
-- Name: ticket_notifications ticket_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_notifications
    ADD CONSTRAINT ticket_notifications_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: traffic_purchases traffic_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_purchases
    ADD CONSTRAINT traffic_purchases_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: apple_iap_accounts uq_apple_iap_accounts_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_accounts
    ADD CONSTRAINT uq_apple_iap_accounts_token UNIQUE (account_token_uuid);


--
-- Name: apple_iap_accounts uq_apple_iap_accounts_user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_accounts
    ADD CONSTRAINT uq_apple_iap_accounts_user_id UNIQUE (user_id);


--
-- Name: apple_notifications uq_apple_notifications_notification_uuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_notifications
    ADD CONSTRAINT uq_apple_notifications_notification_uuid UNIQUE (notification_uuid);


--
-- Name: advertising_campaign_registrations uq_campaign_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations
    ADD CONSTRAINT uq_campaign_user UNIQUE (campaign_id, user_id);


--
-- Name: email_templates uq_email_templates_type_lang; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT uq_email_templates_type_lang UNIQUE (notification_type, language);


--
-- Name: poll_answers uq_poll_answer_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT uq_poll_answer_unique UNIQUE (response_id, question_id);


--
-- Name: poll_responses uq_poll_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_responses
    ADD CONSTRAINT uq_poll_user UNIQUE (poll_id, user_id);


--
-- Name: promocode_uses uq_promocode_uses_user_promo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocode_uses
    ADD CONSTRAINT uq_promocode_uses_user_promo UNIQUE (user_id, promocode_id);


--
-- Name: referral_contest_events uq_referral_contest_referral; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events
    ADD CONSTRAINT uq_referral_contest_referral UNIQUE (contest_id, referral_id);


--
-- Name: contest_attempts uq_round_user_attempt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_attempts
    ADD CONSTRAINT uq_round_user_attempt UNIQUE (round_id, user_id);


--
-- Name: transactions uq_transaction_external_id_method; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT uq_transaction_external_id_method UNIQUE (external_id, payment_method);


--
-- Name: user_channel_subscriptions uq_user_channel_sub; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_channel_subscriptions
    ADD CONSTRAINT uq_user_channel_sub UNIQUE (telegram_id, channel_id);


--
-- Name: user_device_aliases uq_user_device_aliases_user_hwid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_device_aliases
    ADD CONSTRAINT uq_user_device_aliases_user_hwid UNIQUE (user_id, hwid);


--
-- Name: user_roles uq_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT uq_user_role UNIQUE (user_id, role_id);


--
-- Name: user_channel_subscriptions user_channel_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_channel_subscriptions
    ADD CONSTRAINT user_channel_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: user_device_aliases user_device_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_device_aliases
    ADD CONSTRAINT user_device_aliases_pkey PRIMARY KEY (id);


--
-- Name: user_messages user_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_messages
    ADD CONSTRAINT user_messages_pkey PRIMARY KEY (id);


--
-- Name: user_promo_groups user_promo_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_promo_groups
    ADD CONSTRAINT user_promo_groups_pkey PRIMARY KEY (user_id, promo_group_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_referral_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_referral_code_key UNIQUE (referral_code);


--
-- Name: users users_remnawave_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_remnawave_uuid_key UNIQUE (remnawave_uuid);


--
-- Name: wata_payments wata_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wata_payments
    ADD CONSTRAINT wata_payments_pkey PRIMARY KEY (id);


--
-- Name: web_api_tokens web_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_api_tokens
    ADD CONSTRAINT web_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: webhook_deliveries webhook_deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_deliveries
    ADD CONSTRAINT webhook_deliveries_pkey PRIMARY KEY (id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- Name: welcome_texts welcome_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.welcome_texts
    ADD CONSTRAINT welcome_texts_pkey PRIMARY KEY (id);


--
-- Name: wheel_configs wheel_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_configs
    ADD CONSTRAINT wheel_configs_pkey PRIMARY KEY (id);


--
-- Name: wheel_prizes wheel_prizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_prizes
    ADD CONSTRAINT wheel_prizes_pkey PRIMARY KEY (id);


--
-- Name: wheel_spins wheel_spins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT wheel_spins_pkey PRIMARY KEY (id);


--
-- Name: withdrawal_requests withdrawal_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_pkey PRIMARY KEY (id);


--
-- Name: yandex_client_id_map yandex_client_id_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yandex_client_id_map
    ADD CONSTRAINT yandex_client_id_map_pkey PRIMARY KEY (id);


--
-- Name: yandex_client_id_map yandex_client_id_map_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yandex_client_id_map
    ADD CONSTRAINT yandex_client_id_map_user_id_key UNIQUE (user_id);


--
-- Name: yookassa_payments yookassa_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yookassa_payments
    ADD CONSTRAINT yookassa_payments_pkey PRIMARY KEY (id);


--
-- Name: idx_contest_attempt_round; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_attempt_round ON public.contest_attempts USING btree (round_id);


--
-- Name: idx_contest_round_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_round_status ON public.contest_rounds USING btree (status);


--
-- Name: idx_contest_round_template; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_round_template ON public.contest_rounds USING btree (template_id);


--
-- Name: idx_referral_contest_referrer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_referral_contest_referrer ON public.referral_contest_events USING btree (contest_id, referrer_id);


--
-- Name: ix_admin_audit_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_admin_audit_created ON public.admin_audit_log USING btree (created_at);


--
-- Name: ix_admin_audit_resource; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_admin_audit_resource ON public.admin_audit_log USING btree (resource_type, resource_id);


--
-- Name: ix_admin_audit_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_admin_audit_user_created ON public.admin_audit_log USING btree (user_id, created_at);


--
-- Name: ix_advertising_campaign_registrations_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_advertising_campaign_registrations_id ON public.advertising_campaign_registrations USING btree (id);


--
-- Name: ix_advertising_campaigns_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_advertising_campaigns_id ON public.advertising_campaigns USING btree (id);


--
-- Name: ix_advertising_campaigns_partner_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_advertising_campaigns_partner_user_id ON public.advertising_campaigns USING btree (partner_user_id);


--
-- Name: ix_advertising_campaigns_start_parameter; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_advertising_campaigns_start_parameter ON public.advertising_campaigns USING btree (start_parameter);


--
-- Name: ix_antilopay_payments_antilopay_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_antilopay_payments_antilopay_payment_id ON public.antilopay_payments USING btree (antilopay_payment_id);


--
-- Name: ix_antilopay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_antilopay_payments_id ON public.antilopay_payments USING btree (id);


--
-- Name: ix_antilopay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_antilopay_payments_order_id ON public.antilopay_payments USING btree (order_id);


--
-- Name: ix_antilopay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_antilopay_payments_user_id ON public.antilopay_payments USING btree (user_id);


--
-- Name: ix_apple_iap_abuse_events_event_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_iap_abuse_events_event_type ON public.apple_iap_abuse_events USING btree (event_type);


--
-- Name: ix_apple_iap_abuse_events_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_iap_abuse_events_id ON public.apple_iap_abuse_events USING btree (id);


--
-- Name: ix_apple_iap_abuse_events_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_iap_abuse_events_transaction_id ON public.apple_iap_abuse_events USING btree (transaction_id);


--
-- Name: ix_apple_iap_abuse_events_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_iap_abuse_events_user_id ON public.apple_iap_abuse_events USING btree (user_id);


--
-- Name: ix_apple_iap_accounts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_iap_accounts_id ON public.apple_iap_accounts USING btree (id);


--
-- Name: ix_apple_notifications_environment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_environment ON public.apple_notifications USING btree (environment);


--
-- Name: ix_apple_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_id ON public.apple_notifications USING btree (id);


--
-- Name: ix_apple_notifications_notification_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_notification_type ON public.apple_notifications USING btree (notification_type);


--
-- Name: ix_apple_notifications_notification_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_notification_uuid ON public.apple_notifications USING btree (notification_uuid);


--
-- Name: ix_apple_notifications_original_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_original_transaction_id ON public.apple_notifications USING btree (original_transaction_id);


--
-- Name: ix_apple_notifications_payload_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_apple_notifications_payload_hash ON public.apple_notifications USING btree (payload_hash);


--
-- Name: ix_apple_notifications_status_received_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_status_received_at ON public.apple_notifications USING btree (status, received_at) WHERE ((status)::text = ANY (ARRAY[('received'::character varying)::text, ('failed'::character varying)::text]));


--
-- Name: ix_apple_notifications_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_notifications_transaction_id ON public.apple_notifications USING btree (transaction_id);


--
-- Name: ix_apple_transactions_app_account_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_transactions_app_account_token ON public.apple_transactions USING btree (app_account_token);


--
-- Name: ix_apple_transactions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_transactions_id ON public.apple_transactions USING btree (id);


--
-- Name: ix_apple_transactions_original_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_transactions_original_transaction_id ON public.apple_transactions USING btree (original_transaction_id);


--
-- Name: ix_apple_transactions_signed_transaction_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_apple_transactions_signed_transaction_hash ON public.apple_transactions USING btree (signed_transaction_hash);


--
-- Name: ix_apple_transactions_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_apple_transactions_transaction_id ON public.apple_transactions USING btree (transaction_id);


--
-- Name: ix_apple_transactions_web_order_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_apple_transactions_web_order_line_item_id ON public.apple_transactions USING btree (web_order_line_item_id);


--
-- Name: ix_aurapay_payments_aurapay_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_aurapay_payments_aurapay_invoice_id ON public.aurapay_payments USING btree (aurapay_invoice_id);


--
-- Name: ix_aurapay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_aurapay_payments_id ON public.aurapay_payments USING btree (id);


--
-- Name: ix_aurapay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_aurapay_payments_order_id ON public.aurapay_payments USING btree (order_id);


--
-- Name: ix_aurapay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_aurapay_payments_user_id ON public.aurapay_payments USING btree (user_id);


--
-- Name: ix_broadcast_history_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_broadcast_history_id ON public.broadcast_history USING btree (id);


--
-- Name: ix_button_click_logs_button_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_button_date ON public.button_click_logs USING btree (button_id, clicked_at);


--
-- Name: ix_button_click_logs_button_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_button_id ON public.button_click_logs USING btree (button_id);


--
-- Name: ix_button_click_logs_button_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_button_type ON public.button_click_logs USING btree (button_type);


--
-- Name: ix_button_click_logs_clicked_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_clicked_at ON public.button_click_logs USING btree (clicked_at);


--
-- Name: ix_button_click_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_id ON public.button_click_logs USING btree (id);


--
-- Name: ix_button_click_logs_user_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_user_date ON public.button_click_logs USING btree (user_id, clicked_at);


--
-- Name: ix_button_click_logs_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_button_click_logs_user_id ON public.button_click_logs USING btree (user_id);


--
-- Name: ix_cabinet_refresh_tokens_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_cabinet_refresh_tokens_id ON public.cabinet_refresh_tokens USING btree (id);


--
-- Name: ix_cabinet_refresh_tokens_token_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_cabinet_refresh_tokens_token_hash ON public.cabinet_refresh_tokens USING btree (token_hash);


--
-- Name: ix_cabinet_refresh_tokens_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_cabinet_refresh_tokens_user ON public.cabinet_refresh_tokens USING btree (user_id);


--
-- Name: ix_campaign_reg_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_campaign_reg_user_created ON public.advertising_campaign_registrations USING btree (user_id, created_at);


--
-- Name: ix_cloudpayments_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_cloudpayments_payments_id ON public.cloudpayments_payments USING btree (id);


--
-- Name: ix_cloudpayments_payments_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_cloudpayments_payments_invoice_id ON public.cloudpayments_payments USING btree (invoice_id);


--
-- Name: ix_cloudpayments_payments_transaction_id_cp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_cloudpayments_payments_transaction_id_cp ON public.cloudpayments_payments USING btree (transaction_id_cp);


--
-- Name: ix_contest_attempts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_contest_attempts_id ON public.contest_attempts USING btree (id);


--
-- Name: ix_contest_rounds_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_contest_rounds_id ON public.contest_rounds USING btree (id);


--
-- Name: ix_contest_templates_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_contest_templates_id ON public.contest_templates USING btree (id);


--
-- Name: ix_contest_templates_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_contest_templates_slug ON public.contest_templates USING btree (slug);


--
-- Name: ix_cryptobot_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_cryptobot_payments_id ON public.cryptobot_payments USING btree (id);


--
-- Name: ix_cryptobot_payments_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_cryptobot_payments_invoice_id ON public.cryptobot_payments USING btree (invoice_id);


--
-- Name: ix_discount_offers_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_discount_offers_id ON public.discount_offers USING btree (id);


--
-- Name: ix_discount_offers_user_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_discount_offers_user_type ON public.discount_offers USING btree (user_id, notification_type);


--
-- Name: ix_donut_payments_donut_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_donut_payments_donut_transaction_id ON public.donut_payments USING btree (donut_transaction_id);


--
-- Name: ix_donut_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_donut_payments_id ON public.donut_payments USING btree (id);


--
-- Name: ix_donut_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_donut_payments_order_id ON public.donut_payments USING btree (order_id);


--
-- Name: ix_donut_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_donut_payments_user_id ON public.donut_payments USING btree (user_id);


--
-- Name: ix_email_templates_notification_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_email_templates_notification_type ON public.email_templates USING btree (notification_type);


--
-- Name: ix_etoplatezhi_payments_etoplatezhi_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_etoplatezhi_payments_etoplatezhi_payment_id ON public.etoplatezhi_payments USING btree (etoplatezhi_payment_id);


--
-- Name: ix_etoplatezhi_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_etoplatezhi_payments_id ON public.etoplatezhi_payments USING btree (id);


--
-- Name: ix_etoplatezhi_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_etoplatezhi_payments_order_id ON public.etoplatezhi_payments USING btree (order_id);


--
-- Name: ix_etoplatezhi_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_etoplatezhi_payments_user_id ON public.etoplatezhi_payments USING btree (user_id);


--
-- Name: ix_faq_pages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_faq_pages_id ON public.faq_pages USING btree (id);


--
-- Name: ix_faq_pages_language; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_faq_pages_language ON public.faq_pages USING btree (language);


--
-- Name: ix_faq_settings_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_faq_settings_id ON public.faq_settings USING btree (id);


--
-- Name: ix_freekassa_payments_freekassa_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_freekassa_payments_freekassa_order_id ON public.freekassa_payments USING btree (freekassa_order_id);


--
-- Name: ix_freekassa_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_freekassa_payments_id ON public.freekassa_payments USING btree (id);


--
-- Name: ix_freekassa_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_freekassa_payments_order_id ON public.freekassa_payments USING btree (order_id);


--
-- Name: ix_guest_purchases_buyer_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_buyer_user_id ON public.guest_purchases USING btree (buyer_user_id);


--
-- Name: ix_guest_purchases_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_contact ON public.guest_purchases USING btree (contact_type, contact_value);


--
-- Name: ix_guest_purchases_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_id ON public.guest_purchases USING btree (id);


--
-- Name: ix_guest_purchases_landing_status_paid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_landing_status_paid ON public.guest_purchases USING btree (landing_id, status, paid_at);


--
-- Name: ix_guest_purchases_receipt_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_receipt_uuid ON public.guest_purchases USING btree (receipt_uuid);


--
-- Name: ix_guest_purchases_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_source ON public.guest_purchases USING btree (source);


--
-- Name: ix_guest_purchases_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_status ON public.guest_purchases USING btree (status);


--
-- Name: ix_guest_purchases_status_paid_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_status_paid_at ON public.guest_purchases USING btree (status, paid_at);


--
-- Name: ix_guest_purchases_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_guest_purchases_token ON public.guest_purchases USING btree (token);


--
-- Name: ix_guest_purchases_user_gift_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_guest_purchases_user_gift_status ON public.guest_purchases USING btree (user_id, is_gift, status);


--
-- Name: ix_heleket_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_heleket_payments_id ON public.heleket_payments USING btree (id);


--
-- Name: ix_heleket_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_heleket_payments_order_id ON public.heleket_payments USING btree (order_id);


--
-- Name: ix_heleket_payments_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_heleket_payments_uuid ON public.heleket_payments USING btree (uuid);


--
-- Name: ix_info_pages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_info_pages_id ON public.info_pages USING btree (id);


--
-- Name: ix_jupiter_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_jupiter_payments_id ON public.jupiter_payments USING btree (id);


--
-- Name: ix_jupiter_payments_jupiter_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_jupiter_payments_jupiter_transaction_id ON public.jupiter_payments USING btree (jupiter_transaction_id);


--
-- Name: ix_jupiter_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_jupiter_payments_order_id ON public.jupiter_payments USING btree (order_id);


--
-- Name: ix_jupiter_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_jupiter_payments_user_id ON public.jupiter_payments USING btree (user_id);


--
-- Name: ix_kassa_ai_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_kassa_ai_payments_id ON public.kassa_ai_payments USING btree (id);


--
-- Name: ix_kassa_ai_payments_kassa_ai_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_kassa_ai_payments_kassa_ai_order_id ON public.kassa_ai_payments USING btree (kassa_ai_order_id);


--
-- Name: ix_kassa_ai_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_kassa_ai_payments_order_id ON public.kassa_ai_payments USING btree (order_id);


--
-- Name: ix_landing_pages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_landing_pages_id ON public.landing_pages USING btree (id);


--
-- Name: ix_landing_pages_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_landing_pages_slug ON public.landing_pages USING btree (slug);


--
-- Name: ix_lava_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_lava_payments_id ON public.lava_payments USING btree (id);


--
-- Name: ix_lava_payments_lava_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_lava_payments_lava_invoice_id ON public.lava_payments USING btree (lava_invoice_id);


--
-- Name: ix_lava_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_lava_payments_order_id ON public.lava_payments USING btree (order_id);


--
-- Name: ix_lava_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_lava_payments_user_id ON public.lava_payments USING btree (user_id);


--
-- Name: ix_main_menu_buttons_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_main_menu_buttons_id ON public.main_menu_buttons USING btree (id);


--
-- Name: ix_main_menu_buttons_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_main_menu_buttons_order ON public.main_menu_buttons USING btree (display_order, id);


--
-- Name: ix_menu_layout_history_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_menu_layout_history_created ON public.menu_layout_history USING btree (created_at);


--
-- Name: ix_menu_layout_history_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_menu_layout_history_created_at ON public.menu_layout_history USING btree (created_at);


--
-- Name: ix_menu_layout_history_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_menu_layout_history_id ON public.menu_layout_history USING btree (id);


--
-- Name: ix_monitoring_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_monitoring_logs_id ON public.monitoring_logs USING btree (id);


--
-- Name: ix_mulenpay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_mulenpay_payments_id ON public.mulenpay_payments USING btree (id);


--
-- Name: ix_mulenpay_payments_mulen_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_mulenpay_payments_mulen_payment_id ON public.mulenpay_payments USING btree (mulen_payment_id);


--
-- Name: ix_mulenpay_payments_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_mulenpay_payments_uuid ON public.mulenpay_payments USING btree (uuid);


--
-- Name: ix_news_articles_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_articles_created_at ON public.news_articles USING btree (created_at);


--
-- Name: ix_news_articles_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_articles_id ON public.news_articles USING btree (id);


--
-- Name: ix_news_articles_published_at_published; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_articles_published_at_published ON public.news_articles USING btree (is_published, published_at);


--
-- Name: ix_news_articles_published_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_articles_published_category ON public.news_articles USING btree (is_published, category);


--
-- Name: ix_news_articles_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_news_articles_slug ON public.news_articles USING btree (slug);


--
-- Name: ix_news_categories_name_lower; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_news_categories_name_lower ON public.news_categories USING btree (lower((name)::text));


--
-- Name: ix_news_tags_name_lower; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_news_tags_name_lower ON public.news_tags USING btree (lower((name)::text));


--
-- Name: ix_overpay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_overpay_payments_id ON public.overpay_payments USING btree (id);


--
-- Name: ix_overpay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_overpay_payments_order_id ON public.overpay_payments USING btree (order_id);


--
-- Name: ix_overpay_payments_overpay_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_overpay_payments_overpay_payment_id ON public.overpay_payments USING btree (overpay_payment_id);


--
-- Name: ix_overpay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_overpay_payments_user_id ON public.overpay_payments USING btree (user_id);


--
-- Name: ix_pal24_payments_bill_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_pal24_payments_bill_id ON public.pal24_payments USING btree (bill_id);


--
-- Name: ix_pal24_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pal24_payments_id ON public.pal24_payments USING btree (id);


--
-- Name: ix_pal24_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pal24_payments_order_id ON public.pal24_payments USING btree (order_id);


--
-- Name: ix_pal24_payments_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pal24_payments_payment_id ON public.pal24_payments USING btree (payment_id);


--
-- Name: ix_partner_applications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_partner_applications_id ON public.partner_applications USING btree (id);


--
-- Name: ix_payment_method_configs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_payment_method_configs_id ON public.payment_method_configs USING btree (id);


--
-- Name: ix_payment_method_configs_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_payment_method_configs_method_id ON public.payment_method_configs USING btree (method_id);


--
-- Name: ix_payment_method_configs_sort_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_payment_method_configs_sort_order ON public.payment_method_configs USING btree (sort_order);


--
-- Name: ix_paypear_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_paypear_payments_id ON public.paypear_payments USING btree (id);


--
-- Name: ix_paypear_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_paypear_payments_order_id ON public.paypear_payments USING btree (order_id);


--
-- Name: ix_paypear_payments_paypear_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_paypear_payments_paypear_id ON public.paypear_payments USING btree (paypear_id);


--
-- Name: ix_paypear_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_paypear_payments_user_id ON public.paypear_payments USING btree (user_id);


--
-- Name: ix_pinned_messages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pinned_messages_id ON public.pinned_messages USING btree (id);


--
-- Name: ix_platega_payments_correlation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_platega_payments_correlation_id ON public.platega_payments USING btree (correlation_id);


--
-- Name: ix_platega_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_platega_payments_id ON public.platega_payments USING btree (id);


--
-- Name: ix_platega_payments_platega_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_platega_payments_platega_transaction_id ON public.platega_payments USING btree (platega_transaction_id);


--
-- Name: ix_poll_answers_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_answers_id ON public.poll_answers USING btree (id);


--
-- Name: ix_poll_answers_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_answers_option_id ON public.poll_answers USING btree (option_id);


--
-- Name: ix_poll_answers_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_answers_question_id ON public.poll_answers USING btree (question_id);


--
-- Name: ix_poll_answers_response_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_answers_response_id ON public.poll_answers USING btree (response_id);


--
-- Name: ix_poll_options_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_options_id ON public.poll_options USING btree (id);


--
-- Name: ix_poll_options_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_options_question_id ON public.poll_options USING btree (question_id);


--
-- Name: ix_poll_questions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_questions_id ON public.poll_questions USING btree (id);


--
-- Name: ix_poll_questions_poll_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_questions_poll_id ON public.poll_questions USING btree (poll_id);


--
-- Name: ix_poll_responses_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_responses_id ON public.poll_responses USING btree (id);


--
-- Name: ix_poll_responses_poll_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_responses_poll_id ON public.poll_responses USING btree (poll_id);


--
-- Name: ix_poll_responses_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_poll_responses_user_id ON public.poll_responses USING btree (user_id);


--
-- Name: ix_polls_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_polls_id ON public.polls USING btree (id);


--
-- Name: ix_privacy_policies_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_privacy_policies_id ON public.privacy_policies USING btree (id);


--
-- Name: ix_promo_groups_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_groups_id ON public.promo_groups USING btree (id);


--
-- Name: ix_promo_groups_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_groups_priority ON public.promo_groups USING btree (priority);


--
-- Name: ix_promo_offer_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_offer_logs_id ON public.promo_offer_logs USING btree (id);


--
-- Name: ix_promo_offer_logs_offer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_offer_logs_offer_id ON public.promo_offer_logs USING btree (offer_id);


--
-- Name: ix_promo_offer_logs_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_offer_logs_user_id ON public.promo_offer_logs USING btree (user_id);


--
-- Name: ix_promo_offer_templates_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_offer_templates_id ON public.promo_offer_templates USING btree (id);


--
-- Name: ix_promo_offer_templates_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promo_offer_templates_type ON public.promo_offer_templates USING btree (offer_type);


--
-- Name: ix_promocode_uses_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promocode_uses_id ON public.promocode_uses USING btree (id);


--
-- Name: ix_promocodes_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_promocodes_code ON public.promocodes USING btree (code);


--
-- Name: ix_promocodes_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promocodes_id ON public.promocodes USING btree (id);


--
-- Name: ix_promocodes_promo_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promocodes_promo_group_id ON public.promocodes USING btree (promo_group_id);


--
-- Name: ix_promocodes_tariff_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_promocodes_tariff_id ON public.promocodes USING btree (tariff_id);


--
-- Name: ix_public_offers_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_public_offers_id ON public.public_offers USING btree (id);


--
-- Name: ix_referral_contest_events_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_contest_events_id ON public.referral_contest_events USING btree (id);


--
-- Name: ix_referral_contest_virtual_participants_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_contest_virtual_participants_id ON public.referral_contest_virtual_participants USING btree (id);


--
-- Name: ix_referral_contests_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_contests_id ON public.referral_contests USING btree (id);


--
-- Name: ix_referral_earnings_campaign_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_earnings_campaign_id ON public.referral_earnings USING btree (campaign_id);


--
-- Name: ix_referral_earnings_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_earnings_id ON public.referral_earnings USING btree (id);


--
-- Name: ix_referral_earnings_referral_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_earnings_referral_id ON public.referral_earnings USING btree (referral_id);


--
-- Name: ix_referral_earnings_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_referral_earnings_user_id ON public.referral_earnings USING btree (user_id);


--
-- Name: ix_riopay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_riopay_payments_id ON public.riopay_payments USING btree (id);


--
-- Name: ix_riopay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_riopay_payments_order_id ON public.riopay_payments USING btree (order_id);


--
-- Name: ix_riopay_payments_riopay_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_riopay_payments_riopay_order_id ON public.riopay_payments USING btree (riopay_order_id);


--
-- Name: ix_riopay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_riopay_payments_user_id ON public.riopay_payments USING btree (user_id);


--
-- Name: ix_rollypay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rollypay_payments_id ON public.rollypay_payments USING btree (id);


--
-- Name: ix_rollypay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_rollypay_payments_order_id ON public.rollypay_payments USING btree (order_id);


--
-- Name: ix_rollypay_payments_rollypay_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_rollypay_payments_rollypay_payment_id ON public.rollypay_payments USING btree (rollypay_payment_id);


--
-- Name: ix_rollypay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rollypay_payments_user_id ON public.rollypay_payments USING btree (user_id);


--
-- Name: ix_saved_payment_methods_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_saved_payment_methods_id ON public.saved_payment_methods USING btree (id);


--
-- Name: ix_saved_payment_methods_user_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_saved_payment_methods_user_active ON public.saved_payment_methods USING btree (user_id, is_active);


--
-- Name: ix_saved_payment_methods_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_saved_payment_methods_user_id ON public.saved_payment_methods USING btree (user_id);


--
-- Name: ix_saved_payment_methods_yookassa_payment_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_saved_payment_methods_yookassa_payment_method_id ON public.saved_payment_methods USING btree (yookassa_payment_method_id);


--
-- Name: ix_sent_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_sent_notifications_id ON public.sent_notifications USING btree (id);


--
-- Name: ix_server_squads_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_server_squads_id ON public.server_squads USING btree (id);


--
-- Name: ix_server_squads_squad_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_server_squads_squad_uuid ON public.server_squads USING btree (squad_uuid);


--
-- Name: ix_service_rules_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_service_rules_id ON public.service_rules USING btree (id);


--
-- Name: ix_severpay_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_severpay_payments_id ON public.severpay_payments USING btree (id);


--
-- Name: ix_severpay_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_severpay_payments_order_id ON public.severpay_payments USING btree (order_id);


--
-- Name: ix_severpay_payments_severpay_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_severpay_payments_severpay_id ON public.severpay_payments USING btree (severpay_id);


--
-- Name: ix_severpay_payments_severpay_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_severpay_payments_severpay_uid ON public.severpay_payments USING btree (severpay_uid);


--
-- Name: ix_severpay_payments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_severpay_payments_user_id ON public.severpay_payments USING btree (user_id);


--
-- Name: ix_squads_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_squads_id ON public.squads USING btree (id);


--
-- Name: ix_sub_conversions_converted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_sub_conversions_converted_at ON public.subscription_conversions USING btree (converted_at);


--
-- Name: ix_sub_conversions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_sub_conversions_user_id ON public.subscription_conversions USING btree (user_id);


--
-- Name: ix_subscription_conversions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_conversions_id ON public.subscription_conversions USING btree (id);


--
-- Name: ix_subscription_events_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_events_id ON public.subscription_events USING btree (id);


--
-- Name: ix_subscription_servers_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_servers_id ON public.subscription_servers USING btree (id);


--
-- Name: ix_subscription_servers_subscription_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_servers_subscription_id ON public.subscription_servers USING btree (subscription_id);


--
-- Name: ix_subscription_temporary_access_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_temporary_access_id ON public.subscription_temporary_access USING btree (id);


--
-- Name: ix_subscriptions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_id ON public.subscriptions USING btree (id);


--
-- Name: ix_subscriptions_status_trial; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_status_trial ON public.subscriptions USING btree (status, is_trial);


--
-- Name: ix_subscriptions_tariff_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_tariff_id ON public.subscriptions USING btree (tariff_id);


--
-- Name: ix_subscriptions_trial_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_trial_created ON public.subscriptions USING btree (is_trial, created_at);


--
-- Name: ix_subscriptions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_user_id ON public.subscriptions USING btree (user_id);


--
-- Name: ix_subscriptions_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_user_status ON public.subscriptions USING btree (user_id, status);


--
-- Name: ix_subscriptions_user_tariff_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscriptions_user_tariff_status ON public.subscriptions USING btree (user_id, tariff_id, status);


--
-- Name: ix_support_audit_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_support_audit_logs_id ON public.support_audit_logs USING btree (id);


--
-- Name: ix_system_settings_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_system_settings_id ON public.system_settings USING btree (id);


--
-- Name: ix_tariffs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tariffs_id ON public.tariffs USING btree (id);


--
-- Name: ix_ticket_messages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_messages_id ON public.ticket_messages USING btree (id);


--
-- Name: ix_ticket_notifications_admin_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_notifications_admin_read ON public.ticket_notifications USING btree (is_for_admin, is_read);


--
-- Name: ix_ticket_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_notifications_id ON public.ticket_notifications USING btree (id);


--
-- Name: ix_ticket_notifications_ticket_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_notifications_ticket_id ON public.ticket_notifications USING btree (ticket_id);


--
-- Name: ix_ticket_notifications_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_notifications_user_id ON public.ticket_notifications USING btree (user_id);


--
-- Name: ix_ticket_notifications_user_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_ticket_notifications_user_read ON public.ticket_notifications USING btree (user_id, is_read);


--
-- Name: ix_tickets_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tickets_id ON public.tickets USING btree (id);


--
-- Name: ix_traffic_purchases_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_traffic_purchases_created_at ON public.traffic_purchases USING btree (created_at);


--
-- Name: ix_traffic_purchases_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_traffic_purchases_expires_at ON public.traffic_purchases USING btree (expires_at);


--
-- Name: ix_traffic_purchases_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_traffic_purchases_id ON public.traffic_purchases USING btree (id);


--
-- Name: ix_traffic_purchases_sub_expires; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_traffic_purchases_sub_expires ON public.traffic_purchases USING btree (subscription_id, expires_at);


--
-- Name: ix_transactions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);


--
-- Name: ix_transactions_receipt_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_receipt_uuid ON public.transactions USING btree (receipt_uuid);


--
-- Name: ix_transactions_type_created_completed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_type_created_completed ON public.transactions USING btree (type, created_at, is_completed);


--
-- Name: ix_transactions_type_method_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_type_method_created ON public.transactions USING btree (type, payment_method, created_at);


--
-- Name: ix_transactions_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_user_created ON public.transactions USING btree (user_id, created_at);


--
-- Name: ix_transactions_user_type_completed_amount; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transactions_user_type_completed_amount ON public.transactions USING btree (user_id, type, is_completed, amount_kopeks);


--
-- Name: ix_user_channel_sub_channel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_channel_sub_channel_id ON public.user_channel_subscriptions USING btree (channel_id);


--
-- Name: ix_user_channel_sub_telegram_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_channel_sub_telegram_id ON public.user_channel_subscriptions USING btree (telegram_id);


--
-- Name: ix_user_device_aliases_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_device_aliases_user_id ON public.user_device_aliases USING btree (user_id);


--
-- Name: ix_user_messages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_messages_id ON public.user_messages USING btree (id);


--
-- Name: ix_users_discord_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_discord_id ON public.users USING btree (discord_id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_google_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_google_id ON public.users USING btree (google_id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_partner_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_partner_status ON public.users USING btree (partner_status);


--
-- Name: ix_users_promo_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_promo_group_id ON public.users USING btree (promo_group_id);


--
-- Name: ix_users_referred_by_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_referred_by_id ON public.users USING btree (referred_by_id);


--
-- Name: ix_users_telegram_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_telegram_id ON public.users USING btree (telegram_id);


--
-- Name: ix_users_vk_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_vk_id ON public.users USING btree (vk_id);


--
-- Name: ix_users_yandex_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_yandex_id ON public.users USING btree (yandex_id);


--
-- Name: ix_wata_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wata_payments_id ON public.wata_payments USING btree (id);


--
-- Name: ix_wata_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wata_payments_order_id ON public.wata_payments USING btree (order_id);


--
-- Name: ix_wata_payments_payment_link_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_wata_payments_payment_link_id ON public.wata_payments USING btree (payment_link_id);


--
-- Name: ix_web_api_tokens_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_web_api_tokens_id ON public.web_api_tokens USING btree (id);


--
-- Name: ix_web_api_tokens_token_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_web_api_tokens_token_hash ON public.web_api_tokens USING btree (token_hash);


--
-- Name: ix_web_api_tokens_token_prefix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_web_api_tokens_token_prefix ON public.web_api_tokens USING btree (token_prefix);


--
-- Name: ix_webhook_deliveries_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhook_deliveries_id ON public.webhook_deliveries USING btree (id);


--
-- Name: ix_webhook_deliveries_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhook_deliveries_status ON public.webhook_deliveries USING btree (status);


--
-- Name: ix_webhook_deliveries_webhook_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhook_deliveries_webhook_created ON public.webhook_deliveries USING btree (webhook_id, created_at);


--
-- Name: ix_webhooks_event_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhooks_event_type ON public.webhooks USING btree (event_type);


--
-- Name: ix_webhooks_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhooks_id ON public.webhooks USING btree (id);


--
-- Name: ix_webhooks_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_webhooks_is_active ON public.webhooks USING btree (is_active);


--
-- Name: ix_welcome_texts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_welcome_texts_id ON public.welcome_texts USING btree (id);


--
-- Name: ix_wheel_configs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wheel_configs_id ON public.wheel_configs USING btree (id);


--
-- Name: ix_wheel_prizes_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wheel_prizes_id ON public.wheel_prizes USING btree (id);


--
-- Name: ix_wheel_spins_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wheel_spins_id ON public.wheel_spins USING btree (id);


--
-- Name: ix_wheel_spins_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_wheel_spins_user_created ON public.wheel_spins USING btree (user_id, created_at);


--
-- Name: ix_withdrawal_requests_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_withdrawal_requests_id ON public.withdrawal_requests USING btree (id);


--
-- Name: ix_withdrawal_requests_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_withdrawal_requests_status ON public.withdrawal_requests USING btree (status);


--
-- Name: ix_withdrawal_requests_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_withdrawal_requests_user_id ON public.withdrawal_requests USING btree (user_id);


--
-- Name: ix_yookassa_payments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_yookassa_payments_id ON public.yookassa_payments USING btree (id);


--
-- Name: ix_yookassa_payments_yookassa_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_yookassa_payments_yookassa_payment_id ON public.yookassa_payments USING btree (yookassa_payment_id);


--
-- Name: uq_referral_earnings_registration_pending; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_referral_earnings_registration_pending ON public.referral_earnings USING btree (user_id, referral_id) WHERE ((reason)::text = 'referral_registration_pending'::text);


--
-- Name: uq_subscriptions_user_tariff_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_subscriptions_user_tariff_active ON public.subscriptions USING btree (user_id, tariff_id) WHERE ((tariff_id IS NOT NULL) AND ((status)::text = ANY (ARRAY[('active'::character varying)::text, ('trial'::character varying)::text, ('limited'::character varying)::text])));


--
-- Name: access_policies access_policies_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_policies
    ADD CONSTRAINT access_policies_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: access_policies access_policies_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_policies
    ADD CONSTRAINT access_policies_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_audit_log admin_audit_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_log
    ADD CONSTRAINT admin_audit_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: admin_roles admin_roles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: advertising_campaign_registrations advertising_campaign_registrations_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations
    ADD CONSTRAINT advertising_campaign_registrations_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.advertising_campaigns(id) ON DELETE CASCADE;


--
-- Name: advertising_campaign_registrations advertising_campaign_registrations_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations
    ADD CONSTRAINT advertising_campaign_registrations_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE SET NULL;


--
-- Name: advertising_campaign_registrations advertising_campaign_registrations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaign_registrations
    ADD CONSTRAINT advertising_campaign_registrations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: advertising_campaigns advertising_campaigns_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaigns
    ADD CONSTRAINT advertising_campaigns_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: advertising_campaigns advertising_campaigns_partner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaigns
    ADD CONSTRAINT advertising_campaigns_partner_user_id_fkey FOREIGN KEY (partner_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: advertising_campaigns advertising_campaigns_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_campaigns
    ADD CONSTRAINT advertising_campaigns_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE SET NULL;


--
-- Name: antilopay_payments antilopay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antilopay_payments
    ADD CONSTRAINT antilopay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: antilopay_payments antilopay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antilopay_payments
    ADD CONSTRAINT antilopay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: apple_iap_abuse_events apple_iap_abuse_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_abuse_events
    ADD CONSTRAINT apple_iap_abuse_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: apple_iap_accounts apple_iap_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_iap_accounts
    ADD CONSTRAINT apple_iap_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: apple_transactions apple_transactions_transaction_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_transactions
    ADD CONSTRAINT apple_transactions_transaction_id_fk_fkey FOREIGN KEY (transaction_id_fk) REFERENCES public.transactions(id);


--
-- Name: apple_transactions apple_transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apple_transactions
    ADD CONSTRAINT apple_transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: aurapay_payments aurapay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aurapay_payments
    ADD CONSTRAINT aurapay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: aurapay_payments aurapay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aurapay_payments
    ADD CONSTRAINT aurapay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: broadcast_history broadcast_history_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_history
    ADD CONSTRAINT broadcast_history_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: button_click_logs button_click_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.button_click_logs
    ADD CONSTRAINT button_click_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: cabinet_refresh_tokens cabinet_refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet_refresh_tokens
    ADD CONSTRAINT cabinet_refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cloudpayments_payments cloudpayments_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloudpayments_payments
    ADD CONSTRAINT cloudpayments_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: cloudpayments_payments cloudpayments_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloudpayments_payments
    ADD CONSTRAINT cloudpayments_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contest_attempts contest_attempts_round_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_attempts
    ADD CONSTRAINT contest_attempts_round_id_fkey FOREIGN KEY (round_id) REFERENCES public.contest_rounds(id) ON DELETE CASCADE;


--
-- Name: contest_attempts contest_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_attempts
    ADD CONSTRAINT contest_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contest_rounds contest_rounds_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rounds
    ADD CONSTRAINT contest_rounds_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.contest_templates(id) ON DELETE CASCADE;


--
-- Name: cryptobot_payments cryptobot_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptobot_payments
    ADD CONSTRAINT cryptobot_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: cryptobot_payments cryptobot_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptobot_payments
    ADD CONSTRAINT cryptobot_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: discount_offers discount_offers_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_offers
    ADD CONSTRAINT discount_offers_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE SET NULL;


--
-- Name: discount_offers discount_offers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_offers
    ADD CONSTRAINT discount_offers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: donut_payments donut_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donut_payments
    ADD CONSTRAINT donut_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: donut_payments donut_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donut_payments
    ADD CONSTRAINT donut_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: etoplatezhi_payments etoplatezhi_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etoplatezhi_payments
    ADD CONSTRAINT etoplatezhi_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: etoplatezhi_payments etoplatezhi_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etoplatezhi_payments
    ADD CONSTRAINT etoplatezhi_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: freekassa_payments freekassa_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freekassa_payments
    ADD CONSTRAINT freekassa_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: freekassa_payments freekassa_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freekassa_payments
    ADD CONSTRAINT freekassa_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: guest_purchases guest_purchases_buyer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases
    ADD CONSTRAINT guest_purchases_buyer_user_id_fkey FOREIGN KEY (buyer_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: guest_purchases guest_purchases_landing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases
    ADD CONSTRAINT guest_purchases_landing_id_fkey FOREIGN KEY (landing_id) REFERENCES public.landing_pages(id) ON DELETE SET NULL;


--
-- Name: guest_purchases guest_purchases_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases
    ADD CONSTRAINT guest_purchases_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE SET NULL;


--
-- Name: guest_purchases guest_purchases_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_purchases
    ADD CONSTRAINT guest_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: heleket_payments heleket_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heleket_payments
    ADD CONSTRAINT heleket_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: heleket_payments heleket_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heleket_payments
    ADD CONSTRAINT heleket_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: jupiter_payments jupiter_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jupiter_payments
    ADD CONSTRAINT jupiter_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: jupiter_payments jupiter_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jupiter_payments
    ADD CONSTRAINT jupiter_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: kassa_ai_payments kassa_ai_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassa_ai_payments
    ADD CONSTRAINT kassa_ai_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: kassa_ai_payments kassa_ai_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kassa_ai_payments
    ADD CONSTRAINT kassa_ai_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lava_payments lava_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lava_payments
    ADD CONSTRAINT lava_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: lava_payments lava_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lava_payments
    ADD CONSTRAINT lava_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: mulenpay_payments mulenpay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mulenpay_payments
    ADD CONSTRAINT mulenpay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: mulenpay_payments mulenpay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mulenpay_payments
    ADD CONSTRAINT mulenpay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: news_articles news_articles_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.news_categories(id) ON DELETE SET NULL;


--
-- Name: news_articles news_articles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: news_articles news_articles_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.news_tags(id) ON DELETE SET NULL;


--
-- Name: overpay_payments overpay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpay_payments
    ADD CONSTRAINT overpay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: overpay_payments overpay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overpay_payments
    ADD CONSTRAINT overpay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: pal24_payments pal24_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pal24_payments
    ADD CONSTRAINT pal24_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: pal24_payments pal24_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pal24_payments
    ADD CONSTRAINT pal24_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: partner_applications partner_applications_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_applications
    ADD CONSTRAINT partner_applications_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: partner_applications partner_applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_applications
    ADD CONSTRAINT partner_applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payment_method_promo_groups payment_method_promo_groups_payment_method_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method_promo_groups
    ADD CONSTRAINT payment_method_promo_groups_payment_method_config_id_fkey FOREIGN KEY (payment_method_config_id) REFERENCES public.payment_method_configs(id) ON DELETE CASCADE;


--
-- Name: payment_method_promo_groups payment_method_promo_groups_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method_promo_groups
    ADD CONSTRAINT payment_method_promo_groups_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE CASCADE;


--
-- Name: paypear_payments paypear_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypear_payments
    ADD CONSTRAINT paypear_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: paypear_payments paypear_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypear_payments
    ADD CONSTRAINT paypear_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: pinned_messages pinned_messages_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pinned_messages
    ADD CONSTRAINT pinned_messages_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: platega_payments platega_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platega_payments
    ADD CONSTRAINT platega_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: platega_payments platega_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platega_payments
    ADD CONSTRAINT platega_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: poll_answers poll_answers_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.poll_options(id) ON DELETE CASCADE;


--
-- Name: poll_answers poll_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.poll_questions(id) ON DELETE CASCADE;


--
-- Name: poll_answers poll_answers_response_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_response_id_fkey FOREIGN KEY (response_id) REFERENCES public.poll_responses(id) ON DELETE CASCADE;


--
-- Name: poll_options poll_options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_options
    ADD CONSTRAINT poll_options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.poll_questions(id) ON DELETE CASCADE;


--
-- Name: poll_questions poll_questions_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_questions
    ADD CONSTRAINT poll_questions_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: poll_responses poll_responses_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_responses
    ADD CONSTRAINT poll_responses_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: poll_responses poll_responses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_responses
    ADD CONSTRAINT poll_responses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: polls polls_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: promo_offer_logs promo_offer_logs_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_logs
    ADD CONSTRAINT promo_offer_logs_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.discount_offers(id) ON DELETE SET NULL;


--
-- Name: promo_offer_logs promo_offer_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_logs
    ADD CONSTRAINT promo_offer_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: promo_offer_templates promo_offer_templates_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_offer_templates
    ADD CONSTRAINT promo_offer_templates_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: promocode_uses promocode_uses_promocode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocode_uses
    ADD CONSTRAINT promocode_uses_promocode_id_fkey FOREIGN KEY (promocode_id) REFERENCES public.promocodes(id);


--
-- Name: promocode_uses promocode_uses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocode_uses
    ADD CONSTRAINT promocode_uses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: promocodes promocodes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: promocodes promocodes_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE SET NULL;


--
-- Name: promocodes promocodes_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE SET NULL;


--
-- Name: referral_contest_events referral_contest_events_contest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events
    ADD CONSTRAINT referral_contest_events_contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.referral_contests(id) ON DELETE CASCADE;


--
-- Name: referral_contest_events referral_contest_events_referral_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events
    ADD CONSTRAINT referral_contest_events_referral_id_fkey FOREIGN KEY (referral_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: referral_contest_events referral_contest_events_referrer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_events
    ADD CONSTRAINT referral_contest_events_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: referral_contest_virtual_participants referral_contest_virtual_participants_contest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contest_virtual_participants
    ADD CONSTRAINT referral_contest_virtual_participants_contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.referral_contests(id) ON DELETE CASCADE;


--
-- Name: referral_contests referral_contests_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_contests
    ADD CONSTRAINT referral_contests_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: referral_earnings referral_earnings_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings
    ADD CONSTRAINT referral_earnings_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.advertising_campaigns(id) ON DELETE SET NULL;


--
-- Name: referral_earnings referral_earnings_referral_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings
    ADD CONSTRAINT referral_earnings_referral_id_fkey FOREIGN KEY (referral_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: referral_earnings referral_earnings_referral_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings
    ADD CONSTRAINT referral_earnings_referral_transaction_id_fkey FOREIGN KEY (referral_transaction_id) REFERENCES public.transactions(id);


--
-- Name: referral_earnings referral_earnings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_earnings
    ADD CONSTRAINT referral_earnings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: riopay_payments riopay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riopay_payments
    ADD CONSTRAINT riopay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: riopay_payments riopay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riopay_payments
    ADD CONSTRAINT riopay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: rollypay_payments rollypay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rollypay_payments
    ADD CONSTRAINT rollypay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: rollypay_payments rollypay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rollypay_payments
    ADD CONSTRAINT rollypay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: saved_payment_methods saved_payment_methods_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_payment_methods
    ADD CONSTRAINT saved_payment_methods_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sent_notifications sent_notifications_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: sent_notifications sent_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: server_squad_promo_groups server_squad_promo_groups_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_squad_promo_groups
    ADD CONSTRAINT server_squad_promo_groups_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE CASCADE;


--
-- Name: server_squad_promo_groups server_squad_promo_groups_server_squad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_squad_promo_groups
    ADD CONSTRAINT server_squad_promo_groups_server_squad_id_fkey FOREIGN KEY (server_squad_id) REFERENCES public.server_squads(id) ON DELETE CASCADE;


--
-- Name: severpay_payments severpay_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.severpay_payments
    ADD CONSTRAINT severpay_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: severpay_payments severpay_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.severpay_payments
    ADD CONSTRAINT severpay_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: subscription_conversions subscription_conversions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_conversions
    ADD CONSTRAINT subscription_conversions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: subscription_events subscription_events_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_events
    ADD CONSTRAINT subscription_events_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE SET NULL;


--
-- Name: subscription_events subscription_events_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_events
    ADD CONSTRAINT subscription_events_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id) ON DELETE SET NULL;


--
-- Name: subscription_events subscription_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_events
    ADD CONSTRAINT subscription_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: subscription_servers subscription_servers_server_squad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_servers
    ADD CONSTRAINT subscription_servers_server_squad_id_fkey FOREIGN KEY (server_squad_id) REFERENCES public.server_squads(id);


--
-- Name: subscription_servers subscription_servers_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_servers
    ADD CONSTRAINT subscription_servers_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: subscription_temporary_access subscription_temporary_access_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_temporary_access
    ADD CONSTRAINT subscription_temporary_access_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.discount_offers(id) ON DELETE CASCADE;


--
-- Name: subscription_temporary_access subscription_temporary_access_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_temporary_access
    ADD CONSTRAINT subscription_temporary_access_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: subscriptions subscriptions_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE RESTRICT;


--
-- Name: subscriptions subscriptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: support_audit_logs support_audit_logs_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_audit_logs
    ADD CONSTRAINT support_audit_logs_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: support_audit_logs support_audit_logs_target_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_audit_logs
    ADD CONSTRAINT support_audit_logs_target_user_id_fkey FOREIGN KEY (target_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: support_audit_logs support_audit_logs_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_audit_logs
    ADD CONSTRAINT support_audit_logs_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE SET NULL;


--
-- Name: tariff_promo_groups tariff_promo_groups_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_promo_groups
    ADD CONSTRAINT tariff_promo_groups_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE CASCADE;


--
-- Name: tariff_promo_groups tariff_promo_groups_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_promo_groups
    ADD CONSTRAINT tariff_promo_groups_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE CASCADE;


--
-- Name: ticket_messages ticket_messages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_messages ticket_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_messages
    ADD CONSTRAINT ticket_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ticket_notifications ticket_notifications_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_notifications
    ADD CONSTRAINT ticket_notifications_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_notifications ticket_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_notifications
    ADD CONSTRAINT ticket_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: traffic_purchases traffic_purchases_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_purchases
    ADD CONSTRAINT traffic_purchases_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_device_aliases user_device_aliases_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_device_aliases
    ADD CONSTRAINT user_device_aliases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_messages user_messages_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_messages
    ADD CONSTRAINT user_messages_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_promo_groups user_promo_groups_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_promo_groups
    ADD CONSTRAINT user_promo_groups_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE CASCADE;


--
-- Name: user_promo_groups user_promo_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_promo_groups
    ADD CONSTRAINT user_promo_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_promo_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_promo_group_id_fkey FOREIGN KEY (promo_group_id) REFERENCES public.promo_groups(id) ON DELETE RESTRICT;


--
-- Name: users users_referred_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_referred_by_id_fkey FOREIGN KEY (referred_by_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: wata_payments wata_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wata_payments
    ADD CONSTRAINT wata_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: wata_payments wata_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wata_payments
    ADD CONSTRAINT wata_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: webhook_deliveries webhook_deliveries_webhook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_deliveries
    ADD CONSTRAINT webhook_deliveries_webhook_id_fkey FOREIGN KEY (webhook_id) REFERENCES public.webhooks(id) ON DELETE CASCADE;


--
-- Name: welcome_texts welcome_texts_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.welcome_texts
    ADD CONSTRAINT welcome_texts_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: wheel_prizes wheel_prizes_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_prizes
    ADD CONSTRAINT wheel_prizes_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.wheel_configs(id) ON DELETE CASCADE;


--
-- Name: wheel_spins wheel_spins_generated_promocode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT wheel_spins_generated_promocode_id_fkey FOREIGN KEY (generated_promocode_id) REFERENCES public.promocodes(id);


--
-- Name: wheel_spins wheel_spins_prize_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT wheel_spins_prize_id_fkey FOREIGN KEY (prize_id) REFERENCES public.wheel_prizes(id) ON DELETE SET NULL;


--
-- Name: wheel_spins wheel_spins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT wheel_spins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: withdrawal_requests withdrawal_requests_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: withdrawal_requests withdrawal_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: yandex_client_id_map yandex_client_id_map_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yandex_client_id_map
    ADD CONSTRAINT yandex_client_id_map_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: yookassa_payments yookassa_payments_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yookassa_payments
    ADD CONSTRAINT yookassa_payments_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: yookassa_payments yookassa_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yookassa_payments
    ADD CONSTRAINT yookassa_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict UwPUlqjCPvvNJoheupLBQDDpFZkOgN057ZfDx9pU671nuxppclH8y6h4aNj3PNo

