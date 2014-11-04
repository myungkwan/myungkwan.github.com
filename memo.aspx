<%@ Page Language="C#" runat="server" %>
<%@ Import Namespace = "System.IO" %>

<script language="C#" runat="server">
/*

	[�ҽ����� ����]
	
	1. �����κκ�(�±׺κ�)
	2. Page_Load()
	3. �޸����� �޼��� (Memo_Save)
	4. ��¸޼��� (Put_Memo)

*/


// �޸����� ��κ���
// (memo.aspx�� ��� �޼��忡�� ������ ����� �� �ְ� ���⿡ ����)
string memo_file;


	void Page_Load()
	{
		// �޸����� ��θ� ����
		memo_file = Server.MapPath("memo.txt");

		// submit ���� �ʾҴٸ� 
		// ��, �׳� �����ٸ�
		//						(���� ���ǿ��� ������ ����)
		if (!IsPostBack)
			Put_Memo(File.ReadAllText(memo_file));		// �޸�ѷ��ִ� ��� (�޸� �ڷḦ �μ��� �ѱ�)

	}

	// �ۼ��� �޸� �����ϴ� �̺�Ʈ
	void Memo_Save(object o, EventArgs e)
	{

		// �޸��� �̸��� �޸𳻿��� �� ĭ�� �ƴ϶�� �����ϱ�.
		if (name.Value != "" && memo.Value != "")
		{
			string old_data = File.ReadAllText(memo_file);		// ��� �а�
			string new_data = String.Format("{0}_#_{1}_#_{2}", name.Value, memo.Value, DateTime.Now);		// �ڷ������� ���߰�
			string write_data = new_data + "\n" + old_data;		// ������ �ڷḦ ����
			File.WriteAllText(memo_file, write_data);			// ���Ͽ� ����.

			// �޸�ѷ��ִ� ���. 
			Put_Memo(write_data);							

			// �޼��� ����.	
			spanMessage.InnerText = "�޸� ����Ǿ����ϴ�!";



		}
		// ��ĭ�̶��
		else
		{
			// �޼��� ����.	
			spanMessage.InnerText = "�̸��̳� �޸�ĭ�� �������ϴ�. ��� ä���ּ���!";
		}

	}

	// ó�� ���� ��, ���� ���� ���� ���� �޸� �ѷ��ش�.
	// memo_data : �޸��ڷ� ��ü
	void Put_Memo(string memo_data)
	{

		// �޸�� �޸� �����ϴ� '��(line)'�� �������� �迭�� �ڸ���. ��, �ڸ� �ڷᰡ ��� �׳� ������. (�� ���� �ִٸ� ������)
		string[] memo_lines = memo_data.Split(new char[] {'\n'}, StringSplitOptions.RemoveEmptyEntries);

		// �о�� �޸� ������ �־��ش�. (<span id="memocount"...>)
		memocount.InnerText = memo_lines.Length.ToString();

		

		// ���� �߷��� ������ŭ ó�����ش�.


		// ����� ���� �ϴ� ����ش�.
		li1.Text = "";

		// ���پ� ���鼭 Split()�� �ϱ����� for(;;)�� �޸� �� ��ŭ ���ش�.
		for (int i=0; i<memo_lines.Length; i++)
		{
			// �츮�� ���ߴ� "_#_" �����ڷ� �ڸ���.
			// �ɼ��� None���� �ش�.
			string[] fields = memo_lines[i].Split(new string[] {"_#_"}, StringSplitOptions.None);
			
			// �̷��� �Ǹ� fields[0]�� �̸�, [1]�� �޸𳻿�, [2]�� �ۼ��Ͻð� �ȴ�.
			// <tr>..</tr>�� �� ������ ���Ŀ� �°� �ڷḦ ���߾� �ش�.


			li1.Text += String.Format(@"<tr align='center'><td width='100'><font color='blue'>{0}</font></td><td width='400' align='left'>{1}</td><td width='100'>{2}</td></tr><tr><td colspan='3' bgcolor='#eeeeee'></td></tr>",
						fields[0],
						fields[1],
						fields[2]);
		}
	}


</script>


<html>
<head>
<title>��� ���� �޸���</title>

<!-- ��Ʈũ��,��Ʈ����-->
<style type="text/css">
table { font-size:12px; font-family:tahoma; }
</style>
<!---->


</head>


<body>


<center>
���� �޸���! (<span id="memocount" runat="server">0</span>��)


<form runat="server">

	<!-- �Է� -->
	<table width="600" style="border-collapse:collapse; border:1 solid slategray;">
	<tr align="center">
	<td width="100"><input type="text" size="8" id="name" runat="server"></td>
	<td width="400"><input type="text" size="58" id="memo" runat="server"></td>
	<td width="100"><input type="submit" value="�޸�����" runat="server" onserverclick="Memo_Save"></td>
	</tr>


	<!--����� �� ������� (����������) -->
	<tr>
		<td colspan="3" align="center">
			<span id="spanMessage" runat="server" style="color:red"></span>
		</td>
	</tr>


	</table>
	<!-- �Է��� �� -->

<br>

<!-- ��� -->
<table width="600">


	<!-- ������ºκ� -->
	<!-- ������ �ٷ� �����Դϴ� -->
	<ASP:Literal id="li1" runat="server" />



</table>
<!-- ��� �� -->


</form>


</center>
<body>
</html>