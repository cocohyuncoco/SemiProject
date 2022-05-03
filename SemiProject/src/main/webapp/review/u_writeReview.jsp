<%@page import="dao.ReviewDao"%>
<%@page import="dto.ReviewDto"%>
<%@page import="dto.LessonDto"%>
<%@page import="dao.LessonDao"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	// 프로젝트의 경로
	String root=request.getContextPath();
%>
<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js"charset="utf-8"></script>
<script type="text/javascript" src="<%=root%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

</head>
<%
/* 세션에서 로그인중인 email을 통해 mnum값 받기 */
String email = (String)session.getAttribute("emailok");
MemberDao dao = new MemberDao();
String mnum = dao.getMnum(email);
/* 수정할 rnum 받기 */
/* 수정하고 해당 상세게시판으로 가기위해 lnum 받기 */
String rnum = request.getParameter("rnum");
String lnum = request.getParameter("lnum");
%>
<body>
<!-- writeReview 참고 -->
<div class="review">
    <!-- 리뷰작성폼 -->
	<div>
        <form action="review/reviewUpdate.jsp" method="post">
        <!-- rnum,lnum,mnum 넘기기 -->
        <input type="hidden" name="rnum" value="<%=rnum%>">
        <input type="hidden" name="lnum" value="<%=lnum%>">
        <input type="hidden" name="mnum" value="<%=mnum%>">
			<table class="review">
				<!-- 해당 클래스 제목 -->
				<%
				LessonDao ldao = new LessonDao();
				LessonDto ldto = ldao.getData(lnum);
				%>
				<caption class="review"><span><%=ldto.getTitle()%></span></caption>
				<tr>
					<th class="review" align="left"><span>클래스의 만족도는 몇점이셨나요? 별점을 선택해주세요</span></th>
				</tr>
				<tr class="review">
					<td>
						<div class="star-rating">
						  <input type="radio" id="5-stars" name="rating" value="5" />
						  <label for="5-stars" class="star">&#9733;</label>
						  <input type="radio" id="4-stars" name="rating" value="4" />
						  <label for="4-stars" class="star">&#9733;</label>
						  <input type="radio" id="3-stars" name="rating" value="3" />
						  <label for="3-stars" class="star">&#9733;</label>
						  <input type="radio" id="2-stars" name="rating" value="2" />
						  <label for="2-stars" class="star">&#9733;</label>
						  <input type="radio" id="1-star" name="rating" value="1" required="required" />
						  <label for="1-star" class="star">&#9733;</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
					<%
					ReviewDao rdao = new ReviewDao();
					ReviewDto rdto = rdao.getData(rnum);
					%>
						<textarea name="content" id="content" required="required"
						style="width: 100%;height: 300px; background-color: #fff; display: none;"><%=rdto.getRcontents()%></textarea>		
					</td>
				</tr>
				<tr>
					<td align="right">
						<button type="button" class="review" onclick="submitContents(this)"><span>리뷰등록</span></button>
					</td>
				</tr>
				
			</table>   
		</form>
		
		<!-- 스마트게시판에 대한 스크립트 코드 넣기 -->
		<script type="text/javascript">
		var oEditors = [];
		
		nhn.husky.EZCreator.createInIFrame({
		
		    oAppRef: oEditors,
		
		    elPlaceHolder: "content",
		
		    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
		
		    fCreator: "createSEditor2"
		
		}); 
		
		//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
		
		function submitContents(elClickedObj) {
		
		    // 에디터의 내용이 textarea에 적용된다.
		
		    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
		    
		    // 별점 입력 필수!!
		    var check = $("input:radio[id='1-star']").is(":checked");
		    if(!check) {
		    	return alert("별점을 입력해주세요");
		    }
		
		    // 에디터의 내용에 대한 값 검증은 이곳에서
		
		    // document.getElementById("textAreaContent").value를 이용해서 처리한다.
		    try {
		        elClickedObj.form.submit();
		    } catch(e) { 
		
		    }
		
		}
		
		// textArea에 이미지 첨부
		
		function pasteHTML(filepath){
		    var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
		    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]); 
		
		}
		</script>
	</div>
</div>
</body>
</html>