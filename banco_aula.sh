{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 HelveticaNeue;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red89\green138\blue67;\red24\green24\blue24;
\red193\green193\blue193;\red70\green137\blue204;\red202\green202\blue202;\red167\green197\blue152;\red194\green126\blue101;
\red212\green214\blue154;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c41569\c60000\c33333;\cssrgb\c12157\c12157\c12157;
\cssrgb\c80000\c80000\c80000;\cssrgb\c33725\c61176\c83922;\cssrgb\c83137\c83137\c83137;\cssrgb\c70980\c80784\c65882;\cssrgb\c80784\c56863\c47059;
\cssrgb\c86275\c86275\c66667;}
\margl1440\margr1440\vieww50700\viewh19680\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf0 \expnd0\expndtw0\kerning0
#!/bin/bash\
echo "\uc0\u55357 \u56960  Importando estrutura do banco da aula..."\
\
# Criar estrutura\
cat > estrutura_aula.sql << 'EOF'\
\
\pard\pardeftab720\partightenfactor0

\f1\fs24 \cf3 \cb4 \outl0\strokewidth0 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- PostgreSQL database dump\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf3 \cb4 \strokec3 -- Dumped from database version 14.18 (Debian 14.18-1.pgdg120+1)\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Dumped by pg_dump version 14.18 (Debian 14.18-1.pgdg120+1)\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  statement_timeout \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 0\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  \cf6 \strokec6 lock_timeout\cf5 \strokec5  \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 0\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  idle_in_transaction_session_timeout \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 0\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  client_encoding \cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 'UTF8'\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  standard_conforming_strings \cf7 \strokec7 =\cf5 \strokec5  \cf6 \strokec6 on\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 SELECT\cf5 \strokec5  pg_catalog.set_config(\cf9 \strokec9 'search_path'\cf5 \strokec5 , \cf9 \strokec9 ''\cf5 \strokec5 , false);\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  check_function_bodies \cf7 \strokec7 =\cf5 \strokec5  false;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  xmloption \cf7 \strokec7 =\cf5 \strokec5  content;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  client_min_messages \cf7 \strokec7 =\cf5 \strokec5  warning;\cb1 \
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  row_security \cf7 \strokec7 =\cf5 \strokec5  \cf6 \strokec6 off\cf5 \strokec5 ;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: clean_phone_number(text); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .clean_phone_number(phone_input \cf6 \strokec6 text\cf5 \strokec5 ) \cf6 \strokec6 RETURNS\cf5 \strokec5  \cf6 \strokec6 text\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cb1 \
\cf6 \cb4 \strokec6 DECLARE\cf5 \cb1 \strokec5 \
\cb4     cleaned_phone \cf6 \strokec6 TEXT\cf5 \strokec5 ;\cb1 \
\cb4     phone_length \cf6 \strokec6 INTEGER\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4     \cf3 \strokec3 -- Se o input for NULL ou vazio, retornar NULL\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 IF\cf5 \strokec5  phone_input \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 NULL\cf5 \strokec5  \cf6 \strokec6 OR\cf5 \strokec5  \cf10 \strokec10 TRIM\cf5 \strokec5 (phone_input) \cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 ''\cf5 \strokec5  \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4         \cf6 \strokec6 RETURN\cf5 \strokec5  \cf6 \strokec6 NULL\cf5 \strokec5 ;\cb1 \
\cb4     \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\cb4     \cb1 \
\cb4     \cf3 \strokec3 -- Remover todos os caracteres n\'e3o num\'e9ricos\cf5 \cb1 \strokec5 \
\cb4     cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  REGEXP_REPLACE(phone_input, \cf9 \strokec9 '[^0-9]'\cf5 \strokec5 , \cf9 \strokec9 ''\cf5 \strokec5 , \cf9 \strokec9 'g'\cf5 \strokec5 );\cb1 \
\cb4     phone_length :\cf7 \strokec7 =\cf5 \strokec5  \cf6 \strokec6 LENGTH\cf5 \strokec5 (cleaned_phone);\cb1 \
\cb4     \cb1 \
\cb4     \cf3 \strokec3 -- Se j\'e1 come\'e7a com 55, remover para reprocessar\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 IF\cf5 \strokec5  \cf10 \strokec10 LEFT\cf5 \strokec5 (cleaned_phone, \cf8 \strokec8 2\cf5 \strokec5 ) \cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 '55'\cf5 \strokec5  \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4         cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  \cf10 \strokec10 SUBSTRING\cf5 \strokec5 (cleaned_phone, \cf8 \strokec8 3\cf5 \strokec5 );\cb1 \
\cb4         phone_length :\cf7 \strokec7 =\cf5 \strokec5  \cf6 \strokec6 LENGTH\cf5 \strokec5 (cleaned_phone);\cb1 \
\cb4     \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\cb4     \cb1 \
\cb4     \cf3 \strokec3 -- Agora processar o n\'famero sem o 55\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 CASE\cf5 \strokec5  \cb1 \
\cb4         \cf3 \strokec3 -- Se tem 11 d\'edgitos: DDD + 9 + 8 d\'edgitos (remover o 9 extra)\cf5 \cb1 \strokec5 \
\cb4         \cf6 \strokec6 WHEN\cf5 \strokec5  phone_length \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 11\cf5 \strokec5  \cf6 \strokec6 AND\cf5 \strokec5  \cf10 \strokec10 SUBSTRING\cf5 \strokec5 (cleaned_phone, \cf8 \strokec8 3\cf5 \strokec5 , \cf8 \strokec8 1\cf5 \strokec5 ) \cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 '9'\cf5 \strokec5  \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4             cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  \cf10 \strokec10 SUBSTRING\cf5 \strokec5 (cleaned_phone, \cf8 \strokec8 1\cf5 \strokec5 , \cf8 \strokec8 2\cf5 \strokec5 ) \cf7 \strokec7 ||\cf5 \strokec5  \cf10 \strokec10 SUBSTRING\cf5 \strokec5 (cleaned_phone, \cf8 \strokec8 4\cf5 \strokec5 );\cb1 \
\cb4             \cb1 \
\cb4         \cf3 \strokec3 -- Se tem 10 d\'edgitos: DDD + 8 d\'edgitos (j\'e1 est\'e1 correto)\cf5 \cb1 \strokec5 \
\cb4         \cf6 \strokec6 WHEN\cf5 \strokec5  phone_length \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 10\cf5 \strokec5  \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4             \cf3 \strokec3 -- J\'e1 est\'e1 no formato correto\cf5 \cb1 \strokec5 \
\cb4             cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  cleaned_phone;\cb1 \
\cb4             \cb1 \
\cb4         \cf3 \strokec3 -- Se tem 9 d\'edgitos: pode ser DDD incompleto + n\'famero, manter como est\'e1\cf5 \cb1 \strokec5 \
\cb4         \cf6 \strokec6 WHEN\cf5 \strokec5  phone_length \cf7 \strokec7 =\cf5 \strokec5  \cf8 \strokec8 9\cf5 \strokec5  \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4             cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  cleaned_phone;\cb1 \
\cb4             \cb1 \
\cb4         \cf3 \strokec3 -- Outros casos: manter como est\'e1\cf5 \cb1 \strokec5 \
\cb4         \cf6 \strokec6 ELSE\cf5 \cb1 \strokec5 \
\cb4             cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  cleaned_phone;\cb1 \
\cb4     \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 CASE\cf5 \strokec5 ;\cb1 \
\cb4     \cb1 \
\cb4     \cf3 \strokec3 -- SEMPRE adicionar o 55 no in\'edcio\cf5 \cb1 \strokec5 \
\cb4     cleaned_phone :\cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 '55'\cf5 \strokec5  \cf7 \strokec7 ||\cf5 \strokec5  cleaned_phone;\cb1 \
\cb4     \cb1 \
\cb4     \cf6 \strokec6 RETURN\cf5 \strokec5  cleaned_phone;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;\cb1 \
\cb4 $$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.clean_phone_number(phone_input \cf6 \strokec6 text\cf5 \strokec5 ) \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: set_follow_up_docs_pendente_01_at(); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .set_follow_up_docs_pendente_01_at() \cf6 \strokec6 RETURNS\cf5 \strokec5  trigger\cb1 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cb1 \
\cf6 \cb4 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.follow_up_docs_pendente_01 \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.follow_up_docs_pendente_01\cb1 \
\cb4      \cf6 \strokec6 AND\cf5 \strokec5  NEW.follow_up_docs_pendente_01 \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.follow_up_docs_pendente_01_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\cb4   \cf6 \strokec6 RETURN\cf5 \strokec5  NEW;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;\cb1 \
\cb4 $$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_follow_up_docs_pendente_01_at() \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: set_follow_up_docs_pendente_02_at(); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .set_follow_up_docs_pendente_02_at() \cf6 \strokec6 RETURNS\cf5 \strokec5  trigger\cb1 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cb1 \
\cf6 \cb4 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.follow_up_docs_pendente_02 \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.follow_up_docs_pendente_02\cb1 \
\cb4      \cf6 \strokec6 AND\cf5 \strokec5  NEW.follow_up_docs_pendente_02 \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.follow_up_docs_pendente_02_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\cb4   \cf6 \strokec6 RETURN\cf5 \strokec5  NEW;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;\cb1 \
\cb4 $$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_follow_up_docs_pendente_02_at() \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .set_updated_at() \cf6 \strokec6 RETURNS\cf5 \strokec5  trigger\cb1 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cf6 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4   NEW.updated_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 RETURN\cf5 \strokec5  NEW;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;$$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_updated_at() \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: update_all_phone_numbers(); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .update_all_phone_numbers() \cf6 \strokec6 RETURNS\cf5 \strokec5  \cf6 \strokec6 integer\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cb1 \
\cf6 \cb4 \strokec6 DECLARE\cf5 \cb1 \strokec5 \
\cb4     updated_count \cf6 \strokec6 INTEGER\cf5 \strokec5 ;\cb1 \
\cf6 \cb4 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4     \cf3 \strokec3 -- Atualizar todos os n\'fameros de telefone na tabela\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 UPDATE\cf5 \strokec5  coldlist \cb1 \
\cb4     \cf6 \strokec6 SET\cf5 \strokec5  phone \cf7 \strokec7 =\cf5 \strokec5  clean_phone_number(phone)\cb1 \
\cb4     \cf6 \strokec6 WHERE\cf5 \strokec5  phone \cf6 \strokec6 IS NOT NULL\cf5 \strokec5 ;\cb1 \
\cb4     \cb1 \
\cb4     \cf3 \strokec3 -- Pegar o n\'famero de linhas afetadas\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 GET\cf5 \strokec5  DIAGNOSTICS updated_count \cf7 \strokec7 =\cf5 \strokec5  ROW_COUNT;\cb1 \
\cb4     \cb1 \
\cb4     \cf6 \strokec6 RETURN\cf5 \strokec5  updated_count;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;\cb1 \
\cb4 $$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.update_all_phone_numbers() \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: update_event_timestamps(); Type: FUNCTION; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .update_event_timestamps() \cf6 \strokec6 RETURNS\cf5 \strokec5  trigger\cb1 \
\cb4     \cf6 \strokec6 LANGUAGE\cf5 \strokec5  plpgsql\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  $$\cb1 \
\cf6 \cb4 \strokec6 BEGIN\cf5 \cb1 \strokec5 \
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.material_sent \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.material_sent \cf6 \strokec6 AND\cf5 \strokec5  NEW.material_sent \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.send_materials_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.send_follow_up_01 \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.send_follow_up_01 \cf6 \strokec6 AND\cf5 \strokec5  NEW.send_follow_up_01 \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.send_follow_up_01_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.send_follow_up_02 \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.send_follow_up_02 \cf6 \strokec6 AND\cf5 \strokec5  NEW.send_follow_up_02 \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.send_follow_up_02_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.send_follow_up_03 \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.send_follow_up_03 \cf6 \strokec6 AND\cf5 \strokec5  NEW.send_follow_up_03 \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.send_follow_up_03_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.approved \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.approved \cf6 \strokec6 AND\cf5 \strokec5  NEW.approved \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.approved_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 IF\cf5 \strokec5  NEW.purchased \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.purchased \cf6 \strokec6 AND\cf5 \strokec5  NEW.purchased \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.purchased_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cf6 \cb4 \strokec6 IF\cf5 \strokec5  NEW.send_docs \cf6 \strokec6 IS\cf5 \strokec5  \cf6 \strokec6 DISTINCT\cf5 \strokec5  \cf6 \strokec6 FROM\cf5 \strokec5  OLD.send_docs \cf6 \strokec6 AND\cf5 \strokec5  NEW.send_docs \cf7 \strokec7 =\cf5 \strokec5  TRUE \cf6 \strokec6 THEN\cf5 \cb1 \strokec5 \
\cb4     NEW.docs_received_at :\cf7 \strokec7 =\cf5 \strokec5  (\cf6 \strokec6 NOW\cf5 \strokec5 () \cf6 \strokec6 AT\cf5 \strokec5  \cf6 \strokec6 TIME\cf5 \strokec5  \cf6 \strokec6 ZONE\cf5 \strokec5  \cf9 \strokec9 'America/Sao_Paulo'\cf5 \strokec5 );\cb1 \
\cb4   \cf6 \strokec6 END\cf5 \strokec5  \cf6 \strokec6 IF\cf5 \strokec5 ;\cb1 \
\
\cb4   \cf6 \strokec6 RETURN\cf5 \strokec5  NEW;\cb1 \
\cf6 \cb4 \strokec6 END\cf5 \strokec5 ;\cb1 \
\cb4 $$;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.update_event_timestamps() \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  default_tablespace \cf7 \strokec7 =\cf5 \strokec5  \cf9 \strokec9 ''\cf5 \strokec5 ;\cb1 \
\
\cf6 \cb4 \strokec6 SET\cf5 \strokec5  default_table_access_method \cf7 \strokec7 =\cf5 \strokec5  heap;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: coldlist; Type: TABLE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .coldlist (\cb1 \
\cb4     id \cf6 \strokec6 integer\cf5 \strokec5  \cf6 \strokec6 NOT NULL\cf5 \strokec5 ,\cb1 \
\cb4     \cf6 \strokec6 name\cf5 \strokec5  \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 255\cf5 \strokec5 ),\cb1 \
\cb4     phone \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 50\cf5 \strokec5 ),\cb1 \
\cb4     created_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 now\cf5 \strokec5 (),\cb1 \
\cb4     \cf6 \strokec6 sent\cf5 \strokec5  \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     paused \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     funnel_step \cf6 \strokec6 integer\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4 );\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.coldlist \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: coldlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .coldlist_id_seq\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  \cf6 \strokec6 integer\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 START\cf5 \strokec5  \cf6 \strokec6 WITH\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     INCREMENT \cf6 \strokec6 BY\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MINVALUE\cb1 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MAXVALUE\cb1 \
\cb4     CACHE \cf8 \strokec8 1\cf5 \strokec5 ;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.coldlist_id_seq \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: coldlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  public.coldlist_id_seq OWNED \cf6 \strokec6 BY\cf5 \strokec5  public.coldlist.id;\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads; Type: TABLE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .leads (\cb1 \
\cb4     id \cf6 \strokec6 integer\cf5 \strokec5  \cf6 \strokec6 NOT NULL\cf5 \strokec5 ,\cb1 \
\cb4     \cf6 \strokec6 name\cf5 \strokec5  \cf6 \strokec6 character\cf5 \strokec5  varying \cf6 \strokec6 NOT NULL\cf5 \strokec5 ,\cb1 \
\cb4     phone_number \cf6 \strokec6 character\cf5 \strokec5  varying,\cb1 \
\cb4     funnel_step \cf6 \strokec6 integer\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf8 \strokec8 1\cf5 \strokec5 ,\cb1 \
\cb4     created_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 now\cf5 \strokec5 (),\cb1 \
\cb4     updated_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 now\cf5 \strokec5 (),\cb1 \
\cb4     email \cf6 \strokec6 character\cf5 \strokec5  varying,\cb1 \
\cb4     send_docs \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     send_follow_up_01 \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     approved \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     purchased \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     \cf6 \strokec6 status\cf5 \strokec5  \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 50\cf5 \strokec5 ) \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 NULL\cf5 \strokec5 ::\cf6 \strokec6 character\cf5 \strokec5  varying,\cb1 \
\cb4     send_follow_up_02 \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     send_materials_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     send_follow_up_01_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     send_follow_up_02_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     send_follow_up_03_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     approved_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     purchased_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     send_follow_up_03 \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     docs_received_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     material_sent \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     drive_id \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 100\cf5 \strokec5 ) \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 NULL\cf5 \strokec5 ::\cf6 \strokec6 character\cf5 \strokec5  varying,\cb1 \
\cb4     follow_up_docs_pendente_01 \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     follow_up_docs_pendente_01_at \cf6 \strokec6 timestamp without time zone\cf5 \strokec5 ,\cb1 \
\cb4     paused \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     ctwaclid \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 150\cf5 \strokec5 ) \cf6 \strokec6 DEFAULT\cf5 \strokec5  \cf6 \strokec6 NULL\cf5 \strokec5 ::\cf6 \strokec6 character\cf5 \strokec5  varying,\cb1 \
\cb4     follow_up_docs_pendente_02 \cf6 \strokec6 boolean\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  false,\cb1 \
\cb4     follow_up_docs_pendente_02_at \cf6 \strokec6 timestamp without time zone\cf5 \cb1 \strokec5 \
\cb4 );\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.leads \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .leads_id_seq\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  \cf6 \strokec6 integer\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 START\cf5 \strokec5  \cf6 \strokec6 WITH\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     INCREMENT \cf6 \strokec6 BY\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MINVALUE\cb1 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MAXVALUE\cb1 \
\cb4     CACHE \cf8 \strokec8 1\cf5 \strokec5 ;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.leads_id_seq \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  public.leads_id_seq OWNED \cf6 \strokec6 BY\cf5 \strokec5  public.leads.id;\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: n8n_chat_histories; Type: TABLE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .n8n_chat_histories (\cb1 \
\cb4     id \cf6 \strokec6 integer\cf5 \strokec5  \cf6 \strokec6 NOT NULL\cf5 \strokec5 ,\cb1 \
\cb4     session_id \cf6 \strokec6 character varying\cf5 \strokec5 (\cf8 \strokec8 255\cf5 \strokec5 ) \cf6 \strokec6 NOT NULL\cf5 \strokec5 ,\cb1 \
\cb4     \cf6 \strokec6 message\cf5 \strokec5  jsonb \cf6 \strokec6 NOT NULL\cf5 \cb1 \strokec5 \
\cb4 );\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.n8n_chat_histories \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: n8n_chat_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  \cf10 \strokec10 public\cf5 \strokec5 .n8n_chat_histories_id_seq\cb1 \
\cb4     \cf6 \strokec6 AS\cf5 \strokec5  \cf6 \strokec6 integer\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 START\cf5 \strokec5  \cf6 \strokec6 WITH\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     INCREMENT \cf6 \strokec6 BY\cf5 \strokec5  \cf8 \strokec8 1\cf5 \cb1 \strokec5 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MINVALUE\cb1 \
\cb4     \cf6 \strokec6 NO\cf5 \strokec5  MAXVALUE\cb1 \
\cb4     CACHE \cf8 \strokec8 1\cf5 \strokec5 ;\cb1 \
\
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  public.n8n_chat_histories_id_seq \cf6 \strokec6 OWNER\cf5 \strokec5  \cf6 \strokec6 TO\cf5 \strokec5  postgres;\cb1 \
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: n8n_chat_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 SEQUENCE\cf5 \strokec5  public.n8n_chat_histories_id_seq OWNED \cf6 \strokec6 BY\cf5 \strokec5  public.n8n_chat_histories.id;\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: coldlist id; Type: DEFAULT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.coldlist \cf6 \strokec6 ALTER\cf5 \strokec5  COLUMN id \cf6 \strokec6 SET\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  nextval(\cf9 \strokec9 'public.coldlist_id_seq'\cf5 \strokec5 ::regclass);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads id; Type: DEFAULT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.leads \cf6 \strokec6 ALTER\cf5 \strokec5  COLUMN id \cf6 \strokec6 SET\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  nextval(\cf9 \strokec9 'public.leads_id_seq'\cf5 \strokec5 ::regclass);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: n8n_chat_histories id; Type: DEFAULT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.n8n_chat_histories \cf6 \strokec6 ALTER\cf5 \strokec5  COLUMN id \cf6 \strokec6 SET\cf5 \strokec5  \cf6 \strokec6 DEFAULT\cf5 \strokec5  nextval(\cf9 \strokec9 'public.n8n_chat_histories_id_seq'\cf5 \strokec5 ::regclass);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: coldlist coldlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.coldlist\cb1 \
\cb4     \cf6 \strokec6 ADD\cf5 \strokec5  \cf6 \strokec6 CONSTRAINT\cf5 \strokec5  coldlist_pkey \cf6 \strokec6 PRIMARY KEY\cf5 \strokec5  (id);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.leads\cb1 \
\cb4     \cf6 \strokec6 ADD\cf5 \strokec5  \cf6 \strokec6 CONSTRAINT\cf5 \strokec5  leads_pkey \cf6 \strokec6 PRIMARY KEY\cf5 \strokec5  (id);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: n8n_chat_histories n8n_chat_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 ALTER\cf5 \strokec5  \cf6 \strokec6 TABLE\cf5 \strokec5  ONLY public.n8n_chat_histories\cb1 \
\cb4     \cf6 \strokec6 ADD\cf5 \strokec5  \cf6 \strokec6 CONSTRAINT\cf5 \strokec5  n8n_chat_histories_pkey \cf6 \strokec6 PRIMARY KEY\cf5 \strokec5  (id);\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads trg_set_follow_up_docs_pendente_01_at; Type: TRIGGER; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TRIGGER\cf5 \strokec5  \cf10 \strokec10 trg_set_follow_up_docs_pendente_01_at\cf5 \strokec5  \cf6 \strokec6 BEFORE\cf5 \strokec5  \cf6 \strokec6 UPDATE\cf5 \strokec5  \cf6 \strokec6 ON\cf5 \strokec5  public.leads \cf6 \strokec6 FOR\cf5 \strokec5  EACH \cf6 \strokec6 ROW\cf5 \strokec5  \cf6 \strokec6 EXECUTE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_follow_up_docs_pendente_01_at();\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads trg_set_follow_up_docs_pendente_02_at; Type: TRIGGER; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TRIGGER\cf5 \strokec5  \cf10 \strokec10 trg_set_follow_up_docs_pendente_02_at\cf5 \strokec5  \cf6 \strokec6 BEFORE\cf5 \strokec5  \cf6 \strokec6 UPDATE\cf5 \strokec5  \cf6 \strokec6 ON\cf5 \strokec5  public.leads \cf6 \strokec6 FOR\cf5 \strokec5  EACH \cf6 \strokec6 ROW\cf5 \strokec5  \cf6 \strokec6 EXECUTE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_follow_up_docs_pendente_02_at();\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads trg_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TRIGGER\cf5 \strokec5  \cf10 \strokec10 trg_set_updated_at\cf5 \strokec5  \cf6 \strokec6 BEFORE\cf5 \strokec5  \cf6 \strokec6 UPDATE\cf5 \strokec5  \cf6 \strokec6 ON\cf5 \strokec5  public.leads \cf6 \strokec6 FOR\cf5 \strokec5  EACH \cf6 \strokec6 ROW\cf5 \strokec5  \cf6 \strokec6 EXECUTE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.set_updated_at();\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- Name: leads trg_update_event_timestamps; Type: TRIGGER; Schema: public; Owner: postgres\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\cf6 \cb4 \strokec6 CREATE\cf5 \strokec5  \cf6 \strokec6 TRIGGER\cf5 \strokec5  \cf10 \strokec10 trg_update_event_timestamps\cf5 \strokec5  \cf6 \strokec6 BEFORE\cf5 \strokec5  \cf6 \strokec6 UPDATE\cf5 \strokec5  \cf6 \strokec6 ON\cf5 \strokec5  public.leads \cf6 \strokec6 FOR\cf5 \strokec5  EACH \cf6 \strokec6 ROW\cf5 \strokec5  \cf6 \strokec6 EXECUTE\cf5 \strokec5  \cf6 \strokec6 FUNCTION\cf5 \strokec5  public.update_event_timestamps();\cb1 \
\
\
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 -- PostgreSQL database dump complete\cf5 \cb1 \strokec5 \
\cf3 \cb4 \strokec3 --\cf5 \cb1 \strokec5 \
\
\
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf0 \outl0\strokewidth0 \
\
EOF\
\
echo "\uc0\u55357 \u56589  Detectando PostgreSQL..."\
\
# Tentar conectar com configura\'e7\'f5es padr\'e3o mais comuns\
CONFIGS=(\
    "localhost:5432:postgres:postgres"\
    "localhost:5432:postgres:root" \
    "localhost:5433:postgres:postgres"\
    "127.0.0.1:5432:postgres:postgres"\
)\
\
SUCCESS=false\
\
for config in "$\{CONFIGS[@]\}"; do\
    IFS=':' read -r host porta usuario database <<< "$config"\
    \
    echo "\uc0\u55357 \u56615  Tentando: $host:$porta com usu\'e1rio $usuario..."\
    \
    # Testar conex\'e3o (sem senha primeiro)\
    if PGPASSWORD="" psql -h $host -p $porta -U $usuario -d $database -c "\\q" 2>/dev/null; then\
        echo "\uc0\u9989  Conectado! Importando estrutura..."\
        PGPASSWORD="" psql -h $host -p $porta -U $usuario -d $database < estrutura_aula.sql\
        SUCCESS=true\
        break\
    fi\
    \
    # Testar com senhas comuns\
    for senha in "postgres" "root" "123456" ""; do\
        if PGPASSWORD="$senha" psql -h $host -p $porta -U $usuario -d $database -c "\\q" 2>/dev/null; then\
            echo "\uc0\u9989  Conectado com senha! Importando estrutura..."\
            PGPASSWORD="$senha" psql -h $host -p $porta -U $usuario -d $database < estrutura_aula.sql\
            SUCCESS=true\
            break 2\
        fi\
    done\
done\
\
if [ "$SUCCESS" = true ]; then\
    echo "\uc0\u55356 \u57225  Estrutura importada com sucesso!"\
    echo "\uc0\u55357 \u56522  Suas tabelas est\'e3o prontas para uso!"\
else\
    echo "\uc0\u10060  N\'e3o consegui conectar automaticamente."\
    echo "\uc0\u55357 \u56523  Execute manualmente:"\
    echo "   psql -h localhost -U seu_usuario -d seu_banco < estrutura_aula.sql"\
fi}
