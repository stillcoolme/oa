
// 1. �Զ��� ToolbarSet

FCKConfig.ToolbarSets["Default"] = [
	['DocProps','-','Save','NewPage','Preview','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteWord','-','Print','SpellCheck'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
	'/',
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote','CreateDiv'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Link','Unlink','Anchor'],
	['Image','Flash','Table','Rule','Smiley','SpecialChar','PageBreak'],
	'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor'],
	['FitWindow','ShowBlocks','-','About']		// No comma for the last row.
] ;



FCKConfig.ToolbarSets["simple"] = [
	['Bold','Italic','Underline'],
	['Link','Unlink'],
	['Image','Smiley','SpecialChar'],
	['FontName'],
	['FontSize'],
	['TextColor','BGColor'],
] ;

FCKConfig.ToolbarSets["bbs"] = [
	
	['TextColor','BGColor'],
	['FitWindow']
] ;

FCKConfig.ToolbarSets["formTemplateDesigner"] = [
	['Source','DocProps','-','Save','NewPage','Preview','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteWord','-','Print','SpellCheck'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote','CreateDiv'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
	['Link','Unlink','Anchor'],
	['Image','Flash','Table','Rule','Smiley','SpecialChar','PageBreak'],
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor'],
	['FitWindow','ShowBlocks','-','About']		// No comma for the last row.
] ;

// �Ƿ����򵥹�����߼�������ʾ
if(typeof(FCKConfig.EnableAdvanceTable) == "undefined"){ // ��ҳ���е���fckeditorʱָ���� EnableAdvanceTable ��ֵ���ȱ����á�
	FCKConfig.EnableAdvanceTable = false; // Ĭ��Ϊfalse
	// FCKConfig.EnableAdvanceTable = true;
}

// �ڸ߼�������ʾ�Ĺ��ܣ�������1��ʼ��ֻ�е���ˡ��߼����ܡ�������ʾ��
FCKConfig.AdvanceTableNum = 0;
FCKConfig.AdvanceTable = [1,3,5,6,7];

// 2. �����������
FCKConfig.FontNames 	='����;����_GB2312;����;����;Times New Roman;Arial' ;
FCKConfig.FontSizes     ='9/��С;12/��С;16/�е�;20/�ϴ�;24/���';

// 3. �޸� "�س�" �� "shift + �س�" ����ʽ
FCKConfig.EnterMode = 'br' ;			// p | div | br
FCKConfig.ShiftEnterMode = 'p' ;	// p | div | br

// 4. ��������ͼƬ
FCKConfig.SmileyPath	= FCKConfig.BasePath + 'images/smiley/wangwang/' ;
FCKConfig.SmileyImages	= ['0.gif','1.gif','2.gif','3.gif','4.gif','5.gif','6.gif','7.gif','8.gif','9.gif','10.gif','11.gif','12.gif','13.gif','14.gif','15.gif','16.gif','17.gif','18.gif','19.gif','20.gif','21.gif','22.gif','23.gif','24.gif','25.gif','26.gif','27.gif','28.gif','29.gif','30.gif','31.gif','32.gif','33.gif','34.gif','35.gif','36.gif','37.gif','38.gif','39.gif','40.gif','41.gif','42.gif','43.gif','44.gif','45.gif','46.gif','47.gif','48.gif','49.gif','50.gif','51.gif','52.gif','53.gif','54.gif','55.gif','56.gif','57.gif','58.gif','59.gif','60.gif','61.gif','62.gif','63.gif','64.gif','65.gif','66.gif','67.gif','68.gif','69.gif','70.gif','71.gif','72.gif','73.gif','74.gif','75.gif','76.gif','77.gif','78.gif','79.gif','80.gif'] ;
FCKConfig.SmileyColumns = 8 ;
FCKConfig.SmileyWindowWidth		= 668 ;
FCKConfig.SmileyWindowHeight	= 480 ;

// 5. ���������ϴ���ͼƬ���͵���չ���б�
FCKConfig.ImageUploadAllowedExtensions	= ".(jpg|gif|jpeg|png|bmp)$" ;		// empty for all

// ������Ҫ�޸ĵ����� ... 

FCKConfig.LinkDlgHideTarget		= true; // false ;
FCKConfig.LinkDlgHideAdvanced	= true; // false ;

FCKConfig.ImageDlgHideLink		= true; // false ;
FCKConfig.ImageDlgHideAdvanced	= true; // false 

FCKConfig.LinkUpload = false;
