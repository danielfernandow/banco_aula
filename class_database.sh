#!/bin/bash

# Este script foi projetado para ser executado DENTRO de um container Docker do PostgreSQL.
# Ele assume que está sendo executado pelo usuário 'postgres' e irá importar
# a estrutura para um banco de dados especificado pelo usuário.

echo "🚀 Gerando arquivo de estrutura SQL dentro do container..."

# --- Cria o arquivo SQL com a estrutura do banco no diretório /tmp ---
cat > /tmp/estrutura_aula.sql << 'EOF'
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Debian 14.18-1.pgdg120+1)
-- Dumped by pg_dump version 14.18 (Debian 14.18-1.pgdg120+1)

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

--
-- Name: insere_followup_control(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insere_followup_control() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  intervalo INTEGER := 1;  -- valor padrão
BEGIN
  -- Tenta buscar intervalo_dias na config
  SELECT intervalo_dias INTO intervalo FROM config WHERE id = 1;

  -- Se não encontrar (NULL), mantém o padrão 1
  IF intervalo IS NULL THEN
    intervalo := 1;
  END IF;

  -- Insere o registro na tabela followup_control
  INSERT INTO followup_control (
    lead_id,
    tentativa_atual,
    proximo_followup_em,
    status,
    created_at,
    updated_at
  ) VALUES (
    NEW.id,
    1,
    NOW() + (intervalo || ' days')::interval,
    'ativo',
    NOW(),
    NOW()
  );

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.insere_followup_control() OWNER TO postgres;

--
-- Name: update_atualizado_em(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_atualizado_em() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.atualizado_em := NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_atualizado_em() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Atualiza o campo updated_at para o timestamp atual em UTC-3 (America/Sao_Paulo)
  NEW.updated_at := (CURRENT_TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo');
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agendamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agendamentos (
    id integer NOT NULL,
    lead_id integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    status character varying(50) DEFAULT 'agendado'::character varying,
    criado_em timestamp without time zone DEFAULT now(),
    atualizado_em timestamp without time zone DEFAULT now(),
    notificacao_01 boolean DEFAULT false,
    notificacao_02 boolean DEFAULT false,
    id_evento character varying(50)
);


ALTER TABLE public.agendamentos OWNER TO postgres;

--
-- Name: agendamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agendamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agendamentos_id_seq OWNER TO postgres;

--
-- Name: agendamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agendamentos_id_seq OWNED BY public.agendamentos.id;


--
-- Name: config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config (
    id integer NOT NULL,
    max_tentativas integer DEFAULT 5 NOT NULL,
    intervalo_dias integer DEFAULT 3 NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    prompt text,
    exemplos text,
    faq text,
    url_whatsapp character varying(50)
);


ALTER TABLE public.config OWNER TO postgres;

--
-- Name: config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.config_id_seq OWNER TO postgres;

--
-- Name: config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.config_id_seq OWNED BY public.config.id;


--
-- Name: followup_control; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followup_control (
    id integer NOT NULL,
    lead_id integer NOT NULL,
    tentativa_atual integer DEFAULT 1,
    proximo_followup_em timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'ativo'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.followup_control OWNER TO postgres;

--
-- Name: followup_control_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.followup_control_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.followup_control_id_seq OWNER TO postgres;

--
-- Name: followup_control_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.followup_control_id_seq OWNED BY public.followup_control.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(50) NOT NULL,
    qualificado boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.leads OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leads_id_seq OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nome character varying(255),
    telefone character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    email character varying(50)
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


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: agendamentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos ALTER COLUMN id SET DEFAULT nextval('public.agendamentos_id_seq'::regclass);


--
-- Name: config id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config ALTER COLUMN id SET DEFAULT nextval('public.config_id_seq'::regclass);


--
-- Name: followup_control id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followup_control ALTER COLUMN id SET DEFAULT nextval('public.followup_control_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: agendamentos agendamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_pkey PRIMARY KEY (id);


--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- Name: followup_control followup_control_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followup_control
    ADD CONSTRAINT followup_control_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: leads trg_insere_followup_control; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_insere_followup_control AFTER INSERT ON public.leads FOR EACH ROW EXECUTE FUNCTION public.insere_followup_control();


--
-- Name: agendamentos trg_update_atualizado_em_agendamentos; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_atualizado_em_agendamentos BEFORE UPDATE ON public.agendamentos FOR EACH ROW EXECUTE FUNCTION public.update_atualizado_em();


--
-- Name: config trg_update_updated_at_config; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_updated_at_config BEFORE UPDATE ON public.config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: followup_control trg_update_updated_at_followup_control; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_updated_at_followup_control BEFORE UPDATE ON public.followup_control FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: leads trg_update_updated_at_leads; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_updated_at_leads BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: agendamentos agendamentos_lead_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.leads(id) ON DELETE CASCADE;


--
-- Name: followup_control followup_control_lead_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followup_control
    ADD CONSTRAINT followup_control_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.leads(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
EOF

# --- Coleta de dados do usuário ---
# Pede apenas o nome do banco, pois as outras credenciais não são necessárias dentro do container.
read -p "Digite o nome do banco de dados ALVO (deve existir): " DB_NAME
while [ -z "$DB_NAME" ]; do
  echo "O nome do banco de dados não pode ser vazio."
  read -p "Digite o nome do banco de dados ALVO (deve existir): " DB_NAME
done

echo "⏳ Importando estrutura para o banco '$DB_NAME'. Aguarde..."

# Executa psql sem host, usuário ou senha, pois está sendo executado localmente como usuário postgres.
psql -v ON_ERROR_STOP=1 -d "$DB_NAME" < /tmp/estrutura_aula.sql

# Verifica se o comando anterior foi executado com sucesso
if [ $? -eq 0 ]; then
  echo "✅ Estrutura do banco de dados importada com sucesso!"
else
  echo "❌ Falha ao importar a estrutura. Verifique se o banco '$DB_NAME' existe e se você tem permissão."
fi

# --- Limpeza ---
rm /tmp/estrutura_aula.sql
echo "🧹 Limpeza concluída."

