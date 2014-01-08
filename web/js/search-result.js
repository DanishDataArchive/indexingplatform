$(document).ready(function(){
    // read grouped checkbox from session store
    var grouped  = localStorage.getItem('grouped');    
    if(grouped==null) {
        localStorage.setItem('grouped', 'true');
        grouped = 'true';       
    }        

    // set grouped check box
    if(grouped == 'true') {
        $('input[name=grouped]').prop('checked', true);
    } else{
        $('input[name=grouped]').prop('checked', false);
    }    
    
    setFocusToEnd($('input[name=search-string]'));
    $('.result:even').addClass('alternate');
    
    // tooltip
    $( document ).tooltip({"tooltipClass": "search-tooltip"});
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

function simpleSearchTooltip() {
    // get the lang param from url params
    var param = (function(a) {
        if (a == "") return {};
        var b = {};
        for (var i = 0; i < a.length; ++i)
        {
            var p=a[i].split('=');
            if (p.length != 2) continue;
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
        }
        return b;
    })(window.location.search.substr(1).split('&'));
    
    // danish or other
    if(param["lang"]=="da") {
        $('#search-help-simple').tooltip({"tooltipClass": "search-tooltip"}, {"content": "Søg på undersøgelsens (studiets) titel, forsker, indhold mv. Brug evt. modifikatorer:<br/><br/><table border='0' cellspacing='0' cellpadding='1'><tr class='search-table-tooltip'><th>Modifikator</th><th>Beskrivelse</th><th align='left'>Eksempel</th></tr><tr><td  class='search-table-tooltip'>AND</td><td  class='search-table-tooltip'>Begge ord skal være til stede</td><td  class='search-table-tooltip'>politisk AND parti</td></tr><tr><td  class='search-table-tooltip'>OR</td><td  class='search-table-tooltip'>Mindst ét af ordene skal være til stede</td><td  class='search-table-tooltip'>politisk OR parti</td></tr><tr><td  class='search-table-tooltip'>” ”</td><td  class='search-table-tooltip'>Eksakte fraser</td><td  class='search-table-tooltip'>”politisk parti”</td></tr><tr><td  class='search-table-tooltip'>+ og -</td><td  class='search-table-tooltip'>Opprioritering og fravalg: + skal indgå, - må ikke indgå</td><td  class='search-table-tooltip'>+politisk -parti</td></tr><tr><td  class='search-table-tooltip'>*</td><td  class='search-table-tooltip'>Erstatter del af ord</td><td  class='search-table-tooltip'>politi*</td></tr><tr><td  class='search-table-tooltip'>( )</td><td  class='search-table-tooltip'>Gruppering af ord og modifikatorer</td><td  class='search-table-tooltip'>(politik OR parti) AND valg</td></tr></table>" });
    }  else {
        $('#search-help-simple').tooltip({"tooltipClass": "search-tooltip"}, {"content": "Search the title, researcher, topic etc. of the study. You can use the following modifiers:<br/><br/><table border='0' cellspacing='0' cellpadding='1'><tr class='search-table-tooltip'><th>Modifier</th><th>Description</th><th align='left'>Example</th></tr><tr><td class='search-table-tooltip'>AND</td><td class='search-table-tooltip'>Both words must be present</td><td class='search-table-tooltip'>political AND party</td></tr><tr><td class='search-table-tooltip'>OR</td><td class='search-table-tooltip'>At least one of the words must be present</td><td class='search-table-tooltip'>Political OR party</td></tr><tr><td class='search-table-tooltip'>” ”</td><td class='search-table-tooltip'>Exact phrases</td><td class='search-table-tooltip'>”political party”</td></tr><tr><td class='search-table-tooltip'>+ and -</td><td class='search-table-tooltip'>Prioritization and deselection: +must be included, - shall not be included</td><td class='search-table-tooltip'>+political -party</td></tr><tr><td class='search-table-tooltip'>*</td><td class='search-table-tooltip'>Replaces part of word</td><td class='search-table-tooltip'>politi*</td></tr><tr><td class='search-table-tooltip'>( )</td><td class='search-table-tooltip'>Grouping words and modifiers</td><td class='search-table-tooltip'>(political OR party) AND election</td></tr></table>" });
    }  
}

function createOrder() {
    createOrderImp();
    window.open("order/order.html", "_blank");    
}

function createOrderStepUp() {
    createOrderImp();
    window.open("../order/order.html", "_blank");    
}

function createOrderImp() {
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
    // reset all
    // $('#searchform').find('input:checkbox').prop('checked', true);
    // $('input[name=grouped]').removeProp('checked');
    
    // reset to selected
    $('#searchform').find('input:checkbox').prop('checked', false);
    $('input[name=StudyUnit]').prop('checked', true);
    $('input[name=StudyUnitChecked]').prop('checked', true);
    $('input[name=grouped]').prop('checked', true);
}

function submitForm(form) {
    if(validateFields())
        form.submit();
}

function changeHitStart(hitStart) {
    if(validateFields()) {
        $('#searchform').append('<input type="hidden" name="hit-start" value="' + hitStart + '" />');
        // $('#searchform').submit();
    }
}

function toggleCheckBox(checkboxid) {
    if($('input[name='+checkboxid+']').get(0).checked) {
        $('input[name='+checkboxid+']').prop('checked', false);
    }   else  {
        $('input[name='+checkboxid+']').prop('checked', true);
    }         
}

function toggleCheckBoxById(checkboxid) {
    if($('input[id='+checkboxid+']').get(0).checked) {
        $('input[id='+checkboxid+']').prop('checked', false);    
        toggleSubmitButton($('#searchform'));
    }   else  {
        $('input[id='+checkboxid+']').prop('checked', true);    
        toggleSubmitButton($('#searchform'));
    }         
}

function toggleGrouped(checkboxid) {
    if($('input[name='+checkboxid+']').get(0).checked) {
        $('input[name='+checkboxid+']').prop('checked', false);    
        // toggleSubmitButton($('#searchform'));
        localStorage.setItem('grouped', 'false');
    }   else  {
        $('input[name='+checkboxid+']').prop('checked', true);
        // toggleSubmitButton($('#searchform'));
        localStorage.setItem('grouped', 'true');
    }         
}

function storeGrouped(checkboxid) {
    if($('input[name='+checkboxid+']').get(0).checked) {
        localStorage.setItem('grouped', 'true');
    }   else  {
        localStorage.setItem('grouped', 'false');
    }         
}

function setFocusToEnd(inputField){
    if (inputField[0] != null && inputField[0].value.length != 0){
        if (inputField.createTextRange){
            var fieldRange = inputField[0].createTextRange();
            fieldRange.moveStart('character',inputField[0].value.length);
            fieldRange.collapse();
            fieldRange.select();
        }else if (inputField[0].selectionStart || inputField[0].selectionStart == '0') {
            var elemLen = inputField[0].value.length;
            inputField[0].selectionStart = elemLen;
            inputField[0].selectionEnd = elemLen;
            inputField.focus();
        }
    }else{
        inputField.focus();
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