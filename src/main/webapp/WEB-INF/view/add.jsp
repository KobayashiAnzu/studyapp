<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>語句登録</title>
</head>
<body>
<form:form action="" method="post" modelAttribute="korean">

        <form:errors path="name" />
		<p>
			単語：
			<form:input path="name" />
		</p>

		<form:errors path="reading" />
		<p>
			読み：
			<form:input path="reading" />
		</p>

		<form:errors path="mean" />
		<p>
			意味：
			<form:input path="mean" />
		</p>

		<p>
			カテゴリ：
		　<select name="category">
			<option value="挨拶">挨拶</option>
			<option value="天候">天候</option>
			<option value="食べ物">食べ物</option>
			<option value="生き物">生き物</option>
			<option value="自然">自然</option>
			<option value="家族・人">家族・人</option>
			<option value="数字">数字</option>
			<option value="色">色</option>
			<option value="季節">季節</option>
			<option value="日時・カレンダー">日時・カレンダー</option>
			<option value="職業・会社">職業・会社</option>
			<option value="趣味">趣味</option>
			<option value="家・日用品">家・日用品</option>
			<option value="病気・医療">病気・医療</option>
			<option value="医療・装飾品">衣料・装飾品</option>
			<option value="方向・位置">方向・位置</option>
			<option value="動詞（動作）">動詞（動作）</option>
			<option value="形容詞">形容詞</option>
			<option value="前置詞・副詞">前置詞・副詞</option>
			<option value="代名詞">代名詞</option>
			<option value="その他">その他</option>
		　</select>
		</p>

		<input type="submit" />

</form:form>

<img src="../images/keyboard_kr.png"/>

</body>
</html>