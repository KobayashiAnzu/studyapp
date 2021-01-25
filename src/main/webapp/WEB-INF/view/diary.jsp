<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!--  パスをコンテキストルートを含めた形に変換 -->
<spring:url value="/css" var="css" />
<spring:url value="/js" var="js" />
<spring:url value="/home" var="homeUrl" />

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>日記</title>
<link rel="stylesheet" href="${css}/bootstrap.min.css">
<link rel="stylesheet" href="${css}/diary.css">
</head>
<body>

<nav class="navbar navbar-expand-sm sticky-top navbar-info bg-info mt-3 mb-3">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav4" aria-controls="navbarNav4" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link text-light" href="${homeUrl}">HOME</a>
                </li>
            </ul>
        </div>
    </nav>

	<c:forEach items="${diaries}" var="diary">
		<div id="sampleBox" class="article">
			<span class="article-title">
				<c:out value="${diary.feeling}" /><c:out value="${diary.title}" />
			</span>

			<p>
				<c:out value="${diary.contents}" />
			</p>

          <div class="sousa">

			<p>
			    <fmt:formatDate value="${diary.created}" pattern="y/M/d" />
				<a href="diary/editDiary/<c:out value="${diary.id}" />"><img
					src="images/edit.png" alt="編集" /></a>
				<a href="diary/deleteDiary/<c:out value="${diary.id}" />"><img
					src="images/delete.png" alt="削除" /></a>
			</p>
         </div>

		</div>
	</c:forEach>

</body>
</html>