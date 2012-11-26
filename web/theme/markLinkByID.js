//skal der afgrænses på hvilke link-classes der kunne markeres som "aktiv"
var g_linkClass 	= ""

//liste over hvilke classes der skal bruges ved markering på hvilke classes
var g_classNameMap = new Array();
addToAssociativeArray("navi", "navisel", g_classNameMap);
addToAssociativeArray("globalnav", "globalsel", g_classNameMap);



function addToAssociativeArray(p_key, p_value, p_parentLinks) {
	p_key = p_key.toLowerCase();
	p_value= p_value.toLowerCase();
	if (!p_parentLinks[p_key] == "") {
		p_parentLinks[p_key] += ":;:" + p_value;
	} else {
		p_parentLinks[p_key] = p_value;
	}
}

function markLinkByID(p_id) {
    var v_element = document.getElementById(p_id);
    
    if (!g_classNameMap[v_element.className] == "") {
        v_element.className = g_classNameMap[v_element.className];
	}
}
