��, b  d    PQInfo"& ' ( � Print Queue Info��� �  x  p     B #����$Form45�  6x  7p  8  �!   Command1� OK0 �w �   List1�x h�X  �"   Label5� Jobx t�   �%   Label4� Status�x d�   �*   Label3� Descriptionx G�   �#   Label2� UserXx ��   �"   Label1� Seqx x w�   �%  �  __	 
�Q�Q�   H�X��_qZ ��j� � v l @
@  � 3� �� ~� � 
� �                  �  � Command1_Click� �PQInfo 	Form_Load   Form_Activate� 
CenterForm�  MainMenu   VB_WDEMO  �screen# Widtha Height�  List1_Click" List1_DblClick��QIDl�CurrJob4�JobCount+�	JobNumber��Jobs   [100]� oJobList� oLB1T QUEGETID   alltrim�cChoice� mind 	QUELSTQJB   xPadR   	USRGETNME   QJBGETUSRID� 
QJBSETDESC   QJBISADDING� aL Jobu DEFINE� DIALOG� RESOURCE? OF   oWinMain   REDEFINE7 LISTBOX� VAR+ ID   ITEMS   DBLCLICK� LEFT   	JobDetail} ACTIVATE� CENTERED� Tab3  �List1� Tab1� Tab2  �Wait   	OBJGETNME   nil� empty   
QJBGETDESC  �JobInfo   List   	ListIndex  �T1��T2  �T3   	QUEGETNME Label2_Click   Label1_Click% 
QueNameGet   
QueQJbList  �	NOVDEFINTP QJBUserIDGeto QJBAddintTest   
ObjNameGet� QJBDescriptionGet   QJBAddingTest  �Tue    	  ��������     Command1_Click00      X  Z      l e    x   l    9 	  ��������    	 Form_Load0r     X  v     � 0  
    �  *    # � B ���  � d      #    v    Center screen  l e  �  � ��  l  � �� � �  �  � ��  l  � �� � �   x    v 7   Set up vars; QID is a global passed from GetPQInfo()   �    _  � ,  %� d �  � ,  %� d ]�  
   v    Fill array and ListBoxo  
� � I 2   � � 
> ��, 0 � +  %  0 � � �    ~ �    @  a�  � � <   ~�  �    o� * � �   ~� �  v   �  �    ��  � Adding  �  � Ready   ]� � �  �   �  � �  �   # 0 le  �   #  x   M ��  8     9 	  ��������     List1_DblClick0H      X  �      l � l  ��� �  �   �e �  x   9 	  ��������   �