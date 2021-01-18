<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>日記の編集</title>
</head>
<body>
	<form:form action="" method="post" modelAttribute="diary">
		<p>
			タイトル：
			<form:input path="title" />
		</p>
		<p>
			本文：
			<form:input path="contents" />
		</p>

		<input type="submit" />
	</form:form>
</body>
</html>