set search_path to glob_asf
CREATE SEQUENCE IF NOT EXISTS action_action_id_seq
    AS bigint
    START WITH 20
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    NO CYCLE;

SELECT pg_catalog.setval('action_action_id_seq', 19, true);


CREATE TABLE action (
    action_id integer NOT NULL DEFAULT nextval('action_action_id_seq'::regclass),
    name character varying(100) NOT NULL,
    description character varying(255),
    application_cd character varying(3) NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (action_id)
);

CREATE TABLE app_user (
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
    is_active boolean NOT NULL DEFAULT false,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_cd)
);

CREATE TABLE application (
    application_cd character varying(3) NOT NULL,
    description character varying(150),
    requires_2fa boolean,
    pin_validity_minutes integer,
    is_active boolean NOT NULL DEFAULT true,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    application_owner character varying(50) NOT NULL,	
    PRIMARY KEY (application_cd)
);

CREATE TABLE role_action (
    role_id integer NOT NULL,
    action_id integer NOT NULL,
    is_active boolean,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id, action_id)
);

CREATE SEQUENCE IF NOT EXISTS role_plant_role_id_seq
    AS bigint
    START WITH 22
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    NO CYCLE;

SELECT pg_catalog.setval('role_plant_role_id_seq', 21, true);

CREATE TABLE role_plant (
    role_id integer NOT NULL DEFAULT nextval('role_plant_role_id_seq'::regclass),
    role_name character varying(100) NOT NULL,
    plant_cd character varying(10),
    application_cd character varying(3) NOT NULL,
    description character varying(255),
    is_active boolean NOT NULL DEFAULT true,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id)
);

CREATE TABLE user_allowed_plant (
    user_cd character varying(50) NOT NULL,
    plant_cd character varying(10) NOT NULL,
    is_active boolean NOT NULL DEFAULT false,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_cd, plant_cd)
);

CREATE TABLE user_role (
	UID_id uuid NOT NULL,
    user_cd character varying(50) NOT NULL,
    role_id integer NOT NULL,
    is_active boolean,
    created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_edit_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    can_assign boolean,
    can_change_actions boolean,
    PRIMARY KEY (user_cd, role_id)
);

