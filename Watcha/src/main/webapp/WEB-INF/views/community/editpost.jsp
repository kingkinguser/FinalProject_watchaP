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


<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/quilljs/quill/quill.snow.css" />
<link href="https://unpkg.com/quill-image-uploader@1.2.4/dist/quill.imageUploader.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/community.css" type="text/css">

<!-- text editor quill import -->


<script src="https://cdn.jsdelivr.net/npm/quill-blot-formatter@1.0.5/dist/quill-blot-formatter.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/quilljs/quill/quill.min.js"></script>
<script src="https://unpkg.com/quill-image-uploader@1.2.4/dist/quill.imageUploader.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<style type="text/css">



</style>



<script type="text/javascript">

var quill;

$(document).ready(function() {
	$('#postCategoryId').val(`${selectedPost.postCategoryId}`);
	$('#postCategoryId').niceSelect();
	
	$('#tags').on('keyup', searchMovieList);
	setQuillEditor();
	$(document).on('click', '.movie-list-item', appendMovieTag);
	$(document).on('click', '.more__btn', deleteMovieTag);



	const form = document.getElementById('post-form');
	form.addEventListener('submit', handleSubmit);


});

	function setQuillEditor() {

		var Size = Quill.import('attributors/style/size')
		Size.whitelist = [
		'8px','9px','10px','12px','14px','16px','20px','24px','32px','42px','54px','68px','84px','98px'
		]
		Quill.register(Size, true)
		
		Quill.register("modules/imageUploader", ImageUploader);
		Quill.register('modules/blotFormatter', QuillBlotFormatter.default);

		var toolbarOptions = [
			[{ 'font': [] }],
			[{ 'size': ['8px','9px','10px','12px','14px','16px','20px','24px','32px','42px','54px','68px','84px','98px'] }],
			[{ 'header': [1, 2, 3, 4, 5, 6, false] }],
			['bold', 'italic', 'underline', 'strike'],        // toggled buttons	
			[{ 'list': 'ordered'}, { 'list': 'bullet' }],
			[{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
			[{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
			[{ 'align': [] }],
			['link', 'image', 'video'],
			['clean']                                         // remove formatting button
			];

		var option = {
				modules: {
					toolbar: toolbarOptions,
					blotFormatter: {
					
					},
					imageUploader: {
						upload: (file) => {
							return new Promise((resolve, reject) => {
							const formData = new FormData();
							formData.append('image', file);

							// 서버에 업로드
							fetch('/watcha/community/write/upload-image', {
								method: 'POST',
								body: formData,
							})
								.then((response) => response.json())
								.then((result) => {
								// Resolve with the URL of the uploaded image
								console.log(result.url);
								resolve(result.url);
								})
								.catch((error) => {
								// 에러발생
								reject('Image upload failed');
								});
							});
						},
						},
				},
				theme: 'snow',
				placeholder: '내용을 입력하세요.',
		}
		
		
		quill = new Quill('#quillEditor', option);

		quill.root.innerHTML = `${selectedPost.content}`;
		document.getElementById('title').value = `${selectedPost.title}`;
	}


	function handleSubmit(event) {
		event.preventDefault();
		var title = document.getElementById('title').value;
		var category = document.getElementById('postCategoryId').value;
		var editorContent = quill.root.innerHTML;

		if (!title.trim()) {
			alert('글 제목을 입력하세요.');
			return;
		}

		if (category === '') {
			alert('게시글 카테고리를 선택하세요.');
			return;
		}

		if (/^(<p>|<\/p>|<br>|\s)*$/.test(editorContent.trim())) {
			alert('글내용을 입력하세요.');
			return;
			}

		var contentInput = document.getElementById('content');

		contentInput.value = editorContent;
		
		const formData = new FormData(event.target);
		
		const movieIds = Array.from(document.querySelectorAll('.movie_list .movie_item')).map(item => item.dataset.movieId);
  		
		// formData.append('movieIds', JSON.stringify(movieIds));
		const data = {
			...Object.fromEntries(formData.entries()),
			movieIds: movieIds
		};


		submitFormData(data);
	}
	

	function submitFormData(formData) {
		
		fetch(`/watcha/community/${selectedPost.postId}/edit`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(formData)
		})
		.then(response => response.json())
		.then(data => data.status)
		.then(result => {
			if (result === 1) {
				Swal.fire({
				icon: 'success',
				title: '게시글 수정에 성공하였습니다.',
				showConfirmButton: true,
				timer: 3000
				}).then((result) => {
					window.location.href = `/watcha/community/${selectedPost.postId}`;
				});
			} else if (result === 0) {
				Swal.fire({
				icon: 'error',
				title: '게시글 수정에 실패했습니다.',
				showConfirmButton: true,
				timer: 3000
				}).then((result) => {
					window.location.href = `/watcha/community/${selectedPost.postId}`;
				});
			}
		})
		.catch(error => {
			console.error('Error:', error);
		});
	}


	let debounceTimeout;

	function searchMovieList(event) {
		//디바운싱으로 검색횟수를 줄임
		clearTimeout(debounceTimeout);

		const searchText = event.target.value;
		

		//검색어가 존재하면 fetch 실행
		debounceTimeout = setTimeout(() => {
			if (searchText.trim().length > 0) {
			fetchMovies(searchText)
			.then((movies) => {
				displayMovies(movies);
			})
			.catch((error) => {
				console.error('Error fetching movie data:', error);
			});
			} else {
				// 검색어가 없을때 지워주기
				clearMovies();
			}
		}, 300);
	}

	
	 
	function fetchMovies(searchText) {
		const apiUrl = `/watcha/community/write/movielist?search=\${encodeURIComponent(searchText)}`;
		return fetch(apiUrl)
		.then((response) => response.json())
		.then((data) => {
			return data.movies;
		});
	}

	function fetchMovie(movieId) {
		const apiUrl = `/watcha/community/write/movie?search=\${encodeURIComponent(movieId)}`;
		return fetch(apiUrl)
		.then((response) => response.json())
		.then((data) => {
			return data.movie;
		});
	}


	function displayMovies(moviesJSON) {
		const movies = JSON.parse(moviesJSON);
		const movieList = document.querySelector('.movie-search-list-body');
		// 실행전 클리어
		clearMovies();

		// 반복문 돌려서 영화들 추가
		movies.forEach((movie) => {
			// 제일 바깥 div 생성
			const movieDiv = document.createElement('div');
			movieDiv.classList.add('movie-list-item');
			movieDiv.setAttribute('data-movie-id', movie.movie_id);

			// 포스터 div
			const posterDiv = document.createElement('div');
			posterDiv.classList.add('movie-list-item-poster');

			// 포스터 이미지
			const posterImg = document.createElement('img');
			//posterImg.alt = movie.movieTitle;
			posterImg.classList.add('poster-img');
			var imageSrc = `https://image.tmdb.org/t/p/w92/\${movie.poster_path}`;
			posterImg.src = imageSrc;
			posterImg.setAttribute('lazy', 'loaded');

			// 포스터 div에 포스터 img 넣어주기
			posterDiv.appendChild(posterImg);

			// 영화 정보 div
			const infoDiv = document.createElement('div');
			infoDiv.classList.add('movie-list-item-info');

			// 영화 타이틀 p태그
			const titleParagraph = document.createElement('p');
			titleParagraph.classList.add('info-title');
			titleParagraph.textContent = movie.movie_title;

			// 영화 개봉일 p태그
			const releaseYearParagraph = document.createElement('p');
			releaseYearParagraph.classList.add('info-release-year');
			releaseYearParagraph.textContent = movie.release_date;

			// 영화정보에 타이틀, 개봉일 넣어주기
			infoDiv.appendChild(titleParagraph);
			infoDiv.appendChild(releaseYearParagraph);

			// 영화 div에 포스터와 영화정보 div넣어주기
			movieDiv.appendChild(posterDiv);
			movieDiv.appendChild(infoDiv);

			// 완성된 div movielist에 넣어주기
			movieList.appendChild(movieDiv);
		});
	}


	function clearMovies() {
		//tag창에 영화리스트 삭제하기
		const movieList = document.querySelector('.movie-search-list-body');
		while (movieList.firstChild) {
			
			movieList.removeChild(movieList.firstChild);
		}
		
	}

	function appendMovieTag(e) {
		
		
		const movieId = $(this).data('movie-id');
		fetchMovie(movieId)
			.then((movie) => {
				console.log(movie);
				displayMovie(movie);
			})
			.catch((error) => {
				console.error('Error fetching movie data:', error);
			});
  		
	}

	function displayMovie(movieJSON) {
		const movie = JSON.parse(movieJSON);
		const movieList = document.querySelector('.movie_list');
		const existingMovies = movieList.querySelectorAll('.movie_item[data-movie-id]');
		
		// 이미 존재하는 영화 확인
		const movieExists = Array.from(existingMovies).some(item => item.dataset.movieId === movie.movie_id);
		if (movieExists) {
			alert('동일한 영화가 이미 존재합니다.');
			return;
		}
		
		// 영화 최대 개수 확인
		const maxMovies = 5;
		if (existingMovies.length >= maxMovies) {
			alert('최대 5개의 영화를 등록할 수 있습니다.');
			return;
		}


		// 실행전 클리어
		clearMovies();
		document.getElementById('tags').value = '';

		const releaseYear = new Date(movie.release_date).getFullYear();
		const movieItem = `
			<div class="movie_item" data-movie-id="\${movie.movie_id}">
			<div class="movie_item__poster">
				<img class="poster__img" src="https://image.tmdb.org/t/p/w92/\${movie.poster_path}" lazy="loaded">
			</div>
			<div class="movie_item__description">
				<h5 class="description__title">\${movie.movie_title}</h5>
				<p class="description__subtitle">영화 · \${releaseYear}</p>
				<div class="description__bottom">
				<span class="kino_score__percent green">평균 ★\${movie.rating_avg} (\${movie.rating_count} 명)</span>
				</div>
			</div>
			<div class="movie_item__more">
				<button type="button" class="more__btn" data-movie-id="\${movie.movie_id}">삭제</button>
			</div>
			</div>
		`;

		$(".movie_list").append(movieItem);

		
	}

	function deleteMovieTag(event) {
		const clickedElement = event.target;
		const movieId = clickedElement.dataset.movieId;
		const movieItem = document.querySelector(`.movie_item[data-movie-id="\${movieId}"]`);
		//data movie-id가 일치하는 div삭제 해주기
		if (movieItem) {
			movieItem.remove();
		}
		
	}


</script>

</head>
<body>

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
		<div class="row">
			<div class="col-md-8 col-xs-12 offset-md-2">
				<div class="postwrite-box" >
					<section class="ink_board member_mode">
						<div class="bd_write round20">
							<form id="post-form" action="/watcha/community/${selectedPost.postId}/edit" method="POST">
								
								<div class="write_header">
									<h3>글 수정하기</h3>
									<div class="bt_area2 bt_right">
										<button class="ib ib2 ib_mono"
											onclick="window.history.back();return false;" type="button">취소</button>
										<button class="ib ib2 ib_color" type="submit">등록</button>
									</div>
								</div>
								<input type="hidden" id="content" name="content" value="">
								<input type="hidden" id="postId" name="postId" value="${selectedPost.postId}">
								<input type="hidden" id="userId" name="userId" value="${sessionScope.loginuser.user_id}">
								<div class="write_body">
									<div class="write_ctg">
										<select name="postCategoryId" id="postCategoryId">
											<option value="">분류 선택</option>
											<option value="0">🖊일반</option>
											<option value="10">❓질문</option>
											<option value="20">📔정보</option>
											<option value="30">📙후기</option>
										</select>

									</div>
									<div class="write_title use_ctg">
										<input class="ii ii2" type="text" name="title" id="title" placeholder="제목">
									</div>


									<div id="quillEditor" class="quill-Editor">
									</div>


									<div class="write_tags">
										<input class="ii ii2 search-input" type="text" name="tags" id="tags" placeholder="이야기하고 싶은 작품을 검색해보세요">
										<div class="movie-search-list-body">
											<!-- 이 안에 영화리스트 들어감 -->
										</div>
									</div>
									<div class="movie_list">
										<!-- 선택한 영화 들어가는 공간 -->
										<c:forEach items="${selectedPost.movies }" var="movie">
										<div class="movie_item" data-movie-id="${movie.movie_id}">
											<div class="movie_item__poster">
												<img class="poster__img" src="https://image.tmdb.org/t/p/w92/${movie.poster_path}" lazy="loaded">
											</div>
											<div class="movie_item__description">
												<h5 class="description__title">${movie.movie_title}</h5>
												<p class="description__subtitle">영화 · ${movie.releaseYear}</p>
												<div class="description__bottom">
												<span class="kino_score__percent green">평균 ★${movie.rating_avg} (${movie.rating_count} 명)</span>
												</div>
											</div>
											<div class="movie_item__more">
												<button type="button" class="more__btn" data-movie-id="${movie.movie_id}">삭제</button>
											</div>
										</div>
										</c:forEach>
										<!--  -->
									</div>
									
								</div>
								<div class="bt_area bt_right">
									<div class="bt_left">
										<button class="ib ib_mono" type="button"
											onclick="doDocumentSave(this);">임시 저장</button>
										<button class="ib ib_mono" type="button"
											onclick="doDocumentLoad(this);">불러오기</button>
									</div>
									<button class="ib ib_mono"
										onclick="window.history.back();return false;" type="button">취소</button>
									<button class="ib ib_color" type="submit">등록</button>
								</div>
								
							</form>
						</div>
						<div class="ink_align_center"></div>
					</section>

				</div>
			</div>
		</div>

	</div>







</body>



</html>

