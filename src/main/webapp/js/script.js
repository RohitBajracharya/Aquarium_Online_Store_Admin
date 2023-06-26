

const allSideMenu = document.querySelectorAll('#sidebar .side-menu.top li a');

allSideMenu.forEach(item=> {
	const li = item.parentElement;

	item.addEventListener('click', function () {
		allSideMenu.forEach(i=> {
			i.parentElement.classList.remove('active');
		})
		li.classList.add('active');
	})
});



// TOGGLE SIDEBAR
const menuBar = document.querySelector('#content nav .fa-solid.fa-bars');
const sidebar = document.getElementById('sidebar');

menuBar.addEventListener('click', function () {
	sidebar.classList.toggle('hide');
})







const searchButton = document.querySelector('#content nav form .form-input button');
const searchButtonIcon = document.querySelector('#content nav form .form-input button .fa-solid');
const searchForm = document.querySelector('#content nav form');

searchButton.addEventListener('click', function (e) {
	if(window.innerWidth < 576) {
		e.preventDefault();
		searchForm.classList.toggle('show');
		if(searchForm.classList.contains('show')) {
			searchButtonIcon.classList.replace('fa-magnifying-glass', 'fa-xmark');
		} else {
			searchButtonIcon.classList.replace('fa-xmark', 'fa-magnifying-glass');
		}
	}
})





if(window.innerWidth < 768) {
	sidebar.classList.add('hide');
} else if(window.innerWidth > 576) {
	searchButtonIcon.classList.replace('fa-xmark', 'fa-magnifying-glass');
	searchForm.classList.remove('show');
}


window.addEventListener('resize', function () {
	if(this.innerWidth > 576) {
		searchButtonIcon.classList.replace('fa-xmark', 'fa-magnifying-glass');
		searchForm.classList.remove('show');
	}
})






//const addBtn = document.querySelector('.add-customer-btn');
//const popup = document.querySelector('.form-popup');
//const closeBtn = document.querySelector('.cancel-btn');

//// Show the pop-up form when the "Add Customer" button is clicked
//addBtn.addEventListener('click', () => {
  //popup.style.display = 'block';
//});

//// Close the pop-up form when the "Close" button is clicked
//closeBtn.addEventListener('click', () => {
  //popup.style.display = 'none';
//});