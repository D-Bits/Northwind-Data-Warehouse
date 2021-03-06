--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 12.2

-- Started on 2021-03-06 14:19:38

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 25834)
-- Name: dim_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_products (
    id integer NOT NULL,
    unitsinstock integer NOT NULL,
    unitsinorder integer NOT NULL,
    reorderlevel integer,
    discontinued integer NOT NULL
);


ALTER TABLE public.dim_products OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25832)
-- Name: dim_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_products_id_seq OWNER TO postgres;

--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 202
-- Name: dim_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_products_id_seq OWNED BY public.dim_products.id;


--
-- TOC entry 205 (class 1259 OID 25842)
-- Name: fact_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_orders (
    id integer NOT NULL,
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    employeeid integer NOT NULL,
    productid integer NOT NULL,
    requireddate date NOT NULL,
    orderdate date NOT NULL,
    shippeddate date NOT NULL,
    shipvia integer,
    freight integer,
    shipname character varying(255) NOT NULL,
    shipaddress character varying(255) NOT NULL,
    shipcity character varying(255) NOT NULL,
    shipregion character varying(4),
    shippostalcode character varying(10) NOT NULL,
    shipcountry character varying(15) NOT NULL,
    unitprice double precision,
    quantity integer NOT NULL,
    discount integer
);


ALTER TABLE public.fact_orders OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25840)
-- Name: fact_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_orders_id_seq OWNER TO postgres;

--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 204
-- Name: fact_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_orders_id_seq OWNED BY public.fact_orders.id;


--
-- TOC entry 2784 (class 2604 OID 25837)
-- Name: dim_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_products ALTER COLUMN id SET DEFAULT nextval('public.dim_products_id_seq'::regclass);


--
-- TOC entry 2785 (class 2604 OID 25845)
-- Name: fact_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_orders ALTER COLUMN id SET DEFAULT nextval('public.fact_orders_id_seq'::regclass);


--
-- TOC entry 2918 (class 0 OID 25834)
-- Dependencies: 203
-- Data for Name: dim_products; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2920 (class 0 OID 25842)
-- Dependencies: 205
-- Data for Name: fact_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 202
-- Name: dim_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_products_id_seq', 1, false);


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 204
-- Name: fact_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_orders_id_seq', 1, false);


--
-- TOC entry 2787 (class 2606 OID 25839)
-- Name: dim_products dim_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_products
    ADD CONSTRAINT dim_products_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 2606 OID 25850)
-- Name: fact_orders fact_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_orders
    ADD CONSTRAINT fact_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2790 (class 2606 OID 25851)
-- Name: fact_orders fact_orders_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_orders
    ADD CONSTRAINT fact_orders_productid_fkey FOREIGN KEY (productid) REFERENCES public.dim_products(id);


-- Completed on 2021-03-06 14:19:38

--
-- PostgreSQL database dump complete
--

