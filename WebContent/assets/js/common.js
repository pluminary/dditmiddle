// F5 키보드 키를 눌러서 새로고침시 GET 파라미터 제거 후 새로고침 하기
//window.onkeydown = function() {
//	var kcode = event.keyCode;
//	if(kcode == 116) {
//		history.replaceState({}, null, location.pathname);
//	}
//}


//// 스크롤 위치 저장
//window.addEventListener('scroll', function() {
//    // 현재 스크롤 위치를 localStorage에 저장
//    localStorage.setItem('scrollPosition', window.scrollY || document.documentElement.scrollTop);
//});
//// 페이지 로드 시 스크롤 위치 복원
//document.addEventListener('DOMContentLoaded', function() {
//    // 페이지 로드 시 localStorage에서 스크롤 위치를 가져옴
//    if (localStorage.getItem('scrollPosition')) {
//        // 저장된 스크롤 위치로 이동
//        window.scrollTo(0, localStorage.getItem('scrollPosition'));
//    }
//});




