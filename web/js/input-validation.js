function validateFields() {
    // get all the text fields from the form
    var $textFields = $('#searchform').find('input:text');
    
    var textValue;
    var errorsFound = false;
    var errorMessageEn;
    var errorMessageDa;
    
    // validate each text field
    $textFields.each(function () {
        textValue = $(this).val();
        // check if it contains illegal characters
        if (hasIllegalCharacters(textValue)) {
            errorsFound = true;
            errorMessageEn = "Characters '\<>#$^&|' are not allowed.";
            errorMessageDa = "Tegnene '\<>#$^&|' er ikke tilladt.";
            return;
        }
        // check if a word starts with '*'
        if (invalidWildcardUse(textValue, '*')) {
            errorsFound = true;
            errorMessageEn = "The wildcard '*' is not allowed as first character in a word.";
            errorMessageDa = "Jokertegnet '*' må ikke være det første tegn i et ord.";
            return;
        }
        // check if a word starts with '?'
        if (invalidWildcardUse(textValue, '?')) {
            errorsFound = true;
            errorMessageEn = "The wildcard '?' is not allowed as first character in a word.";
            errorMessageDa = "Jokertegnet '?' må ikke være det første tegn i et ord.";
            return;
        }
        // check if 'AND' operator is used correctly
        if (invalidLogicalOperatorUse(textValue, 'AND')) {
            errorsFound = true;
            errorMessageEn = "Incorrect use of the 'AND' operator.";
            errorMessageDa = "Inkorrekt brug af 'AND' operatoren.";
            return;
        }
        // check if 'OR' operator is used correctly
        if (invalidLogicalOperatorUse(textValue, 'OR')) {
            errorsFound = true;
            errorMessageEn = "Incorrect use of the 'OR' operator.";
            errorMessageDa = "Inkorrekt brug af 'OR' operatoren.";
            return;
        }
        // check if parentheses are correct
        if (invalidParentheses(textValue)) {
            errorsFound = true;
            errorMessageEn = "Invalid use of parentheses.";
            errorMessageDa = "Ugyldige brug af parentes.";
            return;
        }
        // check if use of the '"' character is balanced
        if (invalidCharacterBalance(textValue, '"')) {
            errorsFound = true;
            errorMessageEn = "The quotation marks '\"' must be closed.";
            errorMessageDa = "Citationstegnene '\"' skal lukkes.";
            return;
        }
        // check if use of the "'" character is balanced
        if (invalidCharacterBalance(textValue, "'")) {
            errorsFound = true;
            errorMessageEn = "The quotation marks \"'\" must be closed.";
            errorMessageDa = "Citationstegnene \"'\" skal lukkes.";
            return;
        }
    });
    
    if (errorsFound) {
        if (busy) {
            busy.remove();
        }
        if (lang == 'en') {
            alert("The text '" + textValue + "' is invalid.\n" + errorMessageEn);
        } else {
            alert("Teksten '" + textValue + "' er ugyldig.\n" + errorMessageDa);
        }
        return false;
    }
    
    var coverageFrom = $('input[name=coverageFrom]').val();
    // only check date format if date fields exist (i.e. we are in the advenced search form
    if (coverageFrom) {
        if (coverageFrom.length > 0 && ! isValidDate(coverageFrom)) {
            if (busy) {
                busy.remove();
            }
            if (lang == 'en') {
                alert("Start date is not valid.\nThe format must be YYYY-MM-DD.");
            } else {
                alert("Startdato er ikke gyldigt.\nFormatet skal være ÅÅÅÅ-MM-DD.");
            }
            return false;
        }
        var coverageTo = $('input[name=coverageTo]').val();
        if (coverageTo.length > 0 && ! isValidDate(coverageTo)) {
            if (busy) {
                busy.remove();
            }
            if (lang == 'en') {
                alert("End date is not valid.\nThe format must be YYYY-MM-DD.");
            } else {
                alert("Slutdato er ikke gyldigt.\nFormatet skal være ÅÅÅÅ-MM-DD.");
            }
            return false;
        }
    }
    return true;
}

function hasIllegalCharacters(str) {
    return str.match(/[\\\<\>#\$^&|]+/i);
}

function invalidWildcardUse(str, wildcard) {
    var startIndex = 0, length = wildcard.length;
    while ((index = str.indexOf(wildcard, startIndex)) > -1) {
        // if string starts with the wildcard
        if (index == 0) return true;
        // if there is a whatespace before (i.e. word starts with the wildcard)
        if (str.charAt(index -1).match(/\s/)) return true;
        startIndex = index + length;
    }
    return false;
}

function invalidLogicalOperatorUse(str, operator) {
    // split the string into words (trim leading and trailing whitespaces first)
    var words = $.trim(str).split(/\s+/);
    for (var i = 0; i < words.length; i++) {
        // find all occurrences of the operator
        if (words[i] == operator) {
            // if it is the first or last word (i.e. it doesn't have an parameter on each side)
            if (i == 0 || i == words.length -1)
            return true;
            // if any of its neighbours is an logical operator as well
            if (words[i -1] == "AND" || words[i -1] == "OR" || words[i + 1] == "AND" || words[i + 1] == "OR")
            return true;
            // if there is an incorrect parentheses before or after the operator
            if (words[i -1].endsWith("(") || words[i + 1].startsWith(")"))
            return true;
        }
    }
    return false;
}

String.prototype.startsWith = function (str) {
    return this.slice(0, str.length) == str;
};

String.prototype.endsWith = function (str) {
    return this.slice(- str.length) == str;
};

function invalidParentheses(str) {
    // if there are two parentheses with nothing (but whitespaces) between them
    if (str.match(/\(\s*\)/)) return true;
    
    // check if tha parentheses are balanced
    var nesting = 0;
    for (var i = 0; i < str.length;++ i) {
        switch (str.charAt(i)) {
            case '(':
            nesting++;
            break;
            case ')':
            nesting--;
            if (nesting < 0)
            return true;
            break;
        }
    }
    return nesting != 0;
}

function invalidCharacterBalance(str, character) {
    var occurrences = str.split(character).length - 1;
    // check if there is an uneven number of occurrences
    return (occurrences % 2 != 0);
}

function isValidDate(date) {
    var matches = /^(\d{4})-(\d{2})-(\d{2})$/.exec(date);
    if (matches == null) return false;
    var y = matches[1];
    var m = Number(matches[2]) - 1;
    var d = Number(matches[3]);
    var composedDate = new Date(y, m, d);
    return composedDate.getDate() == d &&
    composedDate.getMonth() == m &&
    composedDate.getFullYear() == y;
}