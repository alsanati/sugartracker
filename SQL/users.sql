PGDMP                         {           postgres    15.1    15.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE     p   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3841                       0    0    DATABASE postgres    ACL     2   GRANT ALL ON DATABASE postgres TO dashboard_user;
                   postgres    false    3841                       0    0    postgres    DATABASE PROPERTIES     �   ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'h/hY+aKdyYI3DoQ8ATUPfpcKOWqVHFeqkzd3m9y53obgYQFXXtAZYYSIp2nbzWT5lsCKs2D5wvY/zB8+CV9uNA==';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '60';
                     postgres    false            &           1259    29128    users    TABLE       CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);
    DROP TABLE auth.users;
       auth         heap    supabase_auth_admin    false                       0    0    TABLE users    COMMENT     W   COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';
          auth          supabase_auth_admin    false    294                       0    0    COLUMN users.is_sso_user    COMMENT     �   COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';
          auth          supabase_auth_admin    false    294                       0    0    TABLE users    ACL     \   GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT ALL ON TABLE auth.users TO postgres;
          auth          supabase_auth_admin    false    294            �          0    29128    users 
   TABLE DATA           A  COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at) FROM stdin;
    auth          supabase_auth_admin    false    294   #       a           2606    29253    users users_phone_key 
   CONSTRAINT     O   ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);
 =   ALTER TABLE ONLY auth.users DROP CONSTRAINT users_phone_key;
       auth            supabase_auth_admin    false    294            c           2606    29255    users users_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY auth.users DROP CONSTRAINT users_pkey;
       auth            supabase_auth_admin    false    294            X           1259    29287    confirmation_token_idx    INDEX     �   CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);
 (   DROP INDEX auth.confirmation_token_idx;
       auth            supabase_auth_admin    false    294    294            Y           1259    29288    email_change_token_current_idx    INDEX     �   CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);
 0   DROP INDEX auth.email_change_token_current_idx;
       auth            supabase_auth_admin    false    294    294            Z           1259    29289    email_change_token_new_idx    INDEX     �   CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);
 ,   DROP INDEX auth.email_change_token_new_idx;
       auth            supabase_auth_admin    false    294    294            [           1259    29296    reauthentication_token_idx    INDEX     �   CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);
 ,   DROP INDEX auth.reauthentication_token_idx;
       auth            supabase_auth_admin    false    294    294            \           1259    29297    recovery_token_idx    INDEX     �   CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);
 $   DROP INDEX auth.recovery_token_idx;
       auth            supabase_auth_admin    false    294    294            ]           1259    29311    users_email_partial_key    INDEX     k   CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);
 )   DROP INDEX auth.users_email_partial_key;
       auth            supabase_auth_admin    false    294    294                       0    0    INDEX users_email_partial_key    COMMENT     }   COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';
          auth          supabase_auth_admin    false    3677            ^           1259    29312    users_instance_id_email_idx    INDEX     h   CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));
 -   DROP INDEX auth.users_instance_id_email_idx;
       auth            supabase_auth_admin    false    294    294            _           1259    29313    users_instance_id_idx    INDEX     L   CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);
 '   DROP INDEX auth.users_instance_id_idx;
       auth            supabase_auth_admin    false    294            d           2620    29319    users on_auth_user_created    TRIGGER     w   CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
 1   DROP TRIGGER on_auth_user_created ON auth.users;
       auth          supabase_auth_admin    false    294            �      x��}gs�J���_11��*o��"E'z#�ݍ	���|���fQR�h����ۭn	���<'3+���΍/_��MH�y�m|�aa(eB�0���Z�ɿy�u�L׃�[����ʛ��r���փ��s���o�A����?��C��Df�s;b4^��z�~y<�/�^Jӄ�
��h����`�������S���I.)R�P�#ƹ���$�<{D�H���1IB����"���A��>s�L���J��b���>O���/g�Ah��|��?�����?���+�������������ssu��v�����+��=�q֏�p�������џ(�.4�I�0�B��^�Hqi0ܥ@�W�zp��_={M�ը�٤_=.�izM.Mn0t��`�bj��Jo��~��ѱ�}��L|^�����f�Da��1$B��BP��E>��?*T���wv��3G�\�HhEy܊��:G�]*��r���%Bb�2��!�/����"�4�澢�=���ZU��{��=�ܻ��zy�Ү.���ꎘ	2��J��`���o}^Q�VK�k�`B>)�L�}��%H���%"�{2�����=3�2�9$�Vկչ�X^��t�#W#8JcP�s#���fB�x
#�+�iF��ԇ�P� �6�wm�("��|��a���w������$]g�L�(o՘3o���W.�\��L���"�^�f���n���t 4fAD<���0�Q(����pOJ�<	,��_�b�̟�m��;��I�7���G�D�Db����g��G.ӄ�8ܑ?e=*&��x� G<`�S>��]����ʌ?��x�5nh�4?��)�/�N^<�Η��ߔ��e���y��ġ�d��f>,�onm�p/v뗄+)��Ҽx���RA\��o/�Rq��׉�\][���$�EO��a����"�)z�L�P+4�� �|F>���p�IM����g3?w|͕J��m�K�t��ֻ[��d��m�{�V�/��"q( ̋F���&��"I��!�
#��=���ۥm���)pj��X����S"v������9��q�>�$������<����(�����������/�{��1s<�&�C>��l��LE����i��6�S#���4�CH[�/�)��W(�E� �k}"8 � *���  H	j��� ������`pM����Ae��:[]~�~��G�֊Š(Dh�q����ÄO_�qq0�Ch�꾢>��5�T��h�&e�"W�ֹw�{��Z�$�H��F��N�)�[˄P���#p� �!D�=�-�@y:u�qhX 08�Rs��9h�Q�H$��/#)�Q�� �� ������4q+�~|��H��/�	��8�٠��3�.�R�8�Pp6�X�	��ӑ�.�vt�� ̃�*����w���V��K2�v�k�<.�ꛪ;D/.U@"�~S��n�&zg��Q> �:���:����ow5aL�oz��c/�8"6�A��zڢ`}��"iBW xS�۫���_z��4?���+"���S�G�K�"�9�xH:�����*d���
���=/1EdP_����Dm��Uh��\g��M�(�}��$ǣ�W���'��B)<�'Ŭ�`�?���}G#7�`ڟi�rEL�7-�%pi�E=B�@�6Ҁy1�hD�C$�LD�C4b��u����-��	Eo��t^���40l%xMoX�zB!5H<�`ܬ��,U�e.��µRWj,~��/iF1�G�+*�Ե"�N�0ED�DLD�#"	`SpqVȓ�i�x0� ����-�=��^7X�����5��U���n����q���Z���䮛�{�̆�.:� �0�	�&�)Mď����\�Mp�LjpB����{<��q,�|���}�f��6�H=�K��,�3�s�M̫x嗧�8��Q>Y�W*�=UR3w�o���v1]f������A��BPJ�2������p?��ǊTK u�Z�:�Pǡ�P�ls���杀�bw�"\��c�6��8w(���LbT�L�OQK3w�/t��V�W���DgE�%�Y�(sk��Ņ�L1�z �������)}.� �k-�L5X
�(d-��JB#'R��*��x�D��������|X���H�6����j�~=����6�\�N��z�T��\����_����m�����g��*���i �������7B5��	t!H�=�}a'���%[� a
.��E�k�ԯ����$���L��J0Sڦk8L�{�Uw��N��4G�@����.5�NĜb�8���)�HLF� ���"�5!�"�i,t�B��MnGy\·@��9����kE���^�5����jRj� ���K�X�F�F}�e����ed}���\��)�Xn��3�����q&����I���х&�ň�8l"
�H'B`@�"�'9�	��Bb�����w(9N�o�(���M��J����6H�`ٍZ��?j�T�3��n5ǴXL��Pp	RB�?��_�}��b!�A�* 'W`��:�x�4gB�1^`���nL�Dr�*#��*��x<;��������N�����L>[-����M�x&�ǁ���"hD5����������H(��Ϥ���L®��'1�}>�c!t����fl�2=p��k/�v��,bW��6��6rlhb�V�y]�rj�:�龽Xe��Z����(�Rm�֩E�x�/P"��L~�*��J���� p�<^"�B�%�B�@L�i��bڦE$�`HqPn��e:bK�Qd�iE�1�a��B�j�` ��pY�r��\�V���B�������;h�Q�u�虴p�&7���=�WZ�r�|^)s;�x�-�����.���?�y+��Ϗ��r���~~�C��/rB����C�h�'���DJ���O�!��wSA��p�?*\�Jϓ�ɠ�7�T7���*�)W2�]}K����	�̯��={��)�F] ��;�&J�$�{�"#��K{`�¥v)�\��<��@/������Z	e���I	�[�v<x*.v�B�CY/��|���V���F�Oϛ����F,e�)�+&뗷[dIG�~�L��ϳ��W��kM���-�e����6�!@S>2��0��!!Dw� �1Cox#-+���{��Z-�/]$2��~m���,�7#��k:���~������(��K00-ہ$�s�@��i��9]��0�/TG�:QA�(��������� :~��薐l�~�����a�Ku^��]6k,|�%�ͨ<�����R6�L�'��1Y�,�a�p(����O���B!��'�Ϥ��?�N�W�L�K\k���'��qD�����w��A��E��Ͱ�5���kϼ�Y�:mχ�vT�'r��K�g{2֜�%�J�A��:��2~�M�;�V���g `��.Q�����3iN�ω��� �si��!X��e*]H��P�o"6H �%�b ���9ME��-�`B�=T�=fd�o�Iu��oW/:�0��l��o����j�O���^��{��/���P�p���L	,)�4��맺�}z�ȍ���}	�C�~��~����{��	��Wx��"M��H��M�83x�k�^���$�����ZM�Mf7��Tq̶�j��T}�&��S~��m.<~�Dt�E�Ik�~N��V��^�
�|��B`�⨤"p,�r�l��2G3�6������-�Tq�r@��m�%E;���z�5ڦ�������J���c6ߕ��o���ϸ�~��"�)�4�%M?q��!�犜"�n`�S�&%���/�d L��
c����1wB�I?�}e�#e��C%҉�P�S�����d!cʣU�}��ވ�]n���IG��x��������X�[��_�\�+��R��rA�Ʊ�
IC�},�Fp�s<F�HQq��-�$��:#U�oW��*G�{��̞���3���� J��:6�&z�
�C������w�bs>�v�bM9���3iA>`~��    �F�*I+�O�d�d;������H8��|�#�v�PE�q��a��h<<U�o�{�dm�>l�u1��V˃�x�[-��\�2n����5�+�KA�ۙ`sy��a�1y��-����lE�n�
[CBH"KU�AHT� �c�����hG ����y*���jbvF�� ^�/s�mC�李qj#HQ��x�e�n0Y�j��(�X�Pv�Cq�1P(�r,�c=ڟ��C~�v~@��:hs�L��C�8����-@�V�Q���J��E��,���f��&���{�j3�^��h���ĝz"��v��L��mBm���.�nN�T��9X�t,���B*�՝�ꅴ�H�D]�h���ŋ�l�z"Ș,��8�a|�HkGR	���ў
N.%<ߏ�</������~ �6���*OV�]�C3Y䙚�4W����^�a�߿'y�rl^��Lsy?�q&����lE$���� �{�֊��UpJ�DN�08(E|Gc��Ph�$#���7��6p_7�2��,���*��dw/:��Ri�AA.j3�?^U�YZnN3�%B��[�� N�	3�~���(�� �G�ݥ ���%��u(�C`K����"	�É�p�{����S�]	��}��c�R��>��썜��#>;P9�Q�;(��qt��ܽ4{ �6����������?4���#�ɵS���E(�b^H�Π�("��S�p����z����v8���՛�zc�]�%.S�z��V�S�W{��)�+M���~#R3z��o�J�����:93}�Rl��P�3�A|�f�����3 G��ɖ�l}ܒ�e�*�T�+�r�H���৘!����x�3�`�__�k�����¦�2��]qs&U��'����J�3�L�ՠ�-nX����~4WpN� ?}I+,��w�VĄ�H��u�� ��4}��lmA�\;,4��|l���c߻߄���������G��޼s?��)]�Rݚi�rU
�⺘�P���I<}�L)ï��ۥ�8e���	����ϸq~ľ��Uvg��������bN��9Zێ�2E�A��Q~�n�S��n3~��L�;�(u\��&^Sb;����rK�`�Zμ�Qg����Oq��z���Ka��-�W+��jx�tR���}�oR��j��"�9~���a����7�zѕ_"��]�ם҉ĪU���L�Vnt(5h�-��Nˌ[iU�f���V��r�s��~�Ka���+.�n*P�d���X� {��D�PJ�:��)<�||7YFw��^��(/V�Hm�K�6�7U��r�$��d>,f	�DS����n�N��@-����Nu�BZ �c6w� �L�rJ�}l�
���s��'��A�����j��=�Yܯ��рY�$ׯn��#}D�&U>�����˻��UgHW���ӫn�~��i���5k���e�`ȶqc���K�ϥil�sE�_�Cۤ8U��&G����'�P��<f����R92��>0n� <����� W����p������ߛ��v�=u�����{U���UR;A�p��(Ԏë�'l^B�KI�E_+�m`u��Ч����?)����p���f�ˆ�с�a`%%}�]vz�_�z��������Y�)tޔ̞�u�S�Lf��W�I��#��Q5�3v��d����)�]
�ӈC�W��Xz��|ˑ�m�aF<H
���Av�2��0p��%�8Cr?�U�;+�]�+:4�o6xns��}gكn檒�y:Hl�C�ZL��~�[ԃ.����E~1��0u&-�O��\�H�`�\�2P���:�^��B�Y������@�D8�����Z�ǯ[���[�rO꩙�Mgj�n�9���\=�҅�V�^���)����t����"rv�����]���w�G�Ҝ��K���Rj*/�G��!$)�������5 G��L��+�;��<������U���kU�ko���Q����=+�3�m�j�1���[/��Ţ�n���LM���4ȩ{[�s��c�I[�.~����.��\VTsKS���!!R`jgAy�|EA!�>�x-�}� ]��ݶ=:� ���jPxW!��y��//ۋr��^���/���d��ܾKrm�p朱m
�h�F�Q^��?�kq� Ҝ�K=W�$��f��IhR�;��cS����vp�$��x�����^a�J��)�F�����s��,�z��-i��9����-�����O�`�7��g-0��0{)������ۊH�K�m����-���;<���փI�Ep�hjB'�!�=�u�C�[s^sO.�����c��I�����l�'�|TL��&1�v�Վ��dX}"�^��c��E6q�>��.Ϳ
?�M�Ϗ���M����]Ɓd�RO��mq� �p��"�ǩ=�T�`N��V����E�r�ȧ���-�`����ҋ�a�
�y4K�Eg0��U�%W�'6+!Ff:R�K_Llw����$hJk��m�VD�����dq`[%����8���c7$9Zy�CPd�-̓-�A�����,Z�fŬ��8U��0}j�f�<���k��:-�j�^��z-�m����Kw�l�<@T��B~Kk�d��+r���H����
I4�#\h�� �	�%(�5�Gc�b�#'��#���vEޝ��w��6|ԛ3޶��Lݟ�	��縋��7<��[M~�ԏ==̂w��G��4���\�Q�����t�Ǒ�2�� cG3c>�o|�C��!N �B���zb��l�9)Gު���)꽪�=�OM�2�j^���:ֲ��!_�]]ifz�k����+�ӊ��Z��/V�B�EOIs
�/����\p4��/{ȎK�G����v�Ń���MEl^�����ջ�^_�gr��Įz������uM6Ƚ�H���<�?G�@��;�]��R��Qߤ%c���_+"ʹ�i���a|ۄ�'Th�&	�������0�!bL��Ջ�7
�v�Q4����s�i���4��ˇ�4[�&ie���(�x߇jVK��/� �|ݪR�1��_3���dx6���P%��!֊�����	�W~��>�6���X�����C߀E���<T�!�ڣv�������Jq�G�ꤴ^��d�2�p����v�Q^γ�@���w�QnU��Nݽ ��N`��������
^��0v�~��
�I��l!�:�U1N�j	Y(��d��F�ލ��֙��D�-���k��frڜM+ٹg���ݒu�i�Y�\fO#]%Q�7�I��Ά�Xb��7X���*�"�B��l��E��!"G�u"`�RrME������V��5������7�b�2���J�^���`���u�0}SO�}�H���|��)s��w��c��%����}E��Ҵ��!S.'"�Ff/�����0�����3
��U��]�V��F�/��k$��}�`���'�+�jE`��赶���F=�L��)կ�
���'ȟ�?��礠��Ǌ�o.`�W�Ў�"D�2r³�*@�sñ��-�_h���c�A+N�A�N���B�����K�0���4M�z��hk�Xu����P4��d�mE�A���w�[ǽ|���[ ս��iN~<(����+hKO{��-;q�m��a�x��l��@n�LİM����m\��2˰7�d�7��a���2�boژD��{䱧F��Y����+��m�]�o�)��C�PP��V�bQ����oŌӐ"`X�aL���[Dh�rP�C�hh�"�?�����D�l��l��K교��r�M����u�1�媍�E��A)��d�/����������}p��q�
E7�1�/i0���I�+J)ɥ*N)D�]mg�����H:vv��F����C	C�K"�Gi�ÿw�M�/���aj\��.mx�Vy0��qm:���0���m/�p���k{�v�U�pm�K�	���f��c����-�� ��nS��v���8ĩ� �Z�0���� ҁ�G5�U66}�y���ڪwT�%|6`i÷�_H��j�;���de���ۉa���e��Tz�����&8;l�s �  ��=]����_������}:!E�ZE~��m��[��	� b+�=�\�����.�6]��2Xe����M���Mo��l�����[�oG~�[g���V���!���ke�Q4
+�����f��[%/VL����I����X�m�H�@	�(`�W�;��s`" ��!��0��:��u�zƸG�ӓ����$����z/�mu_J��k.U\����S����7�D_�6x��R�yg�È�[X���˿/h���� �8�m>�(H�8D�c[�C�����)4�{4B���ζ��{���)��"�ȭ��/�h_lj޴��Z5u�/�9y���d�(�//T���W���>�9b��=~�� ��R���̎��c�EA��q�G���9��`Y�������Y-��璏��PA�-{+l��1�N��IS]�^ǫj͕�Q��h��$�!���6]	J����m��|\J3�Ӎ/+b)�U�����<��f���ii�L	�ׁQ����������`���NM��3�������0ō��$[����j�]~^�̻��<#���t�A�uw���~&���o68��게� N+2�5�Vt�<�T��<D`��%��mF0�K*�$!PG���>��drc\EeG�d��S����(j�o�Q�Z�t�E�Is���1�������,�G-MbB��;}I3�w�\Q��Jʂ�§�QZ�Xt��Zq�����_v�fa��<T��=�7�^���i���r�Z��]�����QOុ�%o�k֓aa�ɫn�8����XPQ+B�@_�L� ��RRr�(�)GH�V$�(�nb���=(l� 
�����i�6��5��B�P�Q��2Q	��ͺ����v~����%���/�����@�N\H�O"���F�ǥ���ۙ_7B�4�,��f�D�!?p(g��	E�� #C*1�$��7�6�k]�Y4vH����*�)��6�Ԧ<(�������vf����R�C6۬�/C9���a����}I����+"��-]|�O�3[a�1x��0
a�4Z�,���H��,�]ԴZ(�^-��Vf�ՠ��f�W�_<e9��RƯ-��o������]�|y�܎��\�.�Kۖ���٭�r�WH�*4��~g���`�@ܶ�V�v�'</�os��S��r����?�6q��9^��'&�Ǯ���A%�[;����ݖ��*�e�fs�����˰H�[�R���e�V65EXǄe����²�D8��c��Pe��D|[5�E
C��4�l����}/��l���_�����5m'�-oܞ�� �h�Q���*ϫ�����}ܺ�O�R,L7��;���><m3�w��
��*�<?��ӱ��#�Ǒ�C��mL�h�9L�M�ƾ������3�7K3]������y9�s���Į��;R9VFz�L��h�Y?��6,�i���5�o�e�4ߚ�����K�`�N=�R0����D�*�:ʄ��ڦDGF�Q���H�+wX���!�;>� #!�_�{7�=v�b���o�}�)7;RZ����N��G�uwZl�|{��d˝v�_�..�5� ���7��RZ�"�\���ZD[�@�%�q�A�c�j�6����㎉<�U(Xu�F1[��4�	:��|I���z���휙�}3��V�m}U�zKE���|�j7k����t '�h�6�-.�)�)�8_���a���i09%X�82��u ��Q�J���N�#� z�7���^}�M��� <n2-��y��Ig�&����z�h��{/�h7Yw^
hSt�c6��7�/B]E%���|!�O�FS�s[��#A�����������:���}�"�����!��c��I������������i�۹����T6xڬ�r0�fO[�41�߯6��7sЩ�v�=i۲b�O=������#a������Tp���`��������#�Mנ���������f@;֢M���	�5i8��*��䮚�V������
�E`Om�����m�����f9���1���Ax�v�nۿ���h`��z�17^���X�z�y\:{dCq�!x���,�|�;����B���߯���}_�Y��W1����?tk�0�3��oF�Z7���v�ToP���ZߍK�<�p���'��a�����0:)�����BZ��W�]�H��^�<��*�olׂ�����y#"�a��P��Fy;��^6�ԛ��D�uzS��i�â�}����Pw���8��v�ӛ��
WLN��a�"@N��z)����+�_�ޔxq�K)ܷ4�� �)@ʃ���s<_3#��̓W��6s����~�Hz<��U?�J�>��D�oƯdvE�'l�{�v�-��
�L���:6��Ђ�{{�/���Ņ>V�~�w�z����Ǳ�@��q�Ƨ6Q��!�ABi@���0`����OcB���Ehҥ��AV:媻�6P���Nn��P�u����挵����������K�檻��\����/V���s�?�M2�J�D,�\�ȗ�:���1�x����փ0�=����_MV �|d�/o�r1�V
_��U�D#�ݼk��tќ5�h^�s�r���v���sw��ڗ���󗴭��0%y�"QD� ������,�!�9��싯���p`$^�{���z0g]&��Q��_F�V	��c����7��<�R���N�As���i�����.����*�����p),&����R�{��4 ��[,Y0P>p���� .V9�eԡ4="�����󮀊���Q*?/$�>{A�ed���'�Z�T�F�j�1���~ ���Ȓ8��5:��Ǝ1��NRu�XS��T����3��9�R��&���X�X��"%l	�g'�� bv��{4���x��ƾ�����<f<Y��	���E��7���t�J���eߨw��^�|���vp�]Y�c�B�� �K�9,1X�ǊR(�n�ln{�����D�"��X���v���D~�i�1����f2�����SMr�L+��M�~��d+�}a�IlU����]z�҃QR.ծ�U��鱘��>���Ӻ�K���C�5q&x����+2��y��� `��������E��k�Ʀ�#�ۚI��Hz�(q����M{�H����W����������Z岤�6�e�!�y��!+��}��U��:��8�x��-׹��E/�9�9�8[�>��`6)��6��������+-��     