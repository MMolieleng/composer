ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# stop all the docker containers
stop



# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# pull and tage the correct image for the installer
docker pull hyperledger/composer-playground:unstable
docker tag hyperledger/composer-playground:unstable hyperledger/composer-playground:latest


# Start all composer
docker-compose -p composer -f docker-compose-playground.yml up -d
# copy over pre-imported admin credentials
cd fabric-dev-servers/fabric-scripts/hlfv1/composer/creds
docker exec composer mkdir /home/composer/.hfc-key-store
tar -cv * | docker exec -i composer tar x -C /home/composer/.hfc-key-store

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

echo
echo "--------------------------------------------------------------------------------------"
echo "Hyperledger Fabric and Hyperledger Composer installed, and Composer Playground launched"
echo "Please use 'composer.sh' to re-start, and 'composer.sh stop' to shutdown all the Fabric and Composer docker images"

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� "`PY �=Mo�Hv==��7�� 	�T�n���[I�����hYm�[��n�z(�$ѦH��$�/rrH�=$���\����X�c.�a��S��`��H�ԇ-�v˽�z�iSU���xU�^��R�Z!�h��C�&���֕p��=�`��1�7����_\���Q��1|��!<6e� sG�����H K���x��O�-[5�5��-S���*C{�� �������/ݑTZG�Ԃk~,�T[R�5{&�4�4����A5˱�,��f�Y��,�0�wT��[Pw�H�B�X���T!��ͬ�� ��_ �
�Km�I�e�huU����Z]�Y�L����Qm��RǠ8\W���d˖jbq��I:l�M� D/�;}{��Vq�`E�F�5	7�r��l�0��ڂF�A)�3kX
�P�@�o���H�mK�\4,S^�D��ax&�L�[k	�g葤C!oGx��j!�{���1�ղ�l����G1diL�]r�tq.K�L�F�
�� �p�.F�0�L�j��6����v�rqL�@�fu���\`IҴyD�h#�؋AѲ��(��6�Lw��R���՝��mP��A>�.}5[����a����-�A�9��%�?�qG.u߃�{ �!B
����zh��i�I>�௚�1x��ab��c���sN��G>��iJ�btuw�
���� ��_��,���g�<��ǰ��X���_Ej��Iv����%C@?y
d��QT���]R�lU
;���y{A�g4��k`v�9�	M�����0��,��9�U���B�����a����|����c�����Į���,'��9.�c�a���������d�E{F"��p��m@̈́��08�5�q6&����Z�u�f����O�f��k/��R;��yt�6$AR�i֐Q���T�6)��:s�87����O�\��I͐O䦄����Z��Kʷ^AM��լ�D�ʒ�����oL'̄$�lJ����G��p�p����'L�%dMM�� ]k���,��vKt��� ������H�/�B�[�I�Gë�\��P�\u��p�7V�Q����ա�~�.,�O],��Y�	��&��U'�������0���\ ��Q���@���8p��NTM#��[F�@����z�rS���D�c�O�Q�(�Ȯ?y��.L�N�Qj���d�E�W뀦�ۗ8K�Pn��B�p�";J��k�;A6��5[�\
�O�3UWqn����]I���'?Y�H� T�t/p-n�hk���@�A�,�sQH�/����d~3Xw��w�^Ǵ��0�f���b\pW�����S�p�1�q3;�')�l���reAl�"C�z�Ru�sc�1�1�]�_�B�_z/�(ʮ�V����4QE�8T�]���ll�A�ݦ*7�A���)��^J:(��ʆ�W�d�:�11��e�Ӂ��f�2x�S�xz��pw�0�'ǷSxFD�% 5J'/_^"Q�ݪy9��������x�ЖdJ1t���?F3��Ntg����|b���,�?7���˶�#�ś=C��.��WGJ_�_\��59���a5�b����v3�Ts��e�Ш�4��Q�ly��	U��V�*�r�X]��M�K���{Z]�[,?y@�X�,E9t�4�!YΦ�v�r%[�??��T�=�w �6h�6t^ %�n�0��a�%0�`�sС�fë�D9����(�,^���[�
��Q5�;ի�@�;˃�6D����F�0�z���2`�Ђ��?{ÄV�>B���_�7o������X�}��Q,�du�.�ݪA��}ͽ$*)`qZ\'
:\�^��N����8ϊ���B�{��Lbc���_�y�q��f��8&������ㆱ�?�r�r8I��,3��%b�B��w/���j}�u�T5���Pȴ`]=�ye�3���Q��0F�����Ә���^/�?����p�p��`���P���������n���?���([��C��"^�:Z�[��e�`Z��x����+v��+��\o�	�� ���4���#y��Hb���{�[ {!���� T������cDs�4�!��>RE��U�F��t���b���j;��鮣}���kpy^�O�QV��:�y$���<��#޹/Y䛱�.� ����^�o�<Q��Q�縅��>T���#�m����\��$�8ƹ�]��8L�:x�����=[��c!&̆�~*Lj�D�c���|�3���|[x�����?O,�.�^��=�K5�S�,0���E!��-ef������<�/�����O���6��|��b�������ۂ��?�#�?���?��w���W��=�ɿ�\f��j� ���Y�d��~���nV�/Qȡ9�;R�ĥ4��˃�T͊w�����!KZӰ���#��k���:䲏�v��hw�
�'�69�b|���(�Ԍޞ�:U�=1e�S?��1N`0�E�uA�:�;����;XS�AB�kh��qW!#{E�?"���Y�?����4&�l,��Ll1��������1�xy�����+��HE��e��0�B\	��ꅓ��\R,Wʻ���p$��ż������' T�d�g���bȕSˁ�����p��(!��1�BY<*�b�HH��b�"�Ti�*���� �n�$],d�������Q8ґ����=9
��O0�v!���3G�⮸���;����:�����V�HD�WČ�Z7�X��l�ەi�+bj����4����6*�]i�,���\w�lU��m�VEؚ���>���h7AH˶�	�� w�
t�%�V�Z��|�5�ڸ���;�Y�7u�h��Ň�$����������Z�Ȯ �S�m^�δo�r	) "������ujg�V�0�mb��+���W��b����K|����uxe��͒ŮO�~ר���?{+/�i�?���h�=��/�?�Ӷ�m.��d�A?��?� �����������C�+�G'��v��q	O'�2�H=��Fd��&���F/���F����� !x��ʻ��X��.��{�i���\
8Y��������/s�w�?�9�
�w�q��AG��J�n�F�zg�d���7�g��R����V�os)�$���r|t���\��_�OV�-U-��t@�gB��/��Z'��<�����
���K$��?��¹X�_�������r�ô^n�:�Y@Ɇ�s������\�=�>�A0�%�c	���f��=���L�
��N�O�����;��p�OC{�lx�xϭ?�2��p�K*���S���D�X�?ɘ�P��#��t��ĸ�v�{���j���
�o��&�Cy�mb����o0��n�e���Ϲ����w3ј���̢��7l���ihL����2���8�����I8���<E�

�g(�2��xx��-�Ѽ�J���4��:�װ�L�����k�h[m��X��^N���u�O�2�J��ŤzJ��/��Ѹ,�cU����*�@.^���\�.���pp�P���фcl!�I��eh9j]����tCR�d� %��ٍlJ��$�P�e����TJP2��M
�l)�[�ovv�WE���ߪ7y�y.l%����q�X*���d7W���z����-�2b���ιX�!R�#�����aK{�ś�Uq/�,���Y.��m���A�P��㏥���ڹx�K�n�f�T���s^��GΜiۭ|�V���\��1X��2g�s��g�r�B/_=�PX���܆}�Jq.�J6�Ia�*h��\9�ݒeŮ���;3Z��ZKk������m�]���k�e�U��ʛ2����+�M7u:�<HdX�v�D� �m�vc�{l���i�s�Nn�+v�7�-� {~̤��~��N%9]jb����6N��Ӛ�e�������^'fv9�Q��绯S���n,%Z�-}�uR��};���t�xgǌ*�T������V'.��\F���2S<ԅ�f$)��m�5r��g�U���	F&��3Big�|2'tI����n)���Vw?}��|���R7kC�:�=������V<~��V�;��W$�*��
���I�`��n���PG�Q_L��B�,d5�t�ز6����+��RMd�2�����W����*��L�Ie�|�P�)��&鼊:��Ŝ��otl$��+ҩ��t2�L"�9ԉ���Ѡ/..�{�Z���p$�鶡7�U�}������eX�n_d�*����~O�@��ùoR��)�P�����/��w�0�����3�x|P��wA-��t�b9��&}�%��GT.������d�4S��V�o��x�]q3�a�֗K�F��~��I)�Qv�bǏ(�hl�W^��+Ǌ���W�+ԥ��^�,�S�P*��W�^I�L��9���JV6����b;�(>V�w�򺑭��R�3����r�c��<T$�˗+�r�o粯":�Km)b>�|�f�`�]�|�lt����<����v�������ύ�����@p��IngS���3�����df6ǔ�׃�0g�]k?�Y���̰s6%�I�`�a�?���i>@��S�����/��/�����������
�y���c��
\T�5EṄ��\<ZO�16*�%���e�g����J|ee	P�m�K���|��������/����Ϳ������y������<�.�.��Q?LS�f{�З�\�	����r����K~|IST��m�r�vk�ϖ��/*đ�2���d�>���O��@I����K_,��g�.Q��_<Dq?޳T��ҟ,=B���8��ԁ8/�/�i^
Q~�U��w�������G�ۇ����<=�]���^��HNۂ�������k &��������/��i�5��-S��]J�OD:�g��>�?�C�<3z�?��&%a/��t���L�N9&aE,�e��P����� 8)��S����=_B!a,���f"����6"Z��pa��O`o��$�o#%���8I��UJ|F�z<^�eXg�D��$�E��rJ�^��ƥXlJ\\:�O@������.)����q]����3�O{b��Q��s2��#��Rdm���?{��:~ֻtYf�{�K�^:��,�g�h׷�qV:b}��8N�K�8<��ع8��q��}�T/�
������ ������"����ԧb'���$s;s�d�'�Hs�ğ/���������j�W������[�"�U*ڦ�?u��zq���2[�V�%�c+�D����^��O��ي��VV-#%�O�.�N�����*�*�h�xk�X޲���<���ȏ�*�бV���ۿM�c%XdU�#��J�$�s�	��\����?���>z�c���qG���D_���d���ɪ]���J?���M���)��#v���*X���BX_ǹ����r��C��ko�(��}�qp�}WW�ozc�#׿1�,��O�}�o�b�_P�s���yK�za��&-�<�F���s�8N�b��2w�9{�3Kwa�na�?���|���Ja��M��r�1�]0gI���_���S����(� Z�E'��F�jY�_0�,���^�N<��3��	~$��N�b�ƕ$��4�~����NZ��������f�4�BUV�C��*�����?:6{�:���C���se�T��o�TH���GtR��P����:]`��MW�;��b.,Gdn	�ga�\��5;�'���bf�����+�>ӋO�M�.�ړE���5����M'���/�8�~�+�i��>��f�,�-%a�ʹ<x�m~ae��9N$�T춠$C=�K�����ON������t?tc��Ay�=.��,����ax���=|�������+�{�_�����;���w?��|����{��M:�ou�Gu�u`�����p���?~5�����.��k~�cGu۰�0t��rY܄�v�ng�V6�¦���@<k`h��ؑ%P+� l�z�0�v]�����W����?���������_�×?�����������'%�;�WN�ea������-Q�/���Nc|����	|>���L������qz��/]�$��2CӤ��Kdm����q!4�>���q���J݌�-�]f�vZU�);'�e�����JG�z}-M�v�����0j|̥8���'қk1���d����Zsv�jv:z�
[2����#,x�-LQ�cTň*Lq&(�H��H#��[|�|�Q��8�&�H2�o��lg�Z�%��P���.�f���\�@�U�l:5n��%'r�yRnτ��A3�6;h�'gHƆ�^�?%�!!iF@��B�d����k+�@ 3��_f����95��V2��β)R���M��(��S�����$P�M��B2Iα@w�tD��i��&��,�X9 ���:�W	Ӟn��XYO��@*�n�;���T�$C�I�%GDY�5D�[	���S��6�+.8/QR��CEb��O�t����8|��G�Ё����]-�c3��}�(?��G!�n�m,�ԧ/^��(=YU�\UQ|0�l� v�JI,!������B���D^�Q�c��+���<R$6b�U.:ى�VC�)�T1א"�d3Hm� �C�CH
�1���՜\��c:����Ӱc�a)���Qg�t#G�I�wd6�tV��� ,Ҟ�Qu�*�'�RK��&Er�>/AU���|^�OD	�Z5P�PaƜ�&�
�b��b$j�&�3��]d��|�%hrH���Er¥����JM���Q>���!��M��*s�l��m��D���,%Üt�Vf~d�R�By�^)7h��+�"�x�%b�x�Saa���\rJ�����N������>0�e�J� %Q�;�jG4�̊Ơ��Ԅ��mx05�%��A��S�2߁�� ��zk8�����LXH�'�a��sۨ� /.��<��6������0ʐޜ�>���U�����B��+��:$����nֱ�0D�T	�F|�s�p�/�ԨaW�X�L{H��e���W��۔� ���n[�ܶ��mp�*�E<�mkx�ۖ� ���n[�\�~��B��(H$�R��W[��B�[ٿ��ŃRo�R/������_I6�W���������/Ō_\;��چz�!���xO�z79�)O��k�{�?z��[����R_�����6ޥ�9㽊���ұ��r#��K|ډ�^����tߌw�:���54)�kJ�� ��yiW��8�ꭖ�3�Zv�X4*C�5)�HG�������L�R�.�4g��J�W3Vm��P����^���ek=������R˃��6��S;��9}�x/��;K����"K��5<t����]��-Dn���H���pP�8E��H��4��7X3/�uu�2��Z�0��������U,�9�i�/Y5�NfD��qK�NT��T�L�T�ΞHł�Qwڄ�N�H�)�M���//�[���ڑP�������0&���Ƒ�ͫ��D�|=h��)Al���j/�?K+ua�I��� )�!
��)�Z��=F���hf��ld.V�Td��q�jf���b;�
���x8D��vL��T�.���iUzSɯ��/U� �X�U>C�2���S%�)<3��T�"O�b�-*�ޠ�Ywt�:��5���ԛ�W>�:8~��'���O'_�[��<���� p�7������p����0�7S�|x������J�����.R�q@�\JOʲ�E9n(���w�!�c�M#�֣$F��\�l4>A�ư�i�uT�V�QX{4~��V�x�K&�X>ob4R�����"u
�EEI�� �#gF�;�3�H����Xw7��5ւ��&�G��c�Hr��/tJe+S�M5�Sёo��Z�b}t.pݠ"�H7j��j2@A$�:6q<�Z�-]�E��>����$��Q�X/Ħ��s� %�'�"�16ĸ3'��-fآ#:x���E�C�`�"�u���-O}�td�z$:�� nd�K#� &��Y���,뵐F6S�]�B�6Zb���ZO1��H���c����ӣzP$�Ee��ǃBu Ѩ�M��[��<���N;c�ѥ�o]/1�,���K�ޚDQ9^�V�����l��u 0�8V^R���$�F�G��:�}�[��i�A�Xi!��,� �T�#��mp~I������-?�w	\2���� ��js���|��	����� �����	��$(q��6^�8p�7�~�adI�M�r7]k:P���Z�SԈw�]M��&0o��Al�U33(�]!�T6�|��2V��QmV1���d@_�Th���w����}��>�s�ϱ�V���Ѫ�X�j�{��=����׮��B",Fu�U�Ӛ��.�h4d�	�M�i�;�~���8�8��?g^Q�S{DХڢ<��̃Y6?�J���h�(�vP���N�R�*�D��Z�j�����w[`	j̔A �|��5�r� jޏ�rw�!�Y��בTXGR�#c���BW�y�X�X�. �q����^��#v���}B+ֽj�$V�hd�����.�] }ui.�#��H���q��R�0�������GM�tI�&�W�q�Z1"g���T�9Б<R#�����
�2��(���/��:\�2��zu=��~�q���'!'!�k�s��e�VM�
�#w��<L3�
� ���$TfC+�z�%�������%�/S��ёݹ�z#����'�|~��O�Y�̫eٴ;��~���I���wO�s���<���ֹj�5���x�|5�	ϗ�/PI���������{�����9~���RI����~ |qqm�=n�N�ǣ���=�G��'1}ᄝ ^_�i�#+�0�k�C��m�|I��S�k��  �[�<���_��&�u�����`pv���.��Y6��7�Bd?�wAO}�7ʦ�d�Q���t/��a�f�?h���.�ٯ�e�殿瞶�]���?��{�����@�y�ǲ����
�/������i��{��9���&�g���c�_t�KZ��=�������s�ǐ�������������/웺����]��%���L����?���t'��p?�<�}�{�]��gC������3{��.h�����;�;����|���3���]�=���ۿ#��?��������wB�~ �.F��������������������ڱ����r�!��������������]н����8�3����g0|������]�U�yс�?����`X�PG^i`3nH[(��g��ן��ot��7��<rr��\���j���3x��nA���z��)�jx��E�i39�ob~��U��2y�IU�t�( FvC)����tG��G�Iw�L{�8������P���>(d�0���u�G�tc�zA)��u�Hl�����p�e���q��t��&�E�&V�q]o<vĢ4���h#��5�I�V_굠99q��j�t��P�t�xYw�]�֧O����7�?,�������]k����w�wD{��������pf�����[���	��aE1�����-K�s��B�n�팁��v�鸞��t,��f6��᳒��6��Gqx��G���]К�_��j��óڱ��b���l��⠨��D�I���\���B�@,F �X�Y�Bэެ2'���L^ "���l��Q�c'�S8��ff�� �!��d���?{g֤��E�w~E��2� ���
��K������[k����[SWrNT�/����2R�\��>��u�.�Y4���;��r�
}wj�������Z]ݡ10��pOo
��8<�)�~���w#���'�;|i�����#9�M����S0����?��bKS����ߏ��o���7���7��A��f�_D�i�3�Qs�Dg�d��|�$YN�BNE3�?��y�K|Ĳb�|��7����OA�O#������c�[�ZE�I�E;��m΅#�43�������x�����{J[��۳��]�k�ʄ�eo]����yX�U1T
�\]6e��y<���N̅��j�ǃ�K�"V�޵��˽�������������	�_������JX ��&�����Y8�����_Qь�C�7��������~����q���o�hJ�4��������ߐ���h��}�������� �W�������_�����FhV��l�q]��G	��|��!�������1�m����_l͟f���f����y�u�C�������Ǵ��m��tU�
��0m=����B��k�V�O�X^�����Ӈ�W�c���j��$Ѳg/˩N�
ap�Lǒ3^�ǎϒb�k_���s�-�R��2�]�s�j��Lw�h��ּѺKPV��
�5���޶o��c|���取�&Ǌjݮu;Y6e�&mk�V��zԝHܲ٨m*>�GVh*�����r�?f_�'���^��4d�j�Չ��#��l�w�	�o"qYq�h�t��N��꒱�s�ۛ�R��h�wv���X2]�� Z����� \�?8���?���C��j���r�� ����?�������_#��?������:޸��������;�i��kwޝ�C~��q�
�h��m˻�)/�;L Xɶ�yʩs�#j{IUO��v�1h,�(�����kNlb�����6�*X�����0L��-Ov���S��o�������������[�S��������V��&Ozo7e���\�ԇ����.���EP���K�r7�̫�|L�����eG�C�ａC�G����f�?8�W`��}�8�?������V����?��X���X�A�������Fx����z|S��xM��g�?��p��|1�ɀ�7AS������b?ీ����O1��/��7b��`@Ā���#����/�������� 
���]��`��`���`���`�?��?D���]�a��,�������[��������A������������?,�����hl����xcp��,�?�?�_��-�?|��������"��&ZK7��G��r�����ǿ���B~J�`�N���5�O|��w]�4꬗�'i�q�ľ�2�s��i�����eHD�hP��>z�zjjkzt�?���îZ�e@kuQYg5ZΔ�`�a��?[|������g�����������˅,��J'>e��̎!����p����N唥�M�.T[���au<-�Ԋ�`��h��,��C��4��=˗���tMZ-Sdab��P���՟.9L��స�A@K�N{�Ӗ>��)gM;�l�x�H������@â��^���A����Uv���C����w����3����7.���Q.��G�3���4�RZE�K�2�I�yJd�4%�e9V�(Q`��Vo�����g�f�I�y��M�����}��t�eh�g����S��J���u��X�|-��X9,8c�!Λ@���b��Ō�bԚ����X.lyԑe��
��nn���ՆZoS!n�t{\�	y��o�e��3�tCν)���m�U=����8���ڰ�wkv�2Z��7�������������c��`����B�!����?���\�!���?��� ��������`����������������B�!���?�D������?���������?��}�X�?� �}���?����ρ�o�o��x������,�w���	��q��/8rq����o&�������c����Y�&/��L�E�b�u4�E�׮_��x��V�s�;
�T^{S�6k����ku�����m�k�Y/L;��������>;'��`oFeB�Φ-ֽ��XU��2ө2^)�� �7�T��)����]�Z��O]��l��a��D�沦�FN�])�}������g�g���;�Ԗt���v��bl�@Y�I{;x޽[[�[2��s�tr�OF����G���˵:���69!�\��ڟ?��>�,�c<G�˖۽�qŔ�_�>�:�,�F����JǪ�;y�[��_��T���Iбx;�1��˓C��\�rƻ�񩫤ڵ\�rk{cg�����m��t*膾�R���E5\��d�$��ܔpmkR���9�S��I��{��,)�h�Uϳ�~#���w����� q�������?��?Ё��K$M��@%Y��1�F9�E�s�H1|��,M2i�ǒD���H�L��IL�t&A��ρ��C�:~e��C[~6U"���>[��|x��S�&2=��yd����k�R�ʷ4�<�*i?)��r��X���	�%�4���Jۧv��[+9��t��Qv��6]qC�?ho��:E��?����������C�P�5��j��?������>�4q���������������7���!������_�@����������=����?�����c�����hJ�t��a`��	~t�W.��fcgӕ_��r�"��]~����E���^j��=�%�<���H������u-w6�����!��\���,�)ZM۪���~wl�.��>�n��&57*���5�r��^Q��ڴ�[z�V���Ծ�����B�t3�$�p�1}����:���D,Ô�Uc��k���}p,K�+^���Y7J�w����(���b��t�s̱�s�y{�U&�(X�����`�������/T �� �1���w����C�20����������bh��M�-�o����5f��`�Ȧ�Y������D���������p���F�x}�w���p($aR�Z:�դ*!�ͼX�L��4+Ƚ?*�&ve���4wN��:��hz��kM����6Ӂ1����[t�4����Sϝ�q+��5M�r?��To0+����?��w/y5b��9��'��&/:��w#Ǯ����|����2��zh�~u�.�^Tmǧy��|5�e��Z�ud�+5���ي%�&m�u+p�rӶ��4
��� ���?��B���]�a�����l����xcp��,�?��|���ߩ��?�v���K˘�X�Sʡ���������T����Oto���k�������^*K�^Όz�j_�Ʉ�6�X��tk��x���_.��MA�ݜ����׽�������X-����Ҵ�[�e���_x���n�?{|���Ǘ�����˅,��J'ߥ_[+�c���c�Y���q�2�GҌ�7Yo&���5e]1�j&�N�:�x��{ڑɹljn�ou��D��"����"�l�z�FCz�.gF9���{�����ω8�X�,Ddk�7V�>K|~ȭ[Ur�%�E�%]��윪���X�������!�����p���B.�/R�@�)#1$�r��� J9C�E2����d1)H��%��(��9`$���C��ρ�����b���F���_�zu�e�����,�U0���7.��<��`76'�Nk@~���û;�&3��nvk`콞���zm:C��mr��R��\Z�8�x���K es!Z/����.MMg�S2�G�T3K����??�a���^����4q����<��&�B��I�)��n�F�Vu��)����o���0���0���0��ߛ�,ϦG��R&��$�I�sRJE\�
4'�9�&$'&��%$\��1��y�g��3p�������4¯��O��p.�a%I\w}#f�z��Ng�-W���-2����~�>����U�j��w��Y��1M��_sEK \f'�"r���Fƚzܹy�U�!��JX,������y��:+�Zt��h�B��{���O�������S�� �-M������p�O#`��<俢����o\��G��4�b��?4B��1�Xє��h�7��6�C�7�C�7��_���k�f�?��������A���t4��`�q��j�����7���7���7����FE3��|�
���]���p�:��� ��������������v��E��?�O�㛢~��k���?��9�����������	����c��X@�?�?r���g�@�� ����`Ā���#����?P�7>�+�(hJ�t�����F��?X���?X���_P�!��`c0b������ga���?�D������?������?�lF���]�a��p�2���G��U�7�ߍ �ߐ��ߐ�����8��l���*�V��!�������A����?��F�E��H�4M�,�8:r)���E.�$2a2&b��M�T A��8K8�̈́\`EVL�[��������g���7��b�����������ޓ��fE'�������\�[q�?���MMv���+�Ϲ��c��&q Pn�aPAQ}k'��IUr�|���<I$�R��Z��{������lá+����PUU���+�X�ʳ�9�'�۟9�½�-���F�br�z+@!i&L]�v$��F.७〉�ݾ�)�x��i�"|:F����§��Ww���~�;�.��A�G{h���������Ρ����C'������������[����������t�����0�������@����@�G� ��s�N�?��h�`�[�����������A��-�?���2��������?ZCg�������� �;��0�������o�?��xUM�B᥋��i/WM���K����ge�o���Ny��jyr}�I'O�$q���R�rI���c�B�{�p��<��EܭE��8��-��3����l�����+��hŪ�9?���ٺT9���2���E����K9+2a�:�cV���G�K��r����IMT=���JM��,�3}bz0�������� ��5���@�G� ��s�.�?��h]�?�S^���Eq*B�(�,��]����^�G<� ��.B�h�T�}�P���k�������;�?�y��NûN~tv,��S����p�Y6�*��V�&�j���c'�RFg�1�_y���h�FPG}H$#��-j	�t�.�h��s�.�q6��E�Ō��j㏥��s�Y4=�W ���7?��>��S������?��Q�����x��������o���]�W�#������0������4��]7�>��>��ȏp	�D��nЏ0��c�G]M���$�'� �����!�vM�����h����N��L'����0��̂
��9u��%�fa[�����k��.`�c|f7�-��,c�%�-b,)�4CT#��@*�&d����ϕ�X���d{����`C����E�
U����������oCh��A;Ww������_���'��6����T���U|��qӪ`�N�#��l$�22��n��I���@`���/��YJ�j1~n���-_�O�|I��m��+=_o[��7������Ҳ�P��k˚����5g��/�u#�k���q��ꦟ�_P9��΅��^h�1ϣZ�³�]K�Scؚ�F������,{}�k����k�~�f~��8vQ�����{���qk1U��lI����`�Ô�q��S�2�^���� �'��	��&�r|�S�hB���p���{=���銱\ˣ�6��5R+�h�%{�v8�X�I{���<!��D����`��7����?�@��_���������������?����������y8�������w�?4���{�?����?}��c�+�����<0X��}����������ľ��^w~8��g��D'�2�\�8!����8�qc!4g<��^T�Ҵ�˃�j*�M��d�����3�o���f<F��|[�ބ�R;��q>�\`���?�B�g<���(oc|ؔe��,����j-S�	;���C�T���e1]�T
�d)�W�-ҩ5�T�އ���0��s~:hB|V5~$f)��!��R��0��`*]8�������'_��9���L�I���j�K���E8��H�#I�|olw�^���3�＇.�?��|��A�o#h��B~���?���������|�߄�T���v�����?�x��s����g�__��w^_����2�mu}�]��Ϟ�w���^�w�̳ZM��)mw�w){5�/�7�̮jȱ�����#| �v2��}7��n.a,MȈE�iߘ����{���9|*��f��5_�<��mV�J	��`e��y����@�Ƨfʽ�i�fی־�^����H�r�-�����`ms�*T��2["Ta�c^��p.����\�⇡��8��?bR��S�d�������L��,�%m\&)I6Yhgh;��)$.G?�7*�*�*[|n����b�@ь&��6tB�!��m	��?��ZG�߃�4���ޫ��w�f��� �zW�26T��l����G�?�]Ե��G�?�]�=,'$N�{h�O���ߘs9�g�N�qo��Av�J)͐��)�+|5a����W�5�KX�54U�YM���\�hb���.���bo�r-zj�/S&�NERRR�z��GT����7�i�=#ۼ�yPAfj1]��a͹�d���1��e|T�u!�ȏ�=%B<)�ɞUVȔ�2��ġ �%�ry��G���.B�?��� ܻc ��?�����������߃�0�������=tA�!ԃ�/
�_x��맷�o���� }3�^��U�d�r��nE���[o[�!����J_����3�����WE.[�Ӟ {06Rlu8�,xȟ����%�cO�h�Ui�N^/2�����#����\^L�1~�̛nv8�I�'��V"xX3�2<�����r�k����:��o��`���igd��2F��v�$���$�3�\�tqf���o������rl����uM!��d?��S�Lma�
pn�m��;��{���7����~�@�߃�'� ��� �?��'���y�:����Gkh��[G���hx�C�M��w�1��8����e������iL�|X��K��Q��KZ�C����s��)L�Yζ�̈́���
q�-%M��Ao�s�~��V�r��H�h�"h�(
����]��������k����pO��<�:u��1)[�����a`� �9!�eŢO��K�\��p���1��'S)���Fs�ڊ�5RW'?��l���; ߢ�����������Lb��Q���ϭ���������P����A��=������������%��k��(o_��g	��������@��o������B0��M���[� ����m�?���4��&����p� �����?~����B�[DS��s��+���_# �?P��?P���@�5���N�n ��ϭ�:��؃�?P�km�?0�����������?��`��&��	���������?��8��&�>��=�D'�?���c��7����������O��rN����#�UX����O�������Zb_2͸�H��˸�s���5�ɢL8W3NHyF'0-v�X�O���4���D��
{S�/��39��Ō,�k+����<��7a��N���:�A.��g�o,DAxڲ�v���v������f��O�Ѵ�H�B�j_.��z�RX$Kپ�0�h�N�����>�N����"j�H�R��C<�]a�-�'�T�pL!�UW/]O��s6a��#�����ȗ4���p��>%F�+������g����y��
�A[�/�e��C`�����[�u���G�����F�:��2L�1.CENP��4s���OR�xa��t���ȫ5$��B���������z��$��M�����#��~�LD���Kë�~���IH���4-�$0mx����G�P����G��S��+s�6)����+�����,t�����2���8�N7����y}�B<�SɈ�]YN���]S�"2ay�����zn�w'Ց�s0(3�ʬs�~�uwO���c���%����7�?��/�2oG����+�Ł�k�������������B�:������}0�	�?��U�!P��?����������+��@�AS�����(��4��	�?A�'��l�����/��5�V��j��n��	��� ���@'�����	�� �	C��o �	�?��'���n�������Z� �u ����_'������BG�����$�	t��_9��v�n��r��[_��z�q)�h%8s�|mj�y���������Zz��N����kc���wOa�]m�=|yyV{~A��V�-fE\ٜp�p�^:��S����!%is�"R�
���F$��1c:SgPeI�c���îƴ<X�[�ĩ���a�K�&���B�d�g7�α���V|�J�n5���)�%�Rb�ŀ����S�_|n���#�<�����j��,>���#������l��Qq)��(+7��c�P�L�ÝZ�G6a�ԸL�W�O�=�l�q�1��b�/}]�Jm7��(��G��Ch���Z� �u ����_�G�����F������#4�Р��CEh?"��#Iƣ|�n� `�>Ja�~�8�!��B�~]��G�Oׇ��o �3�	�pq6����%q�,��mm��;�4�a�EC��-���?���7���"��x��9��Q�p���̠tGH�h�z��0��grD0H��^o�{�~��c}5`5ҩƎ�y�)��(>���}J���#����?����4����������`/�[� �_�SR}ɷ_�d_V_��>�����>�V_���˕�7�6(��ʰ��?���o����{��8v���v�Ι���ew�Q��23��Lb'v�������<�ʣB��W�$�'q��J�	���JK�-RBW����R�E��@ ��P��$�ŏ
���RQ��{ss_3w�����t����������Il��c�x8�CL��jh�g�.�ww^�S�X�V8J_�_&	!O�H<�|"����>��q#�Zx�
M^;xege| �\��o��nǑ�q�������;m;�b���9%���c���{�f���R$b#7����rT%��5���cAGwbñ�X��)���>9f��X��S��bY���=A$x�X���$��՞2����m}�k@W;n셗O�}�=]�N�GG�p���QG���%����4�CUx�^�a�{�
E�8�Z���v�`�ET��-䪄���Gj�s@�x��� ꆽ�� wb��w��/��S�c���N�D~<�@��j�?���챑,�+�i|�vg4�Qt-�A�/u�Nw>�������> ŝv/s$Kwޝ��:9�-�X�a��i��?�J�i8Z'���(l��{���eP�:�}q볿�����ΥK����*���z*�f�4�T����HZ��*�%���I�P�6j��6�Pq=�b(��8OFa\������g���o>���~�ן�߿�+?<���
��y����M�
�1p�𼞥.��6t<�����x�e;4T����5�C?Aર�������~���.�[��s�;���B
}�*�����z>�{�>�B�C�BW��K������P�^��{=�e��m�"������������'�:��[�s�����t�U�R;WF㡾v���(pC���1uG�-�03�=X�4'��
Kn��=��������_~j��{o}*����o���߸��?��f��LS�}Oߕ����Ol��z.��j�+.�t
��Xڋ/aX�m���P�vRC3iL�%m()EO������xI����&3�n�i<��$kX;�����/���V��s���q�����?�t����c�;"�G���Mp�@X|���n� E�z�Ƶ�ʵ�O?.D���<��s��>wP�����Q������	)$虣��i}l��m����*����9�h����\f֚3�#��k8����;j�ՠLf�X8[B�Q��(Ve6 ���2�c��,���=Erl��J�5Q����:G֖�<����Ӛ5먭4�v{δ8R]6�p���N@��Ưp�)W'#��q~�o�d��<����橾,�4����,of?/�Kʌ�s�Č���N��3$e�}{�u1�C|B@��W}����~`+"霰q��l��Hs$���i��5�l���o�'E��"��]vh�,�������l0��� H�e�5�Wp͘,c�R{7���R�����Q��\ h2KX1�KM���� �ij�RAXъϋ$�)%���v���@�ԢMv�b��IT(��w���&�9��K��; K�= x���C��lGRųK�
��]�1s��|�APPsrO�.x�X�0gG���6,xX4�ل��{����N Zuy&F\E���آA�qJU�<oyb!H���(U2B��Q�vK�Kn|�`4��&kdR��Is�v�����q/��LV�"�\�e\�l�&�7��gR8�1E��G\�d��fk�q���V5^s�$(ӣ���NJ/�9�?~�ɑ
q���i�����*��n<;KN3�A��a�'[ŶV�U�e�U,�Wp�G#��P�xUw�zj>Q�_&m�].�)���5�i,��j�A��>�0��Y΢r���+MfY3�j���:d]0���rW��5yn²P�F��:yF&�Լ���T�eoT�N�%�%��P4˱R˛��f�Y�Z���F��qL�j ��8�&�ӫc�#ȇpOe��0E�Xc��y��'z�sꊛ�|�'ƹ�+��R����Yfs�!������E�������~�%u��`�rg�E�b���j�Y;ڷ�۷׵�\���)V�Am�FMt�G4fh�";~C�9���Gz�6
֓��IXOb�x|�Y�3lZ�g؄4P��屁��l�yl��,��]�<hk��!��')/@�lE�w��r�b�$�H�
ԸSJc�4o8uǷ%�K�*�S��R�)�����D�G�c�l��L�u0�u�U����|W�a�H|�*]���ݕV��l|@<Q0�̀u�a8����f5Қ�α�^N]��V/��^"AhT_�z�����461�L���t�ƕ�COZ��<��O ,�3�I!O ���?�m�-EwK�_�~.\_��������'�/G�׽���Z߄~>D��Z�+k�h�pp��5��n��R��홃5�w���������+З�@t���w~~d�^I&�E�����4�C�Ċl��!V���p���1����:����,)�6�� ���w-A�q��n�Zr��W�#Q��z�`6]��Z鈆0���p�)�8WLI�j��L_,�b}����	���̉�T�ڻ���!`nԵ\�[6,���ͩ��~9�i�����;�Wm��,�hΛ�o�}�9��~:X�t�bG�+�S�S�	�k6ꖆ�-+��1��[z7as�n��ƽ~���M,a��i���UN"�u<SLYE�}1�aǥ�=��5����?���KsU2ܔ�#$e������/[�Z� 9�����n�5f@�'0BkqZ�17�P<xYi���-�O0�b�J/ž�&���2�ۏ;R��$�����͌dmZ�q���H�ì�N7�d�˩Q��Z��+���k"�r���%��6q�6��U`p�e���{Sޕ4��
��L��l�����M3���X�QM,�L,r��ݎ�稥�}�\���,u==�u���ц+�W�Q狘���Џn��52��uk��7�V����_܄�v�P�7�b6�OlN�؜>q��������}��K��A)��n�Q��i���� ���:��Ɇ�p`�NF��JTe����H��B:��n=���BA�t=������G�~f-7��8ƫS��&�f��ܘ�I\x4�	%+��d ��ʆv�3�� ������c~�=�p��3M��&5��0i�gSO��Vf"[�5[)��5Kݦ�q50oU'��UR�Dh���Y�����eE����ê���ݤY����2�&���/�6q�M�c����sl�U�
�x�~¼U���&zx�����7�z��Ջ��_�8Օ�<�2ނ>�u�^�2>=���[o���<{#d�=s��G����<����ؑm�#n�"���?�ř�CW���I����)��He�vk�C�A�������_�?��������x����&�+_������^�٧ϵ#��k8��~4y��"x��we�gi����[������D�tC�N�"����}|d�7�����h8V��!��~³+t\�{?��u��}�h\?m��c'��"�xb���l`��6��l`��O2�?�W: � 