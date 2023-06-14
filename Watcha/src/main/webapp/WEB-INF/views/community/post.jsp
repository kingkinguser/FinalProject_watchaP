<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>커뮤니티</title>


<link rel="stylesheet" href="<%= ctxPath%>/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
<script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.nice-select.js"></script>

<%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>


<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

body, talbe, th, td, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6,
	pre, form, fieldset, textarea, blockquote, span, * {
	font-family: 'Noto Sans KR', sans-serif;
}

.pt-col2 {
	color: #222 !important;
}

.pt-bg2 {
	background-color: #222 !important; 
}

.pt-bg {
	background-color: #ec5e5e !important;
	color: #FFF !important;
}




.pt-col3, .cmt-notice i {
	color: #888;
}

.pt-col4 {
	color: #777;
}

.text_en {
	font-weight: 400;
}

.community-body {
	background-color: #F8F8F8;
	padding: 30px;
}

.post-list-box{
	border-radius: 0.5rem;
	background-color: #fff;
}


.post-list-box table{
	border-collapse: collapse;
	outline: none;
	margin: 0;

}


.post-list-box th{
	background-color: #FFF;
	padding: 15px 5px;
    font-size: 12px;
    white-space: nowrap;
    text-align: center;
	
}

.post-list-box th:first-child{
	padding-left: 15px;
	border-radius: 20px 0 0 0;
}

.post-list-box td {
    width: 1%;
    padding: 15px 10px;
    text-align: center;
    white-space: nowrap;
    transition-property: background-color;
    transition-duration: 0.2s;
    transition-timing-function: ease-in;
    font-size: 13px;
    padding-top: 13px;
    padding-bottom: 13px;
}

.post-list-box tbody tr:not(.notice):hover td,
.post-list-box tr.now-reading:not(.notice) {
	background-color: #f7f7f7;
}

.community-body a {
    color: #000;
    text-decoration: none;
    outline: none;
}

.community-body a, .community-body button, .community-body input[type=button] {
    transition-property: color, background-color, border-color;
    transition-duration: 0.3s;
}



.title_link {
    line-height: 160%;
}

td.list_title {
    width: auto;
    word-break: break-all;
    white-space: normal;
    font-size: 14px;
}

td.list_left {
    text-align: left;
}

.community-body tr:not(.notice) {
    border-top: 1px solid #EEE;
}

.title-area {
    display: inline-block;
    width: calc(100% - 25px);
    vertical-align: middle;
}

a.cmt_num.updated {
    border-bottom: 1px solid #ec5e5e;
}

a.cmt_num {
    color: #FF0558;
    margin-left: 3px;
    font-size: 14px;
}

td.list_author {
    width: 80px;
}


.msover-date {
    display: inline-block;
    position: relative;
    text-align: center;
}

.msover-date .ink-time {
    position: absolute;
    left: 0;
    top: 0;
    opacity: 0;
    width: 100%;
    white-space: nowrap;
}

.msover-date .ink-time, .msover-date .ink-date {
    transition-property: opacity;
    transition-duration: 0.3s;
}

.msover-date:hover .ink-date {
    opacity: 0;
}

.msover-date:hover .ink-time {
    opacity: 1;
}

.post-list-box td:last-child {
    padding-right: 15px;
}

.post-footer {
    padding-top: 15px;
}

.clearfix:before, .clearfix:after {
    content: " ";
    display: table;
}


.bubbling-child-wrap {
    position: relative;
    display: inline-block;
}


.post-footer .paging {
    margin-top: 15px;
}

.paging {
    text-align: center;
    font-size: 0;
}

.search-item {
	height: 32px;
    line-height: 32px;
    padding: 0 11px;
    border-radius: 5px;
    font-size: 13px;
    margin-right: 3px;
    vertical-align: middle;
    
    display: inline-block;
}

.write-button {
	background-color: #FF0558;
	
}
.write-button span, .write-button i{color: #FFF;}
.write-button span {margin-left: 2px;}

.paging .bt-page:first-of-type {
    border-radius: 10px 0 0 10px;
}
.paging .bt-page, .page_line, .cmt_basic .cmt-buttons .bt, .cmt_write_input textarea, .cmt-title, .cmt-notice, .cmt-body, .profile-img {
    background-color: #f7f7f7 !important;
}


.paging .bt-page {
    font-size: 13px;
    display: inline-block;
    padding: 5px 0;
}


.paging .bt-page a { border-right: 1px solid #EEE; }

.paging .bt-page a {
    display: inline-block;
    padding: 0 12px;
    height: 20px;
    line-height: 20px;
}

.paging .page-num-wrap { display: inline-block; }

.paging .page-num-wrap .bt-page { border-radius: 0; }

.list_icon.new, .paging .bt-page a.active, .atc_vote .bt_vote, .cmt-buttons .cmt_vote .bt_vote { color: #ec5e5e; }

.bubbling-parent:hover + .bubbling-child:not(.bubble-left) {
    top: -35px;
    opacity: 1;
    width: auto;
    height: auto;
    padding: 6px 6px 4px;
    overflow: visible;
}

.bubbling-child {
    position: absolute;
    width: 0;
    height: 0;
    overflow: hidden;
    background-color: #222;
    border-radius: 5px;
    white-space: nowrap;
    font-size: 11px !important;
    line-height: 100% !important;
    font-weight: normal !important;
    color: #FFF;
    opacity: 0;
    transition-duration: 0.3s;
    z-index: 1;
}

.bubbling-child::after {
    content: '';
    position: absolute;
    left: 50%;
    top: 100%;
    margin-left: -4px;
    border: 5px solid transparent;
    border-top: 5px solid #222;
}

.bubbling-child:not(.bubble-left) {
    left: 50%;
    top: -35px;
    transform: translateX(-50%);
    transition-property: top, opacity;
}

.search-button {border: 0; background-color: inherit;}

.search-modal { max-width: 350px; }

.search-select {
	background-color: #eee;
	border: 0;
	height: 32px;
	line-height: 32px;
	font-size: 14px;
}

.search-input {
	width: 100%;
	display: inline-block;
	margin-top: 20px;
    padding: 0 10px;
    box-sizing: border-box;
    border-radius: 5px;
    vertical-align: middle;
    border: 0;
    transition-property: background-color;
    transition-duration: 0.3s;
    height: 32px;
    line-height: 32px;
    font-size: 14px;
    background-color: #eee;
}

.search-input:focus { background-color: #fcf8e3; }

.search-bt-area { justify-content: center;}

.btn-search {
	background-color: #FF0558;
	color: #FFF;
	border: 0;
	font-size: 0.85rem;
	padding: 10px 20px;
}
.btn-cancel {
	background-color: #EEE;
	color: #555;
	border: 0;
	font-size: 0.85rem;
	padding: 10px 20px;
}

.btn-search:hover { color: #FFF; }
.btn-cancel:hover { color: #555;}

.search-header { justify-content: center; }

.search-title  { font-size: 12pt; font-weight: 300;}


.post-detail-box {
	background-color: #FFF;
	margin-bottom: 15px;
	position: relative;
	border-radius: 20px;
	    
}

.post-detail-header h1 {
	font-size: 18px;
    line-height: 160%;
	padding: 20px 25px;
	margin: 0;
    font-weight: normal;
}

.post-info {
    padding: 0 25px;
    line-height: 44px;
    font-size: 13px;
    background-color: #f7f7f7;
}

.post-info>span {
    display: inline-block;
    vertical-align: middle;
}

.post-date {
	color: #777;
	margin-left: 15px;
	font-weight: 400;
}

.post-info-right span {
	margin-left: 10px;
}

.count-likes {
	color: #ec5e5e !important;
}

.post-detail-body {padding: 25px;}

.post-detail-content {
	padding: 30px 40px 35px 40px;
	font-size: 15px;
	font-weight: 400;
	margin: -25px;
	line-height: 180%;
	word-break: break-all;
	word-wrap: break-word;
}

.bt_vote {
	background-color: #fbdfdf;
	margin-right: 5px;
	border-radius: 10px;
	display: inline-block;
    height: 36px;
    line-height: 36px;
    padding: 0 15px;
    cursor: pointer;
    margin: 0;
    -webkit-font-smoothing: subpixel-antialiased !important;
    border: none;
    outline: none;
    font-size: 14px;
    font-weight: 400;
}
.bt_vote .voted_count {
    border-left: 1px solid #f9d2d2;
    display: inline-block;
    padding-left: 15px;
    margin-left: 15px;
    transition-property: border-color;
    transition-duration: 0.3s;
}

.cmt-title {
	padding: 15px 25px;
	position: relative;
}
.cmt-title h3 {
    font-size: 14px;
    display: inline-block;
    padding: 0;
    margin: 0;
    font-weight: normal;
}

.cmt-count {
	font-weight: 400;
	color: #ec5e5e !important;
}

.bt-cmt-write{
	right: 15px;
	position: absolute;
    top: 12px;
}

.cmt-write {
	border: 0;
	background-color: inherit;
}

.cmt-wrap {
	padding: 25px 25px 0;
}

.cmt-notice {
    margin: 25px 25px 0;
    padding: 15px 15px 15px 45px;
    border-radius: 20px;
    line-height: 160%;
    position: relative;
    min-height: 40px;
    box-sizing: border-box;
    font-size: 14px;
}

.cmt-notice i {
    left: 18px;
    top: 15px;
    position: absolute;
    font-size: 18px;
}

.cmt-unit:first-of-type {
    margin-top: 0;
}


.cmt-unit {
    padding-left: 45px;
    margin-top: 25px;
    position: relative;
    display: block;
}

.cmt-unit .post-writer {
    padding: 0 8px;
    font-size: 10px;
    line-height: 16px;
    display: inline-block;
    margin-left: 3px;
    border-radius: 10px;
    vertical-align: bottom;
    color: #fff;
}

.cmt-unit .nickname {
	font-size: 13px;
	font-weight: bold;
}

.profile-box {
	position: absolute;
    left: 0;
    top: 0;
    text-align: center;
    width: 40px;
}

.profile-img.round {
	border-radius: 50%;
}
.profile-img {
    display: inline-block;
    width: 40px;
    height: 40px;
    background: url(https://extmovie.com/layouts/ink_layout_rawdell/images/profile.png) no-repeat center center;
    background-size: cover;
    overflow: hidden;
    vertical-align: middle;
}

.profile-inner-img {
    width: 100%;
    height: auto;
}

.cmt-body {
    position: relative;
    display: inline-block;
    box-sizing: border-box;
    vertical-align: bottom;
    min-width: 249px;
    max-width: calc(100% - 80px);
    padding: 14px 20px;
    border-radius: 15px;
}

.cmt-header {
	padding-left: 13px;
    font-size: 13px;
    padding-bottom: 5px;
}

.cmt-body {
    min-width: 249px;
    max-width: calc(100% - 80px);
    padding: 14px 20px;
    border-radius: 15px;
    position: relative;
    display: inline-block;
    box-sizing: border-box;
    vertical-align: bottom;

}

.cmt-body .parent{
	color : #888;
	font-size : 12px;
	margin-bottom: 7px;
}



.xe-content {
	font-size: 14px;
	line-height: 160%;
	font-weight: 400;
	word-break: break-all;
	word-wrap: break-word;
}

.cmt-buttons {
    position: relative;
    height: 24px;
    margin-top: 10px;
}

.cmt-buttons .bt2 {
    font-size: 12px;
    display: inline-block;
    padding: 0 8px;
    margin-right: 3px;
    line-height: 24px;
    vertical-align: middle;
    
}

.cmt-buttons .bt {
	background-color: #FFF;
}

.cmt-buttons .bt_cmt_report {
    margin-right: 2px;
}

.cmt-buttons .bt_wrap {
    display: inline-block;
    border-radius: 5px;
    vertical-align: middle;
}

.cmt-buttons .bt_wrap .bt:last-of-type {
    margin-right: 0;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
}

.cmt-buttons .bt_wrap .bt:first-of-type {
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
}

.cmt-buttons .bt_wrap .bt {
    display: inline-block;
    margin-right: 1px;
    padding: 0 8px;
    line-height: 24px;
}

.cmt-buttons .bt_wrap .bt {
    font-size: 12px;
    border:none;
}

.cmt-body:hover .cmt_date_wrap .cmt_time {
    opacity: 1;
}

.cmt_date_wrap .cmt_time {
    opacity: 0;
    transition-property: opacity;
    transition-duration: 0.3s;
}

.cmt_date_wrap {
    font-size: 12px;
}

.cmt_date_wrap {
    position: absolute;
    left: 100%;
    bottom: 0;
    margin-left: 5px;
    vertical-align: bottom;
    white-space: nowrap;
}

.cmt_new {
    display: inline-block;
    width: 5px;
    height: 5px;
    margin-left: 2px;
    border-radius: 2.5px;
    vertical-align: top;
}



</style>



<script type="text/javascript">

$(document).ready(function() {
	$('select').niceSelect();
});


</script>

</head>
<body>

	<div class="container-fluid community-body mt-3">
		<div class="row">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="post-detail-box">
					<div class="post-detail-header">
						<h1>
							<a href="https://extmovie.com/movietalk/91006230" class="atc_title">글제목</a>
						</h1>
						<div class="post-info clearfix">
							<span class="post-nickname">작성자
							</span>
							<span class="post-date">2023.05.18. 13:21</span>
							
							<div class="float-right post-info-right">
								<span class="count_read"><i class="fas fa-eye" title="조회 수"></i> 480</span>
								<span class="count-likes pt_col"><i class="fas fa-heart" title="추천 수"></i> 2</span>
								<span class="count_cmt pt-col2"><i class="fas fa-comment-dots" title="댓글"></i> 8</span>
							</div>
						</div>
					</div>
					<div class="post-detail-body">
						<!--BeforeDocument(91006230,43413969)-->
						<div class="post-detail-content" data-pswp-uid="1">
							<p>글내용 글내용 글내용</p>

							<p>글내용 글내용 글내용</p>
							
							<p>글내용 글내용 글내용</p>
							
							<p>글내용 글내용 글내용</p>
							
							<p>글내용 글내용 글내용</p>
						

						</div>
						<!--AfterDocument(91006230,43413969)-->
						
						
						<div class="atc_buttons clearfix">
							<!-- <div class="atc_buttons_etc">
								<span class="ink_bubble_wrap"><button
										class="bt_report ib ib_monoC has_bubble" type="button"
										onclick="insertWarn('로그인 해주세요.')">
										<i class="fas fa-exclamation-triangle only" title="신고"></i>
									</button> <span class="ink_bubble">신고</span></span><span
									class="ink_bubble_wrap"><button
										class="bt_share ib ib_monoC has_bubble" type="button"
										onclick="inkPop('atc_share')">
										<i class="fas fa-share only" title="공유"></i>
									</button> <span class="ink_bubble">공유</span></span><span
									class="ink_bubble_wrap"><button
										class="bt_scrap ib ib_monoC has_bubble" type="button"
										onclick="insertWarn('로그인 해주세요.')">
										<i class="fas fa-star only" title="스크랩"></i>
									</button> <span class="ink_bubble">스크랩</span></span>
							</div> -->
							<div class="atc_vote float-left mt-3">
								<button class="bt_vote vote_area" type="button" onclick="insertWarn('로그인 해주세요.')">
									좋아요
										<span class="voted_count text_en">2</span>
								</button>
							</div>
						</div>
						
					</div>
					
					<div id="comment" class="cmt cmt_bubble">
						<div class="cmt-title">
							<h3>
								댓글 <span class="cmt-count">8</span>
							</h3>
							<span class="bubbling-child-wrap bt-cmt-write"><button class="bubbling-parent cmt-write" type="button" title="댓글 쓰기"><i class="fas fa-edit"></i></button><span class="bubbling-child">댓글 쓰기</span></span>
						</div>
						<div class="cmt-notice">
							<i class="fas fa-microphone"></i>추천+댓글을 달면 포인트가 더 올라갑니다 <br>
							정치,종교 관련 언급 절대 금지입니다 <br> 상대방의 의견에 반박, 비아냥, 조롱 금지입니다 <br>
							영화는 개인의 취향이니, 상대방의 취향을 존중하세요
						</div>
						<!-- //cmt_notice -->
						<div class="cmt-wrap">
							<div class="cmt_list">
								<div class="cmt-unit" id="commnt_91006275">
									<div class="profile-box">
										<span class="profile-img round"></span>
										
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_1288"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/9.gif"
											alt="[레벨:9]" title="포인트:8559point (74%), 레벨:9/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">작성자</a>
										
									</div>
									<div class="cmt-body size13">
										<!--BeforeComment(91006275,1288)-->
										<div class="comment_91006275_1288 rhymix_content xe-content"
											data-pswp-uid="2">댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용</div>
										<!--AfterComment(91006275,1288)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2 bt_recomment" href="javascript:void(0)" onclick="reComment(91010407,91010420,'/movietalk/comment/91010420/reply');return false;">댓글</a>
												<div class="bt_wrap bt_cmt_report">
													<button class="bt" type="button" onclick="inkCmtReport('에스진','91010420')">신고</button>
												</div>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">13:35</span>
											<div class="cmt_date">
												2시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit reply" id="comment_91006497">
									<div class="profile-box">
										<span class="profile-img round">
										<img class="profile-inner-img"
											src="https://img.extmovie.com/files/member_extra_info/profile_image/899/339/056/56339899.jpg"
											alt="profile image">
										</span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_43413969"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/10.gif"
											alt="[레벨:10]" title="포인트:9317point (16%), 레벨:10/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글댓글작성자</a>
										<span class="post-writer pt-bg2">작성자</span>
										
									</div>
									<div class="cmt-body size13">
										<div class="parent">
											<i class="fas fa-comment-dots"></i> 답변대상
										</div>
										<!--BeforeComment(91006497,43413969)-->
										<div
											class="comment_91006497_43413969 rhymix_content xe-content"
											data-pswp-uid="3">댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용</div>
										<!--AfterComment(91006497,43413969)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">14:38</span>
											<div class="cmt_date">
												1시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit reply" id="comment_91006535">
									<div class="profile-box">
										<span class="profile-img round"></span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_1288"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/9.gif"
											alt="[레벨:9]" title="포인트:8559point (74%), 레벨:9/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">답변</a>
										
									</div>
									<div class="cmt-body size13">
										<div class="parent">
											<i class="fas fa-comment-dots"></i> 댓글작성자
										</div>
										<!--BeforeComment(91006535,1288)-->
										<div class="comment_91006535_1288 rhymix_content xe-content"
											data-pswp-uid="4">댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용
											댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용
											댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용</div>
										<!--AfterComment(91006535,1288)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">15:06</span>
											<div class="cmt_date">
												1시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit reply" id="comment_91006685">
									<div class="profile-box">
										<span class="profile-img round"><img class="profile-inner-img"
											src="//img.extmovie.com/files/member_extra_info/profile_image/969/413/043/43413969.png?20190201223456"
											alt="profile image"></span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_43413969"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/10.gif"
											alt="[레벨:10]" title="포인트:9317point (16%), 레벨:10/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글댓글작성자</a>
										<span class="post-writer pt-bg2">작성자</span>
										
									</div>
									<div class="cmt-body size13">
										<div class="parent">
											<i class="fas fa-comment-dots"></i> 답변
										</div>
										<!--BeforeComment(91006685,43413969)-->
										<div
											class="comment_91006685_43413969 rhymix_content xe-content"
											data-pswp-uid="5">감사합니다감사합니다ㅁㄴㅇㅁ감사합니다ㄴㅇㅁㄴㅇ 감사합니다</div>
										<!--AfterComment(91006685,43413969)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">16:26</span>
											<div class="cmt_date">
												3분 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit" id="comment_91006282">
									<div class="profile-box">
										<span class="profile-img round"><img class="profile-inner-img"
											src="//img.extmovie.com/files/member_extra_info/profile_image/243/243.jpg?20150526221556"
											alt="profile image"></span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_243"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/89.gif"
											alt="[레벨:89]" title="포인트:3927938point (75%), 레벨:89/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글작성자</a>
										
									</div>
									<div class="cmt-body size13">
										<!--BeforeComment(91006282,243)-->
											<div class="comment_91006282_243 rhymix_content xe-content"
											data-pswp-uid="6">ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</div>
										<!--AfterComment(91006282,243)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">13:35</span>
											<div class="cmt_date">
												2시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit reply" id="comment_91006501">
									<div class="profile-box">
										<span class="profile-img round"><img class="profile-inner-img"
											src="//img.extmovie.com/files/member_extra_info/profile_image/969/413/043/43413969.png?20190201223456"
											alt="profile image"></span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_43413969"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/10.gif"
											alt="[레벨:10]" title="포인트:9317point (16%), 레벨:10/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글댓글작성자</a>
										<span class="post-writer pt-bg2">작성자</span>
										
									</div>
									<div class="cmt-body size13">
										<div class="parent">
											<i class="fas fa-comment-dots"></i> 답변대상
										</div>
										<!--BeforeComment(91006501,43413969)-->
										<div
											class="comment_91006501_43413969 rhymix_content xe-content"
											data-pswp-uid="7">ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</div>
										<!--AfterComment(91006501,43413969)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">14:39</span>
											<div class="cmt_date">
												1시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit" id="comment_91006323">
									<div class="profile-box">
										<span class="profile-img round"><img class="profile-inner-img"
											src="//img.extmovie.com/files/member_extra_info/profile_image/312/179/003/3179312.jpg?20131216224418"
											alt="profile image"></span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_3179312"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/20.gif"
											alt="[레벨:20]" title="포인트:37647point (44%), 레벨:20/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글작성자</a>
										
									</div>
									<div class="cmt-body size13">
										<!--BeforeComment(91006323,3179312)-->
										<div
											class="comment_91006323_3179312 rhymix_content xe-content"
											data-pswp-uid="8">
											ㅁㄴㅇㄻㄴㄹㄹㄴㄴㄹㄴㅁㄻㅇㄴㄹㄴㄻㄴㄹㄹㅈㄷㄹㄻㅈㄹㅈㄷㅁㄹㄷㅈㄹㅈㄷㄹ
										</div>
										<!--AfterComment(91006323,3179312)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">13:40</span>
											<div class="cmt_date">
												2시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<div class="cmt-unit reply" id="comment_91006505">
									<div class="profile-box">
										<span class="profile-img round">
										<img class="profile-inner-img"
										     src="//img.extmovie.com/files/member_extra_info/profile_image/969/413/043/43413969.png?20190201223456"
											 alt="profile image">
										</span>
									</div>
									<div class="cmt_header">
										<a href="#popup_menu_area" class="nickname member_43413969"
											onclick="return false"><img
											src="https://extmovie.com/modules/point/icons/xeicon_coa/10.gif"
											alt="[레벨:10]" title="포인트:9317point (16%), 레벨:10/99"
											class="xe_point_level_icon"
											style="vertical-align: middle; margin-right: 3px;">댓글댓글작성자</a>
										<span class="post-writer pt-bg2">작성자</span>
										
									</div>
									<div class="cmt-body size13">
										<div class="parent">
											<i class="fas fa-comment-dots"></i> 댓글작성자
										</div>
										<!--BeforeComment(91006505,43413969)-->
										<div
											class="comment_91006505_43413969 rhymix_content xe-content"
											data-pswp-uid="9">^^^^^^</div>
										<!--AfterComment(91006505,43413969)-->
										<div class="cmt-buttons">
											<div class="cmt_vote">
												<a class="bt bt2" href="javascript:void(0)"
													onclick="insertWarn('권한이 없습니다.')">댓글</a>
											</div>
										</div>
										<div class="cmt_date_wrap text_en pt-col4">
											<span class="cmt_time">14:42</span>
											<div class="cmt_date">
												1시간 전 <span class="cmt_new pt-bg"></span>
											</div>
										</div>
									</div>
									<!-- //cmt-body -->
								</div>
								<!-- //cmt_loop -->
							</div>
							<!-- //cmt_list -->
						</div>
						<!-- //cmt_wrap -->
						<div class="cmt_write cmt_write_unit no_grant">
							<div class="cmt_not_permitted">
								<i class="fas fa-comment-dots pt-col4"></i> 권한이 없습니다.
								<a class="ink_link2" href="javascript:void(0)" onclick="inkPop('ink_login2')">로그인</a>
							</div>
						</div>
						<!-- //cmt_write -->
						<!-- <div class="cmt_write_unit cmt_write_re" id="cmt_write_re">
							<form action="/" method="post" class="cmt_form"
								onsubmit="return procFilter(this, insert_comment)"
								editor_sequence="2">
								<input type="hidden" name="error_return_url"
									value="/movietalk/91006230"><input type="hidden"
									name="act" value="dispBoardContent"> <input
									type="hidden" name="mid" value="movietalk"> <input
									type="hidden" name="document_srl" value="91006230"> <input
									type="hidden" name="content" value=""> <input
									type="hidden" name="comment_srl" value=""> <input
									type="hidden" name="parent_srl" value=""> <input
									type="hidden" name="use_html" value="Y"> <input
									type="hidden" id="htm_2" value="n"> <span
									class="inkpf round"></span>
								<div class="cmt_write_input text_ver">
									<textarea class="cmt_textarea" id="editor_2"
										placeholder="댓글 내용을 입력해주세요." style="width: 100%;"></textarea>

								</div>
								<div class="cmt_write_option">
									<a class="go_editor bt_write_type unit" href=""><i
										class="fas fa-chevron-circle-right"></i> 에디터 모드</a> <label
										class="ink_check unit"><input type="checkbox"
										name="is_secret" value="Y"><span><i
											class="fas fa-check"></i></span>비밀</label><span class="write_option"></span>
									<div class="bt_area bt_right">
										<span class="cmt_user_info"> <input class="ii"
											type="text" name="nick_name" placeholder="글쓴이"><input
											class="ii" type="password" name="password" placeholder="비밀번호">
										</span>
										<button class="ib ib2 ib_mono bt_close" type="button"
											onclick="jQuery('#cmt_write_re').hide();">취소</button>
										<button class="ib ib2 ib_color" type="submit">댓글 등록</button>
									</div>
								</div>
								<input type="hidden" name="_rx_csrf_token"
									value="GTL7LiCY6FmFI8Hm">
							</form>
						</div> -->
						<!-- //cmt_write_re -->


					</div>
					<!-- //cmt -->

				</div>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="post-list-box">
					<table>
						<thead>
							<tr>
								<th class="no" scope="col">번호</th>
								<th scope="col">말머리</th>
								<th scope="col" class="title">제목</th>
								<th scope="col">글쓴이</th>
								<th class="date" scope="col">작성일</th>
								<th class="extra_col" scope="col">조회</th>
								<th scope="col">추천</th>
							</tr>
						</thead>
						<tbody class="">
							<!-- NOTICE -->
							<tr class="notice">
								<td class="notice_text text_en no"><span class="notice">공지</span>
								</td>
								<td class="text_en no"><span class="notice">일반</span>
								</td>
								<td class="list_left list_title">
									<a href="/bestboard/91000328/page/72" class="title_link">글제목글제목글제목글제목글제목</a>
									<a href="/bestboard/91000328/page/72#comment" class="cmt_num updated">3</a>
								</td>
								<td class="list_author"><a
									href="#popup_menu_area" class="member_5564"
									onclick="return false">작성자</a>
								</td>
								<td class="text_en date"><span class="msover-date"><span
										class="ink-date">11시간 전</span><span class="ink-time">08:30</span></span></td>
								<td class="extra_col text_en"><span>3857</span></td>
								<td class="extra_col text_en"><span>12</span></td>
							</tr>

							<!-- /NOTICE -->
							<!-- LIST -->
							<tr>
								<td class="no text_en">8</td>
								<!-- 글번호 -->
								<td class="no text_en">일반</td>
								<td class="list_left list_title">
									<div class="article_type">
										<span class="list_icon2 normal"></span>
									</div>
									<div class="title-area">
										<a href="/bestboard/90891362/page/72" class="title_link">글제목글제목</a>
										<!-- 글제목 -->
										<a href="/bestboard/90891362/page/72#comment" class="cmt_num">18</a>
										<!-- 댓글 개수 -->
									</div>
								</td>
								<td class="list_author">
									<a class="xe_point_level_icon" style="vertical-align: middle; margin-right: 3px;">작성자</a>
									<!-- 글작성자 -->
								</td>
								<td class="date text_en"><span class="msover-date">
									<span class="ink-date">23.04.17.</span>
									<!-- 글 작성 일자 -->
									<span class="ink-time">20:27</span></span>
									<!-- 글 작성 시간 -->
								</td>
								<td class="extra_col text_en"><span>1234</span></td>
								<!-- 조회수 -->
								<td class="extra_col text_en"><span>12</span></td>
								<!-- 추천수  -->
							</tr>
							
							<!-- //LIST -->
						</tbody>
					</table>
				</div>

				<div class="post-footer">
					<div class="bt-area bt-left clearfix">
						<span class="bubbling-child-wrap">
							<button class="search-item ib_mono2 bubbling-parent search-button" type="button" data-toggle="modal" data-target="#exampleModal">
								<i class="fas fa-search only" title="검색"></i>
							</button>
							<span class="bubbling-child">검색</span>
						</span>
						<!-- 검색버튼 -->
						<a class="search-item write-button float-right" href="write">
							<i class="fas fa-pen"></i>
							<span>쓰기</span>
						</a>
						<!-- 쓰기버튼 -->
					</div>
					<div class="paging text_en pt-col4">
						<span class="bubbling-child-wrap bt-page">
							<a class="bt_first bubbling-parent" href="/bestboard" title="첫 페이지">
								<i class="fas fa-angle-double-left"></i>
							</a>
						<span class="bubbling-child">첫페이지</span>
						</span> 
						<span class="bt-page">
							<a class="bt-prev" href="/bestboard/page/71" title="prev">
								<i class="fas fa-angle-left"></i>
							</a>
						</span>
						<div class="page-num-wrap">
							<span class="bt-page"><a href="/bestboard/page/63" class="page-num">63</a></span>
							<span class="bt-page"><a href="/bestboard/page/64" class="page-num">64</a></span>
							<span class="bt-page"><a href="/bestboard/page/65" class="page-num">65</a></span>
							<span class="bt-page"><a href="/bestboard/page/66" class="page-num">66</a></span>
							<span class="bt-page"><a href="/bestboard/page/67" class="page-num">67</a></span>
							<span class="bt-page"><a href="/bestboard/page/68" class="page-num">68</a></span>
							<span class="bt-page"><a href="/bestboard/page/69" class="page-num">69</a></span>
							<span class="bt-page"><a href="/bestboard/page/70" class="page-num">70</a></span>
							<span class="bt-page"><a href="/bestboard/page/71" class="page-num">71</a></span>
							<span class="bt-page"><a class="page-num active">72</a></span>
						</div>
						<span class="bt-page">
							<a class="bt-next" href="/bestboard/page/72" title="next">
							<i class="fas fa-angle-right"></i>
							</a>
						</span>
						<span class="bubbling-child-wrap bt-page">
							<a class="bt_last bubbling-parent" href="/bestboard/page/72" title="끝 페이지">
								<i class="fas fa-angle-double-right"></i>
							</a>
							<span class="bubbling-child">끝 페이지</span>
						</span>
					</div>
				</div>


				<div class="modal fade" id="exampleModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered search-modal"
						role="document">
						<div class="modal-content">
							<div class="modal-header search-header">
								<h5 class="modal-title search-title" id="exampleModalLabel">검색</h5>

							</div>
							<div class="modal-body">
								<select class="wide search-select">
									<option value="1">제목+내용</option>
									<option value="2">제목</option>
									<option value="3">내용</option>
									<option value="4" disabled>태그</option>
								</select> <input class="search-input focused" type="text"
									name="search_keyword" value="" title="검색"
									placeholder="검색어를 입력하세요.">
							</div>
							<div class="modal-footer search-bt-area">
								<button type="button" class="btn btn-cancel"
									data-dismiss="modal">취소</button>
								<button type="button" class="btn btn-search">검색</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 검색모달 -->

			</div>
		</div>
	</div>




</body>



</html>

