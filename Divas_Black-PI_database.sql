--
-- PostgreSQL database dump
--

\restrict YYgQhmLtJUjR3IRZG32nGn6DrQYOKuSQ2PKr3UyvpeeHzfQLYP84kAoBkrx1b96

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-20 20:47:23

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 25032)
-- Name: anamnese; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anamnese (
    id_anamnese integer NOT NULL,
    id_cliente integer NOT NULL,
    data_avaliacao date DEFAULT CURRENT_DATE NOT NULL,
    curvatura character varying(2) NOT NULL,
    porosidade character varying(10),
    comprimento character(1) NOT NULL,
    couro_cabeludo character varying(15),
    quimica_anterior character varying(20),
    data_ultima_quimica date,
    alergias character varying(200),
    observacoes character varying(500),
    CONSTRAINT anamnese_comprimento_ck CHECK ((comprimento = ANY (ARRAY['P'::bpchar, 'M'::bpchar, 'G'::bpchar]))),
    CONSTRAINT anamnese_couro_ck CHECK (((couro_cabeludo)::text = ANY ((ARRAY['normal'::character varying, 'oleoso'::character varying, 'seco'::character varying, 'sensivel'::character varying])::text[]))),
    CONSTRAINT anamnese_curvatura_ck CHECK (((curvatura)::text = ANY ((ARRAY['2A'::character varying, '2B'::character varying, '2C'::character varying, '3A'::character varying, '3B'::character varying, '3C'::character varying, '4A'::character varying, '4B'::character varying, '4C'::character varying])::text[]))),
    CONSTRAINT anamnese_porosidade_ck CHECK (((porosidade)::text = ANY ((ARRAY['baixa'::character varying, 'media'::character varying, 'alta'::character varying])::text[]))),
    CONSTRAINT anamnese_quimica_ck CHECK (((quimica_anterior)::text = ANY ((ARRAY['nenhuma'::character varying, 'alisamento'::character varying, 'relaxamento'::character varying, 'coloracao'::character varying, 'descoloracao'::character varying])::text[])))
);


--
-- TOC entry 221 (class 1259 OID 25031)
-- Name: anamnese_id_anamnese_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anamnese_id_anamnese_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 221
-- Name: anamnese_id_anamnese_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anamnese_id_anamnese_seq OWNED BY public.anamnese.id_anamnese;


--
-- TOC entry 231 (class 1259 OID 25118)
-- Name: atendimento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.atendimento (
    id_atendimento integer NOT NULL,
    id_cliente integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    status character varying(10) DEFAULT 'agendado'::character varying NOT NULL,
    desconto numeric(7,2) DEFAULT 0 NOT NULL,
    valor_total numeric(8,2),
    forma_pagamento character varying(10),
    observacoes character varying(500),
    CONSTRAINT atendimento_desconto_ck CHECK ((desconto >= (0)::numeric)),
    CONSTRAINT atendimento_pagto_ck CHECK (((forma_pagamento)::text = ANY ((ARRAY['pix'::character varying, 'debito'::character varying, 'credito'::character varying, 'dinheiro'::character varying])::text[]))),
    CONSTRAINT atendimento_realizado_ck CHECK (((((status)::text = 'realizado'::text) AND (valor_total IS NOT NULL) AND (forma_pagamento IS NOT NULL)) OR (((status)::text <> 'realizado'::text) AND (valor_total IS NULL) AND (forma_pagamento IS NULL)))),
    CONSTRAINT atendimento_status_ck CHECK (((status)::text = ANY ((ARRAY['agendado'::character varying, 'realizado'::character varying, 'cancelado'::character varying])::text[])))
);


--
-- TOC entry 230 (class 1259 OID 25117)
-- Name: atendimento_id_atendimento_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.atendimento_id_atendimento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 230
-- Name: atendimento_id_atendimento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.atendimento_id_atendimento_seq OWNED BY public.atendimento.id_atendimento;


--
-- TOC entry 224 (class 1259 OID 25057)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    id_categoria smallint NOT NULL,
    nome character varying(30) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 25056)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 220 (class 1259 OID 25018)
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nome character varying(50) NOT NULL,
    data_nascimento date NOT NULL,
    telefone character varying(11) NOT NULL,
    email character varying(100),
    endereco character varying(200),
    data_cadastro date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT cliente_telefone_ck CHECK (((telefone)::text ~ '^[0-9]{10,11}$'::text))
);


--
-- TOC entry 219 (class 1259 OID 25017)
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- TOC entry 233 (class 1259 OID 25143)
-- Name: item_atendimento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_atendimento (
    id_item integer NOT NULL,
    id_atendimento integer NOT NULL,
    id_servico smallint NOT NULL,
    valor_cobrado numeric(7,2) NOT NULL,
    CONSTRAINT item_valor_ck CHECK ((valor_cobrado >= (0)::numeric))
);


--
-- TOC entry 232 (class 1259 OID 25142)
-- Name: item_atendimento_id_item_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_atendimento_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 232
-- Name: item_atendimento_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.item_atendimento_id_item_seq OWNED BY public.item_atendimento.id_item;


--
-- TOC entry 228 (class 1259 OID 25087)
-- Name: produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produto (
    id_produto integer NOT NULL,
    nome character varying(100) NOT NULL,
    marca character varying(50) NOT NULL,
    preco_custo numeric(7,2) NOT NULL,
    qtd_estoque smallint DEFAULT 0,
    validade date,
    CONSTRAINT produto_estoque_ck CHECK ((qtd_estoque >= 0)),
    CONSTRAINT produto_preco_ck CHECK ((preco_custo >= (0)::numeric))
);


--
-- TOC entry 227 (class 1259 OID 25086)
-- Name: produto_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.produto_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 227
-- Name: produto_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produto_id_produto_seq OWNED BY public.produto.id_produto;


--
-- TOC entry 226 (class 1259 OID 25068)
-- Name: servico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servico (
    id_servico smallint NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(255),
    tempo_medio_min smallint NOT NULL,
    preco_base numeric(7,2) NOT NULL,
    id_categoria smallint NOT NULL,
    CONSTRAINT servico_preco_ck CHECK ((preco_base >= (0)::numeric)),
    CONSTRAINT servico_tempo_ck CHECK ((tempo_medio_min > 0))
);


--
-- TOC entry 225 (class 1259 OID 25067)
-- Name: servico_id_servico_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servico_id_servico_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 225
-- Name: servico_id_servico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servico_id_servico_seq OWNED BY public.servico.id_servico;


--
-- TOC entry 229 (class 1259 OID 25100)
-- Name: servico_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servico_produto (
    id_servico smallint NOT NULL,
    id_produto integer NOT NULL
);


--
-- TOC entry 4845 (class 2604 OID 25035)
-- Name: anamnese id_anamnese; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anamnese ALTER COLUMN id_anamnese SET DEFAULT nextval('public.anamnese_id_anamnese_seq'::regclass);


--
-- TOC entry 4851 (class 2604 OID 25121)
-- Name: atendimento id_atendimento; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento ALTER COLUMN id_atendimento SET DEFAULT nextval('public.atendimento_id_atendimento_seq'::regclass);


--
-- TOC entry 4847 (class 2604 OID 25060)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 25021)
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- TOC entry 4854 (class 2604 OID 25146)
-- Name: item_atendimento id_item; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_atendimento ALTER COLUMN id_item SET DEFAULT nextval('public.item_atendimento_id_item_seq'::regclass);


--
-- TOC entry 4849 (class 2604 OID 25090)
-- Name: produto id_produto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto ALTER COLUMN id_produto SET DEFAULT nextval('public.produto_id_produto_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 25071)
-- Name: servico id_servico; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico ALTER COLUMN id_servico SET DEFAULT nextval('public.servico_id_servico_seq'::regclass);


--
-- TOC entry 5045 (class 0 OID 25032)
-- Dependencies: 222
-- Data for Name: anamnese; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.anamnese (id_anamnese, id_cliente, data_avaliacao, curvatura, porosidade, comprimento, couro_cabeludo, quimica_anterior, data_ultima_quimica, alergias, observacoes) FROM stdin;
1	42	2025-06-01	4C	baixa	G	normal	nenhuma	\N	\N	\N
2	14	2025-06-02	2C	media	G	seco	relaxamento	2025-02-16	Irritacao com fragrancias fortes	\N
3	45	2025-06-02	4A	baixa	G	sensivel	coloracao	2024-09-24	\N	\N
4	43	2025-06-15	4C	alta	G	normal	coloracao	2024-12-24	\N	\N
5	28	2025-06-16	2C	alta	M	seco	relaxamento	2024-04-01	\N	Quer aumentar a definicao dos cachos
6	35	2025-06-28	2C	alta	M	oleoso	descoloracao	2025-03-16	\N	Usa chapinha com frequencia
7	39	2025-07-01	3B	baixa	M	seco	descoloracao	2024-05-10	\N	Queixa de queda apos relaxamento
8	36	2025-07-04	4C	alta	M	normal	alisamento	2024-06-23	\N	Pontas muito ressecadas
9	58	2025-07-06	3A	alta	M	sensivel	descoloracao	2023-11-24	\N	Cliente em transicao capilar
10	8	2025-07-09	4B	alta	M	normal	nenhuma	\N	\N	Quer aumentar a definicao dos cachos
11	54	2025-07-17	4A	alta	P	oleoso	nenhuma	\N	Alergia a parabenos	\N
12	29	2025-07-26	3A	alta	M	normal	nenhuma	\N	Alergia a parabenos	Queixa de queda apos relaxamento
13	52	2025-09-06	4B	media	P	sensivel	coloracao	2023-10-31	\N	Quer aumentar a definicao dos cachos
14	17	2025-09-07	4C	alta	P	sensivel	relaxamento	2023-11-28	\N	Queixa de queda apos relaxamento
15	27	2025-09-17	4B	baixa	P	normal	nenhuma	\N	Sensibilidade a amonia	Usa chapinha com frequencia
16	12	2025-09-18	4C	alta	M	oleoso	nenhuma	\N	\N	Pontas muito ressecadas
17	51	2025-09-30	4B	alta	P	seco	relaxamento	2025-01-22	\N	Objetivo: crescimento saudavel
18	40	2025-10-07	4A	alta	G	normal	nenhuma	\N	\N	Quer aumentar a definicao dos cachos
19	50	2025-10-09	3A	alta	M	seco	relaxamento	2025-04-05	\N	Usa chapinha com frequencia
20	1	2025-10-14	4C	baixa	M	normal	descoloracao	2023-10-27	Sensibilidade a amonia	Queixa de queda apos relaxamento
21	13	2025-10-14	4A	alta	G	seco	coloracao	2024-04-05	\N	\N
22	44	2025-10-18	2C	baixa	P	seco	descoloracao	2025-06-16	Irritacao com fragrancias fortes	Objetivo: crescimento saudavel
23	38	2025-10-28	3A	baixa	G	sensivel	relaxamento	2024-02-09	\N	Cliente em transicao capilar
24	37	2025-10-31	4C	alta	M	normal	coloracao	2024-04-05	\N	Pontas muito ressecadas
25	15	2025-11-05	4A	alta	P	oleoso	nenhuma	\N	\N	\N
26	5	2025-11-07	3B	alta	G	normal	alisamento	2024-06-25	\N	Quer aumentar a definicao dos cachos
27	31	2025-11-13	4C	alta	P	normal	coloracao	2024-04-12	\N	Cliente em transicao capilar
28	26	2025-11-20	3B	baixa	P	seco	coloracao	2024-06-05	Irritacao com fragrancias fortes	\N
29	41	2025-11-26	4B	baixa	M	oleoso	nenhuma	\N	Sensibilidade a amonia	\N
30	4	2025-12-03	4C	alta	M	seco	coloracao	2024-02-01	Alergia a parabenos	Pontas muito ressecadas
31	45	2025-12-14	4A	alta	G	seco	nenhuma	\N	\N	Queixa de queda apos relaxamento
32	58	2025-12-17	3A	alta	M	seco	descoloracao	2025-03-13	\N	\N
33	8	2025-12-18	4B	alta	G	sensivel	nenhuma	\N	\N	Quer aumentar a definicao dos cachos
34	20	2025-12-25	4B	alta	M	normal	relaxamento	2025-03-14	\N	Objetivo: crescimento saudavel
35	9	2026-01-03	4A	baixa	M	oleoso	descoloracao	2025-03-20	Alergia a parabenos	Quer aumentar a definicao dos cachos
36	49	2026-01-07	3A	alta	M	oleoso	nenhuma	\N	Alergia a parabenos	Queixa de queda apos relaxamento
37	47	2026-01-20	3B	baixa	G	oleoso	relaxamento	2025-07-08	Alergia a parabenos	Quer aumentar a definicao dos cachos
38	10	2026-02-13	4C	media	P	oleoso	relaxamento	2025-11-16	\N	Quer aumentar a definicao dos cachos
39	52	2026-02-13	4B	alta	P	oleoso	nenhuma	\N	\N	Usa chapinha com frequencia
40	30	2026-02-15	4B	alta	P	oleoso	nenhuma	\N	\N	\N
41	11	2026-02-23	3C	media	M	normal	coloracao	2025-10-15	\N	Objetivo: crescimento saudavel
42	53	2026-03-04	4B	alta	M	normal	descoloracao	2025-01-09	\N	Pontas muito ressecadas
43	13	2026-03-23	4A	alta	G	seco	nenhuma	\N	\N	Cliente em transicao capilar
44	56	2026-03-28	2C	alta	P	oleoso	nenhuma	\N	\N	Usa chapinha com frequencia
45	23	2026-04-01	4C	alta	G	oleoso	descoloracao	2024-03-05	\N	Usa chapinha com frequencia
46	12	2026-04-09	4C	baixa	G	normal	nenhuma	\N	\N	Pontas muito ressecadas
47	48	2026-04-13	3C	media	G	normal	descoloracao	2024-05-07	\N	Usa chapinha com frequencia
48	6	2026-04-20	4B	baixa	P	oleoso	coloracao	2024-02-03	\N	Quer aumentar a definicao dos cachos
49	21	2026-04-21	4C	alta	G	oleoso	alisamento	2023-12-19	\N	\N
50	38	2026-04-28	3A	alta	P	seco	nenhuma	\N	Alergia a parabenos	\N
51	7	2026-05-04	4A	alta	M	normal	nenhuma	\N	\N	\N
52	33	2026-05-06	3C	baixa	P	sensivel	relaxamento	2023-12-21	Alergia a parabenos	Objetivo: crescimento saudavel
53	19	2026-05-07	4B	media	P	seco	coloracao	2025-11-20	Irritacao com fragrancias fortes	Queixa de queda apos relaxamento
54	44	2026-05-09	2C	media	P	normal	nenhuma	\N	\N	Queixa de queda apos relaxamento
55	15	2026-05-12	4A	alta	P	seco	nenhuma	\N	\N	\N
56	2	2026-05-15	4B	alta	P	normal	descoloracao	2024-03-17	\N	Quer aumentar a definicao dos cachos
57	57	2026-05-18	3B	alta	G	seco	nenhuma	\N	\N	Cliente em transicao capilar
58	34	2026-05-20	3A	alta	M	normal	nenhuma	\N	\N	\N
59	26	2026-05-25	3B	media	M	normal	descoloracao	2024-10-29	Sensibilidade a amonia	\N
60	32	2026-05-26	3C	alta	M	normal	relaxamento	2024-02-02	\N	\N
61	24	2026-06-01	3B	alta	G	oleoso	descoloracao	2024-06-25	Irritacao com fragrancias fortes	\N
62	22	2026-06-03	3B	media	M	sensivel	relaxamento	2025-09-14	\N	\N
63	16	2026-06-13	4B	alta	G	normal	alisamento	2024-11-18	\N	\N
64	25	2026-06-30	4B	alta	G	seco	nenhuma	\N	Sensibilidade a amonia	\N
65	49	2026-07-01	3A	baixa	G	normal	descoloracao	2025-08-16	\N	Quer aumentar a definicao dos cachos
66	46	2026-07-03	4B	alta	M	normal	nenhuma	\N	\N	\N
67	60	2026-07-07	3B	media	G	normal	relaxamento	2025-07-05	\N	Objetivo: crescimento saudavel
68	18	2026-07-08	4A	alta	P	normal	coloracao	2026-04-18	Irritacao com fragrancias fortes	Usa chapinha com frequencia
69	59	2026-07-10	3C	alta	P	normal	descoloracao	2025-11-16	\N	Quer aumentar a definicao dos cachos
70	55	2026-07-27	3A	media	M	normal	descoloracao	2026-04-23	\N	Quer aumentar a definicao dos cachos
71	30	2026-08-03	4B	alta	G	sensivel	nenhuma	\N	\N	Quer aumentar a definicao dos cachos
72	9	2026-08-05	4A	media	P	seco	relaxamento	2024-10-27	Alergia a parabenos	Pontas muito ressecadas
73	3	2026-08-23	2C	baixa	P	normal	nenhuma	\N	\N	Pontas muito ressecadas
\.


--
-- TOC entry 5054 (class 0 OID 25118)
-- Dependencies: 231
-- Data for Name: atendimento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.atendimento (id_atendimento, id_cliente, data_hora, status, desconto, valor_total, forma_pagamento, observacoes) FROM stdin;
1	50	2026-01-14 16:00:00	realizado	0.00	280.00	debito	Cliente indicou uma amiga
2	35	2026-01-22 10:00:00	realizado	0.00	280.00	credito	Chegou com o cabelo muito embaracado
3	52	2026-01-22 17:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
4	44	2026-01-24 16:00:00	realizado	0.00	60.00	credito	Retorno sugerido em 30 dias
5	27	2026-01-28 10:00:00	realizado	0.00	140.00	pix	Indicada reposicao proteica no proximo retorno
6	58	2026-01-28 16:00:00	realizado	0.00	340.00	credito	\N
7	17	2026-01-30 09:00:00	realizado	10.00	300.00	debito	\N
8	42	2026-01-31 13:00:00	realizado	0.00	300.00	dinheiro	\N
9	39	2026-02-03 17:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
10	28	2026-02-05 10:00:00	realizado	0.00	290.00	pix	\N
11	35	2026-02-06 11:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
12	51	2026-02-07 10:00:00	realizado	0.00	60.00	pix	Retorno sugerido em 30 dias
13	52	2026-02-18 14:00:00	realizado	0.00	310.00	pix	Retorno sugerido em 30 dias
14	52	2026-02-19 10:00:00	realizado	20.00	250.00	dinheiro	\N
15	12	2026-02-19 11:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
16	39	2026-02-19 16:00:00	realizado	0.00	280.00	credito	Retorno sugerido em 30 dias
17	28	2026-02-20 13:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
18	52	2026-02-21 09:00:00	realizado	0.00	280.00	debito	\N
19	52	2026-02-25 14:00:00	realizado	0.00	250.00	pix	\N
20	9	2026-02-26 09:00:00	realizado	0.00	500.00	pix	Chegou com o cabelo muito embaracado
21	40	2026-02-27 09:00:00	realizado	0.00	320.00	pix	\N
22	27	2026-03-03 16:00:00	realizado	0.00	260.00	pix	Retorno sugerido em 30 dias
23	45	2026-03-04 09:00:00	realizado	10.00	450.00	debito	\N
24	27	2026-03-05 13:00:00	realizado	0.00	210.00	pix	Retorno sugerido em 30 dias
25	27	2026-03-07 13:00:00	realizado	15.00	245.00	dinheiro	Chegou com o cabelo muito embaracado
26	50	2026-03-07 14:00:00	realizado	0.00	450.00	pix	\N
27	58	2026-03-07 17:00:00	realizado	0.00	220.00	credito	Cliente pediu mais definicao na raiz
28	15	2026-03-18 15:00:00	realizado	0.00	60.00	pix	\N
29	30	2026-03-19 14:00:00	realizado	0.00	320.00	debito	Orientada a usar touca de cetim
30	58	2026-03-20 17:00:00	realizado	0.00	290.00	dinheiro	\N
31	40	2026-03-24 09:00:00	realizado	15.00	305.00	debito	\N
32	35	2026-03-25 14:00:00	realizado	0.00	280.00	pix	Chegou com o cabelo muito embaracado
33	38	2026-03-25 16:00:00	realizado	20.00	410.00	debito	\N
34	27	2026-03-31 13:00:00	realizado	0.00	360.00	credito	\N
35	35	2026-04-01 10:00:00	realizado	0.00	500.00	credito	Indicada reposicao proteica no proximo retorno
36	35	2026-04-02 11:00:00	realizado	0.00	460.00	pix	Orientada a usar touca de cetim
37	58	2026-04-02 17:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
38	45	2026-04-09 11:00:00	realizado	0.00	270.00	pix	Cliente pediu mais definicao na raiz
39	27	2026-04-10 09:00:00	realizado	20.00	170.00	debito	Cliente pediu mais definicao na raiz
40	8	2026-04-10 17:00:00	realizado	0.00	140.00	pix	Retorno sugerido em 30 dias
41	27	2026-04-11 15:00:00	realizado	0.00	260.00	pix	\N
42	13	2026-04-14 13:00:00	realizado	0.00	480.00	debito	\N
43	43	2026-04-17 17:00:00	realizado	20.00	280.00	dinheiro	Retorno sugerido em 30 dias
44	27	2026-04-18 14:00:00	realizado	0.00	290.00	pix	\N
45	29	2026-04-21 09:00:00	realizado	0.00	270.00	pix	Chegou com o cabelo muito embaracado
46	11	2026-04-21 17:00:00	realizado	0.00	140.00	pix	Retorno sugerido em 30 dias
47	38	2026-04-22 11:00:00	realizado	0.00	210.00	pix	Cliente indicou uma amiga
48	42	2026-04-23 15:00:00	realizado	0.00	310.00	debito	Indicada reposicao proteica no proximo retorno
49	35	2026-04-23 16:00:00	realizado	0.00	270.00	pix	\N
50	11	2026-04-29 11:00:00	realizado	0.00	220.00	pix	\N
51	11	2026-04-30 09:00:00	realizado	10.00	200.00	pix	\N
52	56	2026-05-01 14:00:00	realizado	0.00	470.00	credito	Chegou com o cabelo muito embaracado
53	36	2026-05-02 15:00:00	realizado	0.00	270.00	credito	Orientada a usar touca de cetim
54	39	2026-05-06 09:00:00	realizado	0.00	250.00	pix	\N
55	58	2026-05-09 13:00:00	realizado	0.00	280.00	pix	Cliente indicou uma amiga
56	50	2026-05-09 16:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
57	1	2026-05-13 09:00:00	realizado	0.00	290.00	credito	Cliente pediu mais definicao na raiz
58	52	2026-05-14 13:00:00	realizado	0.00	260.00	debito	Cliente indicou uma amiga
59	27	2026-05-21 13:00:00	realizado	0.00	430.00	pix	Cliente pediu mais definicao na raiz
60	17	2026-05-21 15:00:00	realizado	0.00	320.00	debito	\N
61	40	2026-05-23 15:00:00	realizado	20.00	170.00	pix	\N
62	2	2026-05-23 17:00:00	realizado	0.00	270.00	credito	\N
63	19	2026-05-27 11:00:00	realizado	0.00	260.00	credito	\N
64	52	2026-05-29 09:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
65	44	2026-06-02 13:00:00	realizado	15.00	45.00	pix	Cliente indicou uma amiga
66	56	2026-06-03 09:00:00	realizado	0.00	250.00	credito	Orientada a usar touca de cetim
67	41	2026-06-03 13:00:00	realizado	0.00	220.00	debito	\N
68	48	2026-06-03 16:00:00	realizado	0.00	270.00	pix	\N
69	19	2026-06-04 10:00:00	realizado	0.00	430.00	credito	\N
70	2	2026-06-09 17:00:00	realizado	0.00	140.00	pix	\N
71	14	2026-06-12 09:00:00	realizado	0.00	300.00	credito	\N
72	11	2026-06-12 17:00:00	realizado	0.00	290.00	pix	\N
73	43	2026-06-16 17:00:00	realizado	10.00	290.00	credito	Cliente indicou uma amiga
74	4	2026-06-17 17:00:00	realizado	0.00	400.00	debito	\N
75	52	2026-06-19 13:00:00	realizado	20.00	120.00	credito	\N
76	40	2026-06-20 14:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
77	38	2026-06-23 14:00:00	realizado	0.00	430.00	pix	\N
78	31	2026-06-24 10:00:00	realizado	0.00	210.00	credito	Chegou com o cabelo muito embaracado
79	1	2026-06-25 16:00:00	realizado	0.00	250.00	pix	\N
80	30	2026-06-25 17:00:00	realizado	15.00	275.00	pix	\N
81	21	2026-06-26 14:00:00	realizado	0.00	240.00	pix	Indicada reposicao proteica no proximo retorno
82	52	2026-06-30 15:00:00	realizado	0.00	440.00	pix	Chegou com o cabelo muito embaracado
83	40	2026-07-01 11:00:00	realizado	0.00	300.00	dinheiro	\N
84	56	2026-07-01 16:00:00	realizado	0.00	420.00	pix	\N
85	39	2026-07-03 10:00:00	realizado	0.00	240.00	credito	Indicada reposicao proteica no proximo retorno
86	2	2026-07-03 14:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
87	21	2026-07-03 15:00:00	realizado	0.00	400.00	pix	Cliente pediu mais definicao na raiz
88	50	2026-07-03 17:00:00	realizado	10.00	260.00	debito	\N
89	27	2026-07-14 10:00:00	realizado	0.00	420.00	pix	\N
90	30	2026-07-16 15:00:00	realizado	0.00	220.00	credito	Retorno sugerido em 30 dias
91	16	2026-07-16 16:00:00	realizado	20.00	120.00	pix	Orientada a usar touca de cetim
92	47	2026-07-17 10:00:00	realizado	0.00	220.00	pix	\N
93	15	2026-07-17 14:00:00	realizado	20.00	40.00	credito	\N
94	16	2026-07-18 10:00:00	realizado	0.00	230.00	pix	\N
95	2	2026-07-18 17:00:00	realizado	0.00	450.00	credito	\N
96	2	2026-07-22 09:00:00	realizado	0.00	230.00	pix	\N
97	16	2026-07-23 13:00:00	realizado	0.00	300.00	credito	\N
98	4	2026-07-28 10:00:00	realizado	20.00	220.00	pix	Chegou com o cabelo muito embaracado
99	29	2026-07-28 13:00:00	realizado	0.00	280.00	pix	\N
100	2	2026-07-28 15:00:00	realizado	20.00	420.00	debito	\N
101	27	2026-08-01 11:00:00	realizado	0.00	380.00	credito	Cliente indicou uma amiga
102	16	2026-08-04 09:00:00	realizado	10.00	260.00	credito	\N
103	10	2026-08-05 13:00:00	realizado	10.00	240.00	credito	Cliente pediu mais definicao na raiz
104	57	2026-08-06 10:00:00	realizado	0.00	140.00	credito	Orientada a usar touca de cetim
105	11	2026-08-07 14:00:00	realizado	0.00	280.00	pix	Chegou com o cabelo muito embaracado
106	57	2026-08-11 16:00:00	realizado	0.00	300.00	pix	\N
107	28	2026-08-18 13:00:00	realizado	10.00	270.00	pix	\N
108	12	2026-08-19 13:00:00	realizado	0.00	300.00	credito	\N
109	56	2026-08-20 14:00:00	realizado	15.00	215.00	credito	Cliente indicou uma amiga
110	48	2026-08-26 10:00:00	realizado	0.00	310.00	credito	Orientada a usar touca de cetim
111	11	2026-08-26 15:00:00	realizado	0.00	430.00	credito	Indicada reposicao proteica no proximo retorno
112	52	2026-08-28 14:00:00	realizado	0.00	260.00	pix	\N
113	11	2026-09-01 10:00:00	realizado	0.00	300.00	debito	Chegou com o cabelo muito embaracado
114	10	2026-09-01 15:00:00	cancelado	0.00	\N	\N	Cliente desmarcou
115	39	2026-09-02 14:00:00	realizado	0.00	140.00	pix	\N
116	52	2026-09-03 15:00:00	realizado	0.00	320.00	pix	\N
117	47	2026-09-04 10:00:00	realizado	0.00	480.00	debito	\N
118	33	2026-09-08 13:00:00	realizado	20.00	240.00	credito	Orientada a usar touca de cetim
119	2	2026-09-10 10:00:00	realizado	0.00	280.00	credito	Retorno sugerido em 30 dias
120	39	2026-09-11 11:00:00	realizado	20.00	120.00	credito	\N
121	17	2026-09-16 13:00:00	realizado	15.00	295.00	credito	\N
122	47	2026-09-16 16:00:00	realizado	0.00	290.00	credito	\N
123	16	2026-09-18 15:00:00	realizado	0.00	470.00	pix	Cliente indicou uma amiga
124	35	2026-09-19 15:00:00	realizado	15.00	265.00	pix	\N
125	23	2026-09-23 16:00:00	realizado	15.00	285.00	pix	Retorno sugerido em 30 dias
126	11	2026-09-24 16:00:00	realizado	0.00	400.00	credito	Cliente indicou uma amiga
127	47	2026-09-29 11:00:00	realizado	0.00	320.00	dinheiro	\N
128	10	2026-09-29 13:00:00	realizado	0.00	260.00	credito	\N
129	49	2026-10-01 15:00:00	realizado	0.00	270.00	pix	\N
130	40	2026-10-02 16:00:00	realizado	0.00	210.00	pix	Cliente pediu mais definicao na raiz
131	35	2026-10-03 15:00:00	realizado	0.00	290.00	credito	Chegou com o cabelo muito embaracado
132	39	2026-10-06 15:00:00	realizado	0.00	220.00	debito	Cliente pediu mais definicao na raiz
133	28	2026-10-06 16:00:00	realizado	15.00	285.00	dinheiro	Retorno sugerido em 30 dias
134	50	2026-10-07 10:00:00	realizado	0.00	460.00	pix	\N
135	35	2026-10-07 11:00:00	realizado	0.00	220.00	pix	\N
136	30	2026-10-08 11:00:00	realizado	0.00	320.00	debito	\N
137	54	2026-10-14 09:00:00	realizado	15.00	235.00	credito	Cliente indicou uma amiga
138	38	2026-10-14 14:00:00	realizado	0.00	440.00	pix	\N
139	2	2026-10-20 13:00:00	agendado	0.00	\N	\N	\N
140	16	2026-10-20 14:00:00	agendado	0.00	\N	\N	\N
141	56	2026-10-21 09:00:00	agendado	0.00	\N	\N	\N
142	2	2026-10-21 10:00:00	agendado	0.00	\N	\N	\N
143	19	2026-10-21 14:00:00	agendado	0.00	\N	\N	\N
144	2	2026-10-23 13:00:00	agendado	0.00	\N	\N	\N
145	11	2026-10-23 17:00:00	agendado	0.00	\N	\N	\N
146	10	2026-10-27 10:00:00	agendado	0.00	\N	\N	\N
147	16	2026-10-27 13:00:00	agendado	0.00	\N	\N	\N
148	39	2026-10-28 15:00:00	agendado	0.00	\N	\N	\N
149	19	2026-10-29 10:00:00	agendado	0.00	\N	\N	\N
150	57	2026-11-03 11:00:00	agendado	0.00	\N	\N	\N
151	39	2026-11-04 11:00:00	agendado	0.00	\N	\N	\N
152	27	2026-11-06 11:00:00	agendado	0.00	\N	\N	\N
153	26	2026-11-07 10:00:00	agendado	0.00	\N	\N	\N
154	35	2026-11-07 17:00:00	agendado	0.00	\N	\N	\N
155	39	2026-11-11 09:00:00	agendado	0.00	\N	\N	\N
156	60	2026-11-11 16:00:00	agendado	0.00	\N	\N	\N
157	40	2026-11-12 11:00:00	agendado	0.00	\N	\N	\N
158	34	2026-11-17 14:00:00	agendado	0.00	\N	\N	\N
159	51	2026-11-19 14:00:00	agendado	0.00	\N	\N	\N
160	43	2026-11-28 17:00:00	agendado	0.00	\N	\N	\N
\.


--
-- TOC entry 5047 (class 0 OID 25057)
-- Dependencies: 224
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categoria (id_categoria, nome) FROM stdin;
1	Avaliacao
2	Tratamento
3	Quimica
4	Corte
5	Finalizacao
6	Taxa
\.


--
-- TOC entry 5043 (class 0 OID 25018)
-- Dependencies: 220
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cliente (id_cliente, nome, data_nascimento, telefone, email, endereco, data_cadastro) FROM stdin;
1	Raquel Dias	1974-04-27	11905641395	raquel.dias64@hotmail.com	Rua Moreira e Costa, 1889 - Vila Monumento, Sao Paulo - SP	2025-10-14
2	Ana Pereira	2005-05-24	11996965328	ana.pereira97@gmail.com	Av. Nazare, 665 - Vila Prudente, Sao Paulo - SP	2026-05-15
3	Thiago Teixeira Gomes	1995-10-15	11984801845	\N	Rua Lino Coutinho, 23 - Jabaquara, Sao Paulo - SP	2026-08-23
4	Stephanie Freitas	1982-09-04	11948932528	stephanie.freitas68@gmail.com	Rua Lino Coutinho, 89 - Ipiranga, Sao Paulo - SP	2025-12-03
5	Renata Almeida Lima	2007-02-03	11971822782	renata.lima78@hotmail.com	Rua Vergueiro, 833 - Jabaquara, Sao Paulo - SP	2025-11-07
6	Rafael Carvalho	1999-09-15	11913315098	rafael.carvalho29@gmail.com	\N	2026-04-20
7	Giovana Nascimento Santos	1973-06-03	11983473829	giovana.santos32@hotmail.com	Rua Agostinho Gomes, 396 - Ipiranga, Sao Paulo - SP	2026-05-04
8	Thais Ferreira Gomes	2000-12-02	11910651333	thais.gomes18@hotmail.com	Rua Lino Coutinho, 1033 - Vila Prudente, Sao Paulo - SP	2025-07-09
9	Flavia Moreira Martins	2005-01-03	11932677360	flavia.martins1@hotmail.com	Rua Leais Paulistanos, 1873 - Sacoma, Sao Paulo - SP	2026-01-03
10	Priscila Batista	2006-11-23	11972343098	\N	Rua Bom Pastor, 2402 - Cambuci, Sao Paulo - SP	2026-02-13
11	Sueli Costa Ribeiro	2003-02-28	11921913619	sueli.ribeiro77@gmail.com	Av. Dom Pedro I, 2400 - Vila Mariana, Sao Paulo - SP	2026-02-23
12	Aline Nascimento Araujo	1991-04-09	11962475107	aline.araujo73@gmail.com	\N	2025-09-18
13	Natalia Nascimento Ribeiro	1993-02-08	11954278498	\N	Rua Cipriano Barata, 434 - Vila Monumento, Sao Paulo - SP	2025-10-14
14	Rebeca Souza	1980-05-10	11993534874	rebeca.souza7@gmail.com	Rua Brigadeiro Jordao, 1143 - Ipiranga, Sao Paulo - SP	2025-06-02
15	Lucas Araujo	1987-03-24	11978680112	lucas.araujo48@outlook.com	Av. Dom Pedro I, 532 - Ipiranga, Sao Paulo - SP	2025-11-05
16	Lais Ferreira	1984-11-08	11915869232	lais.ferreira23@hotmail.com	\N	2026-06-13
17	Mirela Araujo	1986-05-06	11916073375	mirela.araujo30@gmail.com	\N	2025-09-07
18	Yasmin Araujo Carvalho	1975-05-12	11986850142	yasmin.carvalho34@gmail.com	Av. Dom Pedro I, 1425 - Jabaquara, Sao Paulo - SP	2026-07-08
19	Adriana Araujo	2003-02-13	11993406088	adriana.araujo95@outlook.com	Rua Tabor, 1776 - Ipiranga, Sao Paulo - SP	2026-05-07
20	Larissa Teixeira Araujo	1978-12-10	11984656482	larissa.araujo86@hotmail.com	Av. Nazare, 2341 - Sacoma, Sao Paulo - SP	2025-12-25
21	Patricia Silva Barbosa	1984-07-26	11999577738	patricia.barbosa95@gmail.com	Rua Cipriano Barata, 2121 - Jabaquara, Sao Paulo - SP	2026-04-21
22	Isabela Araujo Cardoso	1986-11-10	11933200379	isabela.cardoso10@hotmail.com	Rua Moreira e Costa, 2367 - Vila Monumento, Sao Paulo - SP	2026-06-03
23	Sabrina Carvalho Batista	1986-03-21	11901632870	sabrina.batista16@hotmail.com	Rua Lino Coutinho, 2185 - Vila Mariana, Sao Paulo - SP	2026-04-01
24	Daniela Araujo	2003-07-27	11987277434	daniela.araujo67@hotmail.com	Rua Cipriano Barata, 1811 - Ipiranga, Sao Paulo - SP	2026-06-01
25	Leticia Almeida Lima	1991-09-03	11922362316	leticia.lima70@hotmail.com	Rua Agostinho Gomes, 1730 - Cambuci, Sao Paulo - SP	2026-06-30
26	Juliana Freitas Moreira	2007-07-16	11905466889	juliana.moreira63@gmail.com	Rua Lino Coutinho, 128 - Cambuci, Sao Paulo - SP	2025-11-20
27	Lorena Dias	1981-08-05	11998069901	lorena.dias18@hotmail.com	Rua Cipriano Barata, 1562 - Sacoma, Sao Paulo - SP	2025-09-17
28	Luana Araujo Martins	1995-05-25	11964170805	luana.martins9@outlook.com	\N	2025-06-16
29	Kelly Almeida	1980-04-05	11971937452	kelly.almeida96@outlook.com	Rua Brigadeiro Jordao, 680 - Sacoma, Sao Paulo - SP	2025-07-26
30	Cintia Moreira	2007-11-13	11963193149	cintia.moreira73@gmail.com	Av. Dom Pedro I, 1527 - Ipiranga, Sao Paulo - SP	2026-02-15
31	Beatriz Araujo Teixeira	1997-08-04	11965726284	beatriz.teixeira69@hotmail.com	Rua Brigadeiro Jordao, 2436 - Sacoma, Sao Paulo - SP	2025-11-13
32	Eduarda Oliveira Almeida	1999-04-25	11979965075	eduarda.almeida28@hotmail.com	Rua Tabor, 1155 - Vila Mariana, Sao Paulo - SP	2026-05-26
33	Mariana Moreira Nascimento	1983-02-08	11967837770	\N	Av. Ricardo Jafet, 1006 - Sacoma, Sao Paulo - SP	2026-05-06
34	Debora Ferreira Moreira	2004-06-14	11985574443	\N	Rua Silva Bueno, 2204 - Vila Prudente, Sao Paulo - SP	2026-05-20
35	Vanessa Almeida Costa	2001-05-24	11998941343	vanessa.costa39@gmail.com	Av. Nazare, 1133 - Ipiranga, Sao Paulo - SP	2025-06-28
36	Joyce Barbosa	1979-11-28	11971094777	joyce.barbosa7@hotmail.com	Rua Lino Coutinho, 477 - Vila Prudente, Sao Paulo - SP	2025-07-04
37	Ingrid Ribeiro Carvalho	1974-03-05	11994131869	ingrid.carvalho80@gmail.com	Av. Dom Pedro I, 1855 - Cambuci, Sao Paulo - SP	2025-10-31
38	Helena Gomes Moreira	1974-10-24	11913341232	helena.moreira21@gmail.com	Av. Ricardo Jafet, 2442 - Cambuci, Sao Paulo - SP	2025-10-28
39	Viviane Nascimento Santos	1989-12-28	11971349361	viviane.santos83@gmail.com	Rua Brigadeiro Jordao, 592 - Ipiranga, Sao Paulo - SP	2025-07-01
40	Monique Costa	2007-05-15	11917464887	monique.costa77@gmail.com	Av. Ricardo Jafet, 1330 - Vila Mariana, Sao Paulo - SP	2025-10-07
41	Camila Souza Silva	2007-10-01	11949027874	camila.silva75@hotmail.com	Rua Lino Coutinho, 383 - Cambuci, Sao Paulo - SP	2025-11-26
42	Simone Araujo Gomes	1977-03-11	11967468071	simone.gomes42@gmail.com	Av. Dom Pedro I, 2117 - Vila Prudente, Sao Paulo - SP	2025-06-01
43	Michele Barbosa Dias	1974-04-17	11959770348	\N	Av. Ricardo Jafet, 1995 - Ipiranga, Sao Paulo - SP	2025-06-15
44	Diego Teixeira	1981-05-18	11908613171	diego.teixeira20@hotmail.com	Rua Cipriano Barata, 2094 - Jabaquara, Sao Paulo - SP	2025-10-18
45	Carla Gomes	1986-08-18	11926398214	carla.gomes54@hotmail.com	Rua Vergueiro, 1104 - Vila Prudente, Sao Paulo - SP	2025-06-02
46	Erica Conceicao Lima	2002-03-15	11987558867	erica.lima25@outlook.com	Av. Dom Pedro I, 966 - Vila Prudente, Sao Paulo - SP	2026-07-03
47	Elaine Santos Gomes	2001-12-26	11966270289	elaine.gomes13@hotmail.com	\N	2026-01-20
48	Fernanda Conceicao Silva	1980-02-16	11945961586	fernanda.silva81@outlook.com	Rua Lino Coutinho, 2226 - Ipiranga, Sao Paulo - SP	2026-04-13
49	Gabriela Oliveira	1989-04-24	11916117240	\N	Rua Cipriano Barata, 1478 - Sacoma, Sao Paulo - SP	2026-01-07
50	Silvia Pereira	2007-11-26	11922219693	silvia.pereira75@gmail.com	Rua Moreira e Costa, 1050 - Cambuci, Sao Paulo - SP	2025-10-09
51	Wesley Dias	2000-05-22	11982175946	wesley.dias59@hotmail.com	Av. Dom Pedro I, 1989 - Ipiranga, Sao Paulo - SP	2025-09-30
52	Nathalia Cardoso Carvalho	1989-12-10	11906409097	nathalia.carvalho37@gmail.com	Rua Tabor, 907 - Jabaquara, Sao Paulo - SP	2025-09-06
53	Jessica Cardoso	1979-11-04	11904709521	jessica.cardoso42@outlook.com	Rua Agostinho Gomes, 551 - Vila Prudente, Sao Paulo - SP	2026-03-04
54	Tatiane Ferreira	1988-03-09	11974517123	tatiane.ferreira93@outlook.com	Rua Brigadeiro Jordao, 2292 - Sacoma, Sao Paulo - SP	2025-07-17
55	Bruna Silva Carvalho	1978-08-12	11949651370	bruna.carvalho72@hotmail.com	Rua Agostinho Gomes, 268 - Jabaquara, Sao Paulo - SP	2026-07-27
56	Jaqueline Freitas Martins	1997-02-05	11900471138	\N	Rua Moreira e Costa, 2222 - Cambuci, Sao Paulo - SP	2026-03-28
57	Tamires Conceicao Freitas	1997-11-04	11979640537	tamires.freitas31@hotmail.com	\N	2026-05-18
58	Karina Ferreira	1993-01-13	11943171390	\N	Av. Nazare, 2322 - Vila Monumento, Sao Paulo - SP	2025-07-06
59	Paloma Barbosa Conceicao	1984-04-11	11929042284	paloma.conceicao15@outlook.com	Av. Nazare, 70 - Sacoma, Sao Paulo - SP	2026-07-10
60	Rosana Cardoso Almeida	1982-05-02	11926811775	rosana.almeida14@hotmail.com	Rua Greenfeld, 187 - Jabaquara, Sao Paulo - SP	2026-07-07
\.


--
-- TOC entry 5056 (class 0 OID 25143)
-- Dependencies: 233
-- Data for Name: item_atendimento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.item_atendimento (id_item, id_atendimento, id_servico, valor_cobrado) FROM stdin;
1	1	3	180.00
2	1	13	100.00
3	2	4	180.00
4	2	13	100.00
5	3	3	180.00
6	3	12	80.00
7	4	11	60.00
8	5	15	140.00
9	6	5	190.00
10	6	13	100.00
11	6	16	50.00
12	7	3	180.00
13	7	12	80.00
14	7	16	50.00
15	8	3	180.00
16	8	14	120.00
17	9	9	150.00
18	9	13	100.00
19	10	5	190.00
20	10	13	100.00
21	11	4	180.00
22	11	13	100.00
23	12	11	60.00
24	13	3	180.00
25	13	12	80.00
26	13	16	50.00
27	14	5	190.00
28	14	12	80.00
29	15	10	170.00
30	15	14	120.00
31	16	3	180.00
32	16	13	100.00
33	17	3	190.00
34	17	9	150.00
35	17	13	100.00
36	18	9	150.00
37	18	12	80.00
38	18	16	50.00
39	19	10	170.00
40	19	12	80.00
41	20	7	350.00
42	20	12	80.00
43	20	2	20.00
44	20	16	50.00
45	21	3	200.00
46	21	14	120.00
47	22	3	180.00
48	22	12	80.00
49	23	5	190.00
50	23	9	150.00
51	23	14	120.00
52	24	1	30.00
53	24	3	180.00
54	25	4	180.00
55	25	12	80.00
56	26	7	350.00
57	26	13	100.00
58	27	6	120.00
59	27	13	100.00
60	28	11	60.00
61	29	9	150.00
62	29	14	120.00
63	29	16	50.00
64	30	5	190.00
65	30	13	100.00
66	31	9	150.00
67	31	14	120.00
68	31	16	50.00
69	32	3	180.00
70	32	13	100.00
71	33	3	180.00
72	33	10	170.00
73	33	12	80.00
74	34	8	280.00
75	34	12	80.00
76	35	3	180.00
77	35	10	170.00
78	35	13	100.00
79	35	16	50.00
80	36	5	190.00
81	36	10	170.00
82	36	13	100.00
83	37	9	150.00
84	37	13	100.00
85	38	9	150.00
86	38	14	120.00
87	39	15	140.00
88	39	16	50.00
89	40	15	140.00
90	41	3	180.00
91	41	12	80.00
92	42	7	360.00
93	42	14	120.00
94	43	3	180.00
95	43	14	120.00
96	44	3	210.00
97	44	12	80.00
98	45	10	170.00
99	45	13	100.00
100	46	15	140.00
101	47	1	30.00
102	47	4	180.00
103	48	3	190.00
104	48	14	120.00
105	49	10	170.00
106	49	13	100.00
107	50	6	120.00
108	50	13	100.00
109	51	1	30.00
110	51	4	180.00
111	52	5	190.00
112	52	9	150.00
113	52	12	80.00
114	52	16	50.00
115	53	10	170.00
116	53	13	100.00
117	54	9	150.00
118	54	13	100.00
119	55	3	180.00
120	55	13	100.00
121	56	3	180.00
122	56	13	100.00
123	57	5	190.00
124	57	13	100.00
125	58	4	180.00
126	58	12	80.00
127	59	7	350.00
128	59	12	80.00
129	60	5	190.00
130	60	12	80.00
131	60	16	50.00
132	61	15	140.00
133	61	16	50.00
134	62	5	190.00
135	62	12	80.00
136	63	4	180.00
137	63	12	80.00
138	64	1	30.00
139	64	4	180.00
140	64	16	50.00
141	65	11	60.00
142	66	6	120.00
143	66	12	80.00
144	66	16	50.00
145	67	6	120.00
146	67	13	100.00
147	68	9	150.00
148	68	14	120.00
149	69	3	180.00
150	69	10	170.00
151	69	12	80.00
152	70	15	140.00
153	71	3	180.00
154	71	14	120.00
155	72	5	190.00
156	72	13	100.00
157	73	4	180.00
158	73	14	120.00
159	74	8	280.00
160	74	13	100.00
161	74	2	20.00
162	75	15	140.00
163	76	7	350.00
164	76	14	120.00
165	76	2	20.00
166	77	3	180.00
167	77	10	170.00
168	77	12	80.00
169	78	1	30.00
170	78	3	180.00
171	79	9	150.00
172	79	13	100.00
173	80	10	170.00
174	80	14	120.00
175	81	1	30.00
176	81	5	210.00
177	82	5	190.00
178	82	10	170.00
179	82	12	80.00
180	83	3	180.00
181	83	14	120.00
182	84	5	190.00
183	84	9	150.00
184	84	12	80.00
185	85	1	30.00
186	85	4	210.00
187	86	9	150.00
188	86	12	80.00
189	87	8	280.00
190	87	14	120.00
191	88	10	170.00
192	88	13	100.00
193	89	3	190.00
194	89	9	150.00
195	89	12	80.00
196	90	1	30.00
197	90	3	190.00
198	91	15	140.00
199	92	1	30.00
200	92	5	190.00
201	93	11	60.00
202	94	1	30.00
203	94	4	200.00
204	95	7	350.00
205	95	12	80.00
206	95	2	20.00
207	96	9	150.00
208	96	12	80.00
209	97	3	180.00
210	97	14	120.00
211	98	1	30.00
212	98	4	210.00
213	99	4	180.00
214	99	13	100.00
215	100	5	190.00
216	100	10	170.00
217	100	12	80.00
218	101	8	280.00
219	101	12	80.00
220	101	2	20.00
221	102	9	150.00
222	102	14	120.00
223	103	10	170.00
224	103	12	80.00
225	104	15	140.00
226	105	3	180.00
227	105	13	100.00
228	106	4	180.00
229	106	14	120.00
230	107	3	180.00
231	107	13	100.00
232	108	3	180.00
233	108	14	120.00
234	109	9	150.00
235	109	12	80.00
236	110	5	190.00
237	110	14	120.00
238	111	4	180.00
239	111	9	150.00
240	111	13	100.00
241	112	4	180.00
242	112	12	80.00
243	113	9	150.00
244	113	13	100.00
245	113	16	50.00
246	114	15	140.00
247	115	15	140.00
248	116	5	190.00
249	116	12	80.00
250	116	16	50.00
251	117	3	210.00
252	117	9	150.00
253	117	14	120.00
254	118	3	180.00
255	118	12	80.00
256	119	3	200.00
257	119	12	80.00
258	120	15	140.00
259	121	4	180.00
260	121	12	80.00
261	121	16	50.00
262	122	10	170.00
263	122	14	120.00
264	123	4	180.00
265	123	10	170.00
266	123	14	120.00
267	124	3	180.00
268	124	13	100.00
269	125	3	180.00
270	125	14	120.00
271	126	8	280.00
272	126	13	100.00
273	126	2	20.00
274	127	3	200.00
275	127	14	120.00
276	128	3	180.00
277	128	12	80.00
278	129	9	150.00
279	129	14	120.00
280	130	1	30.00
281	130	4	180.00
282	131	5	190.00
283	131	13	100.00
284	132	6	120.00
285	132	13	100.00
286	133	4	200.00
287	133	13	100.00
288	134	5	190.00
289	134	10	170.00
290	134	13	100.00
291	135	6	120.00
292	135	13	100.00
293	136	4	200.00
294	136	14	120.00
295	137	10	170.00
296	137	12	80.00
297	138	3	210.00
298	138	9	150.00
299	138	12	80.00
300	139	7	360.00
301	139	12	80.00
302	139	2	20.00
303	140	6	120.00
304	140	14	120.00
305	141	6	120.00
306	141	12	80.00
307	142	15	140.00
308	143	15	140.00
309	144	8	280.00
310	144	12	80.00
311	145	3	180.00
312	145	13	100.00
313	146	1	30.00
314	146	5	190.00
315	146	16	50.00
316	147	5	190.00
317	147	14	120.00
318	148	4	180.00
319	148	10	170.00
320	148	13	100.00
321	149	10	170.00
322	149	12	80.00
323	149	16	50.00
324	150	1	30.00
325	150	4	180.00
326	150	16	50.00
327	151	5	190.00
328	151	10	170.00
329	151	13	100.00
330	151	16	50.00
331	152	3	200.00
332	152	12	80.00
333	153	10	170.00
334	153	13	100.00
335	154	9	150.00
336	154	13	100.00
337	155	6	120.00
338	155	13	100.00
339	156	4	180.00
340	156	14	120.00
341	157	15	140.00
342	158	6	120.00
343	158	13	100.00
344	159	11	60.00
345	160	9	150.00
346	160	14	120.00
\.


--
-- TOC entry 5051 (class 0 OID 25087)
-- Dependencies: 228
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.produto (id_produto, nome, marca, preco_custo, qtd_estoque, validade) FROM stdin;
1	Shampoo Low Poo 1L	Vitallis	48.90	5	2027-10-24
2	Shampoo Antirresiduo 1L	NB	39.90	10	2026-12-13
3	Condicionador Co-wash 1L	Olenka	45.00	9	2027-04-05
4	Mascara Hidratacao Intensa 1kg	Vitallis	89.90	5	2027-02-10
5	Mascara Nutricao Oleos 1kg	Italian	92.50	19	2027-11-12
6	Ampola Reconstrucao (cx 12)	Vioss	110.00	20	2027-01-14
7	Queratina Liquida 500ml	NB	64.90	3	2027-07-05
8	Oleo de Ricino 1L	Olenka	38.00	4	2026-12-16
9	Relaxante Guanidina	Italian	72.00	9	2027-03-22
10	Coloracao Creme 1.0 Preto	Vioss	22.90	2	2027-08-16
11	Oxidante 20 Volumes 900ml	Vioss	28.50	8	2027-09-14
12	Creme de Pentear 1kg	Vitallis	54.90	19	2027-12-02
13	Gel Ativador de Cachos 1kg	NB	49.90	9	2027-07-03
14	Leave-in Protetor Termico 500ml	Olenka	42.00	20	2027-07-18
15	Finalizador Gelatina 1kg	Italian	46.90	2	2027-04-22
\.


--
-- TOC entry 5049 (class 0 OID 25068)
-- Dependencies: 226
-- Data for Name: servico; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.servico (id_servico, nome, descricao, tempo_medio_min, preco_base, id_categoria) FROM stdin;
1	Avaliacao Capilar	Analise da curvatura, porosidade e couro cabeludo; base para a anamnese	30	30.00	1
2	Teste de Mecha	Teste em pequena mecha antes de qualquer procedimento quimico	15	20.00	1
3	Reposicao Hidrica	Hidratacao profunda que repoe agua e devolve maciez aos fios	150	180.00	2
4	Reposicao Lipidica	Nutricao com oleos vegetais contra ressecamento e frizz	150	180.00	2
5	Reposicao Proteica	Reconstrucao da fibra para fios fragilizados por quimica ou calor	150	190.00	2
6	Umectacao	Tratamento com oleo de ricino aplicado antes da lavagem	90	120.00	2
7	Relaxamento	Reducao controlada do volume sem alisar, com guanidina	240	350.00	3
8	Coloracao	Coloracao global com tom escolhido na avaliacao	180	280.00	3
9	Corte a Seco	Corte fio a fio com o cabelo seco, respeitando a curvatura natural	90	150.00	4
10	Corte de Transicao	Remocao gradual da parte com quimica na transicao capilar	120	170.00	4
11	Corte Masculino Afro	Corte masculino com acabamento na maquina e tesoura	60	60.00	4
12	Fitagem P	Finalizacao com definicao fio a fio - cabelo curto	60	80.00	5
13	Fitagem M	Finalizacao com definicao fio a fio - cabelo medio	90	100.00	5
14	Fitagem G	Finalizacao com definicao fio a fio - cabelo longo	120	120.00	5
15	Twist / Dedoliss	Finalizacao em twists ou dedoliss para cachos definidos	120	140.00	5
16	Taxa de Desembaraco	Cobrada quando o cabelo chega muito embaracado	30	50.00	6
\.


--
-- TOC entry 5052 (class 0 OID 25100)
-- Dependencies: 229
-- Data for Name: servico_produto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.servico_produto (id_servico, id_produto) FROM stdin;
2	9
2	10
2	11
3	1
3	3
3	4
3	14
4	1
4	3
4	5
4	8
5	2
5	6
5	7
5	14
6	8
6	1
7	9
7	2
7	6
8	10
8	11
8	2
8	4
9	12
9	14
10	12
10	14
10	4
11	12
12	12
12	13
13	12
13	13
14	12
14	13
14	15
15	12
15	15
16	3
16	12
\.


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 221
-- Name: anamnese_id_anamnese_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.anamnese_id_anamnese_seq', 73, true);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 230
-- Name: atendimento_id_atendimento_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.atendimento_id_atendimento_seq', 160, true);


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 6, true);


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 60, true);


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 232
-- Name: item_atendimento_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.item_atendimento_id_item_seq', 346, true);


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 227
-- Name: produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produto_id_produto_seq', 15, true);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 225
-- Name: servico_id_servico_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.servico_id_servico_seq', 16, true);


--
-- TOC entry 4873 (class 2606 OID 25050)
-- Name: anamnese anamnese_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anamnese
    ADD CONSTRAINT anamnese_pk PRIMARY KEY (id_anamnese);


--
-- TOC entry 4885 (class 2606 OID 25136)
-- Name: atendimento atendimento_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT atendimento_pk PRIMARY KEY (id_atendimento);


--
-- TOC entry 4875 (class 2606 OID 25066)
-- Name: categoria categoria_nome_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_nome_uk UNIQUE (nome);


--
-- TOC entry 4877 (class 2606 OID 25064)
-- Name: categoria categoria_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pk PRIMARY KEY (id_categoria);


--
-- TOC entry 4871 (class 2606 OID 25030)
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pk PRIMARY KEY (id_cliente);


--
-- TOC entry 4887 (class 2606 OID 25153)
-- Name: item_atendimento item_atendimento_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_atendimento
    ADD CONSTRAINT item_atendimento_pk PRIMARY KEY (id_item);


--
-- TOC entry 4881 (class 2606 OID 25099)
-- Name: produto produto_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pk PRIMARY KEY (id_produto);


--
-- TOC entry 4879 (class 2606 OID 25080)
-- Name: servico servico_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico
    ADD CONSTRAINT servico_pk PRIMARY KEY (id_servico);


--
-- TOC entry 4883 (class 2606 OID 25106)
-- Name: servico_produto servico_produto_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_produto
    ADD CONSTRAINT servico_produto_pk PRIMARY KEY (id_servico, id_produto);


--
-- TOC entry 4893 (class 2606 OID 25154)
-- Name: item_atendimento atendimento_item_atendimento_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_atendimento
    ADD CONSTRAINT atendimento_item_atendimento_fk FOREIGN KEY (id_atendimento) REFERENCES public.atendimento(id_atendimento);


--
-- TOC entry 4889 (class 2606 OID 25081)
-- Name: servico categoria_servico_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico
    ADD CONSTRAINT categoria_servico_fk FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 4888 (class 2606 OID 25051)
-- Name: anamnese cliente_anamnese_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anamnese
    ADD CONSTRAINT cliente_anamnese_fk FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 4892 (class 2606 OID 25137)
-- Name: atendimento cliente_atendimento_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento
    ADD CONSTRAINT cliente_atendimento_fk FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 4890 (class 2606 OID 25112)
-- Name: servico_produto produto_servico_produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_produto
    ADD CONSTRAINT produto_servico_produto_fk FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- TOC entry 4894 (class 2606 OID 25159)
-- Name: item_atendimento servico_item_atendimento_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_atendimento
    ADD CONSTRAINT servico_item_atendimento_fk FOREIGN KEY (id_servico) REFERENCES public.servico(id_servico);


--
-- TOC entry 4891 (class 2606 OID 25107)
-- Name: servico_produto servico_servico_produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_produto
    ADD CONSTRAINT servico_servico_produto_fk FOREIGN KEY (id_servico) REFERENCES public.servico(id_servico);


-- Completed on 2026-10-20 20:47:24

--
-- PostgreSQL database dump complete
--

\unrestrict YYgQhmLtJUjR3IRZG32nGn6DrQYOKuSQ2PKr3UyvpeeHzfQLYP84kAoBkrx1b96

