CREATE SCHEMA alarmprinter
    AUTHORIZATION alarmprinter;

CREATE SEQUENCE alarmprinter.seq_id
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
GRANT ALL ON SEQUENCE alarmprinter.seq_id TO alarmprinter;    

CREATE TABLE alarmprinter.alarmprinter
(
  id bigint NOT NULL DEFAULT nextval('alarmprinter.seq_id'::regclass),
  printerdt timestamp without time zone,
  alarmdt timestamp without time zone,
  state character varying(64),
  class character varying(64),
  type character varying(64),
  priority character varying(64),
  name character varying(64),
  alarmgroup character varying(64),
  provider character varying(64),
  value character varying(32),
  valuelimit character varying(32),
  node character varying(64),
  operator character varying(16),
  comment character varying(131),
  user1 character varying(16),
  user2 character varying(16),
  user3 character varying(131),
  CONSTRAINT pk_alarmprinter PRIMARY KEY (id)
);

GRANT ALL ON TABLE alarmprinter.alarmprinter TO alarmprinter;
