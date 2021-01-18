<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>韓国語辞書</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/korean.css">
</head>
<body>

 <nav class="navbar navbar-expand-sm navbar-info bg-info mt-3 mb-3">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav4" aria-controls="navbarNav4" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link text-light" href="home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light" href="wordlist/add">単語の追加</a>
                </li>
            </ul>
        </div>
    </nav>


<main class="main">


<div class="section-group">

<section>
		<div class="container h-100">
		<form:form action="" method="post" modelAttribute="diary" class="d-flex flex-row justify-content-center align-items-center">

			<div class="form-group w-50 p-3">
			 タイトル： <input type="text" name="title" class="title"/>
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
			  <textarea id="textarea-with-border" class="form-control" rows=10 cols=20 name="contents">
			  </textarea>
			  <input type="submit" value="投稿" class="tokou"/>
			</div>

		  </form:form>
		</div>
		</section>

<section>
<table id="sampleTable">

		<tr>
			<th>単語</th>
			<th>読み</th>
			<th>意味</th>
			<th cmanFilterBtn>カテゴリ</th>
			<th colspan="2">操作</th>
		</tr>
<c:forEach items="${koreans}" var="korean">
		<tr>
			<td><c:out value="${korean.name}" /></td>
			<td><c:out value="${korean.reading}" /></td>
			<td><c:out value="${korean.mean}" /></td>
			<td><c:out value="${korean.category}" /></td>
			<td><a href="korean/edit/<c:out value="${korean.id}" />">編集</a></td>
		    <td><a href="korean/delete/<c:out value="${korean.id}" />">削除</a></td>
		</tr>
</c:forEach>
	</table>

	<!-- ページ番号 -->
<c:choose>
	<c:when test="${page == 1}">
		| 前
	</c:when>
	<c:otherwise>
		| <a href="?page=<c:out value="${page - 1}" />">前</a>
	</c:otherwise>
</c:choose>

<c:forEach begin="1" end="${totalPages}" varStatus="vs">
	<c:choose>
		<c:when test="${page == vs.count}">
			| ${vs.count}
		</c:when>
		<c:otherwise>
			| <a href="?page=${vs.count}">${vs.count}</a>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:choose>
	<c:when test="${page == totalPages}">
		| 次
	</c:when>
	<c:otherwise>
		| <a href="?page=<c:out value="${page + 1}" />">次</a>
	</c:otherwise>
</c:choose>


</section>

</div><!--/.section-group-->
</div><!--/.center-container/.flex-container-->
</main>

<script type="text/javascript">
 //===============================================================
 //  フィルタテーブルの共通変数　設定要！
 //===============================================================
var gTabldID = 'sampleTable';  // テーブルのエリアのIDを設定
var gTfStartRow = 0;
var gTfColList  = [];             // ボタンが配置されている列番号
var gTfListSave = {};             // フィルタリストの保存状態
 //===============================================================
 //  オンロードでテーブル初期設定関数をCALL
 //===============================================================
window.onload = function() {
  tFilterInit();
}
function tFilterInit(){
 //==============================================================
 //  テーブルの初期設定
 //==============================================================
  var wTABLE  = document.getElementById(gTabldID);
  var wTR     = wTABLE.rows;
  var wAddBtn = '';
  // ------------------------------------------------------------
  //   テーブル内をフィルタボタンを付ける
  // ------------------------------------------------------------
  for(var i=0; i < wTR.length; i++){
    var wTD     = wTABLE.rows[i].cells;
    for(var j=0; j < wTD.length; j++){
      // --- 「cmanFilterBtn」の定義があるセルを対象とする ------
      if(wTD[j].getAttribute('cmanFilterBtn') !== null){
        // --- フィルタ対象はボタンの次の行から -----------------
        gTfStartRow = i + 1;
        // --- ボタンを追加（画像はsvgを使用） ------------------
        wAddBtn  = '<div class="tfArea">';
        wAddBtn += '<svg class="tfImg" id="tsBtn_'+j+'" onclick="tFilterCloseOpen('+j+')"><path d="M0 0 L9 0 L6 4 L6 8 L3 8 L3 4Z"></path></svg>';
        wAddBtn += '<div class="tfList" id="tfList_'+j+'" style="display:none">';
        wAddBtn += tFilterCreate(j);
        wAddBtn += '</div>';
        wAddBtn += '</div>';
        wTD[j].innerHTML = wTD[j].innerHTML+wAddBtn;
        // --- フィルタボタンなる列を保存 -----------------------
        gTfColList.push(j);
      }
    }
    // --- ボタンを付けたら以降の行は無視する -------------------
    if(wAddBtn != ''){
      gSortBtnRow = i;
      break;
    }
  }
}
function tFilterCreate(argCol){
 //==============================================================
 //  指定列のフィルタリスト作成
 //==============================================================
  var wTABLE    = document.getElementById(gTabldID);
  var wTR       = wTABLE.rows;
  var wItem     = [];              // クリックされた列の値
  var wNotNum   = 0;               // 1 : 数字でない
  var wItemSave = {};              // フィルタに設定した値がキー
  var rcList    = '';              // 返すフィルタリスト
  // ------------------------------------------------------------
  //  クリックされた列の値を取得する
  // ------------------------------------------------------------
  for(var i=gTfStartRow; i < wTR.length; i++){
    var j = i - gTfStartRow;
    wItem[j] = wTR[i].cells[argCol].innerText.toString();
    if(wItem[j].match(/^[-]?[0-9,\.]+$/)){
    }else{
        wNotNum = 1;
    }
  }
  // ------------------------------------------------------------
  //  列の値でソートを実行
  // ------------------------------------------------------------
    if(wNotNum == 0){
      wItem.sort(sortNumA);           // 数値で昇順
    }else{
      wItem.sort(sortStrA);           // 文字で昇順
    }
  // ------------------------------------------------------------
  //  「すべて」のチェックボックス作成
  // ------------------------------------------------------------
  var wItemId =  id='tfData_ALL_'+argCol;
  rcList += '<div class="tfMeisai">';
  rcList += '<input type="checkbox" id="'+wItemId+'" checked onclick="tFilterAllSet('+argCol+')">';
  rcList += '<label for="'+wItemId+'">(すべて)</label>';
  rcList += '</div>';
  // ------------------------------------------------------------
  //  列の値でフィルタのチェックボックスを作成する
  //    チェックボックスはformで囲む
  // ------------------------------------------------------------
  rcList += '<form name="tfForm_'+argCol+'">';
  for(var i=0; i < wItem.length; i++){
    wVal = trim(wItem[i]);
    if(wVal in wItemSave){
      // ---値でチェックボックスが作成されている(重複) ----------
    }else{
      // ---チェックボックスの作成 ------------------------------
      wItemId =  id='tfData_'+argCol+'_r'+i;
      rcList += '<div class="tfMeisai">';
      rcList += '<input type="checkbox" id="'+wItemId+'" value="'+wVal+'" checked onclick="tFilterClick('+argCol+')">';
      rcList += '<label for="'+wItemId+'">'+( wVal=='' ? '(空白)' : wVal )+'</label>';
      rcList += '</div>';
      // ---重複判定用にチェックボックスの値を保存 --------------
      wItemSave[wVal]='1';
    }
  }
  rcList += '</form>';
  // ------------------------------------------------------------
  //  文字抽出のinputを作成
  // ------------------------------------------------------------
  rcList += '<div class="tfInStr">';
  rcList += '<input type="text" placeholder="含む文字抽出" id="tfInStr_'+argCol+'">';
  rcList += '</div>';
  // ------------------------------------------------------------
  //  「OK」「Cancel」ボタンの作成
  // ------------------------------------------------------------
  rcList += '<div class="tfBtnArea">';
  rcList += '<input type="button" value="OK" onclick="tFilterGo()">';
  rcList += '<input type="button" value="Cancel" onclick="tFilterCancel('+argCol+')">';
  rcList += '</div>';
  // ------------------------------------------------------------
  //  作成したhtmlを返す
  // ------------------------------------------------------------
  return rcList;
}
function tFilterClick(argCol){
 //==============================================================
 //  フィルタリストのチェックボックスクリック
 //    「すべて」のチェックボックスと整合性を合わせる
 //==============================================================
  var wForm   = document.forms['tfForm_'+argCol];
  var wCntOn  = 0;
  var wCntOff = 0;
  var wAll    = document.getElementById('tfData_ALL_'+argCol);   // 「すべて」のチェックボックス
  // --- 各チェックボックスの状態を集計する ---------------------
  for (var i = 0; i < wForm.elements.length; i++){
    if(wForm.elements[i].type == 'checkbox'){
      if (wForm.elements[i].checked) { wCntOn++;  }
      else                           { wCntOff++; }
    }
  }
  // --- 各チェックボックス集計で「すべて」を整備する -----------
  if((wCntOn == 0)||(wCntOff == 0)){
    wAll.checked = true;             // 「すべて」をチェックする
    tFilterAllSet(argCol);           // 各フィルタのチェックする
  }else{
     wAll.checked = false;           // 「すべて」をチェックを外す
  }
}
function tFilterCancel(argCol){
 //==============================================================
 //  キャンセルボタン押下
 //==============================================================
  tFilterSave(argCol, 'load');    // フィルタ条件の復元
  tFilterCloseOpen('');           // フィルタリストを閉じる
}
function tFilterGo(){
 //===============================================================
 //  フィルタの実行
 //===============================================================
  var wTABLE  = document.getElementById(gTabldID);
  var wTR     = wTABLE.rows;
  // ------------------------------------------------------------
  //  全ての非表示を一旦クリア
  // ------------------------------------------------------------
  for(var i = 0; i < wTR.length; i++){
    if(wTR[i].getAttribute('cmanFilterNone') !== null){
      wTR[i].removeAttribute('cmanFilterNone');
    }
  }
  // ------------------------------------------------------------
  //  フィルタボタンのある列を繰り返す
  // ------------------------------------------------------------
  for(var wColList = 0; wColList < gTfColList.length; wColList++){
    var wCol       = gTfColList[wColList];
    var wAll       = document.getElementById('tfData_ALL_'+wCol);     // 「すべて」のチェックボックス
    var wItemSave  = {};
    var wFilterBtn =  document.getElementById('tsBtn_'+wCol);
    var wFilterStr =  document.getElementById('tfInStr_'+wCol);
    var wForm      = document.forms['tfForm_'+wCol];
    // -----------------------------------------------------------
    //  チェックボックスの整備（「すべて」の整合性）
    // -----------------------------------------------------------
    for (var i = 0; i < wForm.elements.length; i++){
      if(wForm.elements[i].type == 'checkbox'){
        if (wForm.elements[i].checked) {
          wItemSave[wForm.elements[i].value] = 1;      // チェックされている値を保存
        }
      }
    }
    // -----------------------------------------------------------
    //  フィルタ（非表示）の設定
    // -----------------------------------------------------------
    if((wAll.checked)&&(trim(wFilterStr.value) == '')){
      wFilterBtn.style.backgroundColor = '';              // フィルタなし色
    }
    else{
      wFilterBtn.style.backgroundColor = '#ffff00';       // フィルタあり色
      for(var i=gTfStartRow; i < wTR.length; i++){
        var wVal = trim(wTR[i].cells[wCol].innerText.toString());
        // --- チェックボックス選択によるフィルタ ----------------
        if(!wAll.checked){
          if(wVal in wItemSave){
          }
          else{
            wTR[i].setAttribute('cmanFilterNone','');
          }
        }
        // --- 抽出文字によるフィルタ ----------------------------
        if(wFilterStr.value != ''){
          reg = new RegExp(wFilterStr.value);
          if(wVal.match(reg)){
          }
          else{
            wTR[i].setAttribute('cmanFilterNone','');
          }
        }
      }
    }
  }
  tFilterCloseOpen('');
}
function tFilterSave(argCol, argFunc){
 //==============================================================
 //  フィルタリストの保存または復元
 //==============================================================
  // ---「すべて」のチェックボックス値を保存 ------------------
  var wAllCheck = document.getElementById('tfData_ALL_'+argCol);
  if(argFunc == 'save'){
    gTfListSave[wAllCheck.id] = wAllCheck.checked;
  }else{
    wAllCheck.checked = gTfListSave[wAllCheck.id];
  }
  // --- 各チェックボックス値を保存 ---------------------------
  var wForm    = document.forms['tfForm_'+argCol];
  for (var i = 0; i < wForm.elements.length; i++){
    if(wForm.elements[i].type == 'checkbox'){
      if(argFunc == 'save'){
        gTfListSave[wForm.elements[i].id] = wForm.elements[i].checked;
      }else{
        wForm.elements[i].checked = gTfListSave[wForm.elements[i].id];
      }
    }
  }
  // --- 含む文字の入力を保存 ---------------------------------
  var wStrInput = document.getElementById('tfInStr_'+argCol);
  if(argFunc == 'save'){
    gTfListSave[wStrInput.id] = wStrInput.value;
  }else{
    wStrInput.value = gTfListSave[wStrInput.id];
  }
}
function tFilterCloseOpen(argCol){
 //==============================================================
 //  フィルタを閉じて開く
 //==============================================================
  // --- フィルタリストを一旦すべて閉じる -----------------------
  for(var i=0; i < gTfColList.length; i++){
    document.getElementById("tfList_"+gTfColList[i]).style.display = 'none';
  }
  // --- 指定された列のフィルタリストを開く ---------------------
  if(argCol != ''){
    document.getElementById("tfList_"+argCol).style.display = '';
    // --- フィルタ条件の保存（キャンセル時に復元するため） -----
    tFilterSave(argCol, 'save');
  }
}
function tFilterAllSet(argCol){
 //==============================================================
 //  「すべて」のチェック状態に合わせて、各チェックをON/OFF
 //==============================================================
  var wChecked = false;
  var wForm    = document.forms['tfForm_'+argCol];
  if(document.getElementById('tfData_ALL_'+argCol).checked){
    wChecked = true;
  }
  for (var i = 0; i < wForm.elements.length; i++){
    if(wForm.elements[i].type == 'checkbox'){
      wForm.elements[i].checked = wChecked;
    }
  }
}
function sortNumA(a, b) {
 //==============================================================
 //  数字のソート関数（昇順）
 //==============================================================
  a = parseInt(a.replace(/,/g, ''));
  b = parseInt(b.replace(/,/g, ''));
  return a - b;
}
function sortStrA(a, b){
 //==============================================================
 //  文字のソート関数（昇順）
 //==============================================================
  a = a.toString().toLowerCase();  // 英大文字小文字を区別しない
  b = b.toString().toLowerCase();
  if     (a < b){ return -1; }
  else if(a > b){ return  1; }
  return 0;
}
function trim(argStr){
 //==============================================================
 //  trim
 //==============================================================
  var rcStr = argStr;
  rcStr	= rcStr.replace(/^[ 　\r\n]+/g, '');
  rcStr	= rcStr.replace(/[ 　\r\n]+$/g, '');
  return rcStr;
}
</script>
</body>
</html>