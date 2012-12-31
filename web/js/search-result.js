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
    
    var chosenStudies = document.getElementsByName("studyChosen[]");
    var studyIdElements = document.getElementsByName("studyId[]");
    var studyTitleElements = document.getElementsByName("studyTitle[]");
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
    var chosenStudies = document.getElementsByName("studyChosen[]");
    var submitButton = document.getElementsByName("submit_order")[0];
    for(i=0; i<chosenStudies.length; i++) {
        if(chosenStudies[i].checked) {
            submitButton.disabled = false;
            return;
        }
    }
    submitButton.disabled = true;
}

function resetForm($form) {
    $('#searchform').find('input:text').val('');
    $('#searchform').find('input:checkbox').prop('checked', true);
    $('input[name=grouped]').removeProp('checked');
}

function submitForm(form) {
    if(validateFields())
        form.submit();
}

function changeHitStart(hitStart) {
    if(validateFields()) {
        $('#searchform').append('<input type="hidden" name="hit-start" value="' + hitStart + '" />');
        $('#searchform').submit();
    }
}

$(function() {
    var options;
    if(lang == 'en') {
        options = {
            dateFormat: "yy-mm-dd"
        }
    }
    else {
        options = {
            dateFormat: "yy-mm-dd",
            dayNamesMin: [ "Sø", "Ma", "Ti", "On", "To", "Fr", "Lø" ],
            monthNames: [ "Januar", "Februar", "Marts", "April", "Maj", "Juni", "Juli", "August", "September", "Oktober", "November", "December" ],
            nextText: "Næste",
            prevText: "Forrige"
        }
    }
    $.datepicker.setDefaults(options);
    $('input[name=coverageFrom]').datepicker();
    $('input[name=coverageTo]').datepicker();
});