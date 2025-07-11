PGDMP      9                }           serra    17.5    17.5 8    c           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            d           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            e           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            f           1262    16389    serra    DATABASE     x   CREATE DATABASE serra WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
    DROP DATABASE serra;
                     postgres    false            �            1259    16450    lettura    TABLE     �   CREATE TABLE public.lettura (
    id_lettura integer NOT NULL,
    id_sensore integer NOT NULL,
    valore numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.lettura;
       public         heap r       postgres    false            �            1259    16449    lettura_id_lettura_seq    SEQUENCE     �   CREATE SEQUENCE public.lettura_id_lettura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.lettura_id_lettura_seq;
       public               postgres    false    222            g           0    0    lettura_id_lettura_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.lettura_id_lettura_seq OWNED BY public.lettura.id_lettura;
          public               postgres    false    221            �            1259    16492    log_allarmi    TABLE     �   CREATE TABLE public.log_allarmi (
    id_log integer NOT NULL,
    id_soglia integer NOT NULL,
    id_lettura integer NOT NULL,
    messaggio text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.log_allarmi;
       public         heap r       postgres    false            �            1259    16491    log_allarmi_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.log_allarmi_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.log_allarmi_id_log_seq;
       public               postgres    false    228            h           0    0    log_allarmi_id_log_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.log_allarmi_id_log_seq OWNED BY public.log_allarmi.id_log;
          public               postgres    false    227            �            1259    16436    sensore    TABLE     �  CREATE TABLE public.sensore (
    id_sensore integer NOT NULL,
    id_serra integer NOT NULL,
    tipo character varying(20) NOT NULL,
    unita_misura character varying(10) NOT NULL,
    posizione character varying(30),
    is_active boolean DEFAULT true,
    CONSTRAINT sensore_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['temperature'::character varying, 'humidity'::character varying, 'light'::character varying])::text[])))
);
    DROP TABLE public.sensore;
       public         heap r       postgres    false            �            1259    16435    sensore_id_sensore_seq    SEQUENCE     �   CREATE SEQUENCE public.sensore_id_sensore_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.sensore_id_sensore_seq;
       public               postgres    false    220            i           0    0    sensore_id_sensore_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.sensore_id_sensore_seq OWNED BY public.sensore.id_sensore;
          public               postgres    false    219            �            1259    16428    serra    TABLE     �   CREATE TABLE public.serra (
    id_serra integer NOT NULL,
    nome character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.serra;
       public         heap r       postgres    false            �            1259    16427    serra_id_serra_seq    SEQUENCE     �   CREATE SEQUENCE public.serra_id_serra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.serra_id_serra_seq;
       public               postgres    false    218            j           0    0    serra_id_serra_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.serra_id_serra_seq OWNED BY public.serra.id_serra;
          public               postgres    false    217            �            1259    16473    soglia_allarme    TABLE     �  CREATE TABLE public.soglia_allarme (
    id_soglia integer NOT NULL,
    id_sensore integer NOT NULL,
    id_utente integer NOT NULL,
    valore_max numeric(10,2) NOT NULL,
    valore_min numeric(10,2) NOT NULL,
    azione character varying(20) NOT NULL,
    CONSTRAINT soglia_allarme_azione_check CHECK (((azione)::text = ANY ((ARRAY['email'::character varying, 'sms'::character varying, 'alert'::character varying])::text[]))),
    CONSTRAINT soglia_allarme_check CHECK ((valore_max > valore_min))
);
 "   DROP TABLE public.soglia_allarme;
       public         heap r       postgres    false            �            1259    16472    soglia_allarme_id_soglia_seq    SEQUENCE     �   CREATE SEQUENCE public.soglia_allarme_id_soglia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.soglia_allarme_id_soglia_seq;
       public               postgres    false    226            k           0    0    soglia_allarme_id_soglia_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.soglia_allarme_id_soglia_seq OWNED BY public.soglia_allarme.id_soglia;
          public               postgres    false    225            �            1259    16463    utente    TABLE     K  CREATE TABLE public.utente (
    id_utente integer NOT NULL,
    nome character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    ruolo character varying(20) NOT NULL,
    CONSTRAINT utente_ruolo_check CHECK (((ruolo)::text = ANY ((ARRAY['admin'::character varying, 'operator'::character varying])::text[])))
);
    DROP TABLE public.utente;
       public         heap r       postgres    false            �            1259    16462    utente_id_utente_seq    SEQUENCE     �   CREATE SEQUENCE public.utente_id_utente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.utente_id_utente_seq;
       public               postgres    false    224            l           0    0    utente_id_utente_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.utente_id_utente_seq OWNED BY public.utente.id_utente;
          public               postgres    false    223            �           2604    16453    lettura id_lettura    DEFAULT     x   ALTER TABLE ONLY public.lettura ALTER COLUMN id_lettura SET DEFAULT nextval('public.lettura_id_lettura_seq'::regclass);
 A   ALTER TABLE public.lettura ALTER COLUMN id_lettura DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16495    log_allarmi id_log    DEFAULT     x   ALTER TABLE ONLY public.log_allarmi ALTER COLUMN id_log SET DEFAULT nextval('public.log_allarmi_id_log_seq'::regclass);
 A   ALTER TABLE public.log_allarmi ALTER COLUMN id_log DROP DEFAULT;
       public               postgres    false    228    227    228            �           2604    16439    sensore id_sensore    DEFAULT     x   ALTER TABLE ONLY public.sensore ALTER COLUMN id_sensore SET DEFAULT nextval('public.sensore_id_sensore_seq'::regclass);
 A   ALTER TABLE public.sensore ALTER COLUMN id_sensore DROP DEFAULT;
       public               postgres    false    220    219    220            �           2604    16431    serra id_serra    DEFAULT     p   ALTER TABLE ONLY public.serra ALTER COLUMN id_serra SET DEFAULT nextval('public.serra_id_serra_seq'::regclass);
 =   ALTER TABLE public.serra ALTER COLUMN id_serra DROP DEFAULT;
       public               postgres    false    218    217    218            �           2604    16476    soglia_allarme id_soglia    DEFAULT     �   ALTER TABLE ONLY public.soglia_allarme ALTER COLUMN id_soglia SET DEFAULT nextval('public.soglia_allarme_id_soglia_seq'::regclass);
 G   ALTER TABLE public.soglia_allarme ALTER COLUMN id_soglia DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    16466    utente id_utente    DEFAULT     t   ALTER TABLE ONLY public.utente ALTER COLUMN id_utente SET DEFAULT nextval('public.utente_id_utente_seq'::regclass);
 ?   ALTER TABLE public.utente ALTER COLUMN id_utente DROP DEFAULT;
       public               postgres    false    223    224    224            Z          0    16450    lettura 
   TABLE DATA           M   COPY public.lettura (id_lettura, id_sensore, valore, created_at) FROM stdin;
    public               postgres    false    222   nE       `          0    16492    log_allarmi 
   TABLE DATA           [   COPY public.log_allarmi (id_log, id_soglia, id_lettura, messaggio, created_at) FROM stdin;
    public               postgres    false    228   �E       X          0    16436    sensore 
   TABLE DATA           a   COPY public.sensore (id_sensore, id_serra, tipo, unita_misura, posizione, is_active) FROM stdin;
    public               postgres    false    220   �E       V          0    16428    serra 
   TABLE DATA           ;   COPY public.serra (id_serra, nome, created_at) FROM stdin;
    public               postgres    false    218   �E       ^          0    16473    soglia_allarme 
   TABLE DATA           j   COPY public.soglia_allarme (id_soglia, id_sensore, id_utente, valore_max, valore_min, azione) FROM stdin;
    public               postgres    false    226   �E       \          0    16463    utente 
   TABLE DATA           ?   COPY public.utente (id_utente, nome, email, ruolo) FROM stdin;
    public               postgres    false    224   �E       m           0    0    lettura_id_lettura_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.lettura_id_lettura_seq', 1, false);
          public               postgres    false    221            n           0    0    log_allarmi_id_log_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.log_allarmi_id_log_seq', 1, false);
          public               postgres    false    227            o           0    0    sensore_id_sensore_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.sensore_id_sensore_seq', 1, false);
          public               postgres    false    219            p           0    0    serra_id_serra_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.serra_id_serra_seq', 1, false);
          public               postgres    false    217            q           0    0    soglia_allarme_id_soglia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.soglia_allarme_id_soglia_seq', 1, false);
          public               postgres    false    225            r           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 1, false);
          public               postgres    false    223            �           2606    16456    lettura lettura_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.lettura
    ADD CONSTRAINT lettura_pkey PRIMARY KEY (id_lettura);
 >   ALTER TABLE ONLY public.lettura DROP CONSTRAINT lettura_pkey;
       public                 postgres    false    222            �           2606    16500    log_allarmi log_allarmi_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.log_allarmi
    ADD CONSTRAINT log_allarmi_pkey PRIMARY KEY (id_log);
 F   ALTER TABLE ONLY public.log_allarmi DROP CONSTRAINT log_allarmi_pkey;
       public                 postgres    false    228            �           2606    16443    sensore sensore_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sensore
    ADD CONSTRAINT sensore_pkey PRIMARY KEY (id_sensore);
 >   ALTER TABLE ONLY public.sensore DROP CONSTRAINT sensore_pkey;
       public                 postgres    false    220            �           2606    16434    serra serra_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.serra
    ADD CONSTRAINT serra_pkey PRIMARY KEY (id_serra);
 :   ALTER TABLE ONLY public.serra DROP CONSTRAINT serra_pkey;
       public                 postgres    false    218            �           2606    16480 "   soglia_allarme soglia_allarme_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.soglia_allarme
    ADD CONSTRAINT soglia_allarme_pkey PRIMARY KEY (id_soglia);
 L   ALTER TABLE ONLY public.soglia_allarme DROP CONSTRAINT soglia_allarme_pkey;
       public                 postgres    false    226            �           2606    16471    utente utente_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_email_key UNIQUE (email);
 A   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_email_key;
       public                 postgres    false    224            �           2606    16469    utente utente_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (id_utente);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public                 postgres    false    224            �           1259    16511    idx_lettura_sensore    INDEX     M   CREATE INDEX idx_lettura_sensore ON public.lettura USING btree (id_sensore);
 '   DROP INDEX public.idx_lettura_sensore;
       public                 postgres    false    222            �           1259    16512    idx_lettura_timestamp    INDEX     O   CREATE INDEX idx_lettura_timestamp ON public.lettura USING btree (created_at);
 )   DROP INDEX public.idx_lettura_timestamp;
       public                 postgres    false    222            �           1259    16513    idx_sensore_tipo    INDEX     ]   CREATE INDEX idx_sensore_tipo ON public.sensore USING btree (tipo) WHERE (is_active = true);
 $   DROP INDEX public.idx_sensore_tipo;
       public                 postgres    false    220    220            �           2606    16457    lettura lettura_id_sensore_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lettura
    ADD CONSTRAINT lettura_id_sensore_fkey FOREIGN KEY (id_sensore) REFERENCES public.sensore(id_sensore) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.lettura DROP CONSTRAINT lettura_id_sensore_fkey;
       public               postgres    false    4785    220    222            �           2606    16506 '   log_allarmi log_allarmi_id_lettura_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.log_allarmi
    ADD CONSTRAINT log_allarmi_id_lettura_fkey FOREIGN KEY (id_lettura) REFERENCES public.lettura(id_lettura);
 Q   ALTER TABLE ONLY public.log_allarmi DROP CONSTRAINT log_allarmi_id_lettura_fkey;
       public               postgres    false    222    228    4789            �           2606    16501 &   log_allarmi log_allarmi_id_soglia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.log_allarmi
    ADD CONSTRAINT log_allarmi_id_soglia_fkey FOREIGN KEY (id_soglia) REFERENCES public.soglia_allarme(id_soglia);
 P   ALTER TABLE ONLY public.log_allarmi DROP CONSTRAINT log_allarmi_id_soglia_fkey;
       public               postgres    false    226    4795    228            �           2606    16444    sensore sensore_id_serra_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sensore
    ADD CONSTRAINT sensore_id_serra_fkey FOREIGN KEY (id_serra) REFERENCES public.serra(id_serra) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.sensore DROP CONSTRAINT sensore_id_serra_fkey;
       public               postgres    false    218    220    4782            �           2606    16481 -   soglia_allarme soglia_allarme_id_sensore_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.soglia_allarme
    ADD CONSTRAINT soglia_allarme_id_sensore_fkey FOREIGN KEY (id_sensore) REFERENCES public.sensore(id_sensore) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.soglia_allarme DROP CONSTRAINT soglia_allarme_id_sensore_fkey;
       public               postgres    false    226    220    4785            �           2606    16486 ,   soglia_allarme soglia_allarme_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.soglia_allarme
    ADD CONSTRAINT soglia_allarme_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(id_utente) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.soglia_allarme DROP CONSTRAINT soglia_allarme_id_utente_fkey;
       public               postgres    false    226    4793    224            Z      x������ � �      `      x������ � �      X      x������ � �      V      x������ � �      ^      x������ � �      \      x������ � �     