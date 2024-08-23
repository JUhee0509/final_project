document.addEventListener('DOMContentLoaded', function() {
    const sliderWrap = document.querySelector(".wrap");

    if (!sliderWrap) return; // sliderWrap이 없으면 종료

    const sliderImg = sliderWrap.querySelector(".img_header");
    const sliderInner = sliderWrap.querySelector(".img_inner");
    const slider = sliderWrap.querySelectorAll(".img");
    const sliderDot = sliderWrap.querySelector(".slider_dot");

    let currentIndex = 0;
    let sliderInterval = 3000; // 이미지 전환 간격 설정 (예: 3초)
    let sliderCount = slider.length;
    let sliderWidth = sliderWrap.querySelector(".img_header").offsetWidth;
    let dotIndex = "";

    function init() {
        slider.forEach(() => dotIndex += "<a href='#' class='dot'></a>");
        sliderDot.innerHTML = dotIndex;
        sliderDot.firstChild.classList.add("active");
    }
    init();

    function moveSlider(num) {
        sliderInner.style.transition = "all 400ms";
        sliderInner.style.transform = 'translateX(' + -sliderWidth * num + 'px)';
        currentIndex = num;

        let DotActive = document.querySelectorAll(".slider_dot .dot");
        DotActive.forEach((active) => active.classList.remove("active"));
        DotActive[num].classList.add("active");
    }

    function autoSlide() {
        setInterval(() => {
            currentIndex = (currentIndex + 1) % sliderCount;
            moveSlider(currentIndex);
        }, sliderInterval);
    }

    autoSlide();

    sliderDot.querySelectorAll(".dot").forEach((dot, index) => {
        dot.addEventListener("click", () => {
            moveSlider(index);
        });
    });
});