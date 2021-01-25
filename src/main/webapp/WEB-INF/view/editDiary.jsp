<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!--  パスをコンテキストルートを含めた形に変換 -->
<spring:url value="/css" var="css" />
<spring:url value="/js" var="js" />
<spring:url value="/diary" var="diaryUrl" />
<spring:url value="/images" var="images" />
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>日記の編集</title>
<link rel="stylesheet" href="${css}/editDiary.css" />
</head>
<body>

<div class="main">
	<form:form action="" method="post" modelAttribute="diary">

			気分・カテゴリ：
			<select name="feeling" class="in">
			 <option value="&#x1f600;">&#x1f600;</option>
			 <option value="&#x1f923;">&#x1f923;</option>
			 <option value="&#x1f637;">&#x1f637;</option>
			 <option value="&#x1f922;">&#x1f922;</option>
			 <option value="&#x1f632;">&#x1f632;</option>
			 <option value="&#x1f630;">&#x1f630;</option>
			 <option value="&#x1f62d;">&#x1f62d;</option>
			 <option value="&#x1f621;">&#x1f621;</option>
			</select><br>

			タイトル：<form:input path="title"  class="in"/><br>


　　　　　　本文：<form:textarea path="contents" cols="45" rows="40" class="in"/><br>


		<input type="submit" class="btn-square-so-pop"/>
	</form:form>
</div>

<p><a href="${diaryUrl}"><img src="${images}/left-arrow.png" alt="戻る" /></a></p>
</body>
</html>