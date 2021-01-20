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
			気分：
			<select name="feeling">
			 <option value="&#x1f600;">&#x1f600;</option>
			 <option value="&#x1f923;">&#x1f923;</option>
			 <option value="&#x1f637;">&#x1f637;</option>
			 <option value="&#x1f922;">&#x1f922;</option>
			 <option value="&#x1f632;">&#x1f632;</option>
			 <option value="&#x1f630;">&#x1f630;</option>
			 <option value="&#x1f62d;">&#x1f62d;</option>
			 <option value="&#x1f621;">&#x1f621;</option>
			</select>
		</p>
		<p>
			本文：
			<form:input path="contents" />
		</p>

		<input type="submit" />
	</form:form>
</body>
</html>