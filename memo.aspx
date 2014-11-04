<%@ Page Language="C#" runat="server" %>
<%@ Import Namespace = "System.IO" %>

<script language="C#" runat="server">
/*

	[소스보는 순서]
	
	1. 디자인부분(태그부분)
	2. Page_Load()
	3. 메모저장 메서드 (Memo_Save)
	4. 출력메서드 (Put_Memo)

*/


// 메모파일 경로변수
// (memo.aspx의 모든 메서드에서 변수를 사용할 수 있게 여기에 지정)
string memo_file;


	void Page_Load()
	{
		// 메모파일 경로를 지정
		memo_file = Server.MapPath("memo.txt");

		// submit 되지 않았다면 
		// 즉, 그냥 열었다면
		//						(차후 강의에서 설명할 예정)
		if (!IsPostBack)
			Put_Memo(File.ReadAllText(memo_file));		// 메모뿌려주는 기능 (메모 자료를 인수로 넘김)

	}

	// 작성한 메모를 저장하는 이벤트
	void Memo_Save(object o, EventArgs e)
	{

		// 메모의 이름과 메모내용이 빈 칸이 아니라면 저장하기.
		if (name.Value != "" && memo.Value != "")
		{
			string old_data = File.ReadAllText(memo_file);		// 모두 읽고
			string new_data = String.Format("{0}_#_{1}_#_{2}", name.Value, memo.Value, DateTime.Now);		// 자료형식을 맞추고
			string write_data = new_data + "\n" + old_data;		// 저장할 자료를 구성
			File.WriteAllText(memo_file, write_data);			// 파일에 저장.

			// 메모뿌려주는 기능. 
			Put_Memo(write_data);							

			// 메세지 띄우기.	
			spanMessage.InnerText = "메모가 저장되었습니다!";



		}
		// 빈칸이라면
		else
		{
			// 메세지 띄우기.	
			spanMessage.InnerText = "이름이나 메모칸이 빠졌습니다. 모두 채워주세요!";
		}

	}

	// 처음 열릴 때, 글을 쓰고 났을 때에 메모를 뿌려준다.
	// memo_data : 메모자료 전체
	void Put_Memo(string memo_data)
	{

		// 메모와 메모를 구분하는 '줄(line)'을 기준으로 배열로 자른다. 단, 자른 자료가 비면 그냥 버린다. (빈 줄이 있다면 버린다)
		string[] memo_lines = memo_data.Split(new char[] {'\n'}, StringSplitOptions.RemoveEmptyEntries);

		// 읽어온 메모 갯수를 넣어준다. (<span id="memocount"...>)
		memocount.InnerText = memo_lines.Length.ToString();

		

		// 이제 잘려진 갯수만큼 처리해준다.


		// 출력할 곳을 일단 비워준다.
		li1.Text = "";

		// 한줄씩 돌면서 Split()을 하기위해 for(;;)를 메모 수 만큼 해준다.
		for (int i=0; i<memo_lines.Length; i++)
		{
			// 우리가 정했던 "_#_" 구분자로 자른다.
			// 옵션은 None으로 준다.
			string[] fields = memo_lines[i].Split(new string[] {"_#_"}, StringSplitOptions.None);
			
			// 이렇게 되면 fields[0]은 이름, [1]은 메모내용, [2]는 작성일시가 된다.
			// <tr>..</tr>에 들어갈 내용을 형식에 맞게 자료를 맞추어 준다.


			li1.Text += String.Format(@"<tr align='center'><td width='100'><font color='blue'>{0}</font></td><td width='400' align='left'>{1}</td><td width='100'>{2}</td></tr><tr><td colspan='3' bgcolor='#eeeeee'></td></tr>",
						fields[0],
						fields[1],
						fields[2]);
		}
	}


</script>


<html>
<head>
<title>닷넷 한줄 메모장</title>

<!-- 폰트크기,폰트지정-->
<style type="text/css">
table { font-size:12px; font-family:tahoma; }
</style>
<!---->


</head>


<body>


<center>
한줄 메모장! (<span id="memocount" runat="server">0</span>개)


<form runat="server">

	<!-- 입력 -->
	<table width="600" style="border-collapse:collapse; border:1 solid slategray;">
	<tr align="center">
	<td width="100"><input type="text" size="8" id="name" runat="server"></td>
	<td width="400"><input type="text" size="58" id="memo" runat="server"></td>
	<td width="100"><input type="submit" value="메모저장" runat="server" onserverclick="Memo_Save"></td>
	</tr>


	<!--비었을 시 오류출력 (빨간색으로) -->
	<tr>
		<td colspan="3" align="center">
			<span id="spanMessage" runat="server" style="color:red"></span>
		</td>
	</tr>


	</table>
	<!-- 입력폼 끝 -->

<br>

<!-- 출력 -->
<table width="600">


	<!-- 내용출력부분 -->
	<!-- 다음에 다룰 내용입니다 -->
	<ASP:Literal id="li1" runat="server" />



</table>
<!-- 출력 끝 -->


</form>


</center>
<body>
</html>