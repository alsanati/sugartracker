PGDMP                         {           postgres    15.1    15.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     p   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3827            �           0    0    DATABASE postgres    ACL     2   GRANT ALL ON DATABASE postgres TO dashboard_user;
                   postgres    false    3827            �           0    0    postgres    DATABASE PROPERTIES     �   ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'h/hY+aKdyYI3DoQ8ATUPfpcKOWqVHFeqkzd3m9y53obgYQFXXtAZYYSIp2nbzWT5lsCKs2D5wvY/zB8+CV9uNA==';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '60';
                     postgres    false            (           1259    29148    diabetes_sugar    TABLE     �   CREATE TABLE public.diabetes_sugar (
    created_at timestamp with time zone DEFAULT now(),
    "personId" uuid,
    sugar_level bigint,
    patient_id bigint,
    fasting boolean,
    id smallint
);
 "   DROP TABLE public.diabetes_sugar;
       public         heap    postgres    false            �           0    0    TABLE diabetes_sugar    ACL     �   GRANT ALL ON TABLE public.diabetes_sugar TO anon;
GRANT ALL ON TABLE public.diabetes_sugar TO authenticated;
GRANT ALL ON TABLE public.diabetes_sugar TO service_role;
          public          postgres    false    296            �          0    29148    diabetes_sugar 
   TABLE DATA           f   COPY public.diabetes_sugar (created_at, "personId", sugar_level, patient_id, fasting, id) FROM stdin;
    public          postgres    false    296          Q           2606    30482 $   diabetes_sugar diabetes_sugar_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.diabetes_sugar
    ADD CONSTRAINT diabetes_sugar_id_key UNIQUE (id);
 N   ALTER TABLE ONLY public.diabetes_sugar DROP CONSTRAINT diabetes_sugar_id_key;
       public            postgres    false    296            R           2606    29799 -   diabetes_sugar diabetes_sugar_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.diabetes_sugar
    ADD CONSTRAINT diabetes_sugar_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.diabetes_sugar DROP CONSTRAINT diabetes_sugar_patient_id_fkey;
       public          postgres    false    296            S           2606    29787 +   diabetes_sugar diabetes_sugar_personId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.diabetes_sugar
    ADD CONSTRAINT "diabetes_sugar_personId_fkey" FOREIGN KEY ("personId") REFERENCES auth.users(id);
 W   ALTER TABLE ONLY public.diabetes_sugar DROP CONSTRAINT "diabetes_sugar_personId_fkey";
       public          postgres    false    296            �           3256    29411 9   diabetes_sugar Enable insert for authenticated users only    POLICY     �   CREATE POLICY "Enable insert for authenticated users only" ON public.diabetes_sugar FOR INSERT TO authenticated WITH CHECK (true);
 S   DROP POLICY "Enable insert for authenticated users only" ON public.diabetes_sugar;
       public          postgres    false    296            �           3256    29412 /   diabetes_sugar Enable read access for all users    POLICY     c   CREATE POLICY "Enable read access for all users" ON public.diabetes_sugar FOR SELECT USING (true);
 I   DROP POLICY "Enable read access for all users" ON public.diabetes_sugar;
       public          postgres    false    296            �           0    29148    diabetes_sugar    ROW SECURITY     <   ALTER TABLE public.diabetes_sugar ENABLE ROW LEVEL SECURITY;          public          postgres    false    296            �   �  x���Kn+����"��%/⮠'�*{�4�r�tJ6��2��_?)-������h������;.FP�+/��}Q��������~�����7}����%UE�:N�W����Jǉ��	$��L����-���8�{���QM�3��cNE���^�D�>�<~�SK�d¿��$B�䂒$"�b݊���E6��^�M����U�w2�;����:��O[����T��ýE���۾��R7�-��~�d�Ȏ'��vQMT�p�?��8?�^�����������2L��_�����e�L/x�����0��z!-��՞}<�T��*<n_�Te�T���U�Y�%�V<�9Q���+\Nn	��wx���h�r��,��y�A��18p�׋;jq�|QH~V��6������e¾��&��'Qc����}��j� )���ɳ�?p�7�j2^���=x���fR��l��xH�)a���G~}��� ��ˋp�0��ƨ�_�F��`!�/����]�E����TenU�mkU9+�q�vxaՋXRt��j�;���q/�P<9�߾s��xD�R�m��qZq�Z��*�_x��ۍ��ܖ;[�j�e%�e�mV�;݈WW��y�K�B6���y%�UЛ�1�0�L�8��H�jGt����U��5���	?y��kB��<n�s��y)��h��W4o\�}3�ǊvhmƏ��!�C-m\�u��F���\i�˾�{��=	䦖Zc���E���ن�L��o��MK�M�y.�1x�I���V�'<o	u ��7��/$�k�Y����RH���m���rD�:R�O�����:��
o�GVź���Entu�Y�EyS3$�w7��zW��Ò�H��uoN��o���֦vٷ��~'t�~u���p����;�z�5��cI�?��y�ӊ_�Gm��-܊'�K�m)��O�E�ܬ..�m�������7O�-zS�a^ǻ�x���Q3�Ó7��ģ/M~�����r�|d�a�97��M� ��军y�b>­��.1��o��?���N{/��x�NJV�y�O���\��ε�w,ټ-�����x".�َ�3ī��}���ɑ��b̾^�����^!�LHV�D߃�����6>��q��Mh�>H(����=?@8�$J/0�����/97d��jr�g���d�s���w#�͢�.�\�yW�g��x^�@�������n��--р
O����~�ػ����PG����I�yB���Ϋm�m�ipA�Ug6]t��;��{'
O��8/ŦFB#e�	��8�ų�p�3��^{��2Q������t��m.ը�m�x���~���k&��N�;xmO{3S����FB����ՠ��=�"�u���꼫��7o�����E����G��k�Q\J1i�a�*nނw'o����oޔ��J.mqF���V�!	Rf�Cu��¾>OB�%!�c��߀���rC�wV�~�u�V���XG�̋�^[X9F�wy.�����ø�g8�]I.դ�'�r�5�
�b���Q�׋��Wd��f��^��������.=�*�=kso��k��+K����<�F�s��S`3��y>��l8�Љ��ko��W(�0>s߰ϵ�;��[xa+�<,=��9'.�x}.�]�y��%S��F��>rEvތ��f��'�-����ԉ�A��q�ь�(M���:j�I��������kA�3��e�I��a����0��,y�E��s?P4^��0)zƕd�(��<�^�;l},��e���\���೵�̌��}~g��df���=��i���AGeF��\��=���!z�8��ڡ吣�K�+Lm:7�����׉�։gl�21
Y�־���R� <�$���>��K�A�� ����D#k����߿�F+��     