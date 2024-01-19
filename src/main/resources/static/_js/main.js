var slide = document.querySelectorAll(".crewList");
var prev = document.querySelector("#prevBtn");
var next = document.querySelector("#nextBtn");
var current = 0;

function showSlides(n){
    for(var i=0;i<slide.length;i++){
        slide[i].style.display = "none";
    }
    slide[n].style.display = "block";
}
showSlides(current);

function prevSlides(){
    if(current > 0){
        current--;
    }else{
        current = slide.length-1;
    }
    showSlides(current);
}
prev.onclick = prevSlides;

function nextSlides(){
    if(current < slide.length-1){
        current += 1;
    }else{
        current=0;
    }
    showSlides(current);
}
next.onclick = nextSlides;