$(document).ready(function(){
    $('.result:even').addClass('alternate');
});

$(function(){
    // Hide all the elements in the DOM that have a class of "referencedElementsList"
    $('.referencedElementsList').hide();
    
    // Make sure all the elements with a class of "referencedElementsTitle" are visible and bound
    // with a click event to toggle the "referencedElementsList" state
    $('.referencedElementsTitle').each(function() {
        $(this).show(0).on('click', function(e) {
            // This is only needed if your using an anchor to target the "referencedElementsList" elements
            //e.preventDefault();
            
            // Find the next "referencedElementsList" element in the DOM
            $(this).next('.referencedElementsList').slideToggle('fast');
        });
    });
});

function createOrder() {
// We are using local storage to pass data to the order page
// If data was already stored remove it
localStorage.removeItem('studyIDs');
localStorage.removeItem('studyTitles');

var chosenStudies = document.order.elements["studyChosen[]"];
var studyIdElements = document.order.elements["studyId[]"];
var studyTitleElements = document.order.elements["studyTitle[]"];
var studyIDs = new Array();;
var studyTitles = new Array();;

for(i=0; i<chosenStudies.length; i++) {
    // Find every study that was selected
    if(chosenStudies[i].checked) {
        // Check if study was already added to the list to avoid duplicates
        if($.inArray(studyIdElements[i].value, studyIDs) == -1) {
            // Add the study ID and title to the lists
            studyIDs.push(studyIdElements[i].value);
            studyTitles.push(studyTitleElements[i].value);
        }
    }
}
// Serialize the arrays to strings and store them into local storage
localStorage.setItem('studyIDs', JSON.stringify(studyIDs));
localStorage.setItem('studyTitles', JSON.stringify(studyTitles));

window.open("order/order.html", "_blank");
}

function toggleSubmitButton() {
var chosenStudies = document.order.elements["studyChosen[]"];
var submitButton = document.order.elements["submit_order"];
for(i=0; i<chosenStudies.length; i++) {
    if(chosenStudies[i].checked) {
        submitButton.disabled = false;
        return;
    }
}
submitButton.disabled = true;
}