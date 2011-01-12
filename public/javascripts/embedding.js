
function polstaEmbed(id, base) {
	var link = document.getElementById('polstalink' + id);
	html = "<iframe style=\"border:solid 1px #ccc;\" width=\"500\" height=\"400\" src=\"" + base + "?embed=" + id + "\"/>";
	if (link.outerHTML) {
		link.outerHTML = html;
	} 
	else {
		var range = link.ownerDocument.createRange();
		range.selectNodeContents(link);
		link.parentNode.replaceChild(range.createContextualFragment(html), link);
	}
}