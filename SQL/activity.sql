PGDMP                         {           postgres    15.1    15.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     p   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3830            �           0    0    DATABASE postgres    ACL     2   GRANT ALL ON DATABASE postgres TO dashboard_user;
                   postgres    false    3830            �           0    0    postgres    DATABASE PROPERTIES     �   ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'h/hY+aKdyYI3DoQ8ATUPfpcKOWqVHFeqkzd3m9y53obgYQFXXtAZYYSIp2nbzWT5lsCKs2D5wvY/zB8+CV9uNA==';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '60';
                     postgres    false            8           1259    29904    activity    TABLE     �   CREATE TABLE public.activity (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    patient_id bigint,
    created_at timestamp with time zone DEFAULT now(),
    activity_type text,
    duration integer,
    intensity text,
    notes text
);
    DROP TABLE public.activity;
       public         heap    postgres    false            �           0    0    TABLE activity    COMMENT     ^   COMMENT ON TABLE public.activity IS 'Stores data about activities the users want to track. ';
          public          postgres    false    312            �           0    0    TABLE activity    ACL     �   GRANT ALL ON TABLE public.activity TO anon;
GRANT ALL ON TABLE public.activity TO authenticated;
GRANT ALL ON TABLE public.activity TO service_role;
          public          postgres    false    312            �          0    29904    activity 
   TABLE DATA           i   COPY public.activity (id, patient_id, created_at, activity_type, duration, intensity, notes) FROM stdin;
    public          postgres    false    312   �       R           2606    30850    activity acitivity_id_key 
   CONSTRAINT     R   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT acitivity_id_key UNIQUE (id);
 C   ALTER TABLE ONLY public.activity DROP CONSTRAINT acitivity_id_key;
       public            postgres    false    312            T           2606    29911    activity acitivity_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT acitivity_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.activity DROP CONSTRAINT acitivity_pkey;
       public            postgres    false    312            U           2606    30859 !   activity activity_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(id) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_patient_id_fkey;
       public          postgres    false    312            �           3256    30858 1   activity Enable delete for users based on user_id    POLICY     v   CREATE POLICY "Enable delete for users based on user_id" ON public.activity FOR DELETE TO authenticated USING (true);
 K   DROP POLICY "Enable delete for users based on user_id" ON public.activity;
       public          postgres    false    312            �           3256    30847 3   activity Enable insert for authenticated users only    POLICY     }   CREATE POLICY "Enable insert for authenticated users only" ON public.activity FOR INSERT TO authenticated WITH CHECK (true);
 M   DROP POLICY "Enable insert for authenticated users only" ON public.activity;
       public          postgres    false    312            �           3256    30866 )   activity Enable read access for all users    POLICY     ]   CREATE POLICY "Enable read access for all users" ON public.activity FOR SELECT USING (true);
 C   DROP POLICY "Enable read access for all users" ON public.activity;
       public          postgres    false    312            �           0    29904    activity    ROW SECURITY     6   ALTER TABLE public.activity ENABLE ROW LEVEL SECURITY;          public          postgres    false    312            �     x�}�1N1��z���#۱�x{J���&���Qp{���\�����Tc�� "dP� �N�#�97������Y�L��dM􈸍��u���J.�s���{{y}z;���=���&0/1��)%��3�dU�y�M˰��A�W��JW�ꔄ�6/{*T��jZ��BSV!iP� 7�u�H���NU���9g�Hh e!�]�06��=q�ㅕ��Z��j��^�CG�P�s��
����	I:��֤�u.$���L�ZrM�p��ә�p�)�C�c?�N��T��     