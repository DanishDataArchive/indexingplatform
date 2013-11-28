function createOrder() {
    // We are using local storage to pass data to the order page
    // If data was already stored remove it
    localStorage.removeItem('studyIDs');
    localStorage.removeItem('studyTitles');
    
    var studyIdElements = document.getElementsByName("studyId[]");
    var studyTitleElements = document.getElementsByName("studyTitle[]");
    var studyIDs = new Array();;
    var studyTitles = new Array();;
    
    // Add the study ID and title to the lists
    studyIDs.push(studyIdElements[0].value);
    studyTitles.push(studyTitleElements[0].value);
    
    // Serialize the arrays to strings and store them into local storage
    // TODO IE
    localStorage.setItem('studyIDs', JSON.stringify(studyIDs));
    localStorage.setItem('studyTitles', JSON.stringify(studyTitles));
    
    window.open("/order/order.html", "_blank");
}

function studySearch(text) {
    makebusy(makebusy(document.getElementById('searchform')));
    $('#searchform').append('<input type="hidden" name="search-string" value="&quot;'+text+'&quot;"/>');   
    $('#searchform').append('<input type="hidden" name="StudyUnit" value="true"/>');
    $('#searchform').submit();
}