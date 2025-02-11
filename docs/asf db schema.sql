--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: asf; Type: SCHEMA; Schema: -; Owner: mes
--

CREATE SCHEMA asf;


ALTER SCHEMA asf OWNER TO mes;

--
-- Name: action_action_id_seq; Type: SEQUENCE; Schema: asf; Owner: mes
--

CREATE SEQUENCE asf.action_action_id_seq
    START WITH 20
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE asf.action_action_id_seq OWNER TO mes;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.action (
    action_id integer DEFAULT nextval('asf.action_action_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255),
    application_cd character varying(3) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE asf.action OWNER TO mes;

--
-- Name: app_user; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.app_user (
    user_cd character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100),
    phone text,
    language_cd character varying(10) NOT NULL,
    default_plant_cd character varying(10) NOT NULL,
    certification_bytes bytea,
    certification_password text,
    certification_valid_start timestamp with time zone,
    certification_valid_end timestamp with time zone,
    badge_code character varying(1000),
    pin text,
    pin_set_date timestamp with time zone,
    pin_expiration_date timestamp with time zone,
    is_active boolean DEFAULT false NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE asf.app_user OWNER TO mes;

--
-- Name: application; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.application (
    application_cd character varying(3) NOT NULL,
    description character varying(150),
    requires_2fa boolean,
    pin_validity_minutes integer,
    is_active boolean DEFAULT true NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    application_owner character varying(50) NOT NULL
);


ALTER TABLE asf.application OWNER TO mes;

--
-- Name: role_action; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.role_action (
    role_id integer NOT NULL,
    action_id integer NOT NULL,
    is_active boolean,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE asf.role_action OWNER TO mes;

--
-- Name: role_plant_role_id_seq; Type: SEQUENCE; Schema: asf; Owner: mes
--

CREATE SEQUENCE asf.role_plant_role_id_seq
    START WITH 22
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE asf.role_plant_role_id_seq OWNER TO mes;

--
-- Name: role_plant; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.role_plant (
    role_id integer DEFAULT nextval('asf.role_plant_role_id_seq'::regclass) NOT NULL,
    role_name character varying(100) NOT NULL,
    plant_cd character varying(10),
    application_cd character varying(3) NOT NULL,
    description character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE asf.role_plant OWNER TO mes;

--
-- Name: user_allowed_plant; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.user_allowed_plant (
    user_cd character varying(50) NOT NULL,
    plant_cd character varying(10) NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE asf.user_allowed_plant OWNER TO mes;

--
-- Name: user_role; Type: TABLE; Schema: asf; Owner: mes
--

CREATE TABLE asf.user_role (
    uid_id uuid NOT NULL,
    user_cd character varying(50) NOT NULL,
    role_id integer NOT NULL,
    is_active boolean,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_edit_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    can_assign boolean,
    can_change_actions boolean
);


ALTER TABLE asf.user_role OWNER TO mes;

--
-- Name: action_action_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.action_action_id_seq
    START WITH 20
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.action_action_id_seq OWNER TO postgres;

--
-- Name: action action_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.action
    ADD CONSTRAINT action_pkey PRIMARY KEY (action_id);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (user_cd);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (application_cd);


--
-- Name: role_action role_action_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.role_action
    ADD CONSTRAINT role_action_pkey PRIMARY KEY (role_id, action_id);


--
-- Name: role_plant role_plant_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.role_plant
    ADD CONSTRAINT role_plant_pkey PRIMARY KEY (role_id);


--
-- Name: user_allowed_plant user_allowed_plant_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.user_allowed_plant
    ADD CONSTRAINT user_allowed_plant_pkey PRIMARY KEY (user_cd, plant_cd);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_cd, role_id);


--
-- Name: action fk_action_applicationcd; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.action
    ADD CONSTRAINT fk_action_applicationcd FOREIGN KEY (application_cd) REFERENCES asf.application(application_cd);


--
-- Name: role_plant fk_approle_applicationcd; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.role_plant
    ADD CONSTRAINT fk_approle_applicationcd FOREIGN KEY (application_cd) REFERENCES asf.application(application_cd);


--
-- Name: role_action fk_roleaction_actionid; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.role_action
    ADD CONSTRAINT fk_roleaction_actionid FOREIGN KEY (action_id) REFERENCES asf.action(action_id);


--
-- Name: role_action fk_roleaction_roleid; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.role_action
    ADD CONSTRAINT fk_roleaction_roleid FOREIGN KEY (role_id) REFERENCES asf.role_plant(role_id);


--
-- Name: user_allowed_plant fk_user_allowed_plant_appuser; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.user_allowed_plant
    ADD CONSTRAINT fk_user_allowed_plant_appuser FOREIGN KEY (user_cd) REFERENCES asf.app_user(user_cd);


--
-- Name: user_role fk_userrole_roleid; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.user_role
    ADD CONSTRAINT fk_userrole_roleid FOREIGN KEY (role_id) REFERENCES asf.role_plant(role_id);


--
-- Name: user_role fk_userrole_usercd; Type: FK CONSTRAINT; Schema: asf; Owner: mes
--

ALTER TABLE ONLY asf.user_role
    ADD CONSTRAINT fk_userrole_usercd FOREIGN KEY (user_cd) REFERENCES asf.app_user(user_cd);


--
-- PostgreSQL database dump complete
--

