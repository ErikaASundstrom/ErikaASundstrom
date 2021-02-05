'use strict';

let state = {

    cardStack: [],
    inputtedText: '',
    sortOrder: 'Most urgent',
    distance: 'Any distance'
};

// render all cards on page in the default state
d3.csv('data/foodbanks.csv').then(function (data) {
    state.cardStack = data;
    sortCards();
    renderCards();
}).catch((error) => {
    document.querySelector('#cardrow').innerHTML = "<p style='color:red; font-size:18px'>Failed to load data</p>";
});

// creates a single card given info from the cardStack
function createCard(info) {
    let cardContainer = document.createElement('div');
    cardContainer.className = 'col-12 col-md-4 d-flex justify-content-center';
    cardContainer.setAttribute('data-toggle', 'modal');
    let compressedName = info.name.replace(/\s+/g, '').replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"") + "Modal";
    cardContainer.setAttribute('data-target', '#' + compressedName);
    cardContainer.setAttribute('tabIndex', '0');

    if (info.display == 'on') {
        cardContainer.className = 'col-12 col-md-4 d-flex justify-content-center';
    } else {
        cardContainer.className = 'col-12 col-md-4 d-none justify-content-center';
    }
    let card = document.createElement('div');
    card.className = 'card mb-4 foodCard';
    card.style.width = '20rem';

    let cardImage = document.createElement('img');
    cardImage.className = 'card-img-top';
    cardImage.src = 'img/' + info.img;
    cardImage.alt = 'Picture of ' + info.name;

    let cardBody = document.createElement('div');
    cardBody.className = 'card-body d-flex flex-column';

    let cardTitle = document.createElement('h5');
    cardTitle.className = 'card-title';
    cardTitle.textContent = info.name;

    let distance = document.createElement('h6');
    distance.className = 'card-subtitle mb-2 text-muted';
    distance.textContent = info.distance + ' miles away';

    let needsTitle = document.createElement('h6');
    needsTitle.className = 'needs-title';
    needsTitle.textContent = "Current Needs:";

    let cardText = document.createElement('p');
    cardText.className = 'card-text';
    cardText.textContent = info.needs;

    let progressContainer = document.createElement('div');
    progressContainer.className = 'mt-auto';

    let progressTitle = document.createElement('h6');
    progressTitle.textContent = 'Current capacity: ' + info.urgency_num + '%';

    let progressBarCapacity = document.createElement('div');
    progressBarCapacity.className = 'progress';
    progressBarCapacity.style.height = '20px';

    let progressBar = document.createElement('div');
    progressBar.setAttribute('role', 'progressbar');
    progressBar.style.width = info.urgency_num + '%';
    progressBar.setAttribute('aria-valuenow', info.urgency_num);
    progressBar.setAttribute('aria-valuemin', '0');
    progressBar.setAttribute('aria-valuemax', '100');
    if (parseInt(info.urgency_num) <= 25) {
        progressBar.className = 'progress-bar progress-bar-urgent';
    } else if (parseInt(info.urgency_num) <= 50) {
        progressBar.className = 'progress-bar progress-bar-warning';
    } else if (parseInt(info.urgency_num) <= 75) {
        progressBar.className = 'progress-bar progress-bar-ok';
    } else {
        progressBar.className = 'progress-bar progress-bar-good';
    }

    progressBarCapacity.appendChild(progressBar);
    progressContainer.appendChild(progressTitle);
    progressContainer.appendChild(progressBarCapacity);

    cardBody.appendChild(cardTitle);
    cardBody.appendChild(distance);
    cardBody.appendChild(needsTitle);
    cardBody.appendChild(cardText);
    cardBody.appendChild(progressContainer);
    card.appendChild(cardImage);
    card.appendChild(cardBody);
    cardContainer.appendChild(card);
    return cardContainer;
}

// creates a single modal, to be called by and passed information from createCard()
function createModal(info) {
    let modalContainer = document.createElement('div');
    modalContainer.className = 'modal fade';
    let compressedName = info.name.replace(/\s+/g, '').replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"") + "Modal";
    modalContainer.id = compressedName;
    modalContainer.tabIndex = '-1';
    modalContainer.setAttribute('role', 'dialog');
    modalContainer.setAttribute('aria-labelledby', compressedName);
    modalContainer.setAttribute('aria-hidden', 'true');

    let modal = document.createElement('div');
    modal.className = 'modal-dialog modal-dialog-centered';
    modal.setAttribute('role', 'document');

    let modalContent = document.createElement('div');
    modalContent.className = 'modal-content';

    let modalHeader = document.createElement('div');
    modalHeader.className = 'modal-header';

    let modalTitle = document.createElement('h5');
    modalTitle.className = 'modal-title';
    modalTitle.id = "cardModalTitle";
    modalTitle.textContent = info.name;

    let closeButton = document.createElement('button');
    closeButton.setAttribute('type', 'button');
    closeButton.className = 'close';
    closeButton.setAttribute('data-dismiss', 'modal');
    closeButton.setAttribute('aria-label', 'close');

    let span = document.createElement('span');
    span.setAttribute('aria-hidden', 'true');
    span.innerHTML = '&times;';

    let modalBody = document.createElement('div');
    modalBody.className = 'modal-body';

    let textContainer = document.createElement('div');
    textContainer.className = 'container-fluid';

    let imageRow = document.createElement('div');
    imageRow.className = 'row';
    imageRow.style.height = '170px';
   
    let locationRow = document.createElement('div');
    locationRow.className = 'row';

    let locationCol = document.createElement('div');
    locationCol.className = 'col-md-6 p-auto';

    let distanceCol = document.createElement('div');
    distanceCol.className = 'col-md-4 ml-auto';

    let bodyRow = document.createElement('div');
    bodyRow.className = 'row';

    let needsCol = document.createElement('div');
    needsCol.className = 'col-md-6 p-auto';

    let hoursCol = document.createElement('div');
    hoursCol.className = 'col-md-6 p-auto';

    let modalImage = document.createElement('img');
    modalImage.className = 'card-img-top';
    modalImage.src = 'img/' + info.img;
    modalImage.alt = 'Picture of ' + info.name;

    let distance = document.createElement('h6');
    distance.className = 'card-subtitle mb-2 text-muted';
    distance.textContent = info.distance + ' miles away';

    let address = document.createElement('h6');
    address.className = 'card-subtitle mb-2 text-muted';
    address.textContent = info.location;

    let phone = document.createElement('address');
    phone.className = 'card-subtitle mb-2 text-muted';
    phone.setAttribute('ahref', 'tel:' + info.phone_number.replace(/\s+/g, '').replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g, ""))
    phone.textContent = info.phone_number;

    let needsTitle = document.createElement('h6');
    needsTitle.className = 'needs-title';
    needsTitle.textContent = "Current Needs:";

    let needsList = document.createElement('ul');
    let needsArray = info.needs.split(',');
    needsArray.forEach((item) => {
        let need = document.createElement('li');
        need.textContent = item;
        needsList.appendChild(need);
    });
    
    let hoursTitle = document.createElement('h6');
    hoursTitle.className = 'hours-title';
    hoursTitle.textContent = "Hours:";

    let hoursList = document.createElement('ul');
    let hoursArray = info.hours.split(',');
    hoursArray.forEach((item) => {
        let hour = document.createElement('li');
        hour.textContent = item;
        hoursList.appendChild(hour);
    });

    let progressContainer = document.createElement('div');
    progressContainer.className = 'progress mt-auto';
    progressContainer.style.height = '20px';

    let progressTitle = document.createElement('h6');
    progressTitle.textContent = 'Current capacity: ' + info.urgency_num + '%';


    let progressArea = document.createElement('div');
    progressArea.className = 'progress-area';


    let progressBar = document.createElement('div');
    progressBar.setAttribute('role', 'progressbar');
    progressBar.style.width = info.urgency_num + '%';
    progressBar.setAttribute('aria-valuenow', info.urgency_num);
    progressBar.setAttribute('aria-valuemin', '0');
    progressBar.setAttribute('aria-valuemax', '100');
    if (parseInt(info.urgency_num) <= 25) {
        progressBar.className = 'progress-bar progress-bar-urgent';
    } else if (parseInt(info.urgency_num) <= 50) {
        progressBar.className = 'progress-bar progress-bar-warning';
    } else if (parseInt(info.urgency_num) <= 75) {
        progressBar.className = 'progress-bar progress-bar-ok';
    } else {
        progressBar.className = 'progress-bar progress-bar-good';
    }

    let modalFooter = document.createElement('div');
    modalFooter.className = 'modal-footer';

    let visitButton = document.createElement('button');
    visitButton.setAttribute('type', 'button');
    visitButton.className = 'btn btn-primary';
    visitButton.innerHTML = 'Visit Site';
    visitButton.setAttribute('onclick', "window.location.href = '" + info.website + "';");

    closeButton.appendChild(span);
    modalHeader.appendChild(modalTitle);
    modalHeader.appendChild(closeButton);
    modalFooter.appendChild(visitButton);
    modalContent.appendChild(modalHeader);
    progressContainer.appendChild(progressBar);
    progressArea.appendChild(progressTitle);
    progressArea.appendChild(progressContainer);
    needsCol.appendChild(needsTitle);
    needsCol.appendChild(needsList);
    hoursCol.appendChild(hoursTitle);
    hoursCol.appendChild(hoursList);
    bodyRow.appendChild(needsCol);
    bodyRow.append(hoursCol);
    distanceCol.appendChild(distance);
    locationCol.appendChild(address);
    locationCol.appendChild(phone);
    locationRow.appendChild(locationCol);
    locationRow.appendChild(distanceCol);
    imageRow.appendChild(modalImage);
    textContainer.appendChild(imageRow);
    textContainer.appendChild(locationRow);
    textContainer.appendChild(bodyRow);
    modalBody.appendChild(textContainer);
    modalBody.appendChild(progressArea);
    modalContent.appendChild(modalBody);
    modalContent.appendChild(modalFooter);
    modal.appendChild(modalContent);
    modalContainer.appendChild(modal);
    return modalContainer;
}

// adds all cards to the container row
function renderCards() {
    let row = document.querySelector('#cardrow');
    row.innerHTML = '';
    state.cardStack.forEach((item) => {
        row.appendChild(createCard(item));
        row.appendChild(createModal(item));
    });
}

// reads what user is inputting as text 
let userInput = document.querySelector('input');
userInput.addEventListener('input', function () {
    state.inputtedText = userInput.value;
    validateZipcode();
})

// checks if inputted zipcode is valid
let validateZipcode = function() {
    let userInput = document.querySelector('input');
    if (state.inputtedText.length != 5 || state.inputtedText == '') {
        userInput.setCustomValidity('Please enter a valid zipcode');
    } else {
        userInput.setCustomValidity('');
    }
}

// reads what user selects in the distance dropdown 
let distanceDropdown = document.querySelector('.custom-select');
distanceDropdown.addEventListener('change', function () {
    state.distance = event.target.value;
});

// reads what the user is sorting by and re-orders
let distance = document.querySelector('#sortby');
distance.addEventListener('change', function (event) {
    state.sortOrder = event.target.value;
    sortCards();
    renderCards();
});

// checks to see if submit button was pressed and filters cards
let form = document.querySelector('form');
form.addEventListener('submit', function (event) {
    event.preventDefault();
    resetCards();
    filterCards();
    renderCards();
});

// checks to see if card's zipcode matches input and re-renders
function filterCards() {
    state.cardStack.forEach((item) => {
        if (item.distance > state.distance) {
            item.display = 'off';
        } else if (item.zipcode != state.inputtedText) {
            item.display = 'off';
        }
    });
}

function resetCards() {
    state.cardStack.forEach((item) => {
        item.display = 'on';
    });
}

// given an array of cards, sorts the items by user input
function sortCards() {
    state.cardStack.forEach((item) => {
        if (state.sortOrder == 'Closest to me') {
            state.cardStack.sort(function (cardA, cardB) {
                return parseFloat(cardA.distance) - parseFloat(cardB.distance);
            });
        } else { //sortOrder is by "most urgent"
            state.cardStack.sort(function (cardA, cardB) {
                return parseFloat(cardA.urgency_num) - parseFloat(cardB.urgency_num);
            });
        }
    });
}

