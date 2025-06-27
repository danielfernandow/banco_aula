#!/bin/bash
echo "🚀 Importando estrutura do banco da aula..."

# Criar estrutura
cat > estrutura_aula.sql << 'EOF'
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
-- Name: clean_phone_number(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clean_phone_number(phone_input text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    cleaned_phone TEXT;
    phone_length INTEGER;
BEGIN
    -- Se o input for NULL ou vazio, retornar NULL
    IF phone_input IS NULL OR TRIM(phone_input) = '' THEN
        RETURN NULL;
    END IF;
    
    -- Remover todos os caracteres não numéricos
    cleaned_phone := REGEXP_REPLACE(phone_input, '[^0-9]', '', 'g');
    phone_length := LENGTH(cleaned_phone);
    
    -- Se já começa com 55, remover para reprocessar
    IF LEFT(cleaned_phone, 2) = '55' THEN
        cleaned_phone := SUBSTRING(cleaned_phone, 3);
        phone_length := LENGTH(cleaned_phone);
    END IF;
    
    -- Agora processar o número sem o 55
    CASE 
        -- Se tem 11 dígitos: DDD + 9 + 8 dígitos (remover o 9 extra)
        WHEN phone_length = 11 AND SUBSTRING(cleaned_phone, 3, 1) = '9' THEN
            cleaned_phone := SUBSTRING(cleaned_phone, 1, 2) || SUBSTRING(cleaned_phone, 4);
            
        -- Se tem 10 dígitos: DDD + 8 dígitos (já está correto)
        WHEN phone_length = 10 THEN
            -- Já está no formato correto
            cleaned_phone := cleaned_phone;
            
        -- Se tem 9 dígitos: pode ser DDD incompleto + número, manter como está
        WHEN phone_length = 9 THEN
            cleaned_phone := cleaned_phone;
            
        -- Outros casos: manter como está
        ELSE
            cleaned_phone := cleaned_phone;
    END CASE;
    
    -- SEMPRE adicionar o 55 no início
    cleaned_phone := '55' || cleaned_phone;
    
    RETURN cleaned_phone;
END;
$$;


ALTER FUNCTION public.clean_phone_number(phone_input text) OWNER TO postgres;

--
-- Name: set_follow_up_docs_pendente_01_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_follow_up_docs_pendente_01_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.follow_up_docs_pendente_01 IS DISTINCT FROM OLD.follow_up_docs_pendente_01
     AND NEW.follow_up_docs_pendente_01 = TRUE THEN
    NEW.follow_up_docs_pendente_01_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_follow_up_docs_pendente_01_at() OWNER TO postgres;

--
-- Name: set_follow_up_docs_pendente_02_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_follow_up_docs_pendente_02_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.follow_up_docs_pendente_02 IS DISTINCT FROM OLD.follow_up_docs_pendente_02
     AND NEW.follow_up_docs_pendente_02 = TRUE THEN
    NEW.follow_up_docs_pendente_02_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_follow_up_docs_pendente_02_at() OWNER TO postgres;

--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
  NEW.updated_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  RETURN NEW;
END;$$;


ALTER FUNCTION public.set_updated_at() OWNER TO postgres;

--
-- Name: update_all_phone_numbers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_all_phone_numbers() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    updated_count INTEGER;
BEGIN
    -- Atualizar todos os números de telefone na tabela
    UPDATE coldlist 
    SET phone = clean_phone_number(phone)
    WHERE phone IS NOT NULL;
    
    -- Pegar o número de linhas afetadas
    GET DIAGNOSTICS updated_count = ROW_COUNT;
    
    RETURN updated_count;
END;
$$;


ALTER FUNCTION public.update_all_phone_numbers() OWNER TO postgres;

--
-- Name: update_event_timestamps(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_event_timestamps() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.material_sent IS DISTINCT FROM OLD.material_sent AND NEW.material_sent = TRUE THEN
    NEW.send_materials_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  IF NEW.send_follow_up_01 IS DISTINCT FROM OLD.send_follow_up_01 AND NEW.send_follow_up_01 = TRUE THEN
    NEW.send_follow_up_01_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  IF NEW.send_follow_up_02 IS DISTINCT FROM OLD.send_follow_up_02 AND NEW.send_follow_up_02 = TRUE THEN
    NEW.send_follow_up_02_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  IF NEW.send_follow_up_03 IS DISTINCT FROM OLD.send_follow_up_03 AND NEW.send_follow_up_03 = TRUE THEN
    NEW.send_follow_up_03_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  IF NEW.approved IS DISTINCT FROM OLD.approved AND NEW.approved = TRUE THEN
    NEW.approved_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  IF NEW.purchased IS DISTINCT FROM OLD.purchased AND NEW.purchased = TRUE THEN
    NEW.purchased_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

IF NEW.send_docs IS DISTINCT FROM OLD.send_docs AND NEW.send_docs = TRUE THEN
    NEW.docs_received_at := (NOW() AT TIME ZONE 'America/Sao_Paulo');
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_event_timestamps() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: coldlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coldlist (
    id integer NOT NULL,
    name character varying(255),
    phone character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    sent boolean DEFAULT false,
    paused boolean DEFAULT false,
    funnel_step integer DEFAULT 1
);


ALTER TABLE public.coldlist OWNER TO postgres;

--
-- Name: coldlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coldlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coldlist_id_seq OWNER TO postgres;

--
-- Name: coldlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coldlist_id_seq OWNED BY public.coldlist.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads (
    id integer NOT NULL,
    name character varying NOT NULL,
    phone_number character varying,
    funnel_step integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    email character varying,
    send_docs boolean DEFAULT false,
    send_follow_up_01 boolean DEFAULT false,
    approved boolean DEFAULT false,
    purchased boolean DEFAULT false,
    status character varying(50) DEFAULT NULL::character varying,
    send_follow_up_02 boolean DEFAULT false,
    send_materials_at timestamp without time zone,
    send_follow_up_01_at timestamp without time zone,
    send_follow_up_02_at timestamp without time zone,
    send_follow_up_03_at timestamp without time zone,
    approved_at timestamp without time zone,
    purchased_at timestamp without time zone,
    send_follow_up_03 boolean DEFAULT false,
    docs_received_at timestamp without time zone,
    material_sent boolean DEFAULT false,
    drive_id character varying(100) DEFAULT NULL::character varying,
    follow_up_docs_pendente_01 boolean DEFAULT false,
    follow_up_docs_pendente_01_at timestamp without time zone,
    paused boolean DEFAULT false,
    ctwaclid character varying(150) DEFAULT NULL::character varying,
    follow_up_docs_pendente_02 boolean DEFAULT false,
    follow_up_docs_pendente_02_at timestamp without time zone
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
-- Name: n8n_chat_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.n8n_chat_histories (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    message jsonb NOT NULL
);


ALTER TABLE public.n8n_chat_histories OWNER TO postgres;

--
-- Name: n8n_chat_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.n8n_chat_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.n8n_chat_histories_id_seq OWNER TO postgres;

--
-- Name: n8n_chat_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.n8n_chat_histories_id_seq OWNED BY public.n8n_chat_histories.id;


--
-- Name: coldlist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coldlist ALTER COLUMN id SET DEFAULT nextval('public.coldlist_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: n8n_chat_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.n8n_chat_histories ALTER COLUMN id SET DEFAULT nextval('public.n8n_chat_histories_id_seq'::regclass);


--
-- Name: coldlist coldlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coldlist
    ADD CONSTRAINT coldlist_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: n8n_chat_histories n8n_chat_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.n8n_chat_histories
    ADD CONSTRAINT n8n_chat_histories_pkey PRIMARY KEY (id);


--
-- Name: leads trg_set_follow_up_docs_pendente_01_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_follow_up_docs_pendente_01_at BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.set_follow_up_docs_pendente_01_at();


--
-- Name: leads trg_set_follow_up_docs_pendente_02_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_follow_up_docs_pendente_02_at BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.set_follow_up_docs_pendente_02_at();


--
-- Name: leads trg_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_updated_at BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: leads trg_update_event_timestamps; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_event_timestamps BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.update_event_timestamps();


--
-- PostgreSQL database dump complete
--
EOF

echo "🔍 Detectando PostgreSQL..."

# Tentar conectar com configurações padrão mais comuns
CONFIGS=(
    "localhost:5432:postgres:postgres"
    "localhost:5432:postgres:root" 
    "localhost:5433:postgres:postgres"
    "127.0.0.1:5432:postgres:postgres"
)

SUCCESS=false

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r host porta usuario database <<< "$config"
    
    echo "🔧 Tentando: $host:$porta com usuário $usuario..."
    
    # Testar conexão (sem senha primeiro)
    if PGPASSWORD="" psql -h $host -p $porta -U $usuario -d $database -c "\q" 2>/dev/null; then
        echo "✅ Conectado! Importando estrutura..."
        PGPASSWORD="" psql -h $host -p $porta -U $usuario -d $database < estrutura_aula.sql
        SUCCESS=true
        break
    fi
    
    # Testar com senhas comuns
    for senha in "postgres" "root" "123456" ""; do
        if PGPASSWORD="$senha" psql -h $host -p $porta -U $usuario -d $database -c "\q" 2>/dev/null; then
            echo "✅ Conectado com senha! Importando estrutura..."
            PGPASSWORD="$senha" psql -h $host -p $porta -U $usuario -d $database < estrutura_aula.sql
            SUCCESS=true
            break 2
        fi
    done
done

if [ "$SUCCESS" = true ]; then
    echo "🎉 Estrutura importada com sucesso!"
    echo "📊 Suas tabelas estão prontas para uso!"
else
    echo "❌ Não consegui conectar automaticamente."
    echo "📋 Execute manualmente:"
    echo "   psql -h localhost -U seu_usuario -d seu_banco < estrutura_aula.sql"
fi
