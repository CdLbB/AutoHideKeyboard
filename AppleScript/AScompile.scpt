FasdUAS 1.101.10   ��   ��    k             l     ��  ��    t n--------------------------------------------------------------------------------------------------------------     � 	 	 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   
  
 l     ��  ��    � � This script was designed to compile "KeyboardAutoHide.scpt" and move any resources needed for the compiled applet to the "Resources" folder compiling them if required.     �  P   T h i s   s c r i p t   w a s   d e s i g n e d   t o   c o m p i l e   " K e y b o a r d A u t o H i d e . s c p t "   a n d   m o v e   a n y   r e s o u r c e s   n e e d e d   f o r   t h e   c o m p i l e d   a p p l e t   t o   t h e   " R e s o u r c e s "   f o l d e r   c o m p i l i n g   t h e m   i f   r e q u i r e d .      l     ��  ��    t n--------------------------------------------------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��������  ��  ��        j     �� �� 0 
scriptname 
scriptName  m        �     K e y b o a r d A u t o H i d e      l     ��������  ��  ��        l     ��   ��    " - determine where we are ---      � ! ! 8 -   d e t e r m i n e   w h e r e   w e   a r e   - - -   " # " l     $���� $ O      % & % k     ' '  ( ) ( r     * + * l    ,���� , n     - . - m   	 ��
�� 
cfol . l   	 /���� / I   	�� 0��
�� .earsffdralis        afdr 0  f    ��  ��  ��  ��  ��   + o      ���� 0 	thefolder 	theFolder )  1�� 1 r     2 3 2 l    4���� 4 n     5 6 5 4    �� 7
�� 
cfol 7 m     8 8 � 9 9  R e s o u r c e s 6 o    ���� 0 	thefolder 	theFolder��  ��   3 o      ���� 0 theresources theResources��   & m      : :�                                                                                  MACS  alis    r  Macintosh HD               ����H+   �c
Finder.app                                                      ��Ɨ�q        ����  	                CoreServices    ��OT      ƘK�     �c  ��  ��  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   #  ; < ; l     ��������  ��  ��   <  = > = l    ?���� ? r     @ A @ n     B C B 1    ��
�� 
psxp C l    D���� D c     E F E o    ���� 0 	thefolder 	theFolder F m    ��
�� 
alis��  ��   A o      ���� 0 
thefolderp 
theFolderP��  ��   >  G H G l   % I���� I r    % J K J n    # L M L 1   ! #��
�� 
psxp M l   ! N���� N c    ! O P O o    ���� 0 theresources theResources P m     ��
�� 
alis��  ��   K o      ���� 0 theresourcesp theResourcesP��  ��   H  Q R Q l     ��������  ��  ��   R  S T S l     �� U V��   U &  - main AppleScript Compiling ---    V � W W @ -   m a i n   A p p l e S c r i p t   C o m p i l i n g   - - - T  X Y X l  & 1 Z���� Z r   & 1 [ \ [ b   & / ] ^ ] b   & - _ ` _ o   & '���� 0 
thefolderp 
theFolderP ` o   ' ,���� 0 
scriptname 
scriptName ^ m   - . a a � b b 
 . s c p t \ o      ���� 0 thescriptin theScriptIn��  ��   Y  c d c l  2 = e���� e r   2 = f g f b   2 ; h i h b   2 9 j k j o   2 3���� 0 
thefolderp 
theFolderP k o   3 8���� 0 
scriptname 
scriptName i m   9 : l l � m m  . a p p g o      ���� 0 thescriptout theScriptOut��  ��   d  n o n l  > O p���� p I  > O�� q��
�� .sysoexecTEXT���     TEXT q b   > K r s r b   > G t u t b   > C v w v m   > ? x x � y y  o s a c o m p i l e   - o   w n   ? B z { z 1   @ B��
�� 
strq { o   ? @���� 0 thescriptout theScriptOut u m   C F | | � } }    - s   s n   G J ~  ~ 1   H J��
�� 
strq  o   G H���� 0 thescriptin theScriptIn��  ��  ��   o  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � 3 -- determine where the app's Resources are ---    � � � � Z -   d e t e r m i n e   w h e r e   t h e   a p p ' s   R e s o u r c e s   a r e   - - - �  � � � l  P e ����� � r   P e � � � b   P a � � � b   P ] � � � l  P W ����� � c   P W � � � l  P S ����� � c   P S � � � o   P Q���� 0 	thefolder 	theFolder � m   Q R��
�� 
alis��  ��   � m   S V��
�� 
TEXT��  ��   � o   W \���� 0 
scriptname 
scriptName � m   ] ` � � � � � 0 . a p p : C o n t e n t s : R e s o u r c e s : � o      ���� 0 appresources appResources��  ��   �  � � � l  f q ����� � r   f q � � � n   f m � � � 1   k m��
�� 
psxp � l  f k ����� � c   f k � � � o   f i���� 0 appresources appResources � m   i j��
�� 
alis��  ��   � o      ���� 0 appresourcesp appResourcesP��  ��   �  � � � l     ��������  ��  ��   �  ��� � l  r ����� � O   r � � � X   v ��� � � k   � � �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
pnam � o   � ����� 0 f   � o      ���� 0 namef nameF �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � ' !- C-code compiling some items ---    � � � � B -   C - c o d e   c o m p i l i n g   s o m e   i t e m s   - - - �  � � � Z   � � ��� � � =  � � � � � c   � � � � � l  � � ����� � n   � � � � � 7  � ��� � �
�� 
cobj � m   � ������� � m   � ������� � o   � ����� 0 namef nameF��  ��   � m   � ���
�� 
TEXT � m   � � � � � � �  . c � k   � � � �  � � � r   � � � � � c   � � � � � l  � � ����� � n   � � � � � 7  � ��� � �
�� 
cobj � m   � �����  � m   � ������� � o   � ����� 0 namef nameF��  ��   � m   � ���
�� 
TEXT � o      ���� 0 
namefshort 
nameFshort �  � � � r   � � � � � b   � � � � � o   � ����� 0 theresourcesp theResourcesP � o   � ����� 0 namef nameF � o      ���� 0 	thecodein 	theCodeIn �  � � � r   � � � � � b   � � � � � o   � ����� 0 appresourcesp appResourcesP � o   � ����� 0 
namefshort 
nameFshort � o      ���� 0 
thecodeout 
theCodeOut �  � � � I  � �� ��~
� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �  g c c   - W a l l   - o   � n   � � � � � 1   � ��}
�} 
strq � o   � ��|�| 0 
thecodeout 
theCodeOut � m   � � � � � � �    � n   � � � � � 1   � ��{
�{ 
strq � o   � ��z�z 0 	thecodein 	theCodeIn � m   � � � � � � � @     - f r a m e w o r k   A p p l i c a t i o n S e r v i c e s�~   �  � � � l  � ��y�x�w�y  �x  �w   �  ��v � l  � ��u � ��u   � ) #- other items are just copied ---		    � � � � F -   o t h e r   i t e m s   a r e   j u s t   c o p i e d   - - - 	 	�v  ��   � I  �t � �
�t .coreclon****      � **** � o   �s�s 0 f   � �r � �
�r 
insh � 4  
�q �
�q 
cfol � o  	�p�p 0 appresources appResources � �o �n
�o 
alrp  m  �m
�m boovtrue�n   � �l l �k�j�i�k  �j  �i  �l  �� 0 f   � o   y z�h�h 0 theresources theResources � m   r s�                                                                                  MACS  alis    r  Macintosh HD               ����H+   �c
Finder.app                                                      ��Ɨ�q        ����  	                CoreServices    ��OT      ƘK�     �c  ��  ��  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��  ��       �g �g   �f�e�f 0 
scriptname 
scriptName
�e .aevtoappnull  �   � **** �d�c�b�a
�d .aevtoappnull  �   � **** k      "		  =

  G  X  c  n  �  �  ��`�`  �c  �b   �_�_ 0 f   ( :�^�]�\ 8�[�Z�Y�X�W a�V l�U x�T |�S�R ��Q�P�O�N�M�L�K�J ��I�H�G�F � � ��E�D�C�B
�^ .earsffdralis        afdr
�] 
cfol�\ 0 	thefolder 	theFolder�[ 0 theresources theResources
�Z 
alis
�Y 
psxp�X 0 
thefolderp 
theFolderP�W 0 theresourcesp theResourcesP�V 0 thescriptin theScriptIn�U 0 thescriptout theScriptOut
�T 
strq
�S .sysoexecTEXT���     TEXT
�R 
TEXT�Q 0 appresources appResources�P 0 appresourcesp appResourcesP
�O 
kocl
�N 
cobj
�M .corecnte****       ****
�L 
pnam�K 0 namef nameF�J���I���H 0 
namefshort 
nameFshort�G 0 	thecodein 	theCodeIn�F 0 
thecodeout 
theCodeOut
�E 
insh
�D 
alrp�C 
�B .coreclon****      � ****�a� )j �,E�O���/E�UO��&�,E�O��&�,E�O�b   %�%E�O�b   %�%E�O���,%a %��,%j O��&a &b   %a %E` O_ �&�,E` O� � ��[a a l kh  �a ,E` O_ [a \[Za \Zi2a &a   R_ [a \[Zk\Za 2a &E` O�_ %E` O_ _ %E`  Oa !_  �,%a "%_ �,%a #%j OPY �a $*�_ /a %ea & 'OP[OY�nUascr  ��ޭ