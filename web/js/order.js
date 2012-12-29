$(document).ready(function(){
    // Load the serialized strings from the local storage and parse them into arrays
    var studyIDs = JSON.parse(localStorage.getItem('studyIDs'));
    var studyTitles = JSON.parse(localStorage.getItem('studyTitles'));
    // For every study in the arrays add a row in the table containing the list of studies
    for(i=0; i<studyIDs.length; i++) {
        $('#studyList').append("<tr><td>" + studyIDs[i] + "</td><td>" + studyTitles[i] + "</td></tr>");
    }
    // Clear local storage
    localStorage.removeItem('studyIDs');
    localStorage.removeItem('studyTitles');
});

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-26906756-1']);
_gaq.push(['_trackPageview']);

(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();