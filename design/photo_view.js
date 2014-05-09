var curImageIndex=0;
var imageArray = new Array("Chrysanthemum.jpg","Desert.jpg","Hydrangeas.jpg","Jellyfish.jpg","Koala.jpg");
var imageAltArray = new Array("Chrysanthemum","Desert","Hydrangeas","Jellyfish","Koala");
function id(name) {
	return document.getElementById(name);
}
window.onload = function(){
	 showImage(curImageIndex);
     id("gallery_next").onclick = nextImage;
     id("gallery_prev").onclick = prevImage;
}

function showImage(cur) {
	 var img = id("gallery_image").firstChild;
     img.setAttribute("src",imageArray[cur]);
     img.setAttribute("alt",imageAltArray[cur]);
     id("gallery_title").innerHTML = img.alt;
}

function nextImage() {
	if (curImageIndex < imageArray.length - 1)
	{
		curImageIndex += 1;
		showImage(curImageIndex);
	}
	if(curImageIndex == imageArray.length - 1)
			hide(id("gallery_next"));
	else
			show(id("gallery_next"));

	if(curImageIndex == 0)
			hide(id("gallery_prev"));
	else
			show(id("gallery_prev")); 	

	return false;	
}

function prevImage() {
	if (curImageIndex > 0)
	{
		curImageIndex -= 1;
		showImage(curImageIndex);
	}
	if(curImageIndex == imageArray.length - 1)
			hide(id("gallery_next"));
	else
			show(id("gallery_next"));
	if(curImageIndex == 0)
			hide(id("gallery_prev"));
	else
			show(id("gallery_prev")); 	
	return false;
}

function show(element){
	element.style.display = "block";
}

function hide(element){
	element.style.display = "none";
}