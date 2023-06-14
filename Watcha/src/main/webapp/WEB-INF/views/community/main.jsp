<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 
 
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
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.nice-select.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1.10.4/dayjs.min.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>



<link rel="stylesheet" href="<%= ctxPath%>/resources/css/community.css" type="text/css">

<style>

.swing {
	transform-origin: top center;
	animation: swing 1s;
	animation-iteration-count : 1;
}
@keyframes swing {

	20% { transform: rotate(3deg); }	
	40% { transform: rotate(-2deg); }
	60% { transform: rotate(2deg); }	
	80% { transform: rotate(-2deg); }	
	100% { transform: rotate(0deg); }

}


</style>


<script type="text/javascript">

let pageLoaded;
$(document).ready(function() {
	$('select').niceSelect();
	if(${not empty selectedPost}) {
		pageLoaded = false;
		refreshCommentList()
		// getCommentList(1);
		if(${not empty sessionScope.loginuser}) {
			hasLikedPost(${selectedPost.postId})
			.then(status => {
				const button = document.querySelector('.bt_vote');
				button.classList.toggle('submitted', status === 1);
			})
		}
		
	}

	
	
	const cmtForm = document.getElementById('cmt_form');
	
	if(cmtForm) {
		cmtForm.addEventListener('submit', submitCommentFrm);	
	}
	


	
});

var postUserid = '${selectedPost.member.user_id}';


function formatDate(date) {
	  const now = dayjs();
	  const parsedDate = dayjs(date, 'YYYY-MM-DD HH:mm:ss');
	  const minutes = now.diff(parsedDate, 'minutes');
	  const hours = now.diff(parsedDate, 'hours');
	  const days = now.diff(parsedDate, 'days');

	  if (minutes < 60) {
	    return `\${minutes}분 전`;
	  } else if (hours < 24) {
	    return `\${hours}시간 전`;
	  } else if (days < 7) {
	    return `\${days}일 전`;
	  } else {
	    return parsedDate.format('YY. MM. DD.');
	  }
	}

function formatTime(date, format) {
	const parsedDate = dayjs(date, 'YYYY-MM-DD HH:mm:ss');
	return parsedDate.format(format);
}

function getCommentList(page) {
	fetch(`comments/${requestScope.selectedPost.postId}/\${page}`)
	.then(response => response.json())
	.then(result => {
		console.log(result);
		renderComments(result);
		renderCommentPageBar(result);
	})
	.catch(error => {
		console.error('Error:', error);
		// 에러 처리
	});
}

function scrollToComment(comment) {
	const commentText = `comment_\${comment}`;

	const commentSection = document.getElementById(commentText);
	if(commentSection) {
		commentSection.scrollIntoView({behavior: "smooth", block: "center"});

		commentSection.classList.add("swing")
		setTimeout(function() {
			commentSection.classList.remove("swing");
		}, 1000);



	} else {
		fetch(`comment/\${comment}?postId=${requestScope.selectedPost.postId}`)
		.then(response => response.json())
		.then(result => {
			getCommentList(result.page);

			setTimeout(function() {
				scrollToComment(result.commentId);
			}, 100); 
		})
		.catch(error => {
			console.error('Error:', error);
			// 에러 처리
		});
	}
	


}

function renderComments(result) {
	  const cmtListDiv = document.querySelector('.cmt_list');

	  while (cmtListDiv.firstChild) {
	    cmtListDiv.removeChild(cmtListDiv.firstChild);
	  }

	  
	    result.comments.forEach(comment => {
	    const commentDiv = document.createElement('div');
	    commentDiv.classList.add('cmt-unit');
	    commentDiv.id = 'comment_' + comment.commentId;
		commentDiv.style.marginLeft = `\${comment.depth * 5}%`;
		

	    const profileBoxDiv = document.createElement('div');
	    profileBoxDiv.classList.add('profile-box');

 	    const profileImgSpan = document.createElement('span');
	    profileImgSpan.classList.add('profile-img', 'round');
	    
	    if(comment.member.profileImg) {
			const profileImg = document.createElement('img');
			profileImg.classList.add('profile-inner-img');
			profileImg.src = comment.member.profile_image;
			profileImgSpan.appendChild(profileImg);
		}
	    profileBoxDiv.appendChild(profileImgSpan);
	    
	    const cmtHeaderDiv = document.createElement('div');
	    cmtHeaderDiv.classList.add('cmt_header');
 
	    const nicknameLink = document.createElement('a');
	    nicknameLink.href = 'javascript:void(0)';
	    nicknameLink.classList.add(`nickname`, `member_\${comment.member.userid}`);
	    nicknameLink.onclick = () => scrollToComment(comment.commentId);
	    nicknameLink.textContent = comment.member.nickname;

	    cmtHeaderDiv.appendChild(nicknameLink);
	    
	    // 만약 게시글 작성자와 댓글 작성자가 똑같다면 추가할 태그
	    if (postUserid === comment.member.user_id) {
	      const postWriterSpan = document.createElement('span');
	      postWriterSpan.classList.add('post-writer', 'pt-bg2');
	      postWriterSpan.textContent = '작성자';
	      cmtHeaderDiv.appendChild(postWriterSpan);
	    }
	    

	    const cmtBodyDiv = document.createElement('div');
	    cmtBodyDiv.classList.add('cmt-body', 'size13');

	    // 부모 코멘트가 존재한다면 넣어줌
	    if (comment.parentUserId) {
	      const parentDiv = document.createElement('div');
	      parentDiv.classList.add('parent');

	      const parentIcon = document.createElement('i');
	      parentIcon.classList.add('fas', 'fa-comment-dots');

	      const parentUserId = document.createElement('span');
	      parentUserId.textContent = comment.parentNickname;
		  parentUserId.onclick = () => scrollToComment(comment.parentCommentId);
		  parentUserId.style.cssText = 'cursor: pointer;'


	      parentDiv.appendChild(parentIcon);
	      parentDiv.appendChild(parentUserId);

	      cmtBodyDiv.appendChild(parentDiv);
	    }

	    const commentTextDiv = document.createElement('div');
	    commentTextDiv.classList.add(`comment_content`);
		if(comment.commentStatus == 1) {
			commentTextDiv.textContent = comment.commentContent;
		} else {
			commentTextDiv.textContent = '삭제된 댓글입니다.';
		}
	    

	    cmtBodyDiv.appendChild(commentTextDiv);

		//버튼 부분
		if(comment.commentStatus == 1) {
			const cmtButtonsDiv = document.createElement('div');
			cmtButtonsDiv.classList.add('cmt-buttons');

			const cmtVoteDiv = document.createElement('div');
			cmtVoteDiv.classList.add('cmt_vote');

			const btLink = document.createElement('a');
			btLink.classList.add('bt', 'bt2');
			btLink.href = 'javascript:void(0)';
			btLink.onclick = () => renderCommentForm(comment.postId, comment.commentId);
			btLink.textContent = '댓글';

			cmtVoteDiv.appendChild(btLink);
			//자기 댓글이면 삭제 버튼
			if(comment.member.user_id == '${sessionScope.loginuser.user_id}') {
				const btDel = document.createElement('a');
				btDel.classList.add('bt', 'bt2', 'bt-del');
				btDel.href = 'javascript:void(0)';
				btDel.onclick = () => deleteComment(comment.commentId);
				btDel.textContent = '삭제';
				cmtVoteDiv.appendChild(btDel);
			}
			

			cmtButtonsDiv.appendChild(cmtVoteDiv);
			cmtBodyDiv.appendChild(cmtButtonsDiv);
		}
	    

	    const cmtDateWrapDiv = document.createElement('div');
	    cmtDateWrapDiv.classList.add('cmt_date_wrap', 'text_en', 'pt-col4');

	    const cmtTimeSpan = document.createElement('span');
	    cmtTimeSpan.classList.add('cmt_time');
	    cmtTimeSpan.textContent = formatTime(comment.commentDate, 'HH:mm');

	    const cmtDateDiv = document.createElement('div');
	    cmtDateDiv.classList.add('cmt_date');

		cmtDateDiv.textContent = formatDate(comment.commentDate);

	    // 24시간안에 작성된 댓글이면 표시
		const commentDate = comment.commentDate;
		const commentDateTime = dayjs(commentDate);
		const currentDate = dayjs();
		const hoursDiff = currentDate.diff(commentDateTime, 'hour');

		if(hoursDiff < 24) {
			const cmtNewSpan = document.createElement('span');
			cmtNewSpan.classList.add('cmt_new', 'pt-bg');
			cmtDateDiv.appendChild(cmtNewSpan);
		}
	    // 24시간안에 작성된 댓글이면 표시

	    cmtDateWrapDiv.appendChild(cmtTimeSpan);
	    cmtDateWrapDiv.appendChild(cmtDateDiv);
		cmtBodyDiv.appendChild(cmtDateWrapDiv);

	    commentDiv.appendChild(profileBoxDiv);
	    commentDiv.appendChild(cmtHeaderDiv);
	    commentDiv.appendChild(cmtBodyDiv);
	    cmtListDiv.appendChild(commentDiv);
	  });

	  



}


function renderCommentForm(postId, commentId) {

	const formDiv = document.querySelectorAll('div.cmt_write_re');

	if(formDiv.length > 0) {
		formDiv.forEach((div) => {
			const divId = div.id.replace("commentForm_", "");
			deleteCommentForm(divId);
		});
		
	}
	

	var commentFormDiv = document.createElement('div');
	commentFormDiv.className = 'cmt_write_unit cmt_write_re';
	commentFormDiv.id = 'commentForm_' + commentId;

	var form = document.createElement('form');
	form.id = 'cmt_form';
	form.action = '/watcha/community/comment';
	form.method = 'POST';

	// Create the hidden input fields
	var postIdInput = document.createElement('input');
	postIdInput.type = 'hidden';
	postIdInput.name = 'postId';
	postIdInput.value = postId;

	var contentInput = document.createElement('input');
	contentInput.type = 'hidden';
	contentInput.name = 'commentContent';
	contentInput.value = '';

	var parentCommentIdInput = document.createElement('input');
	parentCommentIdInput.type = 'hidden';
	parentCommentIdInput.name = 'parentCommentId';
	parentCommentIdInput.value = commentId;

	var textareaDiv = document.createElement('div');
	textareaDiv.className = 'cmt_write_input text_ver';

	//텍스트 area
	var textarea = document.createElement('textarea');
	textarea.className = 'cmt_textarea';
	textarea.id = 'editor_2';
	textarea.placeholder = '댓글 내용을 입력해주세요.';
	textarea.style.width = '100%';

	// 버튼 2개
	var cancelButton = document.createElement('button');
	cancelButton.className = 'ib ib2 ib_mono bt_close';
	cancelButton.type = 'button';
	cancelButton.textContent = '취소';
	cancelButton.addEventListener('click', function() {
	deleteCommentForm(commentId);
	});

	var submitButton = document.createElement('button');
	submitButton.className = 'ib ib2 ib_color';
	submitButton.type = 'submit';
	submitButton.textContent = '댓글 등록';


	// form에 태그들 넣기
	form.appendChild(postIdInput);
	form.appendChild(contentInput);
	form.appendChild(parentCommentIdInput);
	textareaDiv.appendChild(textarea);
	form.appendChild(textareaDiv);
	form.addEventListener('submit', submitCommentFrm);


	// 버튼 area 만들고 버튼 넣기
	var buttonArea = document.createElement('div');
	buttonArea.className = 'bt_area bt_right';
	buttonArea.appendChild(cancelButton);
	buttonArea.appendChild(submitButton);


	var optionDiv = document.createElement('div');
	optionDiv.className = 'cmt_write_option';
	optionDiv.appendChild(buttonArea);

	form.appendChild(optionDiv);
	commentFormDiv.appendChild(form);

	// 부모 div 찾고 넣어주기
	var parentDiv = document.getElementById('comment_' + commentId);
	parentDiv.appendChild(commentFormDiv);
	
}



function renderCommentPageBar(result) {

	//기존 페이지 바 제거.
	const pagebarDiv = document.getElementById('cmt_page_bar');
	while (pagebarDiv.firstChild) {
	    pagebarDiv.removeChild(pagebarDiv.firstChild);
	}

	// 제일 큰 div 생성
	const parentDiv = document.createElement('div');
	parentDiv.className = 'paging text_en pt-col4 comment-paging';

	// 첫 페이지 버튼
	const firstPageLink = document.createElement('a');
	firstPageLink.className = 'bt_first bubbling-parent';
	firstPageLink.href = 'javascript:void(0)';
	
	firstPageLink.onclick = () => getCommentList(1);
	firstPageLink.title = '첫 페이지';

	const firstPageIcon = document.createElement('i');
	firstPageIcon.className = 'fas fa-angle-double-left';

	firstPageLink.appendChild(firstPageIcon);

	const firstPageText = document.createElement('span');
	firstPageText.className = 'bubbling-child';
	firstPageText.textContent = '첫 페이지';

	const firstPageWrapper = document.createElement('span');
	firstPageWrapper.className = 'bubbling-child-wrap bt-page';
	firstPageWrapper.appendChild(firstPageLink);
	firstPageWrapper.appendChild(firstPageText);

	parentDiv.appendChild(firstPageWrapper);

	// 이전 페이지 버튼
	const prevPageLink = document.createElement('a');
	prevPageLink.className = 'bt-prev';
	prevPageLink.href = 'javascript:void(0)';
	const prevPageIndex = Math.max(result.startPage - 1, 1);
	prevPageLink.onclick = () => getCommentList(prevPageIndex);
	prevPageLink.title = 'prev';

	const prevPageIcon = document.createElement('i');
	prevPageIcon.className = 'fas fa-angle-left';

	prevPageLink.appendChild(prevPageIcon);

	const prevPageWrapper = document.createElement('span');
	prevPageWrapper.className = 'bt-page';
	prevPageWrapper.appendChild(prevPageLink);

	parentDiv.appendChild(prevPageWrapper);

	// 페이지 버튼, 숫자
	const pageNumberWrap = document.createElement('div');
	pageNumberWrap.className = 'page-num-wrap';
	for(var page = result.startPage ; page <= result.endPage; page++) {
		(function(page) {
			const pageLink = document.createElement('a');
			pageLink.href = 'javascript:void(0)';
			pageLink.className = 'page-num';
			if(page == result.currentPage) {
				pageLink.classList.add('active');
			} else {
				pageLink.onclick = () => getCommentList(page);
			}
			pageLink.textContent = page;		
			const pageWrapper = document.createElement('span');
			pageWrapper.className = 'bt-page';
			pageWrapper.appendChild(pageLink);
			pageNumberWrap.appendChild(pageWrapper);
		})(page);
	}


	parentDiv.appendChild(pageNumberWrap);

	// 다음 페이지 버튼
	const nextPageLink = document.createElement('a');
	nextPageLink.className = 'bt-next';
	nextPageLink.href = 'javascript:void(0)';
	const nextPageIndex = Math.min(result.endPage + 1, result.totalPages);
	nextPageLink.onclick = () => getCommentList(nextPageIndex);
	nextPageLink.title = 'next';

	const nextPageIcon = document.createElement('i');
	nextPageIcon.className = 'fas fa-angle-right';

	nextPageLink.appendChild(nextPageIcon);

	const nextPageWrapper = document.createElement('span');
	nextPageWrapper.className = 'bt-page';
	nextPageWrapper.appendChild(nextPageLink);

	parentDiv.appendChild(nextPageWrapper);

	// 끝 페이지 버튼
	const lastPageLink = document.createElement('a');
	lastPageLink.className = 'bt_last bubbling-parent';
	lastPageLink.href = 'javascript:void(0)';
	lastPageLink.onclick = () => getCommentList(result.totalPages);
	lastPageLink.title = '끝 페이지';

	const lastPageIcon = document.createElement('i');
	lastPageIcon.className = 'fas fa-angle-double-right';

	lastPageLink.appendChild(lastPageIcon);

	const lastPageText = document.createElement('span');
	lastPageText.className = 'bubbling-child';
	lastPageText.textContent = '끝 페이지';

	const lastPageWrapper = document.createElement('span');
	lastPageWrapper.className = 'bubbling-child-wrap bt-page';
	lastPageWrapper.appendChild(lastPageLink);
	lastPageWrapper.appendChild(lastPageText);

	parentDiv.appendChild(lastPageWrapper);

	// 페이지 바 div에 추가
	pagebarDiv.appendChild(parentDiv);

	if(pageLoaded) {
		pagebarDiv.scrollIntoView({behavior: "smooth", block:"end"})
	}
	pageLoaded = true;
}



function deleteCommentForm(commentId) {
	var commentFormDiv = document.getElementById('commentForm_' + commentId);
	if (commentFormDiv) {
	commentFormDiv.remove();
	}
}



function search() {
	const searchForm = document.getElementById('communitySearchForm');

	//입력 없으면 return
	const searchKeywordInput = document.querySelector("[name='searchKeyword']");
	const searchKeywordValue = searchKeywordInput.value.trim();

	if (searchKeywordValue === '') {
		alert('검색어를 입력해주세요.');
		return false;
	}

	// 카테고리와 글분류 input 추가
	const exceptionModeParam = '${param.exception_mode}';
	const searchCategoryParam = '${param.search_category}';

	if (exceptionModeParam !== '') {
		const exceptionModeInput = document.createElement('input');
		exceptionModeInput.type = 'hidden';
		exceptionModeInput.name = 'exception_mode';
		exceptionModeInput.value = exceptionModeParam;
		searchForm.appendChild(exceptionModeInput);
	}

	if (searchCategoryParam !== '') {
		const searchCategoryInput = document.createElement('input');
		searchCategoryInput.type = 'hidden';
		searchCategoryInput.name = 'search_category';
		searchCategoryInput.value = searchCategoryParam;
		searchForm.appendChild(searchCategoryInput);
	}

	searchForm.action = '/watcha/community';
	searchForm.submit();
}

function submitCommentFrm(event) {
	
	event.preventDefault();

	if(${empty sessionScope.loginuser}) {
		alert("로그인 필요");
		return;
	}
	
	const cmtTextarea = event.target.querySelector('.cmt_textarea');

	const formData = new FormData(event.target);

	if (!cmtTextarea.value) {
		alert("댓글 내용을 입력해주세요");
		return;
	}

	formData.set('commentContent', cmtTextarea.value);

	formData.set('userId', '${sessionScope.loginuser.user_id}');

	let entries = formData.entries();
	for (const pair of entries) {
		console.log(pair[0]+ ', ' + pair[1]); 
	}



	fetch('comment', {
		method: 'POST',
		body: formData,
	})
	.then(response => response.json())
	.then(result => {
		console.log(result);
		getCommentList(result.page);
		
		setTimeout(function() {
			scrollToComment(result.commentId);
		}, 50); 
		showSuccessMessage('댓글이 정상적으로 작성되었습니다!');
	})
	.catch((error) => {
		console.error('Error:', error);
		toastr.error('댓글을 작성하는 도중 문제가 발생하여 댓글이 정상적으로 작성되지 않았습니다.');
	});
}


function deleteComment(commentId) {
	event.preventDefault();
	
	fetch(`comment/\${commentId}`, {
		method: 'DELETE'
	})
	.then(response => response.json())
	.then(result => {
		showSuccessMessage('댓글이 정상적으로 삭제되었습니다!');
		getCommentList(result.page);
	})
	.catch((error) => {
		console.error('Error:', error);
		toastr.error('댓글을 작성하는 도중 서버에 문제가 발생하여 댓글이 정상적으로 삭제되지 않았습니다.');
	});
}


function commentLikes(postId) {
	hasLikedPost(postId)
    .then(status => {
      if (status === 0) {
        // 추가
        return fetch(`likes/\${postId}`, {
          method: 'POST',
          }
        );
      } else if (status === 1) {
		//삭제
        return fetch(`likes/\${postId}`, {
          method: 'DELETE',
        });
      }
    })
	.then(response => response.json())
	.then(response => {
		console.log(response);
		document.querySelector('.voted_count').textContent = response.count;
		// 우측 상단도 올라가야할까???
		const button = document.querySelector('.bt_vote');
		button.classList.toggle('submitted', response.status === 1);
	})
    .catch(err => console.error(err));
}

function hasLikedPost(postId) {
	return fetch(`likes/\${postId}`, {
		method: 'GET',
	})
	.then((response) => response.json())
	.then((result) => {
		return result.status;
	});
}




function showSuccessMessage(message) {
  toastr.options = {
    positionClass: 'toast-bottom-right',
    progressBar: true,
    closeButton: true
  };
  toastr.success(message);
}

function scrollToCommentForm() {
	const commentForm = document.querySelector('.cmt_bottom_unit');
	console.log(commentForm);
	commentForm.scrollIntoView({behavior: "smooth", block: "end"});
}


function getCommentData() {
	return fetch(`comments/${requestScope.selectedPost.postId}`)
	.then((response) => response.json())
	.then((result) => {
		return result;
	});
}

function refreshCommentList() {
	getCommentData()
	.then(result => {
		console.log(result);
		if(result.totalPages > 0) {
			getCommentList(result.totalPages);
		}
		document.querySelector('.cmt-count').textContent = result.totalComments;
	})
	.catch(error => {
		console.error('Error:', error);
	});
}




</script>

</head>
<body>

<c:set var="currentPage" value="${param.page }" />
<c:set var="searchType" value="${param.searchType }" />
<c:set var="searchKeyword" value="${param.searchKeyword }" />
<c:set var="exception_mode" value="${param.exception_mode }" />
<c:set var="search_category" value="${param.search_category }" />

	<div class="container-fluid community-body mt-3">
		<div class="row">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="bd_header">
					<h2 class="bd_title">
						<i class="far fa-list-alt big-icon"></i> <a href="/watcha/community">커뮤니티</a>
					</h2>
				</div>
			</div>
		</div>
		
		
		<c:if test="${selectedPost != null }">
		<div class="row">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="post-detail-box">
					<div class="post-detail-header">
						<h1>
							<a href="${selectedPost.postId }" class="atc_title"><span class="atc-title-category">[${selectedPost.postCategoryName }]</span> ${selectedPost.title }</a>
						</h1>
						<div class="post-info clearfix">
							<span class="post-nickname">${selectedPost.member.nickname }
							</span>
							<span class="post-date">2023.05.17. 13:21</span>
							<div class="float-right post-info-right">
								<span class="count_read"><i class="fas fa-eye" title="조회 수"></i> ${selectedPost.views}</span>
								<span class="count-likes pt_col"><i class="fas fa-heart" title="추천 수"></i> ${selectedPost.likes }</span>
								<span class="count_cmt pt-col2"><i class="fas fa-comment-dots" title="댓글"></i> ${selectedPost.commentCount }</span>
							</div>
						</div>
					</div>
					<div class="post-detail-body">
						<!--BeforeDocument(91006230,43413969)-->
						<div class="post-detail-content" data-pswp-uid="1">							
							${selectedPost.content }
							
							
							<div class="movie_list">
							<c:forEach items="${selectedPost.movies }" var="movie">
								<div class="movie_item" data-movie-id="${movie.movie_id}">
									<div class="movie_item__poster">
										<img class="poster__img" src="https://image.tmdb.org/t/p/w92/${movie.poster_path}" lazy="loaded">
									</div>
									<div class="movie_item__description">
										<h5 class="description__title">${movie.movie_title}</h5>
										<p class="description__subtitle">영화 · ${movie.release_date}</p>
										<div class="description__bottom">
										<span class="kino_score__percent green">평균 ★${movie.rating_avg} (${movie.rating_count} 명)</span>
										</div>
									</div>
								</div>
							</c:forEach>
							</div>
						</div>
						<!--AfterDocument(91006230,43413969)-->
						
						<div class="atc_buttons clearfix">
							<div class="atc_buttons_etc">
								<!-- <span class="bubbling-child-wrap">
									<button class="bt_report ib ib_mono bubbling-parent" type="button" onclick="insertWarn('로그인 해주세요.')">
									<i class="fas fa-exclamation-triangle only" title="신고"></i>
									</button>
									<span class="bubbling-child">신고</span>
								</span> -->
								<span class="bubbling-child-wrap">
									<button class="bt_eidt ib ib_mono bubbling-parent" type="button" onclick="inkPop('atc_share')">
										<i class="fa-solid fa-pen-to-square"></i>
									</button>
									<span class="bubbling-child">수정</span>
								</span>
								<span class="bubbling-child-wrap">
									<button class="bt_delete ib ib_mono bubbling-parent" type="button" onclick="insertWarn('로그인 해주세요.')">
										<i class="fa-solid fa-eraser"></i>
									</button>
									<span class="bubbling-child">삭제</span>
								</span>
							</div>
							<div class="atc_vote float-left mt-3">
								<button class="bt_vote vote_area" type="button" onclick="commentLikes('${selectedPost.postId}')">
									좋아요
										<span class="voted_count text_en">${selectedPost.likes }</span>
								</button>
							</div>
						</div>
						
					</div>
					
					<div id="comment" class="cmt cmt_bubble">
						<div class="cmt-title">
							<h3>
								댓글 <span class="cmt-count">${selectedPost.commentCount}</span>
							</h3>
							<span class="bubbling-child-wrap bt-cmt-refresh">
								<button class="bubbling-parent cmt-write" type="button" title="댓글 새로고침" onclick="refreshCommentList()">
									<i class="fa-solid fa-rotate-right"></i>
								</button>
								<span class="bubbling-child">댓글 새로고침</span>
							</span>
							<span class="bubbling-child-wrap bt-cmt-write">
								<button class="bubbling-parent cmt-write" type="button" title="댓글 쓰기" onclick="scrollToCommentForm()">
									<i class="fa-solid fa-comment"></i>
								</button>
								<span class="bubbling-child">댓글 쓰기</span>
							</span>
						</div>
						<div class="cmt-notice">
							<i class="fas fa-microphone"></i>추천+댓글을 달면 포인트가 더 올라갑니다 <br>
							정치,종교 관련 언급 절대 금지입니다 <br> 상대방의 의견에 반박, 비아냥, 조롱 금지입니다 <br>
							영화는 개인의 취향이니, 상대방의 취향을 존중하세요
						</div>
						<!-- //cmt_notice -->
						<div class="cmt-wrap">
							<div class="cmt_list">								
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
						<div class="cmt_write_unit cmt_bottom_unit">
							<span class="profile-img round"></span>
							<form id="cmt_form" action="/watcha/community/comment" method="POST">
									<input type="hidden" name="postId" value="${selectedPost.postId}">
									<input type="hidden" name="commentContent" value="">
									<!-- <input type="hidden" name="root_comment" value=""> -->
									<input type="hidden" name="parentCommentId" value="">
									
								<div class="cmt_write_input text_ver">
									<textarea class="cmt_textarea" placeholder="댓글 내용을 입력해주세요." style="width: 100%;"></textarea>
								</div>
								<div class="cmt_write_option">
									<div class="bt_area bt_right">
										<button class="ib ib2 ib_mono bt_vote_submit" type="submit"><i class="fas fa-heart pt_col"></i> + 등록</button>
										<button class="ib ib2 ib_color" type="submit">댓글 등록</button>
									</div>
								</div>
								<input type="hidden" name="_rx_csrf_token" value="lK2Xig3TLCSccmeR">
							</form>
						</div>
						<!-- //cmt_write_re -->

						<div id="cmt_page_bar">
							
						</div>
						<!-- //cmt page bar -->
					</div>
					<!-- //cmt -->

				</div>
			</div>
		</div>
		</c:if>
		

		<div class="row">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="list_array_option clear">
					<div class="array_tab left_box">
						<button type="button" ${exception_mode ne 'recommend' ? 'class="on"' : ''} onclick="location.href='/watcha/community'">전체글</button>
						
						<c:url var="recommendURL" value="/community">
						    <c:param name="exception_mode" value="recommend" />
						</c:url>
						
						<button type="button" ${exception_mode eq 'recommend' ? 'class="on"' : ''} onclick="location.href='${recommendURL}'">인기글</button>
					</div>
					<div class="center_box">
						<div class="inner">
							<ul>
								<c:url var="allCategoryURL" value="/community">
									<c:param name="page" value="1" />
								    <c:if test="${not empty exception_mode}">
								    	<c:param name="exception_mode" value="${exception_mode}" />
								    </c:if>
								</c:url>
								<li><a href="${allCategoryURL }" ${empty search_category ? 'class="on"' : ''}>전체</a></li>
								
								
								<c:forEach var="category" items="${requestScope.categories }">
								<c:url var="categoryURL" value="/community">
								    <c:param name="search_category" value="${category.POST_CATEGORY_ID }" />
								    <c:param name="page" value="1" />
								    <c:if test="${not empty exception_mode}">
								    	<c:param name="exception_mode" value="${exception_mode}" />
								    </c:if>
								</c:url>
								<li><a href="${categoryURL }" ${not empty search_category && search_category eq category.POST_CATEGORY_ID ? 'class="on"' : ''}>${category.POST_CATEGORY_NAME}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="right_box">
						<div class="output_array clear" style="display:block"1>
							<div class="switch_btnbox">
								<a class="ib ib2 ib_color float-right" href="/watcha/community/write">
									<i class="fas fa-pen"></i>
									<span>쓰기</span>
								</a>
							</div>
						</div>
					</div>
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
							<!-- LIST -->
							<c:forEach items="${posts }" var="post">
							<tr data-postId="${post.postId }">
								<td class="no text_en">${post.postId }</td>
								<!-- 글번호 -->
								<td class="no text_en">${post.postCategoryName }</td>
								<td class="list_left list_title">
									<div class="article_type">
										<span class="list_icon2 normal"></span>
									</div>
									<div class="title-area">
										<c:if test="${post.hasImage }">
										<i class="fas fa-image" style="color: green;"></i>
										</c:if>
										<c:if test="${not post.hasImage }">
										<i class="fa-regular fa-file-lines"></i>
										</c:if>
										
										<c:url var="postURL" value="/community/${post.postId }">
										  <c:if test="${not empty currentPage}">
										  	<c:param name="page" value="${currentPage}" />
										  </c:if>
										  <c:if test="${not empty searchType}">
										    <c:param name="searchType" value="${searchType}" />
										  </c:if>
										  <c:if test="${not empty searchKeyword}">
										    <c:param name="searchKeyword" value="${searchKeyword}" />
										  </c:if>
										  <c:if test="${not empty exception_mode}">
										    <c:param name="exception_mode" value="${exception_mode}" />
										  </c:if>
										  <c:if test="${not empty search_category}">
										    <c:param name="search_category" value="${search_category}" />
										  </c:if>
										</c:url>
										
										
										<a href="${postURL}" class="title_link">${post.title }</a>
										<!-- 글제목 -->
										<c:if test="${post.commentCount > 0}">
											<a href="${postURL}#comment" class="cmt_num">${post.commentCount }</a>
										</c:if>
										<!-- 댓글 개수 -->
									</div>
								</td>
								<td class="list_author">
									<a class="xe_point_level_icon" style="vertical-align: middle; margin-right: 3px;">${post.member.nickname }</a>
									<!-- 글작성자 -->
								</td>
								<td class="date text_en"><span class="msover-date">
									<span class="ink-date">${post.formattedPostDate }</span>
									<!-- 글 작성 일자 -->
									<span class="ink-time">${post.formattedPostTime}</span></span>
									<!-- 글 작성 시간 -->
								</td>
								<td class="extra_col text_en"><span>${post.views }</span></td>
								<!-- 조회수 -->
								<td class="extra_col text_en"><span>${post.likes }</span></td>
								<!-- 추천수  -->
							</tr>
							</c:forEach>
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
						<a class="ib ib2 ib_color float-right" href="/watcha/community/write">
							<i class="fas fa-pen"></i>
							<span>쓰기</span>
						</a>
						<!-- 쓰기버튼 -->
					</div>
					<div class="paging text_en pt-col4">
						<c:url var="pageCommonURL" value="/community" context="/">
							
							<c:if test="${not empty searchType}">
							<c:param name="searchType" value="${searchType}" />
							</c:if>
							<c:if test="${not empty searchKeyword}">
							<c:param name="searchKeyword" value="${searchKeyword}" />
							</c:if>
							<c:if test="${not empty exception_mode}">
							<c:param name="exception_mode" value="${exception_mode}" />
							</c:if>
							<c:if test="${not empty search_category}">
							<c:param name="search_category" value="${search_category}" />
							</c:if>
						</c:url>

						<c:url var="firstPageURL" value="${pageCommonURL}">
							<c:param name="page" value="1" />
						</c:url>

						<c:url var="prevPageURL" value="${pageCommonURL}">
							<c:choose>
								<c:when test="${1 gt (startPage - 1)}">
									<c:param name="page" value="1" />
								</c:when>
								<c:otherwise>
									<c:param name="page" value="${startPage - 1}" />
								</c:otherwise>
							</c:choose>							
							
						</c:url>
						<c:url var="nextPageURL" value="${pageCommonURL}">
							<c:choose>
								<c:when test="${totalPages lt (endPage + 1)}">
									<c:param name="page" value="${totalPages}" />
								</c:when>
								<c:otherwise>
									<c:param name="page" value="${endPage + 1}" />
								</c:otherwise>
							</c:choose>
						</c:url>

						<c:url var="lastPageURL" value="${pageCommonURL}">
							
							<c:param name="page" value="${totalPages}" />
						</c:url>

						<span class="bubbling-child-wrap bt-page">
							<a class="bt_first bubbling-parent" href="${firstPageURL}" title="첫 페이지">
								<i class="fas fa-angle-double-left"></i>
							</a>
						<span class="bubbling-child">첫페이지</span>
						</span> 
						<span class="bt-page">
							<a class="bt-prev" href="${prevPageURL}" title="prev">
								<i class="fas fa-angle-left"></i>
							</a>
						</span>
						<div class="page-num-wrap">
							<c:forEach begin="${startPage }" end="${endPage }" var="pageNum">
								
								<c:if test="${pageNum ne requestScope.pageNo }">
								<c:url var="pageNumberURL" value="${pageCommonURL}">
									<c:param name="page" value="${pageNum}" />
								</c:url>
								<span class="bt-page"><a href="${pageNumberURL }" class="page-num">${pageNum }</a></span>
								</c:if>
								
								<c:if test="${pageNum eq requestScope.pageNo }">
								<span class="bt-page"><a class="page-num active">${pageNum }</a></span>
								</c:if>
							</c:forEach>
						</div>
						<span class="bt-page">
							<a class="bt-next" href="${nextPageURL}" title="next">
							<i class="fas fa-angle-right"></i>
							</a>
						</span>
						<span class="bubbling-child-wrap bt-page">
							<a class="bt_last bubbling-parent" href="${lastPageURL}" title="끝 페이지">
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
							<form id="communitySearchForm" name="communitySearchForm" method="get">
								<div class="modal-header search-header">
									<h5 class="modal-title search-title" id="exampleModalLabel">검색</h5>

								</div>
								<div class="modal-body">
									<select class="wide search-select" name="searchType">
										<option value=titleContent>제목+내용</option>
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="author">작성지</option>
										<option value="tag" disabled>태그</option>
									</select> <input class="search-input focused" type="text"
										name="searchKeyword" value="" title="검색"
										placeholder="검색어를 입력하세요.">
								</div>
								<div class="modal-footer search-bt-area">
									<button type="button" class="btn btn-cancel"
										data-dismiss="modal">취소</button>
									<button type="button" class="btn btn-search" onclick="search()">검색</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- 검색모달 -->

			</div>
		</div>
	</div>

</body>



</html>

